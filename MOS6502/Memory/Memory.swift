//
//  Memory.swift
//  MOS6502
//
//  Created by Stuart on 15/11/2020.
//

import Foundation

class Memory {
    
    var memSize: UInt16 = 65535
    
    var memory:[UInt8]
    
    init(memorySize: UInt16) {
        memSize = memorySize
        memory = Array(repeating: 0x00, count: Int(memorySize))
    }
    
    func read(location: UInt16) -> UInt8 {
        guard location > 0 && location < memSize else { return 0x0 }
        return memory[Int(location)]
    }
    
    func write(location: UInt16, data: UInt8) {
        guard location > 0 && location < memSize else { return }
        memory[Int(location)] = data
    }
    
    func clear() {
        memory = Array(repeating: 0x00, count: Int(memSize))
    }
}
