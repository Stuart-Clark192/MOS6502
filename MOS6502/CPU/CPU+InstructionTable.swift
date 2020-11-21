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
        let adcExecution = { self.ADC() }
        
        instructions.append(Instruction(details: [
            InstructionDetails(mode: .immediate, syntax: "ADC #$44",    hexCode: 0x69, len: 2, cycles: 2, requiresAdditionalCycles: false, cyclesToAdd: 0),
            InstructionDetails(mode: .zeroPage,  syntax: "ADC $44",     hexCode: 0x65, len: 2, cycles: 3, requiresAdditionalCycles: false, cyclesToAdd: 0),
            InstructionDetails(mode: .zeroPageX, syntax: "ADC $44,X",   hexCode: 0x75, len: 2, cycles: 4, requiresAdditionalCycles: false, cyclesToAdd: 0),
            InstructionDetails(mode: .absolute,  syntax: "ADC $4400",   hexCode: 0x6D, len: 3, cycles: 4, requiresAdditionalCycles: false, cyclesToAdd: 0),
            InstructionDetails(mode: .absoluteX, syntax: "ADC $4400,X", hexCode: 0x7D, len: 3, cycles: 4, requiresAdditionalCycles: true,  cyclesToAdd: 1),
            InstructionDetails(mode: .absoluteY, syntax: "ADC $4400,Y", hexCode: 0x79, len: 3, cycles: 4, requiresAdditionalCycles: true,  cyclesToAdd: 1),
            InstructionDetails(mode: .indirectX, syntax: "ADC ($44,X)", hexCode: 0x61, len: 2, cycles: 6, requiresAdditionalCycles: false, cyclesToAdd: 0),
            InstructionDetails(mode: .indirectY, syntax: "ADC ($44),Y", hexCode: 0x71, len: 2, cycles: 5, requiresAdditionalCycles: true,  cyclesToAdd: 1)
        ], flagsAffected: [.N, .V, .Z, .C], description: "ADC (ADd with Carry)", executionBlock: adcExecution))
        
        
        // PRAGMA MARK: AND (bitwise AND with accumulator)
        let andExecution = { self.AND() }
        
        instructions.append(Instruction(details: [
            InstructionDetails(mode: .immediate, syntax: "AND #$44",    hexCode: 0x29, len: 2, cycles: 2, requiresAdditionalCycles: false, cyclesToAdd: 0),
            InstructionDetails(mode: .zeroPage,  syntax: "AND $44",     hexCode: 0x25, len: 2, cycles: 3, requiresAdditionalCycles: false, cyclesToAdd: 0),
            InstructionDetails(mode: .zeroPageX, syntax: "AND $44,X",   hexCode: 0x35, len: 2, cycles: 4, requiresAdditionalCycles: false, cyclesToAdd: 0),
            InstructionDetails(mode: .absolute,  syntax: "AND $4400",   hexCode: 0x2D, len: 3, cycles: 4, requiresAdditionalCycles: false, cyclesToAdd: 0),
            InstructionDetails(mode: .absoluteX, syntax: "AND $4400,X", hexCode: 0x3D, len: 3, cycles: 4, requiresAdditionalCycles: true,  cyclesToAdd: 1),
            InstructionDetails(mode: .absoluteY, syntax: "AND $4400,Y", hexCode: 0x39, len: 3, cycles: 4, requiresAdditionalCycles: true,  cyclesToAdd: 1),
            InstructionDetails(mode: .indirectX, syntax: "AND ($44,X)", hexCode: 0x21, len: 2, cycles: 6, requiresAdditionalCycles: false, cyclesToAdd: 0),
            InstructionDetails(mode: .indirectY, syntax: "AND ($44),Y", hexCode: 0x31, len: 2, cycles: 5, requiresAdditionalCycles: true,  cyclesToAdd: 1)
        ], flagsAffected: [.N, .Z], description: "AND (bitwise AND with accumulator)", executionBlock: andExecution))
        
        
        // PRAGMA MARK: ASL (Arithmetic Shift Left)
        let aslExecution = { self.ASL() }
        
        instructions.append(Instruction(details: [
            InstructionDetails(mode: .accumulator, syntax: "ASL A",       hexCode: 0x0A, len: 1, cycles: 2, requiresAdditionalCycles: false, cyclesToAdd: 0),
            InstructionDetails(mode: .zeroPage,    syntax: "ASL $44",     hexCode: 0x06, len: 2, cycles: 5, requiresAdditionalCycles: false, cyclesToAdd: 0),
            InstructionDetails(mode: .zeroPageX,   syntax: "ASL $44,X",   hexCode: 0x16, len: 2, cycles: 6, requiresAdditionalCycles: false, cyclesToAdd: 0),
            InstructionDetails(mode: .absolute,    syntax: "ASL $4400",   hexCode: 0x0E, len: 3, cycles: 6, requiresAdditionalCycles: false, cyclesToAdd: 0),
            InstructionDetails(mode: .absoluteX,   syntax: "ASL $4400,X", hexCode: 0x1E, len: 3, cycles: 7, requiresAdditionalCycles: false, cyclesToAdd: 0)
        ], flagsAffected: [.N, .Z, .C], description: "ASL (Arithmetic Shift Left)", executionBlock: aslExecution))
        
        // PRAGMA MARK: BIT (test BITs)
        let bitExecution = { self.BIT() }
        
        instructions.append(Instruction(details: [
            InstructionDetails(mode: .zeroPage,    syntax: "BIT $44",     hexCode: 0x24, len: 2, cycles: 3, requiresAdditionalCycles: false, cyclesToAdd: 0),
            InstructionDetails(mode: .absolute,    syntax: "BIT $4400",   hexCode: 0x2C, len: 3, cycles: 4, requiresAdditionalCycles: false, cyclesToAdd: 0)
        ], flagsAffected: [.N, .V, .Z], description: "BIT (test BITs)", executionBlock: bitExecution))
        
        // PRAGMA MARK: Branch Instructions
        
        let bplExecution = { self.BPL() }
        let bmiExecution = { self.BMI() }
        let bvcExecution = { self.BVC() }
        let bvsExecution = { self.BVS() }
        let bccExecution = { self.BCC() }
        let bcsExecution = { self.BCS() }
        let bneExecution = { self.BNE() }
        let beqExecution = { self.BEQ() }
        
        instructions.append(Instruction(details: [
            InstructionDetails(mode: .relative, syntax: "BPL",       hexCode: 0x10, len: 2, cycles: 2, requiresAdditionalCycles: false, cyclesToAdd: 0)
        ], flagsAffected: [], description: "BPL (Branch on PLus)", executionBlock: bplExecution))
        
        instructions.append(Instruction(details: [
            InstructionDetails(mode: .relative, syntax: "BMI",       hexCode: 0x30, len: 2, cycles: 2, requiresAdditionalCycles: false, cyclesToAdd: 0)
        ], flagsAffected: [], description: "BMI (Branch on MInus)", executionBlock: bmiExecution))
        
        instructions.append(Instruction(details: [
            InstructionDetails(mode: .relative, syntax: "BVC",       hexCode: 0x50, len: 2, cycles: 2, requiresAdditionalCycles: false, cyclesToAdd: 0)
        ], flagsAffected: [], description: "BVC (Branch on oVerflow Clear)", executionBlock: bvcExecution))
        
        instructions.append(Instruction(details: [
            InstructionDetails(mode: .relative, syntax: "BVS",       hexCode: 0x70, len: 2, cycles: 2, requiresAdditionalCycles: false, cyclesToAdd: 0)
        ], flagsAffected: [], description: "BVS (Branch on oVerflow Set)", executionBlock: bvsExecution))
        
        instructions.append(Instruction(details: [
            InstructionDetails(mode: .relative, syntax: "BCC",       hexCode: 0x90, len: 2, cycles: 2, requiresAdditionalCycles: false, cyclesToAdd: 0)
        ], flagsAffected: [], description: "BCC (Branch on Carry Clear)", executionBlock: bccExecution))
        
        instructions.append(Instruction(details: [
            InstructionDetails(mode: .relative, syntax: "BCS",       hexCode: 0xB0, len: 2, cycles: 2, requiresAdditionalCycles: false, cyclesToAdd: 0)
        ], flagsAffected: [], description: "BCS (Branch on Carry Set)", executionBlock: bcsExecution))
        
        instructions.append(Instruction(details: [
            InstructionDetails(mode: .relative, syntax: "BNE",       hexCode: 0xD0, len: 2, cycles: 2, requiresAdditionalCycles: false, cyclesToAdd: 0)
        ], flagsAffected: [], description: "BNE (Branch on Not Equal)", executionBlock: bneExecution))
        
        instructions.append(Instruction(details: [
            InstructionDetails(mode: .relative, syntax: "BEQ",       hexCode: 0xF0, len: 2, cycles: 2, requiresAdditionalCycles: false, cyclesToAdd: 0)
        ], flagsAffected: [], description: "BEQ (Branch on EQual)", executionBlock: beqExecution))
        
        // PRAGMA MARK: BRK (BReaK)
        // TODO: Really need an implied mode!!
        
        let brkExecution = { self.BRK() }
        
        instructions.append(Instruction(details: [
            InstructionDetails(mode: .accumulator, syntax: "BRK",       hexCode: 0x00, len: 1, cycles: 7, requiresAdditionalCycles: false, cyclesToAdd: 0)
        ], flagsAffected: [], description: "BRK (BReaK)", executionBlock: brkExecution))
        
        
        // PRAGMA MARK: CPX (CoMPare accumulator)
        let cmpExecution = { self.CMP() }
        
        instructions.append(Instruction(details: [
            InstructionDetails(mode: .immediate, syntax: "CMP #$44",    hexCode: 0xC9, len: 2, cycles: 2, requiresAdditionalCycles: false, cyclesToAdd: 0),
            InstructionDetails(mode: .zeroPage,  syntax: "CMP $44",     hexCode: 0xC5, len: 2, cycles: 3, requiresAdditionalCycles: false, cyclesToAdd: 0),
            InstructionDetails(mode: .zeroPageX, syntax: "CMP $44,X",   hexCode: 0xD5, len: 2, cycles: 4, requiresAdditionalCycles: false, cyclesToAdd: 0),
            InstructionDetails(mode: .absolute,  syntax: "CMP $4400",   hexCode: 0xCD, len: 3, cycles: 4, requiresAdditionalCycles: false, cyclesToAdd: 0),
            InstructionDetails(mode: .absoluteX, syntax: "CMP $4400,X", hexCode: 0xDD, len: 3, cycles: 4, requiresAdditionalCycles: true,  cyclesToAdd: 1),
            InstructionDetails(mode: .absoluteY, syntax: "CMP $4400,Y", hexCode: 0xD9, len: 3, cycles: 4, requiresAdditionalCycles: true,  cyclesToAdd: 1),
            InstructionDetails(mode: .indirectX, syntax: "CMP ($44,X)", hexCode: 0xC1, len: 2, cycles: 6, requiresAdditionalCycles: false, cyclesToAdd: 0),
            InstructionDetails(mode: .indirectY, syntax: "CMP ($44),Y", hexCode: 0xD1, len: 2, cycles: 5, requiresAdditionalCycles: true,  cyclesToAdd: 1)
        ], flagsAffected: [.N, .Z, .C], description: "CMP (CoMPare accumulator)", executionBlock: cmpExecution))
        
        // PRAGMA MARK: CPX (ComPare X register)
        let cpxExecution = { self.CPX() }
        
        instructions.append(Instruction(details: [
            InstructionDetails(mode: .immediate, syntax: "CPX #$44",    hexCode: 0xE0, len: 2, cycles: 2, requiresAdditionalCycles: false, cyclesToAdd: 0),
            InstructionDetails(mode: .zeroPage,  syntax: "CPX $44",     hexCode: 0xE4, len: 2, cycles: 3, requiresAdditionalCycles: false, cyclesToAdd: 0),
            InstructionDetails(mode: .absolute,  syntax: "CPX $4400",   hexCode: 0xEC, len: 3, cycles: 4, requiresAdditionalCycles: false, cyclesToAdd: 0)
        ], flagsAffected: [.N, .Z, .C], description: "CPX (ComPare X register)", executionBlock: cpxExecution))
        
        // PRAGMA MARK: CPY (ComPare Y register)
        let cpyExecution = { self.CPY() }
        
        instructions.append(Instruction(details: [
            InstructionDetails(mode: .immediate, syntax: "CPY #$44",    hexCode: 0xC0, len: 2, cycles: 2, requiresAdditionalCycles: false, cyclesToAdd: 0),
            InstructionDetails(mode: .zeroPage,  syntax: "CPY $44",     hexCode: 0xC4, len: 2, cycles: 3, requiresAdditionalCycles: false, cyclesToAdd: 0),
            InstructionDetails(mode: .absolute,  syntax: "CPY $4400",   hexCode: 0xCC, len: 3, cycles: 4, requiresAdditionalCycles: false, cyclesToAdd: 0)
        ], flagsAffected: [.N, .Z, .C], description: "CPY (ComPare Y register)", executionBlock: cpyExecution))
        
        // PRAGMA MARK: DEC (DECrement memory)
        let decExecution = { self.DEC() }
        
        instructions.append(Instruction(details: [
            InstructionDetails(mode: .zeroPage,  syntax: "DEC $44",     hexCode: 0xC6, len: 2, cycles: 5, requiresAdditionalCycles: false, cyclesToAdd: 0),
            InstructionDetails(mode: .zeroPageX, syntax: "DEC $44,X",   hexCode: 0xD6, len: 2, cycles: 6, requiresAdditionalCycles: false, cyclesToAdd: 0),
            InstructionDetails(mode: .absolute,  syntax: "DEC $4400",   hexCode: 0xCE, len: 3, cycles: 6, requiresAdditionalCycles: false, cyclesToAdd: 0),
            InstructionDetails(mode: .absoluteX, syntax: "DEC $4400,X", hexCode: 0xDE, len: 3, cycles: 7, requiresAdditionalCycles: false, cyclesToAdd: 0)
        ], flagsAffected: [.N, .Z], description: "DEC (DECrement memory)", executionBlock: decExecution))
        
        // PRAGMA MARK: EOR (bitwise Exclusive OR)
        let eorExecution = { self.EOR() }
        
        instructions.append(Instruction(details: [
            InstructionDetails(mode: .immediate, syntax: "EOR #$44",    hexCode: 0x49, len: 2, cycles: 2, requiresAdditionalCycles: false, cyclesToAdd: 0),
            InstructionDetails(mode: .zeroPage,  syntax: "EOR $44",     hexCode: 0x45, len: 2, cycles: 3, requiresAdditionalCycles: false, cyclesToAdd: 0),
            InstructionDetails(mode: .zeroPageX, syntax: "EOR $44,X",   hexCode: 0x55, len: 2, cycles: 4, requiresAdditionalCycles: false, cyclesToAdd: 0),
            InstructionDetails(mode: .absolute,  syntax: "EOR $4400",   hexCode: 0x4D, len: 3, cycles: 4, requiresAdditionalCycles: false, cyclesToAdd: 0),
            InstructionDetails(mode: .absoluteX, syntax: "EOR $4400,X", hexCode: 0x5D, len: 3, cycles: 4, requiresAdditionalCycles: true,  cyclesToAdd: 1),
            InstructionDetails(mode: .absoluteY, syntax: "EOR $4400,Y", hexCode: 0x59, len: 3, cycles: 4, requiresAdditionalCycles: true,  cyclesToAdd: 1),
            InstructionDetails(mode: .indirectX, syntax: "EOR ($44,X)", hexCode: 0x41, len: 2, cycles: 6, requiresAdditionalCycles: false, cyclesToAdd: 0),
            InstructionDetails(mode: .indirectY, syntax: "EOR ($44),Y", hexCode: 0x51, len: 2, cycles: 5, requiresAdditionalCycles: true,  cyclesToAdd: 1)
        ], flagsAffected: [.N, .Z], description: "EOR (bitwise Exclusive OR)", executionBlock: eorExecution))
        
        // PRAGMA MARK: Flag (Processor Status) Instructions
        
        let clcExecution = { self.CLC() }
        let secExecution = { self.SEC() }
        let cliExecution = { self.CLI() }
        let seiExecution = { self.SEI() }
        let clvExecution = { self.CLV() }
        let cldExecution = { self.CLD() }
        let sedExecution = { self.SED() }
        
        instructions.append(Instruction(details: [
            InstructionDetails(mode: .accumulator, syntax: "CLC",       hexCode: 0x18, len: 1, cycles: 2, requiresAdditionalCycles: false, cyclesToAdd: 0)
        ], flagsAffected: [], description: "CLC (CLear Carry)", executionBlock: clcExecution))
        
        instructions.append(Instruction(details: [
            InstructionDetails(mode: .accumulator, syntax: "SEC",       hexCode: 0x38, len: 1, cycles: 2, requiresAdditionalCycles: false, cyclesToAdd: 0)
        ], flagsAffected: [], description: "SEC (SEt Carry)", executionBlock: secExecution))
        
        instructions.append(Instruction(details: [
            InstructionDetails(mode: .accumulator, syntax: "CLI",       hexCode: 0x58, len: 1, cycles: 2, requiresAdditionalCycles: false, cyclesToAdd: 0)
        ], flagsAffected: [], description: "CLI (CLear Interrupt)", executionBlock: cliExecution))
        
        instructions.append(Instruction(details: [
            InstructionDetails(mode: .accumulator, syntax: "SEI",       hexCode: 0x78, len: 1, cycles: 2, requiresAdditionalCycles: false, cyclesToAdd: 0)
        ], flagsAffected: [], description: "SEI (SEt Interrupt)", executionBlock: seiExecution))
        
        instructions.append(Instruction(details: [
            InstructionDetails(mode: .accumulator, syntax: "CLV",       hexCode: 0xB8, len: 1, cycles: 2, requiresAdditionalCycles: false, cyclesToAdd: 0)
        ], flagsAffected: [], description: "CLV (CLear oVerflow)", executionBlock: clvExecution))
        
        instructions.append(Instruction(details: [
            InstructionDetails(mode: .accumulator, syntax: "CLD",       hexCode: 0xD8, len: 1, cycles: 2, requiresAdditionalCycles: false, cyclesToAdd: 0)
        ], flagsAffected: [], description: "CLD (CLear Decimal)", executionBlock: cldExecution))
        
        instructions.append(Instruction(details: [
            InstructionDetails(mode: .accumulator, syntax: "SED",       hexCode: 0xF8, len: 1, cycles: 2, requiresAdditionalCycles: false, cyclesToAdd: 0)
        ], flagsAffected: [], description: "SED (SEt Decimal)", executionBlock: sedExecution))
        
        // PRAGMA MARK: INC (INCrement memory)
        let incExecution = { self.INC() }
        
        instructions.append(Instruction(details: [
            InstructionDetails(mode: .zeroPage,  syntax: "INC $44",     hexCode: 0xE6, len: 2, cycles: 5, requiresAdditionalCycles: false, cyclesToAdd: 0),
            InstructionDetails(mode: .zeroPageX, syntax: "INC $44,X",   hexCode: 0xF6, len: 2, cycles: 6, requiresAdditionalCycles: false, cyclesToAdd: 0),
            InstructionDetails(mode: .absolute,  syntax: "INC $4400",   hexCode: 0xEE, len: 3, cycles: 6, requiresAdditionalCycles: false, cyclesToAdd: 0),
            InstructionDetails(mode: .absoluteX, syntax: "INC $4400,X", hexCode: 0xFE, len: 3, cycles: 7, requiresAdditionalCycles: false,  cyclesToAdd: 0),
        ], flagsAffected: [.N, .Z], description: "INC (INCrement memory)", executionBlock: incExecution))
        
        // PRAGMA MARK: JMP (JuMP)
        // TODO: Need indirect - confirm though
        let jmpExecution = { self.JMP() }
        
        instructions.append(Instruction(details: [
            InstructionDetails(mode: .absolute,  syntax: "JMP $4400",   hexCode: 0x4C, len: 3, cycles: 3, requiresAdditionalCycles: false, cyclesToAdd: 0)
        ], flagsAffected: [], description: "JMP (JuMP)", executionBlock: jmpExecution))
        
        // PRAGMA MARK: JSR (Jump to SubRoutine)
        let jsrExecution = { self.JSR() }
        
        instructions.append(Instruction(details: [
            InstructionDetails(mode: .absolute,  syntax: "JSR $4400",   hexCode: 0x4C, len: 3, cycles: 6, requiresAdditionalCycles: false, cyclesToAdd: 0)
        ], flagsAffected: [], description: "JSR (Jump to SubRoutine)", executionBlock: jsrExecution))
        
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
        
        // PRAGMA MARK: LSR (Logical Shift Right)
        let lsrExecution = { self.LSR() }
        
        instructions.append(Instruction(details: [
            InstructionDetails(mode: .accumulator, syntax: "LSR A",       hexCode: 0x4A, len: 1, cycles: 2, requiresAdditionalCycles: false, cyclesToAdd: 0),
            InstructionDetails(mode: .zeroPage,    syntax: "LSR $44",     hexCode: 0x46, len: 2, cycles: 5, requiresAdditionalCycles: false, cyclesToAdd: 0),
            InstructionDetails(mode: .zeroPageX,   syntax: "LSR $44,X",   hexCode: 0x56, len: 2, cycles: 6, requiresAdditionalCycles: false, cyclesToAdd: 0),
            InstructionDetails(mode: .absolute,    syntax: "LSR $4400",   hexCode: 0x4E, len: 3, cycles: 6, requiresAdditionalCycles: false, cyclesToAdd: 0),
            InstructionDetails(mode: .absoluteX,   syntax: "LSR $4400,X", hexCode: 0x5E, len: 3, cycles: 7, requiresAdditionalCycles: false, cyclesToAdd: 0),
        ], flagsAffected: [.N, .Z, .C], description: "LSR (Logical Shift Right)", executionBlock: lsrExecution))
        
        // PRAGMA MARK: NOP (No OPeration)
        let nopExecution = { self.NOP() }
        
        instructions.append(Instruction(details: [
            InstructionDetails(mode: .accumulator, syntax: "NOP",       hexCode: 0xEA, len: 1, cycles: 2, requiresAdditionalCycles: false, cyclesToAdd: 0)
        ], flagsAffected: [], description: "NOP (No OPeration)", executionBlock: nopExecution))
        
        // PRAGMA MARK: ORA (bitwise OR with Accumulator)
        let oraExecution = { self.ORA() }
        
        instructions.append(Instruction(details: [
            InstructionDetails(mode: .immediate, syntax: "ORA #$44",    hexCode: 0x09, len: 2, cycles: 2, requiresAdditionalCycles: false, cyclesToAdd: 0),
            InstructionDetails(mode: .zeroPage,  syntax: "ORA $44",     hexCode: 0x05, len: 2, cycles: 3, requiresAdditionalCycles: false, cyclesToAdd: 0),
            InstructionDetails(mode: .zeroPageX, syntax: "ORA $44,X",   hexCode: 0x15, len: 2, cycles: 4, requiresAdditionalCycles: false, cyclesToAdd: 0),
            InstructionDetails(mode: .absolute,  syntax: "ORA $4400",   hexCode: 0x0D, len: 3, cycles: 4, requiresAdditionalCycles: false, cyclesToAdd: 0),
            InstructionDetails(mode: .absoluteX, syntax: "ORA $4400,X", hexCode: 0x1D, len: 3, cycles: 4, requiresAdditionalCycles: true,  cyclesToAdd: 1),
            InstructionDetails(mode: .absoluteY, syntax: "ORA $4400,Y", hexCode: 0x19, len: 3, cycles: 4, requiresAdditionalCycles: true,  cyclesToAdd: 1),
            InstructionDetails(mode: .indirectX, syntax: "ORA ($44,X)", hexCode: 0x01, len: 2, cycles: 6, requiresAdditionalCycles: false, cyclesToAdd: 0),
            InstructionDetails(mode: .indirectY, syntax: "ORA ($44),Y", hexCode: 0x11, len: 2, cycles: 5, requiresAdditionalCycles: true,  cyclesToAdd: 1)
        ], flagsAffected: [.N, .Z], description: "ORA (bitwise OR with Accumulator)", executionBlock: oraExecution))
        
        // PRAGMA MARK: Register Instructions
        
        let taxExecution = { self.TAX() }
        let txaExecution = { self.TXA() }
        let dexExecution = { self.DEX() }
        let inxExecution = { self.INX() }
        let tayExecution = { self.TAY() }
        let tyaExecution = { self.TYA() }
        let deyExecution = { self.DEY() }
        let inyExecution = { self.INY() }
        
        instructions.append(Instruction(details: [
            InstructionDetails(mode: .accumulator, syntax: "TAX",       hexCode: 0xAA, len: 1, cycles: 2, requiresAdditionalCycles: false, cyclesToAdd: 0)
        ], flagsAffected: [], description: "TAX (Transfer A to X)", executionBlock: taxExecution))
        
        instructions.append(Instruction(details: [
            InstructionDetails(mode: .accumulator, syntax: "TXA",       hexCode: 0x8A, len: 1, cycles: 2, requiresAdditionalCycles: false, cyclesToAdd: 0)
        ], flagsAffected: [], description: "TXA (Transfer X to A)", executionBlock: txaExecution))
        
        instructions.append(Instruction(details: [
            InstructionDetails(mode: .accumulator, syntax: "DEX",       hexCode: 0xCA, len: 1, cycles: 2, requiresAdditionalCycles: false, cyclesToAdd: 0)
        ], flagsAffected: [], description: "DEX (DEcrement X)", executionBlock: dexExecution))
        
        instructions.append(Instruction(details: [
            InstructionDetails(mode: .accumulator, syntax: "INX",       hexCode: 0xE8, len: 1, cycles: 2, requiresAdditionalCycles: false, cyclesToAdd: 0)
        ], flagsAffected: [], description: "INX (INcrement X)", executionBlock: inxExecution))
        
        instructions.append(Instruction(details: [
            InstructionDetails(mode: .accumulator, syntax: "TAY",       hexCode: 0xA8, len: 1, cycles: 2, requiresAdditionalCycles: false, cyclesToAdd: 0)
        ], flagsAffected: [], description: "TAY (Transfer A to Y)", executionBlock: tayExecution))
        
        instructions.append(Instruction(details: [
            InstructionDetails(mode: .accumulator, syntax: "TYA",       hexCode: 0x98, len: 1, cycles: 2, requiresAdditionalCycles: false, cyclesToAdd: 0)
        ], flagsAffected: [], description: "TYA (Transfer Y to A)", executionBlock: tyaExecution))
        
        instructions.append(Instruction(details: [
            InstructionDetails(mode: .accumulator, syntax: "DEY",       hexCode: 0x88, len: 1, cycles: 2, requiresAdditionalCycles: false, cyclesToAdd: 0)
        ], flagsAffected: [], description: "DEY (DEcrement Y)", executionBlock: deyExecution))
        
        instructions.append(Instruction(details: [
            InstructionDetails(mode: .accumulator, syntax: "INY",       hexCode: 0xc8, len: 1, cycles: 2, requiresAdditionalCycles: false, cyclesToAdd: 0)
        ], flagsAffected: [], description: "INY (INcrement Y)", executionBlock: inyExecution))
        
        
        // PRAGMA MARK: ROL (ROtate Left)
        let rolExecution = { self.ROL() }
        
        instructions.append(Instruction(details: [
            InstructionDetails(mode: .accumulator, syntax: "ROL A",       hexCode: 0x2A, len: 1, cycles: 2, requiresAdditionalCycles: false, cyclesToAdd: 0),
            InstructionDetails(mode: .zeroPage,    syntax: "ROL $44",     hexCode: 0x26, len: 2, cycles: 5, requiresAdditionalCycles: false, cyclesToAdd: 0),
            InstructionDetails(mode: .zeroPageX,   syntax: "ROL $44,X",   hexCode: 0x36, len: 2, cycles: 6, requiresAdditionalCycles: false, cyclesToAdd: 0),
            InstructionDetails(mode: .absolute,    syntax: "ROL $4400",   hexCode: 0x2E, len: 3, cycles: 6, requiresAdditionalCycles: false, cyclesToAdd: 0),
            InstructionDetails(mode: .absoluteX,   syntax: "ROL $4400,X", hexCode: 0x3E, len: 3, cycles: 7, requiresAdditionalCycles: false, cyclesToAdd: 0),
        ], flagsAffected: [.N, .Z, .C], description: "ROL (ROtate Left)", executionBlock: rolExecution))
        
        // PRAGMA MARK: ROR (ROtate Right)
        let rorExecution = { self.ROR() }
        
        instructions.append(Instruction(details: [
            InstructionDetails(mode: .accumulator, syntax: "ROR A",       hexCode: 0x6A, len: 1, cycles: 2, requiresAdditionalCycles: false, cyclesToAdd: 0),
            InstructionDetails(mode: .zeroPage,    syntax: "ROR $44",     hexCode: 0x66, len: 2, cycles: 5, requiresAdditionalCycles: false, cyclesToAdd: 0),
            InstructionDetails(mode: .zeroPageX,   syntax: "ROR $44,X",   hexCode: 0x76, len: 2, cycles: 6, requiresAdditionalCycles: false, cyclesToAdd: 0),
            InstructionDetails(mode: .absolute,    syntax: "ROR $4400",   hexCode: 0x6E, len: 3, cycles: 6, requiresAdditionalCycles: false, cyclesToAdd: 0),
            InstructionDetails(mode: .absoluteX,   syntax: "ROR $4400,X", hexCode: 0x7E, len: 3, cycles: 7, requiresAdditionalCycles: false, cyclesToAdd: 0),
        ], flagsAffected: [.N, .Z, .C], description: "ROR (ROtate Reft)", executionBlock: rorExecution))
        
        // PRAGMA MARK: RTI (ReTurn from Interrupt)
        let rtiExecution = { self.RTI() }
        
        instructions.append(Instruction(details: [
            InstructionDetails(mode: .accumulator, syntax: "RTI",       hexCode: 0x40, len: 1, cycles: 6, requiresAdditionalCycles: false, cyclesToAdd: 0)
        ], flagsAffected: [], description: "RTI (ReTurn from Interrupt)", executionBlock: rtiExecution))
        
        // PRAGMA MARK: RTS (ReTurn from Subroutine)
        let rtsExecution = { self.RTS() }
        
        instructions.append(Instruction(details: [
            InstructionDetails(mode: .accumulator, syntax: "RTS",       hexCode: 0x60, len: 1, cycles: 6, requiresAdditionalCycles: false, cyclesToAdd: 0)
        ], flagsAffected: [], description: "RTI (ReTurn from Interrupt)", executionBlock: rtsExecution))
        
        // PRAGMA MARK: SBC (SuBtract with Carry)
        
        let sbcExecution = { self.SBC() }
        
        instructions.append(Instruction(details: [
            InstructionDetails(mode: .immediate, syntax: "SBC #$44",    hexCode: 0xE9, len: 2, cycles: 2, requiresAdditionalCycles: false, cyclesToAdd: 0),
            InstructionDetails(mode: .zeroPage,  syntax: "SBC $44",     hexCode: 0xE5, len: 2, cycles: 3, requiresAdditionalCycles: false, cyclesToAdd: 0),
            InstructionDetails(mode: .zeroPageX, syntax: "SBC $44,X",   hexCode: 0xF5, len: 2, cycles: 4, requiresAdditionalCycles: false, cyclesToAdd: 0),
            InstructionDetails(mode: .absolute,  syntax: "SBC $4400",   hexCode: 0xED, len: 3, cycles: 4, requiresAdditionalCycles: false, cyclesToAdd: 0),
            InstructionDetails(mode: .absoluteX, syntax: "SBC $4400,X", hexCode: 0xFD, len: 3, cycles: 4, requiresAdditionalCycles: true,  cyclesToAdd: 1),
            InstructionDetails(mode: .absoluteY, syntax: "SBC $4400,Y", hexCode: 0xF9, len: 3, cycles: 4, requiresAdditionalCycles: true,  cyclesToAdd: 1),
            InstructionDetails(mode: .indirectX, syntax: "SBC ($44,X)", hexCode: 0xE1, len: 2, cycles: 6, requiresAdditionalCycles: false, cyclesToAdd: 0),
            InstructionDetails(mode: .indirectY, syntax: "SBC ($44),Y", hexCode: 0xF1, len: 2, cycles: 5, requiresAdditionalCycles: true,  cyclesToAdd: 1)
        ], flagsAffected: [.N, .V, .Z, .C], description: "SBC (SuBtract with Carry)", executionBlock: sbcExecution))
        
        // PRAGMA MARK: STA (STore Accumulator)
        
        let staExecution = { self.STA() }
        
        instructions.append(Instruction(details: [
            InstructionDetails(mode: .zeroPage,  syntax: "STA $44",     hexCode: 0x85, len: 2, cycles: 3, requiresAdditionalCycles: false, cyclesToAdd: 0),
            InstructionDetails(mode: .zeroPageX, syntax: "STA $44,X",   hexCode: 0x95, len: 2, cycles: 4, requiresAdditionalCycles: false, cyclesToAdd: 0),
            InstructionDetails(mode: .absolute,  syntax: "STA $4400",   hexCode: 0x8D, len: 3, cycles: 4, requiresAdditionalCycles: false, cyclesToAdd: 0),
            InstructionDetails(mode: .absoluteX, syntax: "STA $4400,X", hexCode: 0x9D, len: 3, cycles: 5, requiresAdditionalCycles: false,  cyclesToAdd: 0),
            InstructionDetails(mode: .absoluteY, syntax: "STA $4400,Y", hexCode: 0x99, len: 3, cycles: 5, requiresAdditionalCycles: false,  cyclesToAdd: 0),
            InstructionDetails(mode: .indirectX, syntax: "STA ($44,X)", hexCode: 0x81, len: 2, cycles: 6, requiresAdditionalCycles: false, cyclesToAdd: 0),
            InstructionDetails(mode: .indirectY, syntax: "STA ($44),Y", hexCode: 0x91, len: 2, cycles: 6, requiresAdditionalCycles: false,  cyclesToAdd: 0)
        ], flagsAffected: [], description: "STA (STore Accumulator)", executionBlock: staExecution))
        
        // PRAGMA MARK: Stack Instructions
        let txsExecution = { self.TXS() }
        let tsxExecution = { self.TSX() }
        let phaExecution = { self.PHA() }
        let plaExecution = { self.PLA() }
        let phpExecution = { self.PHP() }
        let plpExecution = { self.PLP() }
        
        instructions.append(Instruction(details: [
            InstructionDetails(mode: .accumulator, syntax: "TXS",       hexCode: 0x9A, len: 1, cycles: 2, requiresAdditionalCycles: false, cyclesToAdd: 0)
        ], flagsAffected: [], description: "TXS (Transfer X to Stack ptr)", executionBlock: txsExecution))
        
        instructions.append(Instruction(details: [
            InstructionDetails(mode: .accumulator, syntax: "TSX",       hexCode: 0xBA, len: 1, cycles: 2, requiresAdditionalCycles: false, cyclesToAdd: 0)
        ], flagsAffected: [], description: "TSX (Transfer Stack ptr to X)", executionBlock: tsxExecution))
        
        instructions.append(Instruction(details: [
            InstructionDetails(mode: .accumulator, syntax: "PHA",       hexCode: 0x48, len: 1, cycles: 3, requiresAdditionalCycles: false, cyclesToAdd: 0)
        ], flagsAffected: [], description: "PHA (PusH Accumulator)", executionBlock: phaExecution))
        
        instructions.append(Instruction(details: [
            InstructionDetails(mode: .accumulator, syntax: "PLA",       hexCode: 0x68, len: 1, cycles: 4, requiresAdditionalCycles: false, cyclesToAdd: 0)
        ], flagsAffected: [], description: "PLA (PuLl Accumulator)", executionBlock: plaExecution))
        
        instructions.append(Instruction(details: [
            InstructionDetails(mode: .accumulator, syntax: "PHP",       hexCode: 0x08, len: 1, cycles: 3, requiresAdditionalCycles: false, cyclesToAdd: 0)
        ], flagsAffected: [], description: "PHP (PusH Processor status)", executionBlock: phpExecution))
        
        instructions.append(Instruction(details: [
            InstructionDetails(mode: .accumulator, syntax: "PLP",       hexCode: 0x28, len: 1, cycles: 4, requiresAdditionalCycles: false, cyclesToAdd: 0)
        ], flagsAffected: [], description: "PLP (PuLl Processor status)", executionBlock: plpExecution))
        
        // PRAGMA MARK: STX (STore X register)
        
        let stxExecution = { self.STX() }
        
        instructions.append(Instruction(details: [
            InstructionDetails(mode: .zeroPage,  syntax: "STX $44",     hexCode: 0x86, len: 2, cycles: 3, requiresAdditionalCycles: false, cyclesToAdd: 0),
            InstructionDetails(mode: .zeroPageY, syntax: "STX $44,Y",   hexCode: 0x96, len: 2, cycles: 4, requiresAdditionalCycles: false, cyclesToAdd: 0),
            InstructionDetails(mode: .absolute,  syntax: "STX $4400",   hexCode: 0x8E, len: 3, cycles: 4, requiresAdditionalCycles: false, cyclesToAdd: 0),
        ], flagsAffected: [], description: "STX (STore X register)", executionBlock: stxExecution))
        
        // PRAGMA MARK: STY (STore Y register)
        
        let styExecution = { self.STY() }
        
        instructions.append(Instruction(details: [
            InstructionDetails(mode: .zeroPage,  syntax: "STY $44",     hexCode: 0x84, len: 2, cycles: 3, requiresAdditionalCycles: false, cyclesToAdd: 0),
            InstructionDetails(mode: .zeroPageX, syntax: "STY $44,X",   hexCode: 0x94, len: 2, cycles: 4, requiresAdditionalCycles: false, cyclesToAdd: 0),
            InstructionDetails(mode: .absolute,  syntax: "STY $4400",   hexCode: 0x8C, len: 3, cycles: 4, requiresAdditionalCycles: false, cyclesToAdd: 0),
        ], flagsAffected: [], description: "STY (STore Y register)", executionBlock: styExecution))
    }
}
