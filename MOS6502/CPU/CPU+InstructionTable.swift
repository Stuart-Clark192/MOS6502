//
//  InstructionTable.swift
//  MOS6502
//
//  Created by Stuart on 15/11/2020.
//

import Foundation

extension CPU {
    
    func buildInstructions() {
        
        // PRAGMA MARK: ADC (ADd with Carry)
        
        instructions.append(Instruction(mode: .immediate, syntax: "ADC #$44", hexCode: 0x69, len: 2, cycles: 2, flagsAffected: [.N, .V, .Z, .C], requiresAdditionalCycles: false, cyclesToAdd: 0, description: "ADd with Carry", executionBlock: nil))
        
        instructions.append(Instruction(mode: .zeroPage, syntax: "ADC $44", hexCode: 0x65, len: 2, cycles: 3, flagsAffected: [.N, .V, .Z, .C], requiresAdditionalCycles: false, cyclesToAdd: 0, description: "ADd with Carry", executionBlock: nil))
        
        instructions.append(Instruction(mode: .zeroPageX, syntax: "ADC $44,X", hexCode: 0x75, len: 2, cycles: 4, flagsAffected: [.N, .V, .Z, .C], requiresAdditionalCycles: false, cyclesToAdd: 0, description: "ADd with Carry", executionBlock: nil))
        
        instructions.append(Instruction(mode: .absolute, syntax: "ADC $4400", hexCode: 0x6D, len: 3, cycles: 4, flagsAffected: [.N, .V, .Z, .C], requiresAdditionalCycles: false, cyclesToAdd: 0, description: "ADd with Carry", executionBlock: nil))
        
        instructions.append(Instruction(mode: .absoluteX, syntax: "ADC $4400,X", hexCode: 0x7D, len: 3, cycles: 4, flagsAffected: [.N, .V, .Z, .C], requiresAdditionalCycles: true, cyclesToAdd: 1, description: "ADd with Carry add 1 cycle if page boundry is crossed", executionBlock: nil))
        
        instructions.append(Instruction(mode: .absoluteY, syntax: "ADC $4400,Y", hexCode: 0x79, len: 3, cycles: 4, flagsAffected: [.N, .V, .Z, .C], requiresAdditionalCycles: true, cyclesToAdd: 1, description: "ADd with Carry add 1 cycle if page boundry is crossed", executionBlock: nil))
        
        instructions.append(Instruction(mode: .indirectX, syntax: "ADC ($44,X)", hexCode: 0x61, len: 2, cycles: 6, flagsAffected: [.N, .V, .Z, .C], requiresAdditionalCycles: false, cyclesToAdd: 0, description: "ADd with Carry", executionBlock: nil))
        
        instructions.append(Instruction(mode: .indirectY, syntax: "ADC ($44),Y", hexCode: 0x71, len: 2, cycles: 5, flagsAffected: [.N, .V, .Z, .C], requiresAdditionalCycles: true, cyclesToAdd: 1, description: "ADd with Carry add 1 cycle if page boundry is crossed", executionBlock: nil))
        
        // PRAGMA MARK: AND (bitwise AND with accumulator)
        
        instructions.append(Instruction(mode: .immediate, syntax: "AND #$44", hexCode: 0x29, len: 2, cycles: 2, flagsAffected: [.N, .Z], requiresAdditionalCycles: false, cyclesToAdd: 0, description: "AND", executionBlock: nil))
        
        instructions.append(Instruction(mode: .zeroPage, syntax: "AND $44", hexCode: 0x25, len: 2, cycles: 3, flagsAffected: [.N, .Z], requiresAdditionalCycles: false, cyclesToAdd: 0, description: "AND", executionBlock: nil))
        
        instructions.append(Instruction(mode: .zeroPageX, syntax: "AND $44,X", hexCode: 0x35, len: 2, cycles: 4, flagsAffected: [.N, .Z], requiresAdditionalCycles: false, cyclesToAdd: 0, description: "AND", executionBlock: nil))
        
        instructions.append(Instruction(mode: .absolute, syntax: "AND $4400", hexCode: 0x2D, len: 3, cycles: 4, flagsAffected: [.N, .Z], requiresAdditionalCycles: false, cyclesToAdd: 0, description: "AND", executionBlock: nil))
        
        instructions.append(Instruction(mode: .absoluteX, syntax: "AND $4400,X", hexCode: 0x3D, len: 3, cycles: 4, flagsAffected: [.N, .Z], requiresAdditionalCycles: true, cyclesToAdd: 1, description: "AND add 1 cycle if page boundry is crossed", executionBlock: nil))
        
        instructions.append(Instruction(mode: .absoluteY, syntax: "AND $4400,Y", hexCode: 0x39, len: 3, cycles: 4, flagsAffected: [.N, .Z], requiresAdditionalCycles: true, cyclesToAdd: 1, description: "AND add 1 cycle if page boundry is crossed", executionBlock: nil))
        
        instructions.append(Instruction(mode: .indirectX, syntax: "AND ($44,X)", hexCode: 0x21, len: 2, cycles: 6, flagsAffected: [.N, .Z], requiresAdditionalCycles: false, cyclesToAdd: 0, description: "AND", executionBlock: nil))
        
        instructions.append(Instruction(mode: .indirectY, syntax: "AND ($44),Y", hexCode: 0x31, len: 2, cycles: 5, flagsAffected: [.N, .Z], requiresAdditionalCycles: true, cyclesToAdd: 1, description: "AND add 1 cycle if page boundry is crossed", executionBlock: nil))
        
        // PRAGMA MARK: ASL (Arithmetic Shift Left)
        
        instructions.append(Instruction(mode: .accumulator, syntax: "ASL A", hexCode: 0x0A, len: 1, cycles: 2, flagsAffected: [.N, .Z, .C], requiresAdditionalCycles: false, cyclesToAdd: 0, description: "ASL", executionBlock: nil))
        
        instructions.append(Instruction(mode: .zeroPage, syntax: "ASL $44", hexCode: 0x06, len: 2, cycles: 5, flagsAffected: [.N, .Z, .C], requiresAdditionalCycles: false, cyclesToAdd: 0, description: "ASL", executionBlock: nil))
        
        instructions.append(Instruction(mode: .zeroPageX, syntax: "ASL $44,X", hexCode: 0x16, len: 2, cycles: 6, flagsAffected: [.N, .Z, .C], requiresAdditionalCycles: false, cyclesToAdd: 0, description: "ASL", executionBlock: nil))
        
        instructions.append(Instruction(mode: .absolute, syntax: "ASL $4400", hexCode: 0x0E, len: 3, cycles: 6, flagsAffected: [.N, .Z, .C], requiresAdditionalCycles: false, cyclesToAdd: 0, description: "ASL", executionBlock: nil))
        
        instructions.append(Instruction(mode: .absoluteX, syntax: "ASL $4400,X", hexCode: 0x1E, len: 3, cycles: 7, flagsAffected: [.N, .Z, .C], requiresAdditionalCycles: false, cyclesToAdd: 0, description: "ASL", executionBlock: nil))
        
        // PRAGMA MARK: BIT (test BITs)
        
        instructions.append(Instruction(mode: .zeroPage, syntax: "BIT $44", hexCode: 0x24, len: 2, cycles: 3, flagsAffected: [.N, .V, .Z], requiresAdditionalCycles: false, cyclesToAdd: 0, description: "BIT", executionBlock: nil))
    
        instructions.append(Instruction(mode: .absolute, syntax: "BIT $4400", hexCode: 0x2C, len: 3, cycles: 4, flagsAffected: [.N, .V, .Z], requiresAdditionalCycles: false, cyclesToAdd: 0, description: "BIT", executionBlock: nil))
        
    }
    
    
    
}
