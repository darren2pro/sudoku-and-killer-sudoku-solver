//
//  KillerSudokuPuzzle.swift
//  SudokuSolver
//
//  Created by Darren Heng on 5/1/22.
//  Copyright © 2022 H. All rights reserved.
//

import Foundation

struct KillerSudokuPuzzle {
    var rawPuzzle: SudokuPuzzle
    var cageRestrictions: [[Int: [Cell]]]
}
