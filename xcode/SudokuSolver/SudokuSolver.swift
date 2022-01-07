//
//  SudokuSolver.swift
//  SudokuSolver
//
//  Created by Darren Heng on 5/1/22.
//  Copyright © 2022 H. All rights reserved.
//

import Foundation

class SudokuSolver {
    private var sudoku: Sudoku

    init(_ sudoku: Sudoku) {
        self.sudoku = sudoku
    }

    func solve() -> Bool {
        let result: Bool = solveSudokuPuzzleWithRecursion(Cell(row: 0, col: 0))
        return result
    }

    private func solveSudokuPuzzleWithRecursion(_ startingCell: Cell) -> Bool {
        var currRow = startingCell.row
        var currCol = startingCell.col

        if currRow == self.sudoku.mBoardSize {
            currRow = 0
            currCol += 1
            if currCol == self.sudoku.mBoardSize {
                // This means that we have already filled up all the cells with numbers
                // and so we have solved the entire puzzle.
                return true
            }
        }

        if !self.sudoku.emptyCells.contains(Cell(row: currRow, col: currCol)) {
            // Means that this current cell is filled with a number already.
            currRow += 1
            let nextCell = Cell(row: currRow, col: currCol)
            return solveSudokuPuzzleWithRecursion(nextCell)
        }

        let currCell = Cell(row: currRow, col: currCol)
        let possibleOptions: Set<Int> = self.sudoku.options(in: currCell)
        for possibleValue in possibleOptions {
            // Always going to be valid possibleValue
            self.sudoku.set(cell: currCell, to: possibleValue)

            if solveSudokuPuzzleWithRecursion(Cell(row: currRow + 1, col: currCol)) {
//                self.sudoku.printBoard()
                return true
            } else {
                // No solution so we set the
                // board value back to 0 and
                // update the subsets to show that this value is not used.
                // This is all done in the function unSet
                self.sudoku.unSet(cell: currCell, to: possibleValue)
            }
        }

        // Coming here means that all of the possible values
        // cannot lead to a solution. So we simply set it back to 0 and return false.
        self.sudoku.set(cell: currCell, to: nil) // this line is not needed, I think.
        return false
    }
}
