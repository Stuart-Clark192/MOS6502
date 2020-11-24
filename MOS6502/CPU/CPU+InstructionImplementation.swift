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
        print("ADC Not implemented yet")
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
        print("BIT Not implemented yet")
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
        print("BEQ Not implemented yet")
    }
    
    func CMP() {
        print("CMP Not implemented yet")
    }
    
    func CPX() {
        print("CPX Not implemented yet")
    }
    
    func CPY() {
        print("CPY Not implemented yet")
    }
    
    func DEC() {
        print("DEC Not implemented yet")
    }
    
    func EOR() {
        print("EOR Not implemented yet")
    }
    
    func CLC() {
        print("CLC Not implemented yet")
    }
    
    func SEC() {
        print("SEC Not implemented yet")
    }
    
    func CLI() {
        print("CLI Not implemented yet")
    }
    
    func SEI() {
        print("SEI Not implemented yet")
    }
    
    func CLV() {
        print("CLV Not implemented yet")
    }
    
    func CLD() {
        print("CLD Not implemented yet")
    }
    
    func SED() {
        print("SED Not implemented yet")
    }
    
    func INC() {
        print("INC Not implemented yet")
    }
    
    func JMP() {
        print("JMP Not implemented yet")
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
        print("Nothing to do")
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
