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
    
     */
    
    
    //Immediate data will be the next data byte, use the data byte directly as the value
    func immediateData() -> UInt8 {
        
        pc += 1
        memoryFetchedValue = memory.read(location: pc)
        return 0
    }
    
    func zeroPageData() -> UInt8 {
        
        pc += 1
        let dataReadLocation = memory.read(location: pc)
        memoryFetchedValue = memory.read(location: UInt16(dataReadLocation & 0x00FF)) // Remember the memory is holding 8 bit values but is 16 bit addresses so we need to &
        
        return 0
    }
    
    func zeroXPageData() -> UInt8 {
        
        pc += 1
        let dataReadLocation = memory.read(location: pc)
        var absAddr = UInt16(x) + UInt16(dataReadLocation)
        
        if absAddr > 0xFF {
            absAddr &= 0xFF
        }
        memoryFetchedValue = memory.read(location: absAddr)
        
        return 0
    }
    
}
