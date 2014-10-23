//
//  Grid.swift
//  Sudoku Solver
//
//  Created by Bernd Beuster on 23.10.14.
//  Copyright (c) 2014 Bernd Beuster. All rights reserved.
//

import Foundation

class Grid: Printable {
    var grid: [Square] = []
    var str = "Not initialized."
    
    var description: String {
        /* Convert to NSString in order to determine the string length. */
        let values = map(grid) { NSString(string: "\($0)") }
        
        /* max. string length of every value */
        var maxLen = 0
        for v in values {
            maxLen = max(maxLen, v.length)
        }
        
        /* Build line */
        var lineSegment = String()
        for i in 0..<3*maxLen + 2 {
            lineSegment += "-"
        }
        let line = "+".join([lineSegment,lineSegment,lineSegment])
        
        /* Build table grid */
        var row: [String] = []
        for r in 0..<9 {
            var col: [String] = []
            
            for i in 0..<9 {
                col.append(values[9*r + i].stringByPaddingToLength(maxLen, withString: " ", startingAtIndex: 0))
            }
            
            let c0 = " ".join(col[0...2])
            let c1 = " ".join(col[3...5])
            let c2 = " ".join(col[6...8])
            row.append("|".join([c0,c1,c2]))
        }
        
        let r0 = "\n".join(row[0...2])
        let r1 = "\n".join(row[3...5])
        let r2 = "\n".join(row[6...8])
        return "\n\(line)\n".join([r0,r1,r2])
    }
    
    /* Convert grid into an array of Squares with '0' or '.' for empties. */
    func gridValue(grid: String) -> [Square] {
        var res: [Square] = []
        
        for c in grid {
            switch c {
            case "0",".":
                res.append(Square(0))
                
            default:
                if let d = String(c).toInt() {
                    res.append(Square(1 << (d - 1)))
                }
            }
        }
        
        return res
    }
    
    init(grid: String) {
        self.grid = gridValue(grid)
    }
}