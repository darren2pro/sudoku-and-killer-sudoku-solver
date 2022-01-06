//
//  NormalSudokuTests.swift
//  NormalSudokuTests
//
//  Created by Darren Heng on 6/1/22.
//  Copyright © 2022 H. All rights reserved.
//

import XCTest
@testable import SudokuSolver

class NormalSudokuTests: XCTestCase {

    let sudokuPuzzle: SudokuPuzzle = [
        [4, 0, 0, 0, 0, 0, 0, 6, 0],
        [5, 0, 0, 0, 8, 0, 9, 0, 0],
        [3, 0, 0, 0, 0, 1, 0, 0, 0],
        [0, 2, 0, 7, 0, 0, 0, 0, 1],
        [0, 9, 0, 0, 0, 0, 0, 4, 0],
        [8, 0, 0, 0, 0, 3, 0, 5, 0],
        [0, 0, 0, 2, 0, 0, 0, 0, 7],
        [0, 0, 6, 0, 5, 0, 0, 0, 8],
        [0, 1, 0, 0, 0, 0, 0, 0, 6]
    ]

    var testNormalSudoku: NormalSudoku?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the
        // invocation of each test method in the class.
        try super.setUpWithError()
        self.testNormalSudoku = try NormalSudoku(board: sudokuPuzzle)
    }

    func testCheckBoardValues() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to
        // complete. Check the results with assertions afterwards.

        let testCell1 = Cell(row: 0, col: 0)
        let testCell2 = Cell(row: 3, col: 8)

        let res1: Bool = testNormalSudoku!.getBoardValue(testCell1) == 4
        let res2: Bool = testNormalSudoku!.getBoardValue(testCell2) == 1

        XCTAssert(res1 && res2, "Checking board values failed.")
    }

    func testOptionsForCellIsAccurate() {
        let testCell1 = Cell(row: 0, col: 1)
        let correctSetOptions1: Set<Int> = Set<Int>([7, 8])
        let res1: Bool = testNormalSudoku!.options(in: testCell1) == correctSetOptions1

        let testCell2 = Cell(row: 8, col: 0)
        let correctSetOptions2: Set<Int> = Set<Int>([2, 7, 9])
        let res2: Bool = testNormalSudoku!.options(in: testCell2) == correctSetOptions2

        XCTAssert(res1 && res2, "Checking options for specific cells failed.")
    }

    func testIsSolved() throws {
        let solvedNormalPuzzle: SudokuPuzzle = [
            [4, 8, 2, 9, 7, 5, 1, 6, 3],
            [5, 6, 1, 3, 8, 2, 9, 7, 4],
            [3, 7, 9, 6, 4, 1, 8, 2, 5],
            [6, 2, 5, 7, 9, 4, 3, 8, 1],
            [1, 9, 3, 5, 6, 8, 7, 4, 2],
            [8, 4, 7, 1, 2, 3, 6, 5, 9],
            [9, 5, 8, 2, 1, 6, 4, 3, 7],
            [7, 3, 6, 4, 5, 9, 2, 1, 8],
            [2, 1, 4, 8, 3, 7, 5, 9, 6]
        ]

        let initiallyNotSolved: Bool = self.testNormalSudoku!.isSolved
        XCTAssertFalse(initiallyNotSolved)

        self.testNormalSudoku = try NormalSudoku(board: solvedNormalPuzzle)
        let isSolved: Bool = self.testNormalSudoku!.isSolved
        XCTAssert(isSolved, "The isSolved computed variable has problems.")

        print("\nPrinting board now:")
        testNormalSudoku!.printBoard()
    }

    func testPerformanceExampleForSetAndUnSet() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
            testNormalSudoku!.set(cell: Cell(row: 5, col: 3), to: 4)
            testNormalSudoku!.unSet(cell: Cell(row: 5, col: 3), to: 4)
        }
    }
}
