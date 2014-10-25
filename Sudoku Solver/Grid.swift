//
//  Grid.swift
//  Sudoku Solver
//
//  Created by Bernd Beuster on 23.10.14.
//  Copyright (c) 2014 Bernd Beuster. All rights reserved.
//

import Foundation

class Grid: Printable {
    let rows = 9, columns = 9
    var values = [Square]()
    
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
        return "\n\(line)\n".join([r0,r1,r2]) + "\n"
    }
    
    /* Convert grid into an array of Int with '0' or '.' for empties. */
    func gridValues(grid: String) -> [Int] {
        var res = [Int]()
        for c in grid {
            switch c {
            case "0",".":
                res.append(0)
            default:
                if let d = String(c).toInt() {
                    res.append(d)
                }
            }
        }
        return res
    }
    
    init(grid: String) {
        /* To start, every square can be any digit */
        for i in 0..<(rows * columns) {
            values.append(Square(0x1ff))
        }
        
        /* Then assign values from the grid. */
        let intValues = gridValues(grid)
        for i in 0..<(rows * columns) {
            if intValues[i] > 0 {
                if assign(i, d: intValues[i]) == nil {
                    values = [] // Fail if we can't assign value to square i.
                }
            }
        }
    }
    
    /* A unit are the columns 1-9, the rows A-I and
    a collection of nine squares. */
    func units(s: Int) -> [[Int]] {
        /* same row */
        var row = s / columns
        var rowUnits = [Int]()
        for column in 0..<columns {
            rowUnits.append(row * columns + column)
        }
        
        /* same column */
        var column = s % rows
        var columnUnits = [Int]()
        for row in 0..<columns {
            columnUnits.append(row * columns + column)
        }
        
        /* 3x3 box */
        row = 3 * (s / (3 * columns))
        column = 3 * ((s % rows) / 3)
        var boxUnits = [Int]()
        for r in 0..<3 {
            for c in 0..<3 {
                boxUnits.append((row + r) * columns + (column + c))
            }
        }
        
        return [rowUnits, columnUnits, boxUnits]
    }
    
    /* The peers are the squares that share a unit. */
    func peers(s: Int) -> [Int] {
        var peers = NSMutableSet(capacity: 20)
        
        /* same row */
        var row = s / columns
        for column in 0..<columns {
            let i = row * columns + column
            if i != s { peers.addObject(i) }
        }
        
        /* same column */
        var column = s % rows
        for row in 0..<rows {
            let i = row * columns + column
            if i != s { peers.addObject(i) }
        }
        
        /* 3x3 box */
        row = 3 * (s / (3 * columns))
        column = 3 * ((s % rows) / 3)
        for r in 0..<3 {
            for c in 0..<3 {
                let i = (row + r) * columns + (column + c)
                if i != s { peers.addObject(i) }
            }
        }
        
        var res = [Int]()
        for i in peers.allObjects {
            res.append(i as Int)
        }
        return res
    }
    
    /* Eliminate all the other values (except d) from values[s] and propagate.
    Return values, except return nil if a contradiction is detected. */
    func assign(s: Int, d: Int) -> [Square]? {
        var otherValues = values[s]
        otherValues.removeDigit(d)
        
        for d2 in otherValues.digits {
            if eliminate(s, d: d2) == nil { return nil }
        }
        return values
    }
    
    /* Eliminate d from values[s]; propagate when values or places <= 2.
    Return values, except return nil if a contradiction is detected. */
    func eliminate(s: Int, d: Int) -> [Square]? {
        if !values[s].hasDigit(d) {
            return values // Already eliminated
        }
        values[s].removeDigit(d)
        
        /* (1) If a square s is reduced to one value d2, then eliminate d2 from the peers. */
        let count = values[s].count
        if count == 0 { return nil } // Contradiction: removed last value
        else if count == 1 {
            let d2 = values[s].digits[0]
            for s2 in peers(s) {
                if eliminate(s2, d: d2) == nil { return nil }
            }
        }
        
        /* (2) If a unit u is reduced to only one place for a value d, then put it there. */
        for u in units(s) {
            var dPlaces = [Int]()
            for s in u {
                if values[s].hasDigit(d) { dPlaces.append(s) }
            }
            
            let count = dPlaces.count
            if count == 0 { return nil } // Contradiction: no place for this value
            else if count == 1 {
                /* d can only be in one place in unit; assign it there */
                if assign(dPlaces[0], d: d) == nil { return nil }
            }
        }
        return values
    }
    
    var solved: Bool {
        for s in values {
            if s.count != 1 { return false }
        }
        return true
    }
    
    /* Using depth-first search and propagation, try all possible values. */
    func search(values: [Square]) -> [Square]? {
        if solved { return values } // Solved!
        
        /* Chose the unfilled square s with the fewest possibilities */
        var minCount = Int.max
        var s = 0
        for i in 0..<(rows * columns) {
            let count = values[i].count
            if count > 1 && count < minCount {
                minCount = count
                s = i
            }
        }
        
        for d in values[s].digits {
            let values = self.values
            if var values2 = assign(s, d: d) { search(values2) }
            if !solved {  self.values = values }
        }
        return nil
    }
}
