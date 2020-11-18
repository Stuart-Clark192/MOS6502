//
//  CPU+InstructionImplementation.swift
//  MOS6502
//
//  Created by Stuart on 18/11/2020.
//

import Foundation

extension CPU {
    
    func getInstrValueFromMemory(addressMode: InstructionMode) {
        
        switch addressMode {
            
        case .immediate:
            immediateData()
            
        case .zeroPage:
            zeroPageData()
            
        case .zeroPageX:
            zeroXPageData()
        
        default:
            print("Not implemented Yet")
            memoryreadValue = 0
        }
    }
    
    func LDA() {
        a = memoryFetchedValue
    }
    
    func LDX() {
        x = memoryFetchedValue
    }
    
    func LDY() {
        y = memoryFetchedValue
    }
    
}
