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

    let sudokuPuzzleConsecutiveEmpty: SudokuPuzzle = [
        [6, 2, 3, 8, 1, 0, 0, 0, 7],
        [1, 4, 5, 3, 7, 0, 0, 0, 6],
        [9, 7, 8, 6, 5, 0, 0, 0, 3],
        [7, 9, 2, 4, 8, 0, 0, 0, 5],
        [4, 8, 6, 5, 2, 0, 0, 0, 9],
        [3, 5, 1, 7, 9, 0, 0, 0, 2],
        [5, 1, 7, 2, 6, 0, 0, 0, 4],
        [2, 3, 9, 1, 4, 0, 0, 0, 8],
        [8, 6, 4, 9, 3, 0, 0, 0, 1]
    ]

    let cageRestrictionsConsecutiveEmpty: [[Int: [Cell]]] = [
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

    let sudokuPuzzlePartial: SudokuPuzzle = [
        [2, 0, 5, 8, 9, 6, 3, 1, 7],
        [8, 9, 6, 7, 3, 1, 4, 0, 5],
        [3, 1, 7, 4, 2, 5, 8, 6, 9],
        [7, 8, 9, 0, 4, 2, 1, 5, 3],
        [5, 3, 0, 1, 7, 0, 6, 9, 4],
        [4, 6, 1, 3, 5, 9, 2, 7, 8],
        [6, 0, 4, 2, 8, 7, 9, 3, 1],
        [1, 7, 3, 9, 6, 4, 5, 8, 2],
        [9, 2, 8, 5, 1, 3, 7, 4, 6]
    ]

    let cageRestrictionsPartial: [[Int: [Cell]]] = [
        [10: [Cell(row: 0, col: 0), Cell(row: 1, col: 0)]],
        [19: [Cell(row: 0, col: 1), Cell(row: 1, col: 1), Cell(row: 1, col: 2)]],
        [5: [Cell(row: 0, col: 2)]],
        [17: [Cell(row: 0, col: 3), Cell(row: 0, col: 4)]],
        [6: [Cell(row: 0, col: 5)]],
        [9: [Cell(row: 0, col: 6), Cell(row: 1, col: 6), Cell(row: 1, col: 7)]],
        [1: [Cell(row: 0, col: 7)]],
        [12: [Cell(row: 0, col: 8), Cell(row: 1, col: 8)]],
        [11: [Cell(row: 1, col: 3), Cell(row: 1, col: 4), Cell(row: 1, col: 5)]],
        [4: [Cell(row: 2, col: 0), Cell(row: 2, col: 1)]],
        [7: [Cell(row: 2, col: 2)]],
        [4: [Cell(row: 2, col: 3)]],
        [6: [Cell(row: 2, col: 4), Cell(row: 3, col: 4)]],
        [5: [Cell(row: 2, col: 5)]],
        [23: [Cell(row: 2, col: 6), Cell(row: 2, col: 7), Cell(row: 2, col: 8)]],
        [24: [Cell(row: 3, col: 0), Cell(row: 3, col: 1), Cell(row: 3, col: 2)]],
        [6: [Cell(row: 3, col: 3)]],
        [10: [Cell(row: 3, col: 5), Cell(row: 4, col: 5)]],
        [7: [Cell(row: 3, col: 6), Cell(row: 4, col: 6)]],
        [8: [Cell(row: 3, col: 7), Cell(row: 3, col: 8)]],
        [8: [Cell(row: 4, col: 0), Cell(row: 4, col: 1)]],
        [2: [Cell(row: 4, col: 2)]],
        [8: [Cell(row: 4, col: 3), Cell(row: 4, col: 4)]],
        [9: [Cell(row: 4, col: 7)]],
        [4: [Cell(row: 4, col: 8)]],
        [4: [Cell(row: 5, col: 0)]],
        [6: [Cell(row: 5, col: 1)]],
        [9: [Cell(row: 5, col: 2), Cell(row: 5, col: 3), Cell(row: 5, col: 4)]],
        [9: [Cell(row: 5, col: 5)]],
        [2: [Cell(row: 5, col: 6)]],
        [16: [Cell(row: 5, col: 7), Cell(row: 5, col: 8), Cell(row: 6, col: 8)]],
        [12: [Cell(row: 6, col: 0), Cell(row: 6, col: 1), Cell(row: 7, col: 0)]],
        [6: [Cell(row: 6, col: 2), Cell(row: 6, col: 3)]],
        [8: [Cell(row: 6, col: 4)]],
        [16: [Cell(row: 6, col: 5), Cell(row: 6, col: 6)]],
        [3: [Cell(row: 6, col: 7)]],
        [7: [Cell(row: 7, col: 1)]],
        [3: [Cell(row: 7, col: 2)]],
        [22: [Cell(row: 7, col: 3), Cell(row: 8, col: 2), Cell(row: 8, col: 3)]],
        [7: [Cell(row: 7, col: 4), Cell(row: 8, col: 4)]],
        [7: [Cell(row: 7, col: 5), Cell(row: 8, col: 5)]],
        [15: [Cell(row: 7, col: 6), Cell(row: 7, col: 7), Cell(row: 7, col: 8)]],
        [17: [Cell(row: 8, col: 6), Cell(row: 8, col: 7), Cell(row: 8, col: 8)]],
        [11: [Cell(row: 8, col: 0), Cell(row: 8, col: 1)]]
    ]

    var killerSudokuPuzzleConsecutiveEmpty: KillerSudokuPuzzle?
    var killerSudokuEmpty: KillerSudoku?

    var killerSudokuPuzzlePartial: KillerSudokuPuzzle?
    var killerSudokuPartial: KillerSudoku?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        self.killerSudokuPuzzleConsecutiveEmpty = KillerSudokuPuzzle(
            rawNormalSudokuPuzzle: sudokuPuzzleConsecutiveEmpty,
            cageRestrictions: cageRestrictionsConsecutiveEmpty
        )

        self.killerSudokuEmpty = try KillerSudoku(board: self.killerSudokuPuzzleConsecutiveEmpty!)

        // Initialising the other puzzle
        self.killerSudokuPuzzlePartial = KillerSudokuPuzzle(
            rawNormalSudokuPuzzle: sudokuPuzzlePartial,
            cageRestrictions: cageRestrictionsPartial
        )

        self.killerSudokuPartial = try KillerSudoku(board: killerSudokuPuzzlePartial!)
    }

    func testKillerConstructors() throws {
        // Test input 1 constructor is already tested in the set up

        // Test input 2
        self.killerSudokuPuzzleConsecutiveEmpty = KillerSudokuPuzzle(
            rawNormalSudokuPuzzle: sudokuPuzzlePartial,
            cageRestrictions: cageRestrictionsPartial
        )

        self.killerSudokuEmpty = try KillerSudoku(board: self.killerSudokuPuzzleConsecutiveEmpty!)

    }

    func testSetFunctionForKillerSudoku() {
        let currCell = Cell(row: 0, col: 0)
        self.killerSudokuEmpty!.set(cell: currCell, to: 6)
        XCTAssertEqual(6, self.killerSudokuEmpty!.getBoardValue(currCell))
    }

    func testKillerWithConsecutiveEmptyPuzzleSolution() throws {

        let solutionForEmptyPuzzle: SudokuPuzzle = [
            [6, 2, 3, 8, 1, 9, 4, 5, 7],
            [1, 4, 5, 3, 7, 2, 9, 8, 6],
            [9, 7, 8, 6, 5, 4, 1, 2, 3],
            [7, 9, 2, 4, 8, 1, 6, 3, 5],
            [4, 8, 6, 5, 2, 3, 7, 1, 9],
            [3, 5, 1, 7, 9, 6, 8, 4, 2],
            [5, 1, 7, 2, 6, 8, 3, 9, 4],
            [2, 3, 9, 1, 4, 7, 5, 6, 8],
            [8, 6, 4, 9, 3, 5, 2, 7, 1]
        ]

        let solver = SudokuSolver(killerSudokuEmpty!)
        let canComputeSolution: Bool = solver.solve()
        XCTAssertTrue(canComputeSolution)

        let computedSolution: SudokuPuzzle = self.killerSudokuEmpty!.mBoard

        print(self.killerSudokuEmpty!)

        XCTAssertEqual(solutionForEmptyPuzzle, computedSolution)

    }

    func testKillerWithPartialPuzzle() {

        let solutionForPartialPuzzle: SudokuPuzzle = [
            [2, 4, 5, 8, 9, 6, 3, 1, 7],
            [8, 9, 6, 7, 3, 1, 4, 2, 5],
            [3, 1, 7, 4, 2, 5, 8, 6, 9],
            [7, 8, 9, 6, 4, 2, 1, 5, 3],
            [5, 3, 2, 1, 7, 8, 6, 9, 4],
            [4, 6, 1, 3, 5, 9, 2, 7, 8],
            [6, 5, 4, 2, 8, 7, 9, 3, 1],
            [1, 7, 3, 9, 6, 4, 5, 8, 2],
            [9, 2, 8, 5, 1, 3, 7, 4, 6]
        ]

        let solver = SudokuSolver(killerSudokuPartial!)
        let canComputeSolution: Bool = solver.solve()
        XCTAssertTrue(canComputeSolution)

        let computedSolution: SudokuPuzzle = self.killerSudokuPartial!.mBoard

        XCTAssertEqual(solutionForPartialPuzzle, computedSolution)
    }

}
