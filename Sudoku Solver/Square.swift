//
//  Square.swift
//  Sudoku Solver
//
//  Created by Bernd Beuster on 23.10.14.
//  Copyright (c) 2014 Bernd Beuster. All rights reserved.
//

import Foundation

struct Square: Printable {
    var value = UInt16()
    
    init(_ value: UInt16 = 0) {
        self.value = UInt16(value)
    }
    
    /* Return description for protocol Printable. */
    var description: String {
        if value == 0 {
            return "-"
        } else {
            var str = String()
            for i in 1...9 {
                let mask = UInt16(1 << (i - 1))
                
                if ((mask & value) != 0) {
                    str += String(i)
                }
            }
            return str
        }
    }

    /* Return the number of set members in value. */
    var count: Int {
        var val = value
        var count: Int
        
        for count = 0; val != 0; ++count {
            val &= val - 1 // clear the least significant bit set
        }
        return count
    }
    
    func toMask(member: Int) -> UInt16 {
        assert(member >= 1 && member <= 9, "Index out of range.")
        return UInt16(1 << (member - 1))
    }
    
    func hasMember(member: Int) -> Bool {
        return (value & toMask(member)) != 0
    }
    
    mutating func addMember(member: Int) {
        value |= toMask(member)
     }

    mutating func removeMember(member: Int) {
        value &= ~toMask(member)
     }
    
    var members: [Int] {
        var res = [Int]()
        for i in 1...9 {
            if hasMember(i) {
                res.append(i)
            }
        }
        return res
    }
}
