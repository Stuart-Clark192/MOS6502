//
//  UInt6Extensions.swift
//  MOS6502
//
//  Created by Stuart on 15/11/2020.
//

import Foundation

extension UInt16 {
    func highByte() -> UInt8 {
        UInt8(self >> 8)
    }
    
    func lowByte() -> UInt8 {
        UInt8(self & 0x00ff)
    }
    
    static func combine(lowByte: UInt8, highByte: UInt8) -> UInt16 {
        (UInt16(highByte) << 8) | UInt16(lowByte)
    }
}
