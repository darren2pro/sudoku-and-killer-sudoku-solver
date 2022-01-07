//
//  KillerSudokuPuzzle.swift
//  SudokuSolver
//
//  Created by Darren Heng on 5/1/22.
//  Copyright © 2022 H. All rights reserved.
//

import Foundation

/// This structure takes a rawPuzzle of type: SudokuPuzzle and cageRestrictions of type: [[Int: [Cell]]]
struct KillerSudokuPuzzle {
    var rawNormalSudokuPuzzle: SudokuPuzzle
    var cageRestrictions: [[Int: [Cell]]]
}
