//
//  SudokuSolver.swift
//  SudokuSolver
//
//  Created by Darren Heng on 5/1/22.
//  Copyright © 2022 H. All rights reserved.
//

import Foundation

class SudokuSolver {
    private var sudokuPuzzle: Sudoku

    init(_ sudokuPuzzle: Sudoku) {
        self.sudokuPuzzle = sudokuPuzzle
    }

    func solve() -> Bool {
        let result: Bool = solveSudokuPuzzleWithRecursion(Cell(row: 0, col: 0))
        return result
    }

    private func solveSudokuPuzzleWithRecursion(_ startingCell: Cell) -> Bool {
        var currRow = startingCell.row
        var currCol = startingCell.col

        if currRow == self.sudokuPuzzle.mBoardSize {
            currRow = 0
            currCol += 1
            if currCol == self.sudokuPuzzle.mBoardSize {
                // This means that we have already filled up all the cells with numbers and so we have solved the entire puzzle.
                return true
            }
        }

        if !self.sudokuPuzzle.emptyCells.contains(Cell(row: currRow, col: currCol)) {
            // Means that this current cell is filled with a number already.
            currRow += 1
            let nextCell = Cell(row: currRow, col: currCol)
            return solveSudokuPuzzleWithRecursion(nextCell)
        }

        let currCell = Cell(row: currRow, col: currCol)
        let possibleOptions: Set<Int> = self.sudokuPuzzle.options(in: currCell)
        for possibleValue in possibleOptions {
            // Always going to be valid possibleValue
            self.sudokuPuzzle.set(cell: currCell, to: possibleValue)
            if solveSudokuPuzzleWithRecursion(Cell(row: currRow+1, col: currCol)) {
                return true
            } else {
                // no solution so we set the board value back to 0 and update the subsets to show that this value is not used.
                self.sudokuPuzzle.setSubsetValue(cell: currCell, value: possibleValue, false)
                self.sudokuPuzzle.set(cell: currCell, to: nil)
            }
        }

        // Coming here means that all of the possible values cannot lead to a solution. So we simply set it back to 0 and return false.
        self.sudokuPuzzle.set(cell: currCell, to: nil) // this line is not needed, I think.
        return false
    }
}
