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
    
    func testFromFile() {
        XCTAssertEqual(fromFile("/Users/bernd/Projects/Swift/Sudoku Solver/Sudoku Solver/easy50.txt", separator: "========").count,50)
        XCTAssertEqual(fromFile("/Users/bernd/Projects/Swift/Sudoku Solver/Sudoku Solver/hardest.txt").count,11)
        XCTAssertEqual(fromFile("/Users/bernd/Projects/Swift/Sudoku Solver/Sudoku Solver/top95.txt").count,95)
    }
}
