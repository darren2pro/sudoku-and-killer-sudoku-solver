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
        try super.init(board: board.rawPuzzle)
        self.mCageManager = CageManager(board: board, self)
    }

    override internal func isValid(in cell: Cell, _ value: Int) -> Bool {

        // Not done. What other conditions? We need to check the sum whether it is correct.
        let passKillerConditions: Bool = self.mCageManager.passKillerCondition(cell, checking: value)

        return super.isValid(in: cell, value) && passKillerConditions
    }

    override func set(cell: Cell, to value: Int?) {
        super.set(cell: cell, to: value)
        // Reset the cageSubset to reflect the new cageSum. Then update the map from cage number to sum as well.
        if let setVal: Int = value {
            self.mCageManager.setAll(cell: cell, to: setVal)
        } else {
            // Nothing to do. It just means we want to set the board back to 0.
            // This is already done in the super.set function call.
        }
    }

    override func unSet(cell: Cell, to value: Int?) {
        super.unSet(cell: cell, to: value)
        self.mCageManager.unSetAll(cell: cell, value: value)
    }

}
