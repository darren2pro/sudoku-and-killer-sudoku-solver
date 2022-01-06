//
//  KillerSudokuTests.swift
//  KillerSudokuTests
//
//  Created by Darren Heng on 6/1/22.
//  Copyright © 2022 H. All rights reserved.
//

import XCTest
@testable import SudokuSolver

class KillerSudokuTests: XCTestCase {

    let sudokuPuzzle: SudokuPuzzle = [
        [0, 0, 0, 0, 0, 0, 0, 0, 0],
        [1, 0, 4, 0, 0, 6, 0, 0, 0],
        [0, 0, 3, 1, 4, 9, 7, 0, 0],
        [0, 0, 7, 8, 0, 0, 1, 0, 2],
        [2, 0, 0, 0, 0, 1, 0, 9, 0],
        [0, 0, 1, 5, 0, 0, 4, 0, 6],
        [0, 0, 2, 4, 1, 8, 9, 0, 0],
        [8, 0, 5, 0, 0, 2, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0] // Not correct.
    ]

    let cageRestrictions: [[Int: [Cell]]] = [
        [8: [Cell(row: 0, col: 0), Cell(row: 0, col: 1)]],
        [9: [Cell(row: 0, col: 6), Cell(row: 0, col: 7)]],
        [8: [Cell(row: 0, col: 2), Cell(row: 1, col: 2)]],
        [12: [Cell(row: 0, col: 3), Cell(row: 0, col: 4), Cell(row: 1, col: 3)]],
        [15: [Cell(row: 0, col: 5), Cell(row: 1, col: 5), Cell(row: 2, col: 5)]],
        [19: [Cell(row: 1, col: 6), Cell(row: 1, col: 7), Cell(row: 2, col: 7)]],
        [16: [Cell(row: 0, col: 8), Cell(row: 1, col: 8), Cell(row: 2, col: 8)]],
        [14: [Cell(row: 1, col: 0), Cell(row: 1, col: 1), Cell(row: 2, col: 0)]],
        [15: [Cell(row: 2, col: 1), Cell(row: 2, col: 2)]],
        [10: [Cell(row: 2, col: 3), Cell(row: 3, col: 3)]],
        [12: [Cell(row: 1, col: 4), Cell(row: 2, col: 4)]],
        [7: [Cell(row: 2, col: 6), Cell(row: 3, col: 6)]],
        [24: [Cell(row: 3, col: 0), Cell(row: 3, col: 1), Cell(row: 4, col: 1)]],
        [17: [Cell(row: 3, col: 7), Cell(row: 3, col: 8), Cell(row: 4, col: 8)]],
        [8: [Cell(row: 3, col: 2), Cell(row: 4, col: 2)]],
        [12: [Cell(row: 4, col: 3), Cell(row: 5, col: 3)]],
        [19: [Cell(row: 3, col: 4), Cell(row: 4, col: 4), Cell(row: 5, col: 4)]],
        [4: [Cell(row: 3, col: 5), Cell(row: 4, col: 5)]],
        [15: [Cell(row: 4, col: 6), Cell(row: 5, col: 6)]],
        [12: [Cell(row: 4, col: 0), Cell(row: 5, col: 0), Cell(row: 5, col: 1)]],
        [7: [Cell(row: 4, col: 7), Cell(row: 5, col: 7), Cell(row: 5, col: 8)]],
        [8: [Cell(row: 5, col: 2), Cell(row: 6, col: 2)]],
        [10: [Cell(row: 6, col: 4), Cell(row: 7, col: 4)]],
        [14: [Cell(row: 5, col: 5), Cell(row: 6, col: 5)]],
        [12: [Cell(row: 6, col: 6), Cell(row: 6, col: 7)]],
        [18: [Cell(row: 6, col: 8), Cell(row: 7, col: 7), Cell(row: 7, col: 8)]],
        [15: [Cell(row: 6, col: 0), Cell(row: 7, col: 0), Cell(row: 8, col: 0)]],
        [13: [Cell(row: 6, col: 1), Cell(row: 7, col: 1), Cell(row: 7, col: 2)]],
        [12: [Cell(row: 6, col: 3), Cell(row: 7, col: 3), Cell(row: 8, col: 3)]],
        [15: [Cell(row: 7, col: 5), Cell(row: 8, col: 4), Cell(row: 8, col: 5)]],
        [7: [Cell(row: 7, col: 6), Cell(row: 8, col: 6)]],
        [10: [Cell(row: 8, col: 1), Cell(row: 8, col: 2)]],
        [8: [Cell(row: 8, col: 7), Cell(row: 8, col: 8)]]
    ]

    var killerSudokuPuzzle: KillerSudokuPuzzle?

    var killerSudoku: KillerSudoku?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        self.killerSudokuPuzzle = KillerSudokuPuzzle(rawPuzzle: sudokuPuzzle, cageRestrictions: cageRestrictions)

        self.killerSudoku = try KillerSudoku(board: killerSudokuPuzzle!)
    }


    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

}
