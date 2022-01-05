//
//  Main.swift
//  SudokuSolver
//
//  Created by Darren Heng on 5/1/22.
//  Copyright © 2022 H. All rights reserved.
//

import Foundation

////////////////////////////// Main Program ///////////////////////////////////////////

func main() {

    let samplePuzzle: SudokuPuzzle = [
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

    do {
        let sampleSudoku: Sudoku = try NormalSudoku(board: samplePuzzle)
        print("Initial:")
        sampleSudoku.printBoard()

        /////
        if SudokuSolver(sampleSudoku).solve() {
            print("Solution:")
            sampleSudoku.printBoard()
        } else {
            print("Given Sudoku puzzle cannot be solved.")
        }
        /////

    } catch SudokuError.invalidPuzzleDimension(let givenDimension) {
        print("Invalid Puzzle Dimension = \(givenDimension).")
    } catch {
        print("Other errors.")
    }
}

main()
