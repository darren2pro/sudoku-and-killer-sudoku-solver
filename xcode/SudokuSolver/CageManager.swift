//
//  CageManager.swift
//  SudokuSolver
//
//  Created by Darren Heng on 6/1/22.
//  Copyright © 2022 H. All rights reserved.
//

import Foundation

class CageManager {
    // Used for checking whether there are any repeats and updating the max or min values
    var mapFromCellToCage: [Cell: Cage] = [:]
    var killerSudoku: KillerSudoku?

    init() { }

    init(killerPuzzle: KillerSudokuPuzzle, _ killerSudoku: KillerSudoku) {
        self.killerSudoku = killerSudoku
        initialiseMapFromCellToCage(killerPuzzle: killerPuzzle, killerSudoku)
    }

    private func initialiseMapFromCellToCage(killerPuzzle: KillerSudokuPuzzle, _ killerSudoku: KillerSudoku) {
        for cage in killerPuzzle.cageRestrictions {
            let cageSum: Int = cage.first!.key
            let cellsContained: [Cell] = cage.first!.value
            let newCage = Cage(cellsContained: cellsContained, cageSum: cageSum)
            for cell in cellsContained {
                self.mapFromCellToCage[cell] = newCage
            }
        }
    }

    internal func passKillerCondition(_ cell: Cell, checking: Int) -> Bool {
        let currCage: Cage = mapFromCellToCage[cell]!
        return currCage.passKillerCondition(killerSudoku!, checking: checking)
    }
}
