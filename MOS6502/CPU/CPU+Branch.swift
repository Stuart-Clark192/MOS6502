//
//  CPU+Branch.swift
//  MOS6502
//
//  Created by Stuart on 27/11/2020.
//

import Foundation

extension CPU {
    
    func branchIfFlag(flag: StatusFlag, is value: Bool) {
        let isNegativeJump = memoryFetchedValue.isBitSet(pos: 7)
        let offset = abs(memoryFetchedValue.setBit(pos: 7, to: false).toInt8())
        
        if isFlagSet(flag) == value {
            if isNegativeJump {
                pc -= UInt16(offset)
            } else {
                pc += UInt16(offset)
            }
        }
    }
    
}
