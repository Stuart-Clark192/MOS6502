//
//  CPU+InstructionImplementation.swift
//  MOS6502
//
//  Created by Stuart on 18/11/2020.
//

// Another instruction reference http://www.obelisk.me.uk/6502/reference.html

import Foundation

extension CPU {
    
    func getInstrValueFromMemory(addressMode: InstructionMode) -> UInt8 {
        
        var cyclesUsed:UInt8 = 0
        
        switch addressMode {
        
        case .accumulator:
            cyclesUsed = accumulatorData()
        
        case .immediate:
            cyclesUsed = immediateData()
            
        case .zeroPage:
            cyclesUsed = zeroPageData()
            
        case .zeroPageX:
            cyclesUsed = zeroXPageData()
        
        case .zeroPageY:
            cyclesUsed = zeroYPageData()
        case .absolute:
            cyclesUsed = absoluteData()
        case .absoluteX:
            cyclesUsed = absoluteXData()
        case .absoluteY:
            cyclesUsed = absoluteYData()
        case .indirectX:
            cyclesUsed = indirectXData()
        case .indirectY:
            cyclesUsed = indirectYData()
        case .implied:
            break
        case .relative:
            cyclesUsed = relativeData()
            
        case .indirect:
            cyclesUsed = indirectData()
        }
        
        return cyclesUsed
    }
    
    func setNZFlagsFor(value: UInt8) {
        setFlag(.N, for: Int(value))
        setFlag(.Z, for: Int(value))
    }
    
    func ADC() {
        // Operates on the accumulator - Accumulator + Value + Carry flag
        // Need to account for decimal mode as well here!! and set the overflow flag
        var value: UInt16 = 0
        var binaryResult = UInt16(memoryFetchedValue) + UInt16(a) + (p.isBitSet(pos: 0) ? 1 : 0)
        setFlag(.C, binaryResult > 0xff)
        setNZFlagsFor(value: binaryResult.lowByte())
            
        if p.isBitSet(pos: 3) {
            // Decimal mode -- this part is not correct yet as it is not doing the BCD Carry
            let memoryBCD = memoryFetchedValue.bcdValue()
            let aBCD = a.bcdValue()
            let carry: UInt8 = p.isBitSet(pos: 0) ? 1 : 0
            
            value = UInt16(memoryBCD) + UInt16(aBCD) + UInt16(carry)
            setFlag(.C, value > 99)
            value.printRepresentation()
            print("")
        } else {
            value = UInt16(memoryFetchedValue) + UInt16(a) + (p.isBitSet(pos: 0) ? 1 : 0)
            
        }
        
        a = binaryResult.lowByte()
    }
    
    func AND() {
        a &= memoryFetchedValue
        setNZFlagsFor(value: a)
    }
    
    func ASL() {
        var value = memoryFetchedValue
        if value.isBitSet(pos: 7) {
            setFlag(.C, true)
        }
        value = value << 1
        
        if (currentInstrMode == .accumulator) {
            a = value
            setNZFlagsFor(value: a)
        } else {
            memory.write(location: memoryAddress, data: value)
            setNZFlagsFor(value: value)
        }
    }
    
    func BIT() {
        var value = UInt16(memoryFetchedValue)
        value &= UInt16(a)
        value.printRepresentation()
        setFlag(.Z, for: Int(value))
        setFlag(.N, memoryFetchedValue.isBitSet(pos: 7) ? true : false)
        setFlag(.V, memoryFetchedValue.isBitSet(pos: 6) ? true : false)
    }
    
    func BPL() {
        branchIfFlag(flag: .N, is: false)
    }
    
    func BMI() {
        branchIfFlag(flag: .N, is: true)
    }
    
    func BVC() {
        branchIfFlag(flag: .V, is: false)
    }
    
    func BVS() {
        branchIfFlag(flag: .V, is: true)
    }
    
    func BCC() {
        branchIfFlag(flag: .C, is: false)
    }
    
    func BCS() {
        branchIfFlag(flag: .C, is: true)
    }
    
    func BNE() {
        branchIfFlag(flag: .Z, is: false)
    }
    
    func BEQ() {
        branchIfFlag(flag: .Z, is: true)
    }
    
    func BRK() {
        // Nothing to do
    }
    
    func CMP() {
        // If the value in the accumulator is equal or greater than the compared value, the Carry will be set.
        // The equal (Z) and negative (N) flags will be set based on equality or lack thereof and the sign (i.e. A>=$80) of the accumulator.
        
        setFlag(.C, a >= memoryFetchedValue ? true : false)
        setFlag(.Z, a == memoryFetchedValue ? true : false)
        setFlag(.N, a >= 0x80 ? true : false)
    }
    
    func CPX() {
        
        setFlag(.C, x >= memoryFetchedValue ? true : false)
        setFlag(.Z, x == memoryFetchedValue ? true : false)
        setFlag(.N, x >= 0x80 ? true : false)
    }
    
    func CPY() {
        
        setFlag(.C, y >= memoryFetchedValue ? true : false)
        setFlag(.Z, y == memoryFetchedValue ? true : false)
        setFlag(.N, y >= 0x80 ? true : false)
    }
    
    func DEC() {
        var value = memoryFetchedValue
        if value == 0 {
            value = 0xFF
            setFlag(.N, true)
            setFlag(.Z, for: Int(value))
        } else {
            value -= 1
            setNZFlagsFor(value: value)
        }
        memory.write(location: memoryAddress, data: value)
    }
    
    func EOR() {
        // Exclusive-OR Memory with Accumulator
        
        a ^= memoryFetchedValue
        setNZFlagsFor(value: a)
    }
    
    func CLC() {
        setFlag(.C, false)
    }
    
    func SEC() {
        setFlag(.C, true)
    }
    
    func CLI() {
        setFlag(.I, false)
    }
    
    func SEI() {
        setFlag(.I, true)
    }
    
    func CLV() {
        setFlag(.V, false)
    }
    
    func CLD() {
        setFlag(.D, false)
    }
    
    func SED() {
        setFlag(.D, true)
    }
    
    func INC() {
        var value = memoryFetchedValue
        if value == 0xFF {
            value = 0
        }
        setNZFlagsFor(value: value)
        memory.write(location: memoryAddress, data: value)
    }
    
    func JMP() {
        // Need to account for the 6502 bug on page boundry
        pc = memoryAddress
    }
    
    func JSR() {
        // push the return address onto the stack
        pc -= 1
        pushStack(value: pc.highByte())
        pushStack(value: pc.lowByte())
        pc = memoryAddress
    }
    
    func LDA() {
        a = memoryFetchedValue
        
        // Set flags
        setNZFlagsFor(value: a)
    }
    
    func LDX() {
        x = memoryFetchedValue
        
        // Set flags
        setNZFlagsFor(value: x)
    }
    
    func LDY() {
        y = memoryFetchedValue
        
        // Set flags
        setNZFlagsFor(value: y)
    }
    
    func LSR() {
        
        setFlag(.C, memoryFetchedValue.isBitSet(pos: 7) ? true : false)
        memoryFetchedValue = memoryFetchedValue >> 1
        if (currentInstrMode == .accumulator) {
            a = memoryFetchedValue
            setNZFlagsFor(value: a)
        } else {
            memory.write(location: memoryAddress, data: memoryFetchedValue)
            setNZFlagsFor(value: memoryFetchedValue)
        }
    }
    
    func NOP() {
        // TODO: Once we have the cycles implemented this will count towards the cycle count
        // Other than that nothing to do
    }
    
    func ORA() {
        a |= memoryFetchedValue
        setNZFlagsFor(value: a)
    }
    
    //Register
    func TAX() {
        x = a
        setNZFlagsFor(value: x)
    }
    
    func TXA() {
        a = x
        setNZFlagsFor(value: a)
    }
    
    func DEX() {
        if x == 0 {
            x = 0xFF
            setFlag(.N, true)
            setFlag(.Z, for: Int(x))
        } else {
            x -= 1
            setNZFlagsFor(value: x)
        }
    }
    
    func INX() {
        if x == 0xFF {
            x = 0
        } else {
            x += 1
        }
        setNZFlagsFor(value: x)
    }
    
    func TAY() {
        y = a
        setNZFlagsFor(value: y)
    }
    
    func TYA() {
        a = y
        setNZFlagsFor(value: a)
    }
    
    func DEY() {
        if y == 0 {
            y = 0xFF
            setFlag(.N, true)
            setFlag(.Z, for: Int(y))
        } else {
            y -= 1
            setNZFlagsFor(value: y)
        }
    }
    
    func INY() {
        if y == 0xFF {
            y = 0
        }
        setNZFlagsFor(value: y)
    }
    
    func ROL() {
        
        let topBitSet = memoryFetchedValue.isBitSet(pos: 7)
        let carrySet = p.isBitSet(pos: 0)
        
        memoryFetchedValue = memoryFetchedValue << 1
        memoryFetchedValue |= carrySet ? 1 : 0
        setFlag(.C, topBitSet)
        
        if (currentInstrMode == .accumulator) {
            a = memoryFetchedValue
            setNZFlagsFor(value: a)
        } else {
            memory.write(location: memoryAddress, data: memoryFetchedValue)
            setNZFlagsFor(value: memoryFetchedValue)
        }
    }
    
    func ROR() {
        let bottomBitSet = memoryFetchedValue.isBitSet(pos: 0)
        let carrySet = p.isBitSet(pos: 0)
        
        memoryFetchedValue = memoryFetchedValue >> 1
        memoryFetchedValue |= carrySet ? 1 : 0
        setFlag(.C, bottomBitSet)
        
        if (currentInstrMode == .accumulator) {
            a = memoryFetchedValue
            setNZFlagsFor(value: a)
        } else {
            memory.write(location: memoryAddress, data: memoryFetchedValue)
            setNZFlagsFor(value: memoryFetchedValue)
        }
    }
    
    func RTI() {
        // The RTI instruction is used at the end of an interrupt processing routine. It pulls the processor flags from the stack followed by the program counter.
        p = popStack()
        
        // Pull the program counter
        pc = UInt16.combine(lowByte: popStack(), highByte: popStack())
        pc += 1
    }
    
    func RTS() {
        pc = UInt16.combine(lowByte: popStack(), highByte: popStack())
        pc += 1
    }
    
    func SBC() {
        print("SBC Not implemented yet")
        
        // looking at various forums I shoudl be able to negate the memory value and then run the same implementation that ADC uses
        
        // Operates on the accumulator - Accumulator + Value + Carry flag
        // Need to account for decimal mode as well here!!
//        var value: UInt16 = 0
//
//        if p.isBitSet(pos: 3) {
//            // Decimal mode
//            value = UInt16(memoryFetchedValue.bcdValue()) + UInt16(a.bcdValue()) + (p.isBitSet(pos: 0) ? 1 : 0)
//        } else {
//           value = UInt16(memoryFetchedValue) + UInt16(a) + (p.isBitSet(pos: 0) ? 1 : 0)
//        }
//
//        setFlag(.C, value > 0xff)
//
//        a = value.lowByte()
//        setNZFlagsFor(value: a)
    }
    
    func STA() {
        memory.write(location: memoryAddress, data: a)
    }
    
    func TXS() {
        // (Transfer X to Stack ptr)
        s = x
    }
    
    func TSX() {
        // (Transfer Stack ptr to X)
        x = s
    }
    
    func PHA() {
        // (PusH Accumulator)
        pushStack(value: a)
    }
    
    func PLA() {
        // (PuLl Accumulator)
        a = popStack()
    }
    
    func PHP() {
        // (PusH Processor status)
        pushStack(value: p)
    }
    
    func PLP() {
        p = popStack()
    }
    
    func STX() {
        memory.write(location: memoryAddress, data: x)
    }
    
    func STY() {
        memory.write(location: memoryAddress, data: y)
    }
    
}
