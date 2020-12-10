//
//  CPU+Disassembler.swift
//  MOS6502
//
//  Created by Stuart on 27/11/2020.
//

import Foundation

extension CPU {
    
    func printDissasemblyOfInstruction(instrToExecute: InstructionDetails) -> String {
    
        var instrSyntaxResolved = ""
        switch instrToExecute.mode {
        
        case .immediate:
            instrSyntaxResolved = instrToExecute.syntax.replacingOccurrences(of: "#$44", with: "#$\(singleByteToString(value: memoryFetchedValue))")
        case .zeroPage:
            instrSyntaxResolved = instrToExecute.syntax.replacingOccurrences(of: " $44", with: " $\(singleByteToString(value: memoryAddress.lowByte()))")
        case .zeroPageX:
            instrSyntaxResolved = instrToExecute.syntax.replacingOccurrences(of: " #$44", with: " #$\(singleByteToString(value: memoryFetchedValue))")
        case .zeroPageY:
            instrSyntaxResolved = instrToExecute.syntax.replacingOccurrences(of: " #$44", with: " #$\(singleByteToString(value: memoryFetchedValue))")
        case .absolute:
            instrSyntaxResolved = instrToExecute.syntax.replacingOccurrences(of: " $4400", with: " $\(doubleByteToString(value: memoryAddress))")
        case .absoluteX:
            instrSyntaxResolved = instrToExecute.syntax.replacingOccurrences(of: " #$44", with: " #$\(singleByteToString(value: memoryFetchedValue))")
        case .absoluteY:
            instrSyntaxResolved = instrToExecute.syntax.replacingOccurrences(of: " #$44", with: " #$\(singleByteToString(value: memoryFetchedValue))")
        case .indirectX:
            instrSyntaxResolved = instrToExecute.syntax.replacingOccurrences(of: "$44", with: "$\(singleByteToString(value: fetchedInstructionBytes[1]))")
        case .indirectY:
            instrSyntaxResolved = instrToExecute.syntax.replacingOccurrences(of: "$44", with: "$\(singleByteToString(value: fetchedInstructionBytes[1]))")
        case .implied:
            instrSyntaxResolved = instrToExecute.syntax.replacingOccurrences(of: " #$44", with: " #$\(singleByteToString(value: memoryFetchedValue))")
        case .accumulator:
            instrSyntaxResolved = instrToExecute.syntax
        case .relative:
            instrSyntaxResolved = "\(instrToExecute.syntax) $\(doubleByteToString(value: resolveBranchAddress(for: memoryFetchedValue, fromExecutionAddress: fetchedInstructionAddress)))"
        case .indirect:
            instrSyntaxResolved = instrToExecute.syntax.replacingOccurrences(of: " #$44", with: " #$\(singleByteToString(value: memoryFetchedValue))")
        }
        
        return """
            \(doubleByteToString(value: fetchedInstructionAddress).rightPad(to: 10)) \(instructionBytesString().rightPad(to: 10)) \(instrSyntaxResolved.rightPad(to: 15)) \(instrToExecute.mode)
            """
    }
    
    private func doubleByteToString(value: UInt16) -> String {
        String(format:"%04llX", value)
    }
    
    private func singleByteToString(value: UInt8) -> String {
        String(format:"%02llX", value)
    }
    
    private func instructionBytesString() -> String {
        fetchedInstructionBytes
            .map { "\(singleByteToString(value: $0))" }
            .joined(separator: " ")
    }
    
    private func resolveBranchAddress(for memoryValue: UInt8, fromExecutionAddress: UInt16) -> UInt16 {
        var resolvedAddress = fromExecutionAddress
        let isNegativeJump = memoryFetchedValue.isBitSet(pos: 7)
        let offset = abs(memoryFetchedValue.setBit(pos: 7, to: false).toInt8())
        
        if isNegativeJump {
            resolvedAddress -= UInt16(offset)
        } else {
            resolvedAddress += UInt16(offset)
        }
        return resolvedAddress + 2
    }
}
