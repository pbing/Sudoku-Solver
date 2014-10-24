//
//  Grid.swift
//  Sudoku Solver
//
//  Created by Bernd Beuster on 23.10.14.
//  Copyright (c) 2014 Bernd Beuster. All rights reserved.
//

import Foundation

struct Grid: Printable {
    let rows = 9, columns = 9
    var values = [Square]()
    
    func indexIsValid(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    
    subscript(row: Int, column: Int) -> Square {
        get {
            assert(indexIsValid(row, column: column), "Index out of range.")
            return values[(row * columns + column)]
        }
        
        set {
            assert(indexIsValid(row, column: column), "Index out of range.")
            values[(row * columns + column)] = newValue
        }
    }
    
    /* Return description for protocol Printable. */
    var description: String {
        /* Convert to NSString in order to determine the string length. */
        let values = map(self.values) { NSString(string: "\($0)") }
        
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
        var row = [String]()
        for r in 0..<rows {
            var col = [String]()
            
            for i in 0..<columns {
                col.append(values[r * columns + i].stringByPaddingToLength(maxLen, withString: " ", startingAtIndex: 0))
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
    func gridValues(grid: String) -> [Square] {
        var res = [Square]()
        for c in grid {
            switch c {
            case "0",".":
                res.append(Square(0b111111111))
            default:
                if let d = String(c).toInt() {
                    res.append(Square(UInt16(1 << (d - 1))))                  
                }
            }
        }
        return res
    }
    
    init(grid: String) {
        values = gridValues(grid)
    }
    
    /* A unit are the columns 1-9, the rows A-I and
    a collection of nine squares. */
    func units(index: Int) -> [[Int]] {
        /* same row */
        var row = index / columns
        var rowUnits = [Int]()
        for column in 0..<columns {
            rowUnits.append(row * columns + column)
        }
        
        /* same column */
        var column = index % rows
        var columnUnits = [Int]()
        for row in 0..<columns {
            columnUnits.append(row * columns + column)
        }
        
        /* 3x3 box */
        row = 3 * (index / (3 * columns))
        column = 3 * ((index % rows) / 3)
        var boxUnits = [Int]()
        for r in 0..<3 {
            for c in 0..<3 {
                boxUnits.append((row + r) * columns + (column + c))
            }
        }
        
        return [rowUnits, columnUnits, boxUnits]
    }
    
    /* The peers are the squares that share a unit. */
    func peers(index: Int) -> [Int] {
        var peers = NSMutableSet(capacity: 20)
        
        /* same row */
        var row = index / columns
        for column in 0..<columns {
            let i = row * columns + column
            if i != index { peers.addObject(i) }
        }
        
        /* same column */
        var column = index % rows
        for row in 0..<columns {
            let i = row * columns + column
            if i != index { peers.addObject(i) }
        }
        
        /* 3x3 box */
        row = 3 * (index / (3 * columns))
        column = 3 * ((index % rows) / 3)
        for r in 0..<3 {
            for c in 0..<3 {
                let i = (row + r) * columns + (column + c)
                if i != index { peers.addObject(i) }
            }
        }
        
        var res = [Int]()
        for i in peers.allObjects {
            res.append(i as Int)
        }
        return res
    }
    
    /* Eliminate all the other values (except d) from values[s] and propagate.
    Return values, except return False if a contradiction is detected. */
    func assign(values: [Square], index: Int, member: Int) -> [Square]? {
        return nil
    }
    
    /* Eliminate d from values[s]; propagate when values or places <= 2.
    Return values, except return False if a contradiction is detected. */
    func eliminate(values: [Square], s: Int, d: Square) -> [Square]? {
        return nil
    }
}