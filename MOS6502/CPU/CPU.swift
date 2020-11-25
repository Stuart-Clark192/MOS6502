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
            p |= ((value & 0x80) == 1 ? 1 : 0) << 7
        case .V:
            p |= 1 << 6
        case .D:
            p |= 1 << 3
        case .I:
            p |= 1 << 2
        case .Z:
            p |= (value == 0 ? 1 : 0) << 1
        case .C:
            p |= value > 0xFF ? 1 : 0
        default:
            break
        }
    }
    
    internal func setFlag(_ flag: StatusFlag, _ value: Bool) {
        switch flag {

        case .N:
            p |= (value ? 1 : 0) << 7
        case .V:
            p |= (value ? 1 : 0) << 6
        case .D:
            p |= (value ? 1 : 0) << 3
        case .I:
            p |= (value ? 1 : 0) << 2
        case .Z:
            p |= (value ? 1 : 0) << 1
        case .C:
            p |= value ? 1 : 0
        default:
            break
        }
    }
    
    func reset() {
        
        pc = UInt16.combine(lowByte: memory.read(location: 0xFFFC), highByte: memory.read(location: 0xFFFD))
        s = 0xFF
        a = 0
        x = 0
        y = 0
        p = 0b00110000
    }
    
    func runCycle() {
        
        calculationSum = 0
        let instr = get()
        
        let tableInstr = instructions.first {
            $0.details.first {
                $0.hexCode == instr
            } != nil
        }
        
        let correctlyAddressedInstr = tableInstr?.details.first {
            $0.hexCode == instr
        }
        
        if let instrToExecute = correctlyAddressedInstr, let tableInstr = tableInstr {
            
            currentInstrMode = instrToExecute.mode
            
            getInstrValueFromMemory(addressMode: instrToExecute.mode)
            
            print("******Executing instruction \(instrToExecute.syntax) with addressing mode \(instrToExecute.mode), memory value \(memoryFetchedValue)")
            
            tableInstr.executionBlock()
        }
    }
}
