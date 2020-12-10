//
//  RangeReplaceableCollectionExtensions.swift
//  MOS6502
//
//  Created by Stuart on 15/11/2020.
//

import Foundation

extension RangeReplaceableCollection where Self: StringProtocol {
    func leftPad(to length: Int, using element: Element = " ") -> SubSequence {
        return repeatElement(element, count: Swift.max(0, length-count)) + suffix(Swift.max(count, count-length))
    }
    
    func rightPad (to length: Int, using element: Element = " ") -> SubSequence {
        return suffix(Swift.max(count, count-length)) + repeatElement(element, count: Swift.max(0, length-count))
    }
}
