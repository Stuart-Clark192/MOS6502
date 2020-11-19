//
//  InstructionTable.swift
//  MOS6502
//
//  Created by Stuart on 15/11/2020.
//

import Foundation

extension CPU {
    
    func buildInstructions() {
        
        let dummyInstruct = { print("*****Dummy*****") }
        
        // PRAGMA MARK: ADC (ADd with Carry)
        instructions.append(Instruction(details: [
            InstructionDetails(mode: .immediate, syntax: "ADC #$44",    hexCode: 0x69, len: 2, cycles: 2, requiresAdditionalCycles: false, cyclesToAdd: 0),
            InstructionDetails(mode: .zeroPage,  syntax: "ADC $44",     hexCode: 0x65, len: 2, cycles: 3, requiresAdditionalCycles: false, cyclesToAdd: 0),
            InstructionDetails(mode: .zeroPageX, syntax: "ADC $44,X",   hexCode: 0x75, len: 2, cycles: 4, requiresAdditionalCycles: false, cyclesToAdd: 0),
            InstructionDetails(mode: .absolute,  syntax: "ADC $4400",   hexCode: 0x6D, len: 3, cycles: 4, requiresAdditionalCycles: false, cyclesToAdd: 0),
            InstructionDetails(mode: .absoluteX, syntax: "ADC $4400,X", hexCode: 0x7D, len: 3, cycles: 4, requiresAdditionalCycles: true,  cyclesToAdd: 1),
            InstructionDetails(mode: .absoluteY, syntax: "ADC $4400,Y", hexCode: 0x79, len: 3, cycles: 4, requiresAdditionalCycles: true,  cyclesToAdd: 1),
            InstructionDetails(mode: .indirectX, syntax: "ADC ($44,X)", hexCode: 0x61, len: 2, cycles: 6, requiresAdditionalCycles: false, cyclesToAdd: 0),
            InstructionDetails(mode: .indirectY, syntax: "ADC ($44),Y", hexCode: 0x71, len: 2, cycles: 5, requiresAdditionalCycles: true,  cyclesToAdd: 1)
        ], flagsAffected: [.N, .V, .Z, .C], description: "ADC (ADd with Carry)", executionBlock: dummyInstruct))
        
        
        // PRAGMA MARK: AND (bitwise AND with accumulator)
        
        instructions.append(Instruction(details: [
            InstructionDetails(mode: .immediate, syntax: "AND #$44",    hexCode: 0x29, len: 2, cycles: 2, requiresAdditionalCycles: false, cyclesToAdd: 0),
            InstructionDetails(mode: .zeroPage,  syntax: "AND $44",     hexCode: 0x25, len: 2, cycles: 3, requiresAdditionalCycles: false, cyclesToAdd: 0),
            InstructionDetails(mode: .zeroPageX, syntax: "AND $44,X",   hexCode: 0x35, len: 2, cycles: 4, requiresAdditionalCycles: false, cyclesToAdd: 0),
            InstructionDetails(mode: .absolute,  syntax: "AND $4400",   hexCode: 0x2D, len: 3, cycles: 4, requiresAdditionalCycles: false, cyclesToAdd: 0),
            InstructionDetails(mode: .absoluteX, syntax: "AND $4400,X", hexCode: 0x3D, len: 3, cycles: 4, requiresAdditionalCycles: true,  cyclesToAdd: 1),
            InstructionDetails(mode: .absoluteY, syntax: "AND $4400,Y", hexCode: 0x39, len: 3, cycles: 4, requiresAdditionalCycles: true,  cyclesToAdd: 1),
            InstructionDetails(mode: .indirectX, syntax: "AND ($44,X)", hexCode: 0x21, len: 2, cycles: 6, requiresAdditionalCycles: false, cyclesToAdd: 0),
            InstructionDetails(mode: .indirectY, syntax: "AND ($44),Y", hexCode: 0x31, len: 2, cycles: 5, requiresAdditionalCycles: true,  cyclesToAdd: 1)
        ], flagsAffected: [.N, .Z], description: "AND (bitwise AND with accumulator)", executionBlock: dummyInstruct))
        
        
        // PRAGMA MARK: ASL (Arithmetic Shift Left)
        
        instructions.append(Instruction(details: [
            InstructionDetails(mode: .accumulator, syntax: "ASL A",       hexCode: 0x0A, len: 1, cycles: 2, requiresAdditionalCycles: false, cyclesToAdd: 0),
            InstructionDetails(mode: .zeroPage,    syntax: "ASL $44",     hexCode: 0x06, len: 2, cycles: 5, requiresAdditionalCycles: false, cyclesToAdd: 0),
            InstructionDetails(mode: .zeroPageX,   syntax: "ASL $44,X",   hexCode: 0x16, len: 2, cycles: 6, requiresAdditionalCycles: false, cyclesToAdd: 0),
            InstructionDetails(mode: .absolute,    syntax: "ASL $4400",   hexCode: 0x0E, len: 3, cycles: 6, requiresAdditionalCycles: false, cyclesToAdd: 0),
            InstructionDetails(mode: .absoluteX,   syntax: "ASL $4400,X", hexCode: 0x1E, len: 3, cycles: 7, requiresAdditionalCycles: false, cyclesToAdd: 0)
        ], flagsAffected: [.N, .Z, .C], description: "ASL (Arithmetic Shift Left)", executionBlock: dummyInstruct))
        
        // PRAGMA MARK: BIT (test BITs)
        
        instructions.append(Instruction(details: [
            InstructionDetails(mode: .zeroPage,    syntax: "BIT $44",     hexCode: 0x24, len: 2, cycles: 3, requiresAdditionalCycles: false, cyclesToAdd: 0),
            InstructionDetails(mode: .absolute,    syntax: "BIT $4400",   hexCode: 0x2C, len: 3, cycles: 4, requiresAdditionalCycles: false, cyclesToAdd: 0)
        ], flagsAffected: [.N, .V, .Z], description: "BIT (test BITs)", executionBlock: dummyInstruct))
        
        // PRAGMA MARK: LDA (Load Accumulator)
        let ldaExecution = { self.LDA() }
        
        instructions.append(Instruction(details: [
            InstructionDetails(mode: .immediate, syntax: "LDA #$44",    hexCode: 0xA9, len: 2, cycles: 2, requiresAdditionalCycles: false, cyclesToAdd: 0),
            InstructionDetails(mode: .zeroPage,  syntax: "LDA $44",     hexCode: 0xA5, len: 2, cycles: 3, requiresAdditionalCycles: false, cyclesToAdd: 0),
            InstructionDetails(mode: .zeroPageX, syntax: "LDA $44,X",   hexCode: 0xB5, len: 2, cycles: 4, requiresAdditionalCycles: false, cyclesToAdd: 0),
            InstructionDetails(mode: .absolute,  syntax: "LDA $4400",   hexCode: 0xAD, len: 3, cycles: 4, requiresAdditionalCycles: false, cyclesToAdd: 0),
            InstructionDetails(mode: .absoluteX, syntax: "LDA $4400,X", hexCode: 0xBD, len: 3, cycles: 4, requiresAdditionalCycles: true,  cyclesToAdd: 1),
            InstructionDetails(mode: .absoluteY, syntax: "LDA $4400,Y", hexCode: 0xB9, len: 3, cycles: 4, requiresAdditionalCycles: true,  cyclesToAdd: 1),
            InstructionDetails(mode: .indirectX, syntax: "LDA ($44,X)", hexCode: 0xA1, len: 2, cycles: 6, requiresAdditionalCycles: false, cyclesToAdd: 0),
            InstructionDetails(mode: .indirectY, syntax: "LDA ($44),Y", hexCode: 0xB1, len: 2, cycles: 5, requiresAdditionalCycles: true,  cyclesToAdd: 1)
        ], flagsAffected: [.N, .Z], description: "LDA (LoaD Accumulator)", executionBlock: ldaExecution))
        
        
        // PRAGMA MARK: LDX (Load X Register)
        let ldxExecution = { self.LDX() }
        
        instructions.append(Instruction(details: [
            InstructionDetails(mode: .immediate, syntax: "LDX #$44",    hexCode: 0xA2, len: 2, cycles: 2, requiresAdditionalCycles: false, cyclesToAdd: 0),
            InstructionDetails(mode: .zeroPage,  syntax: "LDX $44",     hexCode: 0xA6, len: 2, cycles: 3, requiresAdditionalCycles: false, cyclesToAdd: 0),
            InstructionDetails(mode: .zeroPageY, syntax: "LDX $44,Y",   hexCode: 0xB6, len: 2, cycles: 4, requiresAdditionalCycles: false, cyclesToAdd: 0),
            InstructionDetails(mode: .absolute,  syntax: "LDX $4400",   hexCode: 0xAE, len: 3, cycles: 4, requiresAdditionalCycles: false, cyclesToAdd: 0),
            InstructionDetails(mode: .absoluteY, syntax: "LDX $4400,Y", hexCode: 0xBE, len: 3, cycles: 4, requiresAdditionalCycles: true,  cyclesToAdd: 1),
        ], flagsAffected: [.N, .Z], description: "LDX (LoaD X register)", executionBlock: ldxExecution))
    
        
        // PRAGMA MARK: LDY (Load Y Register)
        let ldyExecution = { self.LDY() }
        
        instructions.append(Instruction(details: [
            InstructionDetails(mode: .immediate, syntax: "LDY #$44",    hexCode: 0xA0, len: 2, cycles: 2, requiresAdditionalCycles: false, cyclesToAdd: 0),
            InstructionDetails(mode: .zeroPage,  syntax: "LDY $44",     hexCode: 0xA4, len: 2, cycles: 3, requiresAdditionalCycles: false, cyclesToAdd: 0),
            InstructionDetails(mode: .zeroPageX, syntax: "LDY $44,X",   hexCode: 0xB4, len: 2, cycles: 4, requiresAdditionalCycles: false, cyclesToAdd: 0),
            InstructionDetails(mode: .absolute,  syntax: "LDY $4400",   hexCode: 0xAC, len: 3, cycles: 4, requiresAdditionalCycles: false, cyclesToAdd: 0),
            InstructionDetails(mode: .absoluteX, syntax: "LDY $4400,X", hexCode: 0xBC, len: 3, cycles: 4, requiresAdditionalCycles: true,  cyclesToAdd: 1),
        ], flagsAffected: [.N, .Z], description: "LDY (LoaD Y register)", executionBlock: ldyExecution))

    }
}
