//
//  NormalSudoku.swift
//  SudokuSolver
//
//  Created by Darren Heng on 5/1/22.
//  Copyright © 2022 H. All rights reserved.
//

import Foundation

typealias SudokuPuzzle = [[Int]]

class NormalSudoku: Sudoku {

    let sideLengthAllowed: Int = 9

    var emptyCells: Set<Cell> {
        var emptyCellsToReturn = Set<Cell>()
        for row in 0..<mBoard.count {
            for col in 0..<mBoard.count {
                let value = mBoard[row][col]
                if value == 0 {
                    let emptyCellToAdd = Cell(row: row, col: col)
                    emptyCellsToReturn.insert(emptyCellToAdd)
                }
            }
        }
        return emptyCellsToReturn
    }

    var isSolved: Bool {
        if self.emptyCells.isEmpty {
            return true
        } else {
            return false
        }
    }

    var mBoardSize: Int {
        Int(pow(Float(mBoxSize), 2))
    }

    let mBoxSize: Int
    var mBoard: SudokuPuzzle
    var mRowSubset: [[Bool]]
    var mColSubset: [[Bool]]
    var mBoxSubset: [[Bool]]

    init(board: SudokuPuzzle) throws {
        mBoard = board
        guard board.count == sideLengthAllowed else {
            throw SudokuError.invalidPuzzleDimension(givenDimension: board.count)
        }
        mBoxSize = Int(sqrt(Double(board.count)))

        // Initialise everything to be false. This tracks whether we
        // satisfy the rules of Sudoku, in that whether any of the
        // digits are repeated.
        // Sets all the rows to be false
        mRowSubset = [[Bool]](repeating: [Bool](repeating: false, count: board.count), count: board.count)
        // Sets all the cols to be false
        mColSubset = [[Bool]](repeating: [Bool](repeating: false, count: board.count), count: board.count)
        // Sets all the boxes to be false
        mBoxSubset = [[Bool]](repeating: [Bool](repeating: false, count: board.count), count: board.count)

        initSubsets()
    }

    internal func initSubsets() {
        for row in 0..<mBoard.count {
            for col in 0..<mBoard.count {
                let value = mBoard[row][col]
                if value != 0 {
                    setSubsetValue(row, col, value, true)
                }
            }
        }
    }

    private func setSubsetValue(_ row: Int, _ col: Int, _ value: Int, _ isPresent: Bool) {
        mRowSubset[row][value - 1] = isPresent
        mColSubset[col][value - 1] = isPresent
        mBoxSubset[computeBoxNo(row, col)][value - 1] = isPresent
    }

    private func setSubsetValue(cell: Cell, value: Int, _ isPresent: Bool) {
        setSubsetValue(cell.row, cell.col, value, isPresent)
    }

    private func computeBoxNo(_ row: Int, _ col: Int) -> Int {
        let boxRow = row / mBoxSize
        let boxCol = col / mBoxSize

        return boxRow * mBoxSize + boxCol
    }

    private func setBoardValue(_ cell: Cell, _ value: Int) {
        mBoard[cell.row][cell.col] = value
    }

    internal func getBoardValue(_ cell: Cell) -> Int {
        mBoard[cell.row][cell.col]
    }

    func set(cell: Cell, to value: Int?) {
        // Assumes that the value being passed as argument is already valid.
        if let setValue = value {
            setSubsetValue(cell.row, cell.col, setValue, true)
            setBoardValue(cell, setValue)
        } else {
            // Means that value was nil, so there is nothing to do.
            // We simply reset the cell on the board to 0 if needed.
            if !self.emptyCells.contains(cell) {
                setBoardValue(cell, 0)
            }
        }
    }

    func unSet(cell: Cell, to value: Int?) {
        // Undo the set operation. This function is called because the value,
        // though possible, will not lead to a solution.
        if let val: Int = value {
            setSubsetValue(cell: cell, value: val, false)
            set(cell: cell, to: nil)
        } else {
            // There is no value being passed, so we simply do nothing
        }
    }

    func options(in cell: Cell) -> Set<Int> {
        var availableOptions: Set<Int> = Set<Int>()
        for possibleValue in 1...mBoardSize {
            if isValid(in: cell, possibleValue) {
                availableOptions.insert(possibleValue)
            }
        }
        return availableOptions
    }

    internal func isValid(in cell: Cell, _ value: Int) -> Bool {
        let val = value - 1
        let isUsed = mRowSubset[cell.row][val] ||
        mColSubset[cell.col][val] ||
        mBoxSubset[computeBoxNo(cell.row, cell.col)][val]
        return !isUsed
    }

    func printBoard() {
        for row in 0..<mBoardSize {
            if row.isMultiple(of: mBoxSize) {
                print(" -----------------------")
            }
            for col in 0..<mBoardSize {
                if col .isMultiple(of: mBoxSize) {
                    print("| ", terminator: "")
                }

                print(mBoard[row][col] != 0 ? String(mBoard[row][col]) : "X", terminator: "")
                print(" ", terminator: "")
            }
            print("|")
        }
        print(" -----------------------")
    }

}
