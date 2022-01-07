//
//  KillerSudoku.swift
//  SudokuSolver
//
//  Created by Darren Heng on 5/1/22.
//  Copyright © 2022 H. All rights reserved.
//

import Foundation

class KillerSudoku: NormalSudoku {

    var mCageManager = CageManager()

    init(board: KillerSudokuPuzzle) throws {
        try super.init(board: board.rawNormalSudokuPuzzle)
        self.mCageManager = CageManager(killerPuzzle: board, self)
    }

    override internal func isValid(in cell: Cell, _ value: Int) -> Bool {
        let passKillerConditions: Bool = self.mCageManager.passKillerCondition(cell, checking: value)

        return super.isValid(in: cell, value) && passKillerConditions
    }

}
