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
        guard location >= 0 && location < memSize else { return 0x0 }
        return memory[Int(location)]
    }
    
    func write(location: UInt16, data: UInt8) {
        guard location >= 0 && location < memSize else { return }
        memory[Int(location)] = data
    }
    
    func clear() {
        memory = Array(repeating: 0x00, count: Int(memSize))
    }
    
    func loadProg(with bytes: [UInt8], startingFromAddress: UInt16 = 0) {
        var currentMemoryAddress = startingFromAddress
        
        clear()
        
        bytes.forEach {
            write(location: currentMemoryAddress, data: $0)
            currentMemoryAddress += 1
        }
        
        // Set the starting location
        write(location: 0xFFFC, data: startingFromAddress.lowByte())
        write(location: 0xFFFD, data: startingFromAddress.highByte())
    }
    
    func dumpMem(startingFromAddress: UInt16 = 0) {
        
        var memoryAddress = startingFromAddress
        let strideLength = 16
        let pageLength: UInt16 = 16
        
        for page in stride(from: memoryAddress, to: memoryAddress + (pageLength * UInt16(strideLength)), by: strideLength) {
            var outputString = String(format:"%04llX", page)
            //print(outputString)
            for memLocation in page...page + UInt16(strideLength - 1) {
                outputString += String(format:" %02llX", read(location: memLocation))
            }
            print(outputString)
        }
        
        
    }
}
