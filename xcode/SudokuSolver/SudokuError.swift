//
//  SudokuError.swift
//  SudokuSolver
//
//  Created by Darren Heng on 5/1/22.
//  Copyright © 2022 H. All rights reserved.
//

enum SudokuError: Error {
    case invalidPuzzleDimension(givenDimension: Int)
}
