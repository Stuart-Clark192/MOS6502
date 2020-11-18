//
//  CPU+Addressing.swift
//  MOS6502
//
//  Created by Stuart on 15/11/2020.
//

import Foundation

extension CPU {
    
    /* Each of these functions will retrieve the value from memory and set it to the CPU memoryFetchedValue
       The return value for each is the number of additional CPU Cycles to add if any - for instance if a page
       Boundry has been crossed
     
       Details of addressing modes taken from http://www.emulator101.com/6502-addressing-modes.html
     
       Still need to implement page crossing boundries increasing the cycle count
    
     */
    
    
    //Immediate data will be the next data byte, use the data byte directly as the value
    func immediateData() -> UInt8 {
        
        print("Reading Value pc = \(pc)")
        pc.printRepresentation()
        memoryFetchedValue = memory.read(location: pc)
        pc += 1
        return 0
    }
    
    func zeroPageData() -> UInt8 {
        
        let dataReadLocation = memory.read(location: pc)
        memoryFetchedValue = memory.read(location: UInt16(dataReadLocation & 0x00FF)) // Remember the memory is holding 8 bit values but is 16 bit addresses so we need to &
        pc += 1
        return 0
    }
    
    func zeroXPageData() -> UInt8 {
        
        let dataReadLocation = memory.read(location: pc)
        var absAddr = UInt16(x) + UInt16(dataReadLocation)
        
        if absAddr > 0xFF {
            absAddr &= 0xFF
        }
        memoryFetchedValue = memory.read(location: absAddr)
        pc += 1
        return 0
    }
    
    func zeroYPageData() -> UInt8 {
        
        let dataReadLocation = memory.read(location: pc)
        var absAddr = UInt16(y) + UInt16(dataReadLocation)
        
        if absAddr > 0xFF {
            absAddr &= 0xFF
        }
        memoryFetchedValue = memory.read(location: absAddr)
        
        return 0
    }
    
    func relativeData() -> UInt8 {
        pc += 1
        memoryFetchedValue = memory.read(location: pc)
        
        return 0
    }
    
    func absoluteData() -> UInt8 {
        
        pc += 1
        let lowByte = memory.read(location: pc)
        pc += 1
        let highByte = memory.read(location: pc)
        
        memoryFetchedValue = memory.read(location: UInt16.combine(lowByte: lowByte, highByte: highByte))
        
        return 0
    }
    
    func absoluteXData() -> UInt8 {
        pc += 1
        let lowByte = memory.read(location: pc)
        pc += 1
        let highByte = memory.read(location: pc)
        
        memoryFetchedValue = memory.read(location: UInt16.combine(lowByte: lowByte, highByte: highByte) + UInt16(x))
        
        return 0
    }
    
    func absoluteYData() -> UInt8 {
        pc += 1
        let lowByte = memory.read(location: pc)
        pc += 1
        let highByte = memory.read(location: pc)
        
        memoryFetchedValue = memory.read(location: UInt16.combine(lowByte: lowByte, highByte: highByte) + UInt16(y))
        
        return 0
    }
    
    func indirectData() -> UInt8 {
        
        // Note this CPU has a hardware bug that will need to be implemented here
        // Basically
        
        // Get the pointer address
        pc += 1
        let lowByte = memory.read(location: pc)
        pc += 1
        let highByte = memory.read(location: pc)
        
        //Get the address the pointer points to
        let pointerAddress = UInt16.combine(lowByte: lowByte, highByte: highByte)
        let targetAddressLowByte = memory.read(location: pointerAddress)
        let targetAddressHighByte = memory.read(location: pointerAddress + 1)
        
        memoryFetchedValue = memory.read(location: UInt16.combine(lowByte: targetAddressLowByte, highByte: targetAddressHighByte))
        
        return 0
    }
    
    func indirectXData() -> UInt8 {
        
        pc += 1
        let dataReadLocation = memory.read(location: pc)
        var absAddr = UInt16(x) + UInt16(dataReadLocation)
        
        if absAddr > 0xFF {
            absAddr &= 0xFF
        }
        
        let targetAddressLowByte = memory.read(location: absAddr)
        let targetAddressHighByte = memory.read(location: absAddr + 1)
        
        memoryFetchedValue = memory.read(location: UInt16.combine(lowByte: targetAddressLowByte, highByte: targetAddressHighByte))
        
        return 0
    }
    
    func indirectYData() -> UInt8 {
        
        pc += 1
        let dataReadLocation = memory.read(location: pc)
        var absAddr = UInt16(y) + UInt16(dataReadLocation)
        
        if absAddr > 0xFF {
            absAddr &= 0xFF
        }
        
        let targetAddressLowByte = memory.read(location: absAddr)
        let targetAddressHighByte = memory.read(location: absAddr + 1)
        
        memoryFetchedValue = memory.read(location: UInt16.combine(lowByte: targetAddressLowByte, highByte: targetAddressHighByte))
        
        return 0
    }
    
}
