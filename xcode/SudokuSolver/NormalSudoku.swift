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
        get {
            var emptyCellsToReturn = Set<Cell>()
            for i in 0..<mBoard.count {
                for j in 0..<mBoard.count {
                    let value = mBoard[i][j]
                    if value == 0 {
                        let emptyCellToAdd = Cell(row: i, col: j)
                        emptyCellsToReturn.insert(emptyCellToAdd)
                    }
                }
            }
            return emptyCellsToReturn
        }
    }

    var isSolved: Bool {
        get {
            if self.emptyCells.isEmpty {
                return true
            } else {
                return false
            }
        }
    }
    
    var mBoardSize: Int {
        get {
            return Int(pow(Float(mBoxSize), 2))
        }
    }
    
    let mBoxSize:Int
    var mBoard:SudokuPuzzle
    var mRowSubset:[[Bool]]
    var mColSubset:[[Bool]]
    var mBoxSubset:[[Bool]]
    
    init(board: SudokuPuzzle) throws {
        mBoard = board
        guard board.count == sideLengthAllowed else {
            throw SudokuError.invalidPuzzleDimension(givenDimension: board.count)
        }
        mBoxSize = Int(sqrt(Double(board.count)))
        
        // Initialize everything to be false. This tracks whether we satisfy the rules of Sudoku, in that whether any of the digits are repeated.
        mRowSubset = [[Bool]](repeating: [Bool](repeating: false, count: board.count), count: board.count) // Sets all the rows to be false
        mColSubset = [[Bool]](repeating: [Bool](repeating: false, count: board.count), count: board.count) // Sets all the cols to be false
        mBoxSubset = [[Bool]](repeating: [Bool](repeating: false, count: board.count), count: board.count) // Sets all the boxes to be false
        
        initSubsets()
    }
    
    internal func initSubsets() {
        for i in 0..<mBoard.count {
            for j in 0..<mBoard.count {
                let value = mBoard[i][j]
                if value != 0 {
                    setSubsetValue(i, j, value, true);
                }
            }
        }
    }
    
    internal func setSubsetValue(_ i:Int, _ j:Int, _ value:Int, _ isPresent:Bool) {
        mRowSubset[i][value - 1] = isPresent
        mColSubset[j][value - 1] = isPresent
        mBoxSubset[computeBoxNo(i, j)][value - 1] = isPresent
    }
    
    func setSubsetValue(cell: Cell, value: Int, _ isPresent: Bool) {
        setSubsetValue(cell.row, cell.col, value, isPresent)
    }
    
    internal func computeBoxNo(_ i:Int, _ j:Int) -> Int {
        let boxRow = i / mBoxSize
        let boxCol = j / mBoxSize
 
        return boxRow * mBoxSize + boxCol
    }
    
    internal func setBoardValue(_ cell: Cell, _ value: Int) {
        mBoard[cell.row][cell.col] = value
    }
    
    func set(cell: Cell, to value: Int?) {
        // Assumes that the value being passed as argument is already valid.
        if let setValue = value {
            setSubsetValue(cell.row, cell.col, setValue, true)
            setBoardValue(cell, setValue)
        } else {
            // Means that value was nil, so there is nothing to do. We simply reset the cell on the board to 0 if needed.
            if !self.emptyCells.contains(cell) {
                setBoardValue(cell, 0)
            }
        }
    }
    
    func options(in cell: Cell) -> Set<Int> {
        var availableOptions: Set<Int> = Set<Int>()
        for possibleValue in 1...mBoardSize {
            if isValid(in:cell, possibleValue) {
                availableOptions.insert(possibleValue)
            }
        }
        return availableOptions
    }
    
    internal func isValid(in cell: Cell, _ value: Int) -> Bool {
        let val = value - 1
        let isUsed = mRowSubset[cell.row][val] || mColSubset[cell.col][val] || mBoxSubset[computeBoxNo(cell.row, cell.col)][val]
        return !isUsed
    }
    
    func printBoard() {
        for i in 0..<mBoardSize {
            if i % mBoxSize == 0 {
                print(" -----------------------")
            }
            for j in 0..<mBoardSize {
                if j % mBoxSize == 0 {
                    print("| ", terminator: "")
                }
                
                print(mBoard[i][j] != 0 ? String(mBoard[i][j]) : "X", terminator: "")
                print(" ", terminator: "")
            }
            print("|")
        }
        print(" -----------------------")
    }
    
}
