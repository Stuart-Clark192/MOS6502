//
//  CPUViewModel.swift
//  MOS6502
//
//  Created by Stuart on 07/12/2020.
//

import Foundation

class CPUViewModel: ObservableObject {
    
    var cpu: CPU
    var startingMemoryAddress: UInt16
    
    @Published private(set) var memory: [String] = []
    @Published private(set) var dissasembly: [String] = []
    
    init(with cpu: CPU, startingFromAddress: UInt16 = 0x0000) {
        self.cpu = cpu
        self.startingMemoryAddress = startingFromAddress
        getMemory()
        getDissasembly()
    }
    
    func getMemory() {
        memory = cpu.memory.dumpMemStr(startingFromAddress: startingMemoryAddress)
    }
    
    func getNextMemoryBlock(getPrevious: Bool) {
        if getPrevious {
            guard startingMemoryAddress >= 320 else { return }
            startingMemoryAddress -= 320
        } else {
            guard startingMemoryAddress <= cpu.memory.memSize - 320 else { return }
            startingMemoryAddress += 320
        }
        memory = cpu.memory.dumpMemStr(startingFromAddress: startingMemoryAddress)
        
    }
    
    func getDissasembly() {
        
        cpu.reset()
        cpu.run(isDissasembleMode: true)
        dissasembly = cpu.dissasembly
    }
}
