import UIKit
@testable import MOS6502PlaygroundSupport   // Using @testable means we dont need to make everything public in the app code :D

func printHeaderFor(example name: String) {
    print("*".leftPad(to: 50, using: "*"))
    print("* Example \(name)")
    print("*".leftPad(to: 50, using: "*"))
    print()
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
var relativeAddr:UInt8 = 122
var relative: Int8 = relativeAddr.toInt8()

relativeAddr.printRepresentation()
relative.printRepresentation()


// Instanciate the CPU and set the reset vector
var mem = Memory(memorySize: 65535)
var cpu2 = CPU(with: mem)
cpu2.memory.write(location: 0xFFFC, data: 10)
cpu2.memory.write(location: 0xFFFD, data: 20)
cpu2.reset()

printHeaderFor(example: "PC Currently pointing to")
cpu2.pc.printRepresentation()
cpu2.peek().printRepresentation()


/* Quick test to see if this will run the following 6502 code
 
 Assuming memory location 0x0010 has the value of 2 stored
 
 LDA #1      // Load accumulator with the value 1
 
 */

/*printHeaderFor(example: "LDA Immediate")
cpu2.memory.write(location: 0x140A, data: 0xA9) // LDA Command
cpu2.memory.write(location: 0x140B, data: 99) // Value to load


cpu2.runCycle()
cpu2.a.printRepresentation()

printHeaderFor(example: "LDA Zero Page")

mem.clear()
cpu2.memory.write(location: 0xFFFC, data: 10)
cpu2.memory.write(location: 0xFFFD, data: 20)
cpu2.reset()

cpu2.memory.write(location: 0x140A, data: 0xA5) // LDA Command
cpu2.memory.write(location: 0x140B, data: 0x44) // Value to load
cpu2.memory.write(location: 0x44, data: 99)


cpu2.runCycle()
cpu2.a.printRepresentation()

printHeaderFor(example: "LDX immediate")

mem.clear()
cpu2.memory.write(location: 0xFFFC, data: 10)
cpu2.memory.write(location: 0xFFFD, data: 20)
cpu2.reset()

cpu2.memory.write(location: 0x140A, data: 0xA2) // LDX Command
cpu2.memory.write(location: 0x140B, data: 55) // Value to load


cpu2.runCycle()
cpu2.x.printRepresentation()


printHeaderFor(example: "LDX Zero Page")

mem.clear()
cpu2.memory.write(location: 0xFFFC, data: 10)
cpu2.memory.write(location: 0xFFFD, data: 20)
cpu2.reset()

cpu2.memory.write(location: 0x140A, data: 0xA6) // LDX Command
cpu2.memory.write(location: 0x140B, data: 0x44) // Value to load
cpu2.memory.write(location: 0x44, data: 21)

cpu2.runCycle()
cpu2.x.printRepresentation()*/


printHeaderFor(example: "LDA Zero Page X")

mem.clear()
cpu2.memory.write(location: 0xFFFC, data: 10)
cpu2.memory.write(location: 0xFFFD, data: 20)
cpu2.reset()

cpu2.memory.write(location: 0x140A, data: 0xA2) // LDX Command
cpu2.memory.write(location: 0x140B, data: 20) // Value to load
cpu2.memory.write(location: 0x28, data: 77) //Load location 40 with 77
cpu2.memory.write(location: 0x140C, data: 0xB5) // LDA zero page x Command
cpu2.memory.write(location: 0x140D, data: 20) // Value to load

cpu2.runCycle()
cpu2.runCycle()
cpu2.x.printRepresentation()
cpu2.a.printRepresentation()


printHeaderFor(example: "LDA Immediate from memory program load")

cpu2.memory.loadProg(with: [0xA9,0x81], startingFromAddress: 0xC010)
cpu2.reset()
cpu2.runCycle()
cpu2.runCycle()
cpu2.a.printRepresentation()
cpu2.p.printRepresentation()
