//
//  CPU.swift
//  MOS6502
//
//  Created by Stuart on 15/11/2020.
//

import Foundation

/* Currently working from the information on https://www.masswerk.at/6502/6502_instruction_set.html
 And also http://www.6502.org/tutorials/6502opcodes.html which was used for the timing tables
 
 */

class CPU {
    
    // Instruction Lookup table
    var instructions: [Instruction] = []
    
    // Program Counter
    var pc: UInt16 = 0
    
    // Stack Pointer
    var s: UInt8 = 0xFF
    
    // Status Register
    var p: UInt8 = 0
    
    // Accumulator
    var a: UInt8 = 0
    
    // X and Y registers
    var x: UInt8 = 0
    var y: UInt8 = 0
    
    // Program counter is also split into PCH and PCL which are the high and low 8 bits of PC
    var pch: UInt8 {
        pc.highByte()
    }
    
    var pcl: UInt8 {
        pc.lowByte()
    }
    
    var memory: Memory
    var calculationSum: Int = 0
    var memoryFetchedValue: UInt8 = 0
    var memoryReadValue: UInt8 = 0
    var memoryAddress: UInt16 = 0
    var currentInstrMode: InstructionMode = .immediate
    var fetchedInstruction: UInt8 = 0x00
    
    init(with memory: Memory) {
        self.memory = memory
        buildInstructions()
    }
    
    func peek() -> UInt8 {
        memory.read(location: pc)
    }
    
    func peek(location: UInt16) -> UInt8 {
        memory.read(location: location)
    }
    
    func get() -> UInt8 {
        pc += 1
        return memory.read(location: pc - 1)
    }
    
    internal func setFlag(_ flag: StatusFlag, for value: Int) {
        switch flag {
        
        case .N:
            //p |= ((value & 0x80) == 1 ? 1 : 0) << 7
            p = p.setBit(pos: 7, to: (value & 0x80) == 1)
        case .V:
            p |= 1 << 6
        case .D:
            p |= 1 << 3
        case .I:
            p |= 1 << 2
        case .Z:
//            p |= (value == 0 ? 1 : 0) << 1
            p = p.setBit(pos: 1, to: value == 0)
        case .C:
//            p |= value > 0xFF ? 1 : 0
            p = p.setBit(pos: 0, to: value > 0xFF)
        default:
            break
        }
    }
    
    internal func setFlag(_ flag: StatusFlag, _ value: Bool) {
        switch flag {
        
        case .N:
            p = p.setBit(pos: 7, to: value)
        case .V:
            p = p.setBit(pos: 6, to: value)
        case .D:
            p = p.setBit(pos: 3, to: value)
        case .I:
            p = p.setBit(pos: 2, to: value)
        case .Z:
            p = p.setBit(pos: 1, to: value)
        case .C:
            p = p.setBit(pos: 0, to: value)
        default:
            break
        }
    }
    
    internal func isFlagSet(_ flag: StatusFlag) -> Bool {
        switch flag {
        
        case .N:
            return p.isBitSet(pos: 7)
        case .V:
            return p.isBitSet(pos: 6)
        case .D:
            return p.isBitSet(pos: 3)
        case .I:
            return p.isBitSet(pos: 2)
        case .Z:
            return p.isBitSet(pos: 1)
        case .C:
            return p.isBitSet(pos: 0)
        default:
            return false
        }
    }
    
    func reset() {
        
        pc = UInt16.combine(lowByte: memory.read(location: 0xFFFC), highByte: memory.read(location: 0xFFFD))
        s = 0xFF
        a = 0
        x = 0
        y = 0
        p = 0b00110000
        fetchedInstruction = 0x00
    }
    
    func runCycle() {
        
        calculationSum = 0
        fetchedInstruction = get()
        
        let tableInstr = instructions.first {
            $0.details.first {
                $0.hexCode == fetchedInstruction
            } != nil
        }
        
        let correctlyAddressedInstr = tableInstr?.details.first {
            $0.hexCode == fetchedInstruction
        }
        
        if let instrToExecute = correctlyAddressedInstr, let tableInstr = tableInstr {
            
            currentInstrMode = instrToExecute.mode
            
            getInstrValueFromMemory(addressMode: instrToExecute.mode)
            
            print("******Executing instruction \(instrToExecute.syntax) with addressing mode \(instrToExecute.mode), memory value \(memoryFetchedValue)")
            
            tableInstr.executionBlock()
        }
    }
    
    func run() {
        
        calculationSum = 0
        fetchedInstruction = get()
        
        while fetchedInstruction != 0x00 {
            
            
            let tableInstr = instructions.first {
                $0.details.first {
                    $0.hexCode == fetchedInstruction
                } != nil
            }
            
            let correctlyAddressedInstr = tableInstr?.details.first {
                $0.hexCode == fetchedInstruction
            }
            
            if let instrToExecute = correctlyAddressedInstr, let tableInstr = tableInstr {
                
                currentInstrMode = instrToExecute.mode
                
                getInstrValueFromMemory(addressMode: instrToExecute.mode)
                
                print("******Executing instruction \(instrToExecute.syntax) with addressing mode \(instrToExecute.mode), memory value \(memoryFetchedValue)")
                
                tableInstr.executionBlock()
            }
            calculationSum = 0
            fetchedInstruction = get()
        }
    }
}
