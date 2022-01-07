//
//  NormalSudokuSolverTests.swift
//  SudokuSolverTests
//
//  Created by Darren Heng on 6/1/22.
//  Copyright © 2022 H. All rights reserved.
//

import XCTest
@testable import SudokuSolver

class NormalSudokuSolverTests: XCTestCase {

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

    func testSolution() throws {
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

        let solver = SudokuSolver(testNormalSudoku!)
        XCTAssert(solver.solve(), "This puzzle should be solvable, but solver is unable to solve.")

        let computedSolution: SudokuPuzzle = self.testNormalSudoku!.mBoard

        XCTAssertEqual(solvedNormalPuzzle, computedSolution, "Solution is wrong.")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            let solver = SudokuSolver(testNormalSudoku!)

            solver.solve()
            testNormalSudoku!.printBoard()
        }
    }

}
