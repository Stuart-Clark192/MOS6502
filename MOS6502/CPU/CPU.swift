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
    var s: UInt8 = 0
    
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
    
    init(with memory: Memory) {
        self.memory = memory
        buildInstructions()
    }
    
    func peek() -> UInt8 {
        memory.read(location: pc)
    }
    
    private func get() -> UInt8 {
        pc += 1
        return memory.read(location: pc - 1)
    }
    
    private func setFlag(_ flag: StatusFlag) {
        switch flag {

        case .N:
            p |= ((a & 0x80) != 0 ? 1 : 0) << 7
        case .V:
            p |= 1 << 6
        case .D:
            p |= 1 << 3
        case .I:
            p |= 1 << 2
        case .Z:
            p |= (a == 0 ? 1 : 0) << 1
        case .C:
            p |= calculationSum > 0xFF ? 1 : 0
        default:
            break
        }
    }
    
    func reset() {
        
        pc = UInt16.combine(lowByte: memory.read(location: 0xFFFC), highByte: memory.read(location: 0xFFFD))
        s = 0xFD
        a = 0
        x = 0
        y = 0
        
    }
    
    func runCycle() {
        
        calculationSum = 0
        let instr = get()
        
        switch instr {
        case 0x05: /* Logical Or zero paged */
            let value = get()
            a |= UInt8(memory.read(location: UInt16(value)))
            
        case 0xA5: /* Load accumulator zero paged */
            let value = get()
            a = UInt8(memory.read(location: UInt16(value)))
            
        
        case 0xA9: /* Load accumulator Immediate */
            let value = get()
            a = UInt8(value)
            
            setFlag(.N)
            setFlag(.Z)
        default:
            print("Uncoded instruction")
        }
    }
}
