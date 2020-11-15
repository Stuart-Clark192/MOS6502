//
//  InstructionTable.swift
//  MOS6502
//
//  Created by Stuart on 15/11/2020.
//

import Foundation

class InstructionTable {
    var instructions: [Instruction] = []
    
    func buildInstructions() {
        
        // PRAGMA MARK: ADC (ADd with Carry)
        
        instructions.append(Instruction(mode: .immediate, syntax: "ADC #$44", hexCode: 0x69, len: 2, cycles: 2, flagsAffected: "NVZC", requiresAdditionalCycles: false, cyclesToAdd: 0, description: "ADd with Carry"))
        
        instructions.append(Instruction(mode: .zeroPage, syntax: "ADC $44", hexCode: 0x65, len: 2, cycles: 3, flagsAffected: "NVZC", requiresAdditionalCycles: false, cyclesToAdd: 0, description: "ADd with Carry"))
        
        instructions.append(Instruction(mode: .zeroPageX, syntax: "ADC $44,X", hexCode: 0x75, len: 2, cycles: 4, flagsAffected: "NVZC", requiresAdditionalCycles: false, cyclesToAdd: 0, description: "ADd with Carry"))
        
        instructions.append(Instruction(mode: .absolute, syntax: "ADC $4400", hexCode: 0x6D, len: 3, cycles: 4, flagsAffected: "NVZC", requiresAdditionalCycles: false, cyclesToAdd: 0, description: "ADd with Carry"))
        
        instructions.append(Instruction(mode: .absoluteX, syntax: "ADC $4400,X", hexCode: 0x7D, len: 3, cycles: 4, flagsAffected: "NVZC", requiresAdditionalCycles: true, cyclesToAdd: 1, description: "ADd with Carry add 1 cycle if page boundry is crossed"))
        
        instructions.append(Instruction(mode: .absoluteY, syntax: "ADC $4400,Y", hexCode: 0x79, len: 3, cycles: 4, flagsAffected: "NVZC", requiresAdditionalCycles: true, cyclesToAdd: 1, description: "ADd with Carry add 1 cycle if page boundry is crossed"))
        
        instructions.append(Instruction(mode: .indirectX, syntax: "ADC ($44,X)", hexCode: 0x61, len: 2, cycles: 6, flagsAffected: "NVZC", requiresAdditionalCycles: false, cyclesToAdd: 0, description: "ADd with Carry"))
        
        instructions.append(Instruction(mode: .indirectY, syntax: "ADC ($44),Y", hexCode: 0x71, len: 2, cycles: 5, flagsAffected: "NVZC", requiresAdditionalCycles: true, cyclesToAdd: 1, description: "ADd with Carry add 1 cycle if page boundry is crossed"))
        
        // PRAGMA MARK: AND (bitwise AND with accumulator
        
        instructions.append(Instruction(mode: .immediate, syntax: "AND #$44", hexCode: 0x29, len: 2, cycles: 2, flagsAffected: "NZ", requiresAdditionalCycles: false, cyclesToAdd: 0, description: "AND"))
        
        instructions.append(Instruction(mode: .zeroPage, syntax: "AND $44", hexCode: 0x25, len: 2, cycles: 3, flagsAffected: "NZ", requiresAdditionalCycles: false, cyclesToAdd: 0, description: "AND"))
        
        instructions.append(Instruction(mode: .zeroPageX, syntax: "AND $44,X", hexCode: 0x35, len: 2, cycles: 4, flagsAffected: "NZ", requiresAdditionalCycles: false, cyclesToAdd: 0, description: "AND"))
        
        instructions.append(Instruction(mode: .absolute, syntax: "AND $4400", hexCode: 0x2D, len: 3, cycles: 4, flagsAffected: "NZ", requiresAdditionalCycles: false, cyclesToAdd: 0, description: "AND"))
        
        instructions.append(Instruction(mode: .absoluteX, syntax: "AND $4400,X", hexCode: 0x3D, len: 3, cycles: 4, flagsAffected: "NZ", requiresAdditionalCycles: true, cyclesToAdd: 1, description: "AND add 1 cycle if page boundry is crossed"))
        
        instructions.append(Instruction(mode: .absoluteY, syntax: "AND $4400,Y", hexCode: 0x39, len: 3, cycles: 4, flagsAffected: "NZ", requiresAdditionalCycles: true, cyclesToAdd: 1, description: "AND add 1 cycle if page boundry is crossed"))
        
        instructions.append(Instruction(mode: .indirectX, syntax: "AND ($44,X)", hexCode: 0x21, len: 2, cycles: 6, flagsAffected: "NZ", requiresAdditionalCycles: false, cyclesToAdd: 0, description: "AND"))
        
        instructions.append(Instruction(mode: .indirectY, syntax: "AND ($44),Y", hexCode: 0x31, len: 2, cycles: 5, flagsAffected: "NZ", requiresAdditionalCycles: true, cyclesToAdd: 1, description: "AND add 1 cycle if page boundry is crossed"))
        
    }
}
