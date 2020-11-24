//
//  CPU+InstructionImplementation.swift
//  MOS6502
//
//  Created by Stuart on 18/11/2020.
//

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
        if value > 0xff {
            setFlag(.C, true)
        }
        
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
        if value.bitSetInt(pos: 7) {
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
        setFlag(.N, memoryFetchedValue.bitSetInt(pos: 7) ? true : false)
        setFlag(.V, memoryFetchedValue.bitSetInt(pos: 6) ? true : false)
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
        print("BNE Not implemented yet")
    }
    
    func BEQ() {
        print("BEQ Not implemented yet")
    }
    
    func BRK() {
        pc += 1
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
        print("LSR Not implemented")
        var valueToShift = memoryFetchedValue
    }
    
    func NOP() {
        // TODO: Once we have the cycles implemented this will count towards the cycle count
    }
    
    func ORA() {
        print("ORA Not implemented yet")
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
        print("ROL Not implemented yet")
    }
    
    func ROR() {
        print("ROR Not implemented yet")
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
        a.printRepresentation()
        memoryAddress.printRepresentation()
        memory.write(location: memoryAddress, data: a)
    }
    
    func TXS() {
        
    }
    
    func TSX() {
        print("TSX Not implemented yet")
    }
    
    func PHA() {
        print("PHA Not implemented yet")
    }
    
    func PLA() {
        print("PLA Not implemented yet")
    }
    
    func PHP() {
        print("PHP Not implemented yet")
    }
    
    func PLP() {
        print("PLP Not implemented yet")
    }
    
    func STX() {
        memory.write(location: memoryAddress, data: x)
    }
    
    func STY() {
        memory.write(location: memoryAddress, data: y)
    }
    
}
