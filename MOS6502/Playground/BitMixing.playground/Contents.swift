import UIKit

extension RangeReplaceableCollection where Self: StringProtocol {
    func leftPad(to length: Int, using element: Element = " ") -> SubSequence {
        return repeatElement(element, count: Swift.max(0, length-count)) + suffix(Swift.max(count, count-length))
    }
}

func printHeaderFor(example name: String) {
    print("*".leftPad(to: 50, using: "*"))
    print("* Example \(name)")
    print("*".leftPad(to: 50, using: "*"))
    print()
}

extension BinaryInteger {
    
    //Note these are to get round the issue with using radix 2 with negative signed numbers
    //As printing radix 2 of a Signed -2 ends up printing 00000-10 which is incorrect
    var binaryDescription: String {
        var binaryString = ""
        var internalNumber = self
        for _ in (1...self.bitWidth) {
            binaryString.insert(contentsOf: "\(internalNumber & 1)", at: binaryString.startIndex)
            internalNumber >>= 1
        }
        return "0b" + binaryString
    }
    
    func printRepresentation() {
        print("Binary Test", self.binaryDescription)
        //        print("Binary:  ",String(self, radix: 2).leftPad(to: 8, using: "0"))
        print("Decimal: ",String(self).leftPad(to: 8))
        print("Hex:     ",String(self, radix: 16).leftPad(to: 8))
        print()
    }
}

extension UInt16 {
    func highByte() -> UInt8 {
        UInt8(self >> 8)
    }
    
    func lowByte() -> UInt8 {
        UInt8(self & 0x00ff)
    }
    
    static func combine(lowByte: UInt8, highByte: UInt8) -> UInt16 {
        (UInt16(highByte) << 8) | UInt16(lowByte)
    }
}

/*Defining numbers in different bases*/

let binaryNumber: UInt8 = 0b00000001
let decimalNumber: UInt8 = 1
let hexNumber: UInt8 = 0x1

printHeaderFor(example: "Number Definition")
binaryNumber.printRepresentation()
decimalNumber.printRepresentation()
hexNumber.printRepresentation()

/*Binary negation*/
var exampleOfNot: UInt8 = 0b00000000
var notResult: UInt8 =  ~exampleOfNot

printHeaderFor(example: "Binary Negation")
exampleOfNot.printRepresentation()
notResult.printRepresentation()

/*Binary negation of signed int*/
var exampleSignedOfNot: Int8 = 0b00000001
var signedNotResult:Int8 =  ~exampleSignedOfNot

printHeaderFor(example: "Binary Negation Signed Int")
exampleSignedOfNot.printRepresentation()
signedNotResult.printRepresentation()


/* Spliting a UInt16 into 2 UInt8 bytes*/

var numberToSplit: UInt16 = 0b1000000000000001
var highByte: UInt8 = numberToSplit.highByte()
var lowByte: UInt8 = numberToSplit.lowByte()

printHeaderFor(example: "Binary H/L of UInt16")
numberToSplit.printRepresentation()
highByte.printRepresentation()
lowByte.printRepresentation()

/* Number shifting */
var numberToShift: UInt8 = 0b00010000
var leftShift = numberToShift << 1
var rightShift = numberToShift >> 1

printHeaderFor(example: "Number shifting")
numberToShift.printRepresentation()
leftShift.printRepresentation()
rightShift.printRepresentation()

/* Create UInt16 from 2 UInt8 on startup the 6502 will look at address 0xFFFC and 0xFFFD to set the initial location of the Program counter
 With FFFD Being th highByte and FFFC Being the low byte */

let combineHighByte: UInt8 = 0b10000000
let combineLowByte: UInt8 = 0b00000001

let combinedByte: UInt16 = UInt16.combine(lowByte: combineLowByte, highByte: combineHighByte)

printHeaderFor(example: "L/H Byte to UInt16")
combineHighByte.printRepresentation()
combineLowByte.printRepresentation()
combinedByte.printRepresentation()

/* Setting bit in an 8 bit value */

var statusByte: UInt8 = 0

// Set bit 0
statusByte |= 1 << 0

printHeaderFor(example: "Setting bit in an 8 bit value")
statusByte.printRepresentation()

// Set bit 7

statusByte |= 1 << 7
statusByte.printRepresentation()

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
}

/* Currently working from the information on https://www.masswerk.at/6502/6502_instruction_set.html
 And also http://www.6502.org/tutorials/6502opcodes.html which was used for the timing tables
 
 */

class CPU {
    // Program Counter
    var pc: UInt16 = 0
    
    // Stack Pointer
    var s: UInt8 = 0
    
    // Status Register
    var p: UInt8 = 0
    
    // Accumulator
    var a: Int8 = 0
    
    // X and Y registers
    var x: UInt8 = 0
    var y: UInt8 = 0
    
    // Program counter is also split into PCH and PCL which are the high and low 8 bits of PC
    var pch: UInt8 {
        pc.highByte()
    }
    
    var pcl: UInt8 {
        pc.lowByte()
    }
    
    var memory: Memory
    
    init(with memory: Memory) {
        self.memory = memory
    }
    
    func peek() -> UInt8 {
        memory.read(location: pc)
    }
    
    private func get() -> UInt8 {
        pc += 1
        return memory.read(location: pc - 1)
    }
    
    func reset() {
        
        pc = UInt16.combine(lowByte: memory.read(location: 0xFFFC), highByte: memory.read(location: 0xFFFD))
        
    }
    
    func runCycle() {
        
        let instr = get()
        
        switch instr {
        case 0x05: /* Logical Or zero paged */
            let value = get()
            a |= Int8(memory.read(location: UInt16(value)))
            
            
            
        case 0xA5: /* Load accumulator zero paged */
            let value = get()
            a = Int8(memory.read(location: UInt16(value)))
            
            
        case 0xA9: /* Load accumulator Immediate */
            let value = get()
            a = Int8(value)
            
            
        default:
            print("Uncoded instruction")
        }
    }
}

// Instanciate the CPU and set the reset vector
var cpu = CPU(with: Memory(memorySize: 65535))
cpu.memory.write(location: 0xFFFC, data: 10)
cpu.memory.write(location: 0xFFFD, data: 20)
cpu.reset()

printHeaderFor(example: "PC Currently pointing to")
cpu.pc.printRepresentation()
cpu.peek().printRepresentation()


0x80.printRepresentation()

/* Quick test to see if this will run the following 6502 code
 
 Assuming memory location 0x0010 has the value of 2 stored
 
 LDA #1      // Load accumulator with the value 1
 ORA $10     // Or the value in the accumulator with the value at zero page address 0x10
 
 */

cpu.memory.write(location: 0x140A, data: 0xA9) // LDA Command
cpu.memory.write(location: 0x140B, data: 1) // Value to load
cpu.memory.write(location: 0x140C, data: 0x05) // Or - zero paged
cpu.memory.write(location: 0x140D, data: 0x10) // Value to or with the accumulator
cpu.memory.write(location: 0x0010, data: 2)


cpu.runCycle()
cpu.a.printRepresentation()

cpu.runCycle()
cpu.a.printRepresentation()

enum InstructionMode {
    case immediate   //  use the value directly following the operand
    case zeroPage
    case zeroPageX
    case absolute
    case absoluteX
    case absoluteY
    case indirectX
    case indirectY
    case implied
}

struct Instruction {
    let mode: InstructionMode
    let syntax: String
    let hexCode: UInt8
    let len: Int
    let cycles: Int
    let flagsAffected: String
    let requiresAdditionalCycles: Bool
    let cyclesToAdd: Int
    let description: String
    
    // Add a closure that should be executed for this instruction
}


// Build the instruction table
class InstructionTable {
    var instructions: [Instruction] = []
    
    func buildInstructions() {
        
        //ADC
        instructions.append(Instruction(mode: .immediate, syntax: "ADC #$44", hexCode: 0x69, len: 2, cycles: 2, flagsAffected: "NVZC", requiresAdditionalCycles: false, cyclesToAdd: 0, description: "ADd with Carry"))
        
        instructions.append(Instruction(mode: .zeroPage, syntax: "ADC $44", hexCode: 0x65, len: 2, cycles: 3, flagsAffected: "NVZC", requiresAdditionalCycles: false, cyclesToAdd: 0, description: "ADd with Carry"))
        
        instructions.append(Instruction(mode: .zeroPageX, syntax: "ADC $44, X", hexCode: 0x75, len: 2, cycles: 4, flagsAffected: "NVZC", requiresAdditionalCycles: false, cyclesToAdd: 0, description: "ADd with Carry"))
        
        instructions.append(Instruction(mode: .absolute, syntax: "ADC $4400", hexCode: 0x6D, len: 3, cycles: 4, flagsAffected: "NVZC", requiresAdditionalCycles: false, cyclesToAdd: 0, description: "ADd with Carry"))
        
        instructions.append(Instruction(mode: .absoluteX, syntax: "ADC $4400, X", hexCode: 0x7D, len: 3, cycles: 4, flagsAffected: "NVZC", requiresAdditionalCycles: true, cyclesToAdd: 1, description: "ADd with Carry add 1 cycle if page boundry is crossed"))
        
        instructions.append(Instruction(mode: .absoluteY, syntax: "ADC $4400, Y", hexCode: 0x79, len: 3, cycles: 4, flagsAffected: "NVZC", requiresAdditionalCycles: true, cyclesToAdd: 1, description: "ADd with Carry add 1 cycle if page boundry is crossed"))
        
        instructions.append(Instruction(mode: .indirectX, syntax: "ADC ($44, X)", hexCode: 0x61, len: 2, cycles: 6, flagsAffected: "NVZC", requiresAdditionalCycles: false, cyclesToAdd: 0, description: "ADd with Carry"))
        
        instructions.append(Instruction(mode: .indirectY, syntax: "ADC ($44), Y", hexCode: 0x71, len: 2, cycles: 5, flagsAffected: "NVZC", requiresAdditionalCycles: true, cyclesToAdd: 1, description: "ADd with Carry add 1 cycle if page boundry is crossed"))
    }
}


/* Checking wrap around logic is correct
 
 So for Zero page X, if the sum of the address + the value in the X register > 0xFF then the resulting
 Address wraps around to fall within the range of 0xFF - basically dropping the carry bit
 
 in the example below 0x80 + 0xFF = 0x17F   (128 + 255 = 383)
 
 Anding with 0xFF will do the following
 
 
 Result of sum  : 0000000101111111
 Binary of 0xFF : 0000000011111111
 result of and  : 0000000001111111
 
 where 0111111 = 0x7F
 */

printHeaderFor(example: "Zero page wrap around")
let testX:UInt8 = 0x80
let testAddress:UInt8 = 0xFF
testX.printRepresentation()
testAddress.printRepresentation()

var addrAbs:UInt16 = UInt16(testX) + UInt16(testAddress)

addrAbs.printRepresentation()

if addrAbs > 0xFF {
    addrAbs &= 0xFF
}

addrAbs.printRepresentation()

printHeaderFor(example: "UInt8 to Signed integer in range of -128 - 127")
var relativeAddr:UInt8 = 1
var relative: Int8 = 0

relativeAddr.printRepresentation()

if (relativeAddr < 128) {
    relative = Int8(bitPattern: relativeAddr)
    relative |= -0x80
} else {
    relativeAddr -= 128
    relative = Int8(bitPattern: relativeAddr)
}

relative.printRepresentation()

print(Int8.max)

