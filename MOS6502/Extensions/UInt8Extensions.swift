//
//  UInt8Extensions.swift
//  MOS6502
//
//  Created by Stuart on 17/11/2020.
//

import Foundation

extension UInt8 {
    func toInt8() -> Int8 {
        var relative: Int8 = 0
        var working: UInt8 = self

        if (working < 128) {
            relative = Int8(bitPattern: working)
            relative |= -0x80
        } else {
            working -= 128
            relative = Int8(bitPattern: working)
        }
        
        return relative
    }
    
    func setBit (pos: UInt, to value: Bool) -> UInt8 {
        guard pos < self.bitWidth else { return 0 }
        
        if value {
            
            return self | 1 << pos
        } else {
        
            let mask: UInt8 = (~(1 << pos))
            return ( self & mask )
        }
    }
}
