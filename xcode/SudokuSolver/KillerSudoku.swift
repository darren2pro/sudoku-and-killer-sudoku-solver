//
//  KillerSudoku.swift
//  SudokuSolver
//
//  Created by Darren Heng on 5/1/22.
//  Copyright © 2022 H. All rights reserved.
//

import Foundation

class KillerSudoku: NormalSudoku {
    var mCageSubset: [[Bool]]
    var mapFromCellToCageNumber: [Cell: Int]
    var mapFromCageNumberToCurrentCageSum: [Int: Int]
    init(board: KillerSudokuPuzzle) throws {
        let numOfCages: Int = board.cageRestrictions.count

        // Initialize to empty first
        self.mCageSubset = [[Bool]](repeating: [Bool](repeating: false, count: board.rawPuzzle.count), count: numOfCages) // Sets all to be false
        self.mapFromCellToCageNumber = [:] // Create an empty dictionary
        self.mapFromCageNumberToCurrentCageSum = [:] // Create an empty dictionary

        try super.init(board: board.rawPuzzle)

        setCageVariablesFromCageRestrictions(board.cageRestrictions)
    }

    internal func setCageVariablesFromCageRestrictions(_ cageRestrictions: [[Int: [Cell]]]) {
        var currCageNumber = 0

        for cage in cageRestrictions {

            var numberOfCellsInCage:Int = 0
            var cageSumGlobal:Int = 0

            for (cageSum, arrayOfCellsInCage) in cage {
                self.mapFromCageNumberToCurrentCageSum[currCageNumber] = cageSum
                numberOfCellsInCage = arrayOfCellsInCage.count
                cageSumGlobal = cageSum

                for cellInCage in arrayOfCellsInCage {
                    self.mapFromCellToCageNumber[cellInCage] = currCageNumber
                }

            }

            func computeMaxPossibleValueOfCellForAParticularCage() -> Int {
                var count:Int = cageSumGlobal

                for i in 1...numberOfCellsInCage {
                    count -= i
                }

                return count
            }
            func computeMinPossibleValueOfCellForAParticularCage() -> Int {
                var count:Int = cageSumGlobal
                var pointer = 9

                for i in 0..<numberOfCellsInCage {
                    count -= pointer
                    pointer -= 1
                }

                return count
            }

            for possibleValue in 0..<self.mBoardSize {
                if (possibleValue <= computeMaxPossibleValueOfCellForAParticularCage()) && (possibleValue >=  computeMinPossibleValueOfCellForAParticularCage()) {
                    self.mCageSubset[currCageNumber][possibleValue] = true
                }
            }

            currCageNumber += 1
        }
    }

    override internal func isValid(in cell: Cell, _ value: Int) -> Bool {
        let val = value - 1

        // Not done. What other conditions? We need to check the sum whether it is correct.
        let failKillerConditions: Bool = mCageSubset[computeCageNumber(cell)][val] // checks whether the value has already appeared in the cage.

        return super.isValid(in: cell, value) && failKillerConditions
    }

    internal func computeCageNumber(_ cell: Cell) -> Int {
        return self.mapFromCellToCageNumber[cell]!
    }

    override func set(cell: Cell, to value: Int?) {
        super.set(cell: cell, to: value)
        // Reset the cageSubset to reflect the new cageSum. Then update the map from cage number to sum as well.
        if let setVal: Int = value {
            updateCageSubset(cell: cell, to: value)
            updateCageSum(cell: cell, newlyAdded: value)
        } else {
            // we want to reset
            error here because not implemented.
        }
    }

    internal func computeMaxPossibleValueOfCellForACage(cageSum: Int, numberOfCellsInCage: Int) -> Int {
        var count:Int = cageSum

        for i in 1...numberOfCellsInCage {
            count -= i
        }

        return count
    }

    internal func computeMinPossibleValueOfCellForACage(cageSum: Int, numberOfCellsInCage: Int) -> Int {
        var count:Int = cageSum
        var pointer = 9

        for i in 0..<numberOfCellsInCage {
            count -= pointer
            pointer -= 1
        }

        return count
    }

    internal func updateCageSubset(cell:Cell, to value: Int) {

    }

    internal func updateCageSum(cell: Cell, newlyAdded: Int) {

    }
}

