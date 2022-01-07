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

}
