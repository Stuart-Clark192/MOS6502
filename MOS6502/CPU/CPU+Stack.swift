//
//  CPU+Stack.swift
//  MOS6502
//
//  Created by Stuart on 27/11/2020.
//

import Foundation

extension CPU {
    
    func popStack() -> UInt8 {
        
        if s == 0xFF {
            print("Stack Overflow")
            s = 0
        } else {
            s += 1
        }
        
        let stackMemoryLocation = UInt16(s) + 0x100
        return memory.read(location: stackMemoryLocation)
    }
    
    func pushStack(value: UInt8) {
        
        let stackMemoryLocation = UInt16(s) + 0x100
        memory.write(location: stackMemoryLocation, data: value)
        
        if s == 0 {
            print("Stack Underflow")
            s = 0xFF
        } else {
            s -= 1
        }
    }
    
}
