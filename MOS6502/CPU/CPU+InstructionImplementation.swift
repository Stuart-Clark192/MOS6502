//
//  CPU+InstructionImplementation.swift
//  MOS6502
//
//  Created by Stuart on 18/11/2020.
//

// Another instruction reference http://www.obelisk.me.uk/6502/reference.html

import Foundation

extension CPU {
    
    func getInstrValueFromMemory(addressMode: InstructionMode) {
        
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
            print("Nothing implemented yet")
        case .relative:
            cyclesUsed = relativeData()
            
        case .indirect:
            cyclesUsed = indirectData()
        }
    }
    
    func ADC() {
        // Operates on the accumulator
        let value = UInt16(memoryFetchedValue) + UInt16(a)

        setFlag(.C, value > 0xff)
        
        a = value.lowByte()
        setFlag(.N, for: Int(a))
        setFlag(.Z, for: Int(a))
    }
    
    func AND() {
        a &= memoryFetchedValue
        
        setFlag(.N, for: Int(a))
        setFlag(.Z, for: Int(a))
    }
    
    func ASL() {
        var value = memoryFetchedValue
        if value.isBitSet(pos: 7) {
            setFlag(.C, true)
        }
        value = value << 1
        
        if (currentInstrMode == .accumulator) {
            a = value
            setFlag(.N, for: Int(a))
            setFlag(.Z, for: Int(a))
        } else {
            memory.write(location: memoryAddress, data: value)
            setFlag(.N, for: Int(value))
            setFlag(.Z, for: Int(value))
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
        print("BPL Not implemented yet")
    }
    
    func BMI() {
        print("BMI Not implemented yet")
    }
    
    func BVC() {
        print("BVC Not implemented yet")
    }
    
    func BVS() {
        print("BVS Not implemented yet")
    }
    
    func BCC() {
        print("BCC Not implemented yet")
    }
    
    func BCS() {
        print("BCS Not implemented yet")
    }
    
    func BNE() {
        var test = memoryFetchedValue
        var isNegativeJump = test.isBitSet(pos: 7)
        var newTest = test.setBit(pos: 7, to: false)
        var then = abs(newTest.toInt8())
        
        if !isFlagSet(.Z) {
            if isNegativeJump {
                pc -= UInt16(then)
            } else {
                pc += UInt16(then)
            }
        }
    }
    
    func BEQ() {
        print("BEQ Not implemented yet")
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
            setFlag(.N, for: Int(value))
            setFlag(.Z, for: Int(value))
        }
        memory.write(location: memoryAddress, data: value)
    }
    
    func EOR() {
        // Exclusive-OR Memory with Accumulator
        
        a ^= memoryFetchedValue
        setFlag(.N, for: Int(a))
        setFlag(.Z, for: Int(a))
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
        setFlag(.N, for: Int(value))
        setFlag(.Z, for: Int(value))
        memory.write(location: memoryAddress, data: value)
    }
    
    func JMP() {
        pc = memoryAddress
    }
    
    func JSR() {
        print("JSR Not implemented yet")
    }
    
    func LDA() {
        a = memoryFetchedValue
        
        // Set flags
        setFlag(.N, for: Int(a))
        setFlag(.Z, for: Int(a))
    }
    
    func LDX() {
        x = memoryFetchedValue
        
        // Set flags
        setFlag(.N, for: Int(x))
        setFlag(.Z, for: Int(x))
    }
    
    func LDY() {
        y = memoryFetchedValue
        
        // Set flags
        setFlag(.N, for: Int(y))
        setFlag(.Z, for: Int(y))
    }
    
    func LSR() {
        
        setFlag(.C, memoryFetchedValue.isBitSet(pos: 7) ? true : false)
        memoryFetchedValue = memoryFetchedValue >> 1
        if (currentInstrMode == .accumulator) {
            a = memoryFetchedValue
            setFlag(.N, for: Int(a))
            setFlag(.Z, for: Int(a))
        } else {
            memory.write(location: memoryAddress, data: memoryFetchedValue)
            setFlag(.N, for: Int(memoryFetchedValue))
            setFlag(.Z, for: Int(memoryFetchedValue))
        }
    }
    
    func NOP() {
        // TODO: Once we have the cycles implemented this will count towards the cycle count
        // Other than that nothing to do
    }
    
    func ORA() {
        a |= memoryFetchedValue
        
        setFlag(.N, for: Int(a))
        setFlag(.Z, for: Int(a))
    }
    
    //Register
    func TAX() {
        x = a
        setFlag(.N, for: Int(x))
        setFlag(.Z, for: Int(x))
    }
    
    func TXA() {
        a = x
        setFlag(.N, for: Int(a))
        setFlag(.Z, for: Int(a))
    }
    
    func DEX() {
        if x == 0 {
            x = 0xFF
            setFlag(.N, true)
            setFlag(.Z, for: Int(x))
        } else {
            x -= 1
            setFlag(.N, for: Int(x))
            setFlag(.Z, for: Int(x))
        }
    }
    
    func INX() {
        if x == 0xFF {
            x = 0
        } else {
            x += 1
        }
        setFlag(.N, for: Int(x))
        setFlag(.Z, for: Int(x))
    }
    
    func TAY() {
        y = a
        setFlag(.N, for: Int(y))
        setFlag(.Z, for: Int(y))
    }
    
    func TYA() {
        a = y
        setFlag(.N, for: Int(a))
        setFlag(.Z, for: Int(a))
    }
    
    func DEY() {
        if y == 0 {
            y = 0xFF
            setFlag(.N, true)
            setFlag(.Z, for: Int(y))
        } else {
            y -= 1
            setFlag(.N, for: Int(y))
            setFlag(.Z, for: Int(y))
        }
    }
    
    func INY() {
        if y == 0xFF {
            y = 0
        }
        setFlag(.N, for: Int(y))
        setFlag(.Z, for: Int(y))
    }
    
    func ROL() {
        
        let topBitSet = memoryFetchedValue.isBitSet(pos: 7)
        let carrySet = p.isBitSet(pos: 0)
        
        memoryFetchedValue = memoryFetchedValue << 1
        memoryFetchedValue |= carrySet ? 1 : 0
        setFlag(.C, topBitSet)
        
        if (currentInstrMode == .accumulator) {
            a = memoryFetchedValue
            setFlag(.N, for: Int(a))
            setFlag(.Z, for: Int(a))
        } else {
            memory.write(location: memoryAddress, data: memoryFetchedValue)
            setFlag(.N, for: Int(memoryFetchedValue))
            setFlag(.Z, for: Int(memoryFetchedValue))
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
            setFlag(.N, for: Int(a))
            setFlag(.Z, for: Int(a))
        } else {
            memory.write(location: memoryAddress, data: memoryFetchedValue)
            setFlag(.N, for: Int(memoryFetchedValue))
            setFlag(.Z, for: Int(memoryFetchedValue))
        }
    }
    
    func RTI() {
        print("RTI Not implemented yet")
    }
    
    func RTS() {
        print("RTS Not implemented yet")
    }
    
    func SBC() {
        print("SBC Not implemented yet")
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
        let stackMemoryLocation = UInt16(s) + 0x100
        memory.write(location: stackMemoryLocation, data: a)
        
        if s == 0 {
            s = 0xFF
        } else {
            s -= 1
        }
    }
    
    func PLA() {
        // (PuLl Accumulator)
        if s == 0xFF {
            s = 0
        } else {
            s += 1
        }
        
        let stackMemoryLocation = UInt16(s) + 0x100
        a = memory.read(location: stackMemoryLocation)
    }
    
    func PHP() {
        // (PusH Processor status)
        let stackMemoryLocation = UInt16(s) + 0x100
        memory.write(location: stackMemoryLocation, data: p)
        
        if s == 0 {
            s = 0xFF
        } else {
            s -= 1
        }
    }
    
    func PLP() {
        // (PuLl Processor status)
        if s == 0xFF {
            s = 0
        } else {
            s += 1
        }
        
        let stackMemoryLocation = UInt16(s) + 0x100
        p = memory.read(location: stackMemoryLocation)
    }
    
    func STX() {
        memory.write(location: memoryAddress, data: x)
    }
    
    func STY() {
        memory.write(location: memoryAddress, data: y)
    }
    
}
