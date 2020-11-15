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
}

struct Instruction {
    let mode: InstructionMode
    let syntax: String
    let hexCode: UInt8
    let len: Int
    let cycles: Int
    let flagsAffected: String
    let requiresAdditionalCycles: Bool
    let cyclesToAdd: Int
    let description: String
    
    // Add a closure that should be executed for this instruction
}
