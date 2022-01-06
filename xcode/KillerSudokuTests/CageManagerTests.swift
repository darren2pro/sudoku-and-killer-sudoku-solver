//
//  CageManagerTests.swift
//  KillerSudokuTests
//
//  Created by Darren Heng on 6/1/22.
//  Copyright © 2022 H. All rights reserved.
//

import XCTest
@testable import SudokuSolver

class CageManagerTests: XCTestCase {

    let sudokuPuzzle: SudokuPuzzle = [
        [0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0]
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

    let sudokuPuzzle1: SudokuPuzzle = [
        [2, 0, 5, 8, 9, 6, 3, 1, 7],
        [8, 9, 6, 7, 3, 1, 0, 0, 5],
        [3, 1, 7, 0, 0, 5, 0, 6, 9],
        [7, 8, 9, 0, 4, 2, 1, 5, 3],
        [5, 3, 0, 1, 7, 0, 6, 9, 4],
        [4, 6, 1, 3, 5, 9, 2, 7, 8],
        [6, 0, 4, 2, 8, 7, 9, 3, 1],
        [1, 7, 3, 9, 6, 4, 5, 8, 2],
        [9, 2, 8, 5, 1, 3, 7, 4, 6]
    ]

    let cageRestrictions1: [[Int: [Cell]]] = [
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

    var killerSudokuPuzzle: KillerSudokuPuzzle?
    var killerSudoku: KillerSudoku?

    var killerSudokuPuzzle1: KillerSudokuPuzzle?
    var killerSudoku1: KillerSudoku?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()

        self.killerSudokuPuzzle = KillerSudokuPuzzle(rawPuzzle: sudokuPuzzle, cageRestrictions: cageRestrictions)

        self.killerSudoku = try KillerSudoku(board: self.killerSudokuPuzzle!)

        // Initialising the other puzzle
        self.killerSudokuPuzzle1 = KillerSudokuPuzzle(rawPuzzle: sudokuPuzzle1, cageRestrictions: cageRestrictions1)

        self.killerSudoku1 = try KillerSudoku(board: killerSudokuPuzzle1!)
    }

    func testInput1() throws {

        print("For showing:")

        XCTAssertEqual(Set<Int>([2]), self.killerSudoku1!.options(in: Cell(row: 1, col: 7)))
        XCTAssertEqual(Set<Int>([4]), self.killerSudoku1!.options(in: Cell(row: 1, col: 6)))
        XCTAssertEqual(Set<Int>([4]), self.killerSudoku1!.options(in: Cell(row: 0, col: 1)))
        XCTAssertEqual(Set<Int>([4]), self.killerSudoku1!.options(in: Cell(row: 2, col: 3)))
        XCTAssertEqual(Set<Int>([2]), self.killerSudoku1!.options(in: Cell(row: 2, col: 4)))
        XCTAssertEqual(Set<Int>([8, 4]), self.killerSudoku1!.options(in: Cell(row: 2, col: 6)))
    }

}
