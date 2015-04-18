//
//  utilities.swift
//  Sudoku Solver
//
//  Created by Bernd Beuster on 24.10.14.
//  Copyright (c) 2014 Bernd Beuster. All rights reserved.
//

import Foundation
import CoreServices

let currentDirectoryPath = "/Users/bernd/Projects/Swift/Sudoku Solver/Sudoku Solver"

/* A unit are the columns 1-9, the rows A-I and
a collection of nine squares. */
func squareUnits(s: Int) -> [[Int]] {
    
    /* same row */
    var row = s / columns
    var rowUnits = [Int](count: columns, repeatedValue: 0)
    var i = 0
    for column in 0..<columns {
        rowUnits[i++] = row * columns + column
    }
    
    /* same column */
    var column = s % rows
    var columnUnits = [Int](count: rows, repeatedValue: 0)
    i = 0
    for row in 0..<rows {
        columnUnits[i++] = row * columns + column
    }
    
    /* 3x3 box */
    row = 3 * (s / (3 * columns))
    column = 3 * ((s % rows) / 3)
    var boxUnits = [Int](count: 3 * 3, repeatedValue: 0)
    for r in 0..<3 {
        for c in 0..<3 {
            let i = r * 3 + c
            boxUnits[i] = (row + r) * columns + (column + c)
        }
    }
    return [rowUnits, columnUnits, boxUnits]
}

/* The peers are the squares that share a unit. */
func squarePeers(s: Int) -> NSMutableSet {
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
    return peers
}

/* Parse a file into a list of strings, separated by separator. */
func fromFile(fileName: String, separator: String = "\n") -> [String] {
    var res = [String]()
    if let data = NSData(contentsOfFile: fileName) {
        if let str = NSString(data: data, encoding: NSUTF8StringEncoding) {
            let res = str.componentsSeparatedByString(separator) as! [String]
            return res.filter { !$0.isEmpty }
        }
    }
    return res
}

/* Solve one grid */
func solve(grid: String) -> Grid {
    var g = Grid(grid)
    g.search()
    return g
}

/* Attempt to solve a sequence of grids. Report results.
When showif is false, don't display any puzzles.
*/
func solveAll(grids: [String], name: String = "", showIf: Bool = false) {
    var maxTime = UInt64(0), sumTime = UInt64(0)
    var n = 0, solved = 0
    for grid in grids {
        let startTime = mach_absolute_time()
        var g = solve(grid)
        let elapsedTime = mach_absolute_time() - startTime

        maxTime = max(maxTime, elapsedTime)
        sumTime += elapsedTime
        ++n
        if g.solved { ++solved }
        
        if showIf {
            println(grid)
            println(g)
        }
    }
    
    let realMaxTime = Double(maxTime) * 1.0e-9
    let realTime = Double(sumTime) * 1.0e-9 / Double(n)
    println("Solved \(solved) of \(n) \(name) puzzles (avg \(realTime) secs (\(1.0/realTime) Hz), max \(realMaxTime) secs).")
}
