//
//  TestSudokuSolver.swift
//  TestSudokuSolver
//
//  Created by Bernd Beuster on 23.10.14.
//  Copyright (c) 2014 Bernd Beuster. All rights reserved.
//

import Foundation
import XCTest

class TestSudokuSolver: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testPerformanceSolve() {
        self.measureBlock() {
            let grid1 = "003020600900305001001806400008102900700000008006708200002609500800203009005010300"
            let grid2 = "4.....8.5.3..........7......2.....6.....8.4......1.......6.3.7.5..2.....1.4......"
            solve(grid1)
            solve(grid2)
        }
    }
    
    func testSquareDescription() {
        XCTAssertEqual("\(Square())", "-")
        XCTAssertEqual("\(Square(0))", "-")
        XCTAssertEqual("\(Square(0b000000001))", "1")
        XCTAssertEqual("\(Square(0b000000010))", "2")
        XCTAssertEqual("\(Square(0b000000100))", "3")
        XCTAssertEqual("\(Square(0b000001000))", "4")
        XCTAssertEqual("\(Square(0b000010000))", "5")
        XCTAssertEqual("\(Square(0b000100000))", "6")
        XCTAssertEqual("\(Square(0b001000000))", "7")
        XCTAssertEqual("\(Square(0b010000000))", "8")
        XCTAssertEqual("\(Square(0b100000000))", "9")
        XCTAssertEqual("\(Square(0b000000011))", "12")
        XCTAssertEqual("\(Square(0b000000111))", "123")
        XCTAssertEqual("\(Square(0b000001111))", "1234")
        XCTAssertEqual("\(Square(0b000011111))", "12345")
        XCTAssertEqual("\(Square(0b000111111))", "123456")
        XCTAssertEqual("\(Square(0b001111111))", "1234567")
        XCTAssertEqual("\(Square(0b011111111))", "12345678")
        XCTAssertEqual("\(Square(0b111111111))", "123456789")
        XCTAssertEqual("\(Square(0b010101010))", "2468")
        XCTAssertEqual("\(Square(0b101010101))", "13579")
    }
    
    func testSquareCount() {
        XCTAssertEqual(Square().count, 0)
        XCTAssertEqual(Square(0).count,0)
        XCTAssertEqual(Square(0b000000001).count, 1)
        XCTAssertEqual(Square(0b000000010).count, 1)
        XCTAssertEqual(Square(0b000000100).count, 1)
        XCTAssertEqual(Square(0b000001000).count, 1)
        XCTAssertEqual(Square(0b000010000).count, 1)
        XCTAssertEqual(Square(0b000100000).count, 1)
        XCTAssertEqual(Square(0b001000000).count, 1)
        XCTAssertEqual(Square(0b010000000).count, 1)
        XCTAssertEqual(Square(0b100000000).count, 1)
        XCTAssertEqual(Square(0b000000011).count, 2)
        XCTAssertEqual(Square(0b000000111).count, 3)
        XCTAssertEqual(Square(0b000001111).count, 4)
        XCTAssertEqual(Square(0b000011111).count, 5)
        XCTAssertEqual(Square(0b000111111).count, 6)
        XCTAssertEqual(Square(0b001111111).count, 7)
        XCTAssertEqual(Square(0b011111111).count, 8)
        XCTAssertEqual(Square(0b111111111).count, 9)
        XCTAssertEqual(Square(0b010101010).count, 4)
        XCTAssertEqual(Square(0b101010101).count, 5)
    }
    
    func testSquareHasDigit() {
        for digit in 1...9 {
            let mask = UInt16(1 << (digit - 1))
            XCTAssertFalse(Square().hasDigit(digit))
            XCTAssert(Square(mask).hasDigit(digit))
        }
    }
    
    func testSquareAddDigit() {
        var square = Square(0)
        XCTAssertEqual(square.count, 0)
        
        for digit in 1...9 {
            square.addDigit(digit)
            XCTAssert(square.hasDigit(digit))
            XCTAssertEqual(square.count, digit)
        }
    }
    
    func testSquareRemoveDigit() {
        var square = Square(0b111111111)
        XCTAssertEqual(square.count, 9)
        
        for digit in 1...9 {
            square.removeDigit(digit)
            XCTAssertFalse(square.hasDigit(digit))
            XCTAssertEqual(square.count, 9 - digit)
        }
    }
    
    func testGridUnits() {
        let grid1 = "003020600900305001001806400008102900700000008006708200002609500800203009005010300"
        let grid = Grid(grid: grid1)
        
        /* Square 'C2' */
        XCTAssertEqual(grid.units(2*9 + 1).count, 3)
        XCTAssertEqual(grid.units(2*9 + 1),
            [[18, 19, 20, 21, 22, 23, 24, 25, 26],
                [1, 10, 19, 28, 37, 46, 55, 64, 73],
                [0, 1, 2, 9, 10, 11, 18, 19, 20]])
        
        /* Square 'E5' */
        XCTAssertEqual(grid.units(4*9 + 4).count, 3)
        XCTAssertEqual(grid.units(4*9 + 4),
            [[36, 37, 38, 39, 40, 41, 42, 43, 44],
                [4, 13, 22, 31, 40, 49, 58, 67, 76],
                [30, 31, 32, 39, 40, 41, 48, 49, 50]])
    }
    
    func testGridPeers() {
        let grid1 = "003020600900305001001806400008102900700000008006708200002609500800203009005010300"
        let grid = Grid(grid: grid1)
        
        /* Square 'C2' */
        XCTAssertEqual(grid.peers(2*9 + 1).count, 20)
        XCTAssertEqual(grid.peers(2*9 + 1).sorted { $0 < $1 },
            [0, 1, 2, 9, 10, 11, 18, 20, 21, 22, 23, 24, 25, 26, 28, 37, 46, 55, 64, 73])
        
        /* Square 'E5' */
        XCTAssertEqual(grid.peers(4*9 + 4).count, 20)
        XCTAssertEqual(grid.peers(4*9 + 4).sorted { $0 < $1 },
            [4, 13, 22, 30, 31, 32, 36, 37, 38, 39, 41, 42, 43, 44, 48, 49, 50, 58, 67, 76])
    }
    
    func testGridInit() {
        let grid1 = "003020600900305001001806400008102900700000008006708200002609500800203009005010300"
        let expected1 =
            "4 8 3|9 2 1|6 5 7\n" +
            "9 6 7|3 4 5|8 2 1\n" +
            "2 5 1|8 7 6|4 9 3\n" +
            "-----+-----+-----\n" +
            "5 4 8|1 3 2|9 7 6\n" +
            "7 2 9|5 6 4|1 3 8\n" +
            "1 3 6|7 9 8|2 4 5\n" +
            "-----+-----+-----\n" +
            "3 7 2|6 8 9|5 1 4\n" +
            "8 1 4|2 5 3|7 6 9\n" +
            "6 9 5|4 1 7|3 8 2\n"
        
        let grid2 = "4.....8.5.3..........7......2.....6.....8.4......1.......6.3.7.5..2.....1.4......"
        let expected2 =
            "4       1679    12679  |139     2369    269    |8       1239    5      \n" +
            "26789   3       1256789|14589   24569   245689 |12679   1249    124679 \n" +
            "2689    15689   125689 |7       234569  245689 |12369   12349   123469 \n" +
            "-----------------------+-----------------------+-----------------------\n" +
            "3789    2       15789  |3459    34579   4579   |13579   6       13789  \n" +
            "3679    15679   15679  |359     8       25679  |4       12359   12379  \n" +
            "36789   4       56789  |359     1       25679  |23579   23589   23789  \n" +
            "-----------------------+-----------------------+-----------------------\n" +
            "289     89      289    |6       459     3      |1259    7       12489  \n" +
            "5       6789    3      |2       479     1      |69      489     4689   \n" +
            "1       6789    4      |589     579     5789   |23569   23589   23689  \n"

        XCTAssertEqual("\(Grid(grid: grid1))", expected1)
        XCTAssertEqual("\(Grid(grid: grid2))", expected2)
    }
    
    func testFromFile() {
        let fileManager = NSFileManager()
        fileManager.changeCurrentDirectoryPath("/Users/bernd/Projects/Swift/Sudoku Solver/Sudoku Solver")
        
        XCTAssertEqual(fromFile("easy50.txt", separator: "========").count,50)
        XCTAssertEqual(fromFile("hardest.txt").count,11)
        XCTAssertEqual(fromFile("top95.txt").count,95)
    }
    
    func testSolve() {
        let grid1 = "003020600900305001001806400008102900700000008006708200002609500800203009005010300"
        let expected1 =
            "4 8 3|9 2 1|6 5 7\n" +
            "9 6 7|3 4 5|8 2 1\n" +
            "2 5 1|8 7 6|4 9 3\n" +
            "-----+-----+-----\n" +
            "5 4 8|1 3 2|9 7 6\n" +
            "7 2 9|5 6 4|1 3 8\n" +
            "1 3 6|7 9 8|2 4 5\n" +
            "-----+-----+-----\n" +
            "3 7 2|6 8 9|5 1 4\n" +
            "8 1 4|2 5 3|7 6 9\n" +
            "6 9 5|4 1 7|3 8 2\n"

        let grid2 = "4.....8.5.3..........7......2.....6.....8.4......1.......6.3.7.5..2.....1.4......"
        let expected2 =
            "4 1 7|3 6 9|8 2 5\n" +
            "6 3 2|1 5 8|9 4 7\n" +
            "9 5 8|7 2 4|3 1 6\n" +
            "-----+-----+-----\n" +
            "8 2 5|4 3 7|1 6 9\n" +
            "7 9 1|5 8 6|4 3 2\n" +
            "3 4 6|9 1 2|7 5 8\n" +
            "-----+-----+-----\n" +
            "2 8 9|6 4 3|5 7 1\n" +
            "5 7 3|2 9 1|6 8 4\n" +
            "1 6 4|8 7 5|2 9 3\n"

        XCTAssertEqual("\(solve(grid1))", expected1)
        XCTAssertEqual("\(solve(grid2))", expected2)
    }
}
