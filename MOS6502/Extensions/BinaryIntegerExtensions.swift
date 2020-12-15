//
//  BinaryIntegerExtensions.swift
//  MOS6502
//
//  Created by Stuart on 15/11/2020.
//

import Foundation

extension BinaryInteger {
    
    //Note these are to get round the issue with using radix 2 with negative signed numbers
    //As printing radix 2 of a Signed -2 ends up printing 00000-10 which is incorrect
    var binaryDescription: String {
            var binaryString = ""
            var internalNumber = self
            for _ in (1...self.bitWidth) {
                binaryString.insert(contentsOf: "\(internalNumber & 1)", at: binaryString.startIndex)
                internalNumber >>= 1
            }
            return "0b" + binaryString
        }
    
    var asHex: String {
        String(self, radix: 16, uppercase: true)
    }
    
    var asBinary: String {
        var binaryString = ""
        var internalNumber = self
        for _ in (1...self.bitWidth) {
            binaryString.insert(contentsOf: "\(internalNumber & 1)", at: binaryString.startIndex)
            internalNumber >>= 1
        }
        return binaryString
    }
    
    func printRepresentation() {
        print("Binary Test", self.binaryDescription)
//        print("Binary:  ",String(self, radix: 2).leftPad(to: 8, using: "0"))
        print("Decimal: ",String(self).leftPad(to: 8))
        print("Hex:     ",String(self, radix: 16, uppercase: true).leftPad(to: 8))
        print()
    }
    
    func isBitSet(pos: UInt8) -> Bool {
        guard pos < self.bitWidth else { return false }
        return (self & (1 << pos)) != 0
    }
}
