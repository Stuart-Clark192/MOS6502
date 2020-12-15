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
    @Published private(set) var registerString: String = ""
    
    init(with cpu: CPU, startingFromAddress: UInt16 = 0x0000) {
        self.cpu = cpu
        self.startingMemoryAddress = startingFromAddress
        getMemory()
        getDissasembly()
        getRegisterString()
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
        cpu.reset()
    }
    
    func getRegisterString() {
        let pc = cpu.pc.asHex.leftPad(to: 4, using: "0")
        let accum = cpu.a.asHex.leftPad(to: 2, using: "0")
        let xr = cpu.x.asHex.leftPad(to: 2, using: "0")
        let yr = cpu.y.asHex.leftPad(to: 2, using: "0")
        let sr = cpu.p.asHex.leftPad(to: 2, using: "0")
        let sp = cpu.s.asHex.leftPad(to: 2, using: "0")
        let sBin = cpu.p.asBinary
        registerString = "\(pc)    \(accum)    \(xr)  \(yr)  \(sr)  \(sp)      \(sBin)"
    }
    
    func run() {
        cpu.reset()
        cpu.run(isDissasembleMode: false)
        getMemory()
        getRegisterString()
    }
    
    func step() {
        cpu.runCycle()
        getMemory()
        getRegisterString()
    }
    
    func reset() {
        cpu.reset()
        getMemory()
        getRegisterString()
    }
}
