//
//  CPU+Branch.swift
//  MOS6502
//
//  Created by Stuart on 27/11/2020.
//

import Foundation

extension CPU {
    
    func branchIfFlag(flag: StatusFlag, is value: Bool) {
        var test = memoryFetchedValue
        var isNegativeJump = test.isBitSet(pos: 7)
        var newTest = test.setBit(pos: 7, to: false)
        var then = abs(newTest.toInt8())
        
        if isFlagSet(flag) == value {
            if isNegativeJump {
                pc -= UInt16(then)
            } else {
                pc += UInt16(then)
            }
        }
    }
    
}
