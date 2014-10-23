//
//  main.swift
//  Sudoku Solver
//
//  Created by Bernd Beuster on 23.10.14.
//  Copyright (c) 2014 Bernd Beuster. All rights reserved.
//

import Foundation

/* Parse a file into a list of strings, separated by separator. */
func fromFile(fileName: String, separator: String = "\n") -> [String] {
    var res = [String]()
    
    if let data = NSData(contentsOfFile: fileName) {
        if let str = NSString(data: data, encoding: NSUTF8StringEncoding) {
            let res = str.componentsSeparatedByString(separator) as [String]
            return res.filter { !$0.isEmpty }
        }
    }
    return res
}

//println(fromFile("/Users/bernd/Projects/Swift/Sudoku Solver/Sudoku Solver/easy50.txt",separator:"========"))
//println(fromFile("/Users/bernd/Projects/Swift/Sudoku Solver/Sudoku Solver/hardest.txt"))
//println(fromFile("/Users/bernd/Projects/Swift/Sudoku Solver/Sudoku Solver/top95.txt"))

let grid = Grid()
println(grid)