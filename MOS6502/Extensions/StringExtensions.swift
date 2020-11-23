//
//  StringExtensions.swift
//  MOS6502
//
//  Created by Stuart on 22/11/2020.
//

import Foundation

extension String {
    
    func toUInt8Array() -> [UInt8] {
        self
            .uppercased()
            .split(separator: " ")
            .map {
                (UInt8($0, radix: 16) ?? 0)
            }
    }
}

