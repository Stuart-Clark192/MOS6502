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
        print("AND Not implemented yet")
    }
    
    func ASL() {
        print("ASL Not implemented yet")
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
        print("TAX Not implemented yet")
    }
    
    func TXA() {
        print("TXA Not implemented yet")
    }
    
    func DEX() {
        print("DEX Not implemented yet")
    }
    
    func INX() {
        print("INX Not implemented yet")
    }
    
    func TAY() {
        print("TAY Not implemented yet")
    }
    
    func TYA() {
        print("TYA Not implemented yet")
    }
    
    func DEY() {
        print("DEY Not implemented yet")
    }
    
    func INY() {
        print("INY Not implemented yet")
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
        print("Memory address we are setting to is ")
        memoryAddress.printRepresentation()
        memory.write(location: memoryAddress, data: a)
    }
    
    func TXS() {
        print("TXS Not implemented yet")
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
