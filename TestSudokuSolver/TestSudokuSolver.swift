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
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
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
    
    func testSquareHasMember() {
        for member in 1...9 {
            let mask = UInt16(1 << (member - 1))
            XCTAssertFalse(Square().hasMember(member))
            XCTAssert(Square(mask).hasMember(member))
        }
    }
    
    func testSquareAddMember() {
        var square = Square(0)
        XCTAssertEqual(square.count, 0)
        
        for member in 1...9 {
            square.addMember(member)
            XCTAssert(square.hasMember(member))
            XCTAssertEqual(square.count, member)
        }
    }
    
    func testSquareRemoveMember() {
        var square = Square(0b111111111)
        XCTAssertEqual(square.count, 9)
        
        for member in 1...9 {
            square.removeMember(member)
            XCTAssertFalse(square.hasMember(member))
            XCTAssertEqual(square.count, 9 - member)
        }
    }
    
    func testGridUnits() {
        let grid = Grid(grid: "")
        
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
        let grid = Grid(grid: "")
        
        /* Square 'C2' */
        XCTAssertEqual(grid.peers(2*9 + 1).count, 20)
        XCTAssertEqual(grid.peers(2*9 + 1).sorted { $0 < $1 },
            [0, 1, 2, 9, 10, 11, 18, 20, 21, 22, 23, 24, 25, 26, 28, 37, 46, 55, 64, 73])
        
        /* Square 'E5' */
        XCTAssertEqual(grid.peers(4*9 + 4).count, 20)
        XCTAssertEqual(grid.peers(4*9 + 4).sorted { $0 < $1 },
            [4, 13, 22, 30, 31, 32, 36, 37, 38, 39, 41, 42, 43, 44, 48, 49, 50, 58, 67, 76])
    }
    
    func testFromFile() {
        let fileManager = NSFileManager()
        fileManager.changeCurrentDirectoryPath("/Users/bernd/Projects/Swift/Sudoku Solver/Sudoku Solver")
        
        XCTAssertEqual(fromFile("easy50.txt", separator: "========").count,50)
        XCTAssertEqual(fromFile("hardest.txt").count,11)
        XCTAssertEqual(fromFile("top95.txt").count,95)
    }
}
