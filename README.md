# MOS6502

A work in progress Swift implementation of the 6502 Emulator, far from complete as yet :)

## Why

Mostly just out of interest, I grew up with ZX81's and then the ZX Spectrum and C64 and also have an interest in electronics

## What is here?
Included in this repo is a _MOS6502_ iOS/Mac Catalyst application written in Swift + SwiftUI, and a Swift Playground called _BitMixing_ that demonstrates the functionality of the _MOS6502_ Swift module.

## How to run the MOS6502 App
Requirements:

* You need a copy of Xcode installed on your Mac.  The MOS6502 App was tested on Xcode version 12, it may work on older versions of Xcode.
* In order to build and run the app on a Mac or a real iOS device, you must have a current Apple Developer account
	* If you do not have or do not want to obtain an Apple Developer account, you will only be able to run the app on a simulated iOS device.

Open Xcode, open the "MOS6502.xcworkspace" file, then choose the "MOS6502" scheme and a target device in the menu bar of Xcode.  If you have an Apple Developer account, the target device can be "My Mac" or a real iOS device that is available on the network/connected to your computer.  If you do not have an Apple Developer account, you should only choose one of the simulated iOS devices.

Click on the "MOS6502" project in Project Navigator, and browse to the "Signing & Capabilities" tab for the "MOS6502" target, then select your Apple Developer account ID in the "Team" dropdown to run on a Mac or a real iOS device, or select "None" in the dropdown to run on a simulated iOS device.

Click on the "Run" button, or, select "Product -> Run" from the menu bar in Xcode, or click "⌘ - R" on the keyboard to run the program on your target device.  Xcode will then build and run the application, which might take a few minutes depending on the speed of your computer.

## How to run the BitMixing Swift Playground
Requirements:

*  You need a copy of Xcode installed.  The BitMixing Swift Playground has been tested using Xcode version 12; it may run in an older version of Xcode, or it may not.
	* The BitMixing Swift Playground will not run in the "Swift Playgrounds" App on macOS or iOS.
* You do not need to have a current Apple Developer account in order to build and run the BitMixing Swift Playground.

Open Xcode, open the "MOS6502.xcworkspace" file, then choose the
"MOS6502PlaygroundSupport" scheme and "My Mac" as the target device.

Click on the "MOS6502" project in Project Navigator, and browse to the "Signing & Capabilities" tab for the "MOS6502PlaygroundSupport" target, then select your Apple Developer account ID in the "Team" dropdown (if you have one), or "None" in the dropdown if you do not have an Apple Developer account ID.

Click on "Product -> Build" or hit "⌘ - B" on the keyboard to build the Swift Playground support module.  Once the module has been built, browse to the "BitMixing.playground" file in Project Navigator, click on it, and then hit the "Play" button at the bottom of the editor window to run the Swift Playground.

## License

This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.
