//
//  Cage.swift
//  SudokuSolver
//
//  Created by Darren Heng on 7/1/22.
//  Copyright © 2022 H. All rights reserved.
//

import Foundation

class Cage {
    var cellsContained: [Cell] = []
    let cageSum: Int

    init(cellsContained: [Cell], cageSum: Int) {
        self.cellsContained = cellsContained
        self.cageSum = cageSum
    }

    internal func passKillerCondition(_ killerSudoku: KillerSudoku, checking: Int) -> Bool {
        var currCageSumExisting: Int = 0
        var usedNumbers: [Int] = []
        for cell in cellsContained {
            currCageSumExisting += killerSudoku.getBoardValue(cell)
            if killerSudoku.getBoardValue(cell) != 0 {
                usedNumbers.append(killerSudoku.getBoardValue(cell))
            }
        }

        let withinMaximumCageSum: Bool = (currCageSumExisting + checking) <= cageSum

        let notPreviouslyUsed: Bool = !usedNumbers.contains(checking)

        if cellsContained.count == usedNumbers.count {
            // All the cells in the cage are filled.
            let isExactlyEqualCageSum: Bool = (currCageSumExisting + checking) == cageSum

            return withinMaximumCageSum &&
            notPreviouslyUsed &&
            isExactlyEqualCageSum
        } else {
            // Not all cells are filled yet
            return withinMaximumCageSum &&
            notPreviouslyUsed
        }
    }

}
