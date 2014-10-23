//
//  Square.swift
//  Sudoku Solver
//
//  Created by Bernd Beuster on 23.10.14.
//  Copyright (c) 2014 Bernd Beuster. All rights reserved.
//

struct Square: Printable {
    var value = Int()
    
    init(_ value: Int = 0) {
        self.value = value
    }
    
    var description: String {
        if value == 0 {
            return "-"
        } else {
            var str = String()
            
            for i in 1...9 {
                let mask = 1 << (i - 1)
                
                if ((mask & value) != 0) {
                    str += String(i)
                }
            }
            
            return str
        }
    }
}
