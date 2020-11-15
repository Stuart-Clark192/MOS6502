//
//  InstructionMode.swift
//  MOS6502
//
//  Created by Stuart on 15/11/2020.
//

import Foundation

enum InstructionMode {
    case immediate   //  use the value directly following the operand
    case zeroPage
    case zeroPageX
    case absolute
    case absoluteX
    case absoluteY
    case indirectX
    case indirectY
    case implied
    case accumulator
    case relative
}

struct Instruction {
    let mode: InstructionMode
    let syntax: String
    let hexCode: UInt8
    let len: Int
    let cycles: Int
    let flagsAffected: [StatusFlag]
    let requiresAdditionalCycles: Bool
    let cyclesToAdd: Int
    let description: String
    let executionBlock: (() -> UInt8)?
}

enum StatusFlag {
    case N      // Negative             Bit 7
    case V      // Overflow             Bit 6
    case nu1    // Unused               Bit 5
    case nu2    // Unused               Bit 4
    case D      // Decimal              Bit 3
    case I      // Interrupt Disable    Bit 2
    case Z      // Zero                 Bit 1
    case C      // Carry                Bit 0
}
