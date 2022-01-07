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

    var mCageSubset: [[Bool]] = []
    var mapFromCellToCageNumber: [Cell: Int] = [:]
    var mapFromCageNumberToCurrentCageSum: [Int: Int] = [:]
    var mCageNumberToSetOfCells: [Int: Set<Cell>] = [:]

    var killerSudoku: KillerSudoku?

    init() { }

    init(board: KillerSudokuPuzzle, _ killerSudoku: KillerSudoku) {
        self.killerSudoku = killerSudoku
        initialiseMapFromCellToCage(board: board, killerSudoku)
        /*
        setCageNumberToSetOfCells(board: board, killerSudoku)

        self.mapFromCellToCageNumber = setMapFromCellToCageNumber(board.cageRestrictions)

        self.mapFromCageNumberToCurrentCageSum = setMapFromCageNumberToCurrentCageSum(board.cageRestrictions)
        self.updateCurrCageSum(killerSudoku)

        self.mCageSubset = setCageSubset(board, killerSudoku)
         */

    }

    private func initialiseMapFromCellToCage(board: KillerSudokuPuzzle, _ killerSudoku: KillerSudoku) {
        for cage in board.cageRestrictions {
            let cageSum: Int = cage.first!.key
            let cellsContained: [Cell] = cage.first!.value
            let newCage: Cage = Cage(cellsContained: cellsContained, cageSum: cageSum)
            for cell in cellsContained {
                self.mapFromCellToCage[cell] = newCage
            }
        }

    }

    private func setCageNumberToSetOfCells(board: KillerSudokuPuzzle, _ killerSudoku: KillerSudoku) {
        for cage in board.cageRestrictions {
            let cageNumber: Int = board.cageRestrictions.firstIndex(of: cage)!
            let setOfCellsForThisCage: Set<Cell> = Set(board.cageRestrictions[cageNumber].first!.value)
            self.mCageNumberToSetOfCells[cageNumber] = setOfCellsForThisCage
        }
    }

    private func cageNumberToSetOfEmptyCells(_ cageNum: Int) -> Set<Cell> {
        var emptyCellsForCageNum: Set<Cell> = []
        for cell in mCageNumberToSetOfCells[cageNum]! {
            if killerSudoku!.emptyCells.contains(cell) {
                emptyCellsForCageNum.insert(cell)
            }
        }
        return emptyCellsForCageNum
    }

    private func updateCurrCageSum(_ killerSudoku: KillerSudoku) {
        // This is called to minus the cage sum according to what is already filled.
        for row in 0..<killerSudoku.mBoard.count {
            for col in 0..<killerSudoku.mBoard.count {
                let currCell = Cell(row: row, col: col)
                if killerSudoku.getBoardValue(currCell) != 0 {
                    self.deductFromCageSum(currCell, valueToDeduct: killerSudoku.getBoardValue(currCell))
                }
            }
        }
    }

    private func deductFromCageSum(_ cell: Cell, valueToDeduct: Int) {
        let cageNum: Int = self.mapFromCellToCageNumber[cell]!
        mapFromCageNumberToCurrentCageSum[cageNum] = mapFromCageNumberToCurrentCageSum[cageNum]! - valueToDeduct
    }

    private func setCageSubset(_ board: KillerSudokuPuzzle, _ killerSudoku: KillerSudoku) -> [[Bool]] {

        let numOfCages: Int = board.cageRestrictions.count

        // Sets all to be false
        var mCageSubset: [[Bool]] = [[Bool]](repeating: [Bool](repeating: false, count: board.rawPuzzle.count), count: numOfCages)

        // Iterate all the cells to set any values that are already filled
        for row in 0..<killerSudoku.mBoard.count {
            for col in 0..<killerSudoku.mBoard.count {
                let currCell: Cell = Cell(row: row, col: col)
                if killerSudoku.getBoardValue(currCell) != 0 {
                    mCageSubset[mapFromCellToCageNumber[currCell]!][killerSudoku.getBoardValue(currCell) - 1] = true
                }
            }
        }

        // Checks for the maximum and minimum possible value within that cage
        for cage in board.cageRestrictions {
            let cageNumber: Int = board.cageRestrictions.firstIndex(of: cage)!
            for possibleValue in 1...killerSudoku.mBoardSize {
                let lessThanMax: Bool = possibleValue <= computeMaxPossibleValueOfCellForACage(cageNumber)
                let moreThanMin: Bool = possibleValue >= computeMinPossibleValueOfCellForACage(cageNumber)
                let alreadyUsedByAnotherCellInSameCage: Bool = mCageSubset[cageNumber][possibleValue - 1]

                if lessThanMax && moreThanMin && !alreadyUsedByAnotherCellInSameCage {
                    mCageSubset[cageNumber][possibleValue - 1] = false
                } else {
                    mCageSubset[cageNumber][possibleValue - 1] = true
                }

            }
        }

        return mCageSubset
    }

    private func setMapFromCellToCageNumber(_ cageRestrictions: [[Int: [Cell]]]) -> [Cell: Int] {
        var mapFromCellToCageNumber: [Cell: Int] = [:]
        var currCageNumber: Int = 0

        for cage in cageRestrictions {
            let arrayOfCellsInCage: [Cell] = cage.first!.value

            for cellInCage in arrayOfCellsInCage {
                mapFromCellToCageNumber[cellInCage] = currCageNumber
            }
            currCageNumber += 1
        }
        return mapFromCellToCageNumber
    }

    private func setMapFromCageNumberToCurrentCageSum(_ cageRestrictions: [[Int: [Cell]]]) -> [Int: Int] {
        var mapFromCageNumberToCurrentCageSum: [Int: Int] = [:]
        var currCageNumber: Int = 0

        for cage in cageRestrictions {
            let cageSum: Int = cage.first!.key
            mapFromCageNumberToCurrentCageSum[currCageNumber] = cageSum
            currCageNumber += 1
        }

        return mapFromCageNumberToCurrentCageSum
    }

    private func computeMaxPossibleValueOfCellForACage(_ cageNumber: Int) -> Int {
        var count: Int = mapFromCageNumberToCurrentCageSum[cageNumber]!
        let numberOfOtherEmptyCellsInCage: Int = cageNumberToSetOfEmptyCells(cageNumber).count - 1

        print("Number of empty cells in 0,0:", numberOfOtherEmptyCellsInCage)

        if numberOfOtherEmptyCellsInCage <= 0 {
            return count
        } else {
            for emptyCellsPointer in 1...numberOfOtherEmptyCellsInCage {
                count -= emptyCellsPointer
            }
            return count
        }
    }

    internal func computeMaxPossibleValueOfCellForACage(_ cell: Cell) -> Int {
        let cageNum: Int = self.mapFromCellToCageNumber[cell]!
        return computeMaxPossibleValueOfCellForACage(cageNum)
    }

    private func computeMinPossibleValueOfCellForACage(_ cageNumber: Int) -> Int {
        var count: Int = mapFromCageNumberToCurrentCageSum[cageNumber]!
        let numberOfEmptyCellsInCage: Int = cageNumberToSetOfEmptyCells(cageNumber).count

        var pointer = 9

        for _ in 0..<numberOfEmptyCellsInCage {
            count -= pointer
            pointer -= 1
        }

        return count
    }

    internal func passKillerCondition(_ cell: Cell, checking: Int) -> Bool {
        let cageNumber: Int = mapFromCellToCageNumber[cell]!
        return mCageSubset[cageNumber][checking - 1]
    }

    internal func setAll(cell: Cell, to value: Int) {
        self.mCageSubset[mapFromCellToCageNumber[cell]!][value - 1] = true
        self.deductFromCageSum(cell, valueToDeduct: value)
    }

    internal func unSetAll(cell: Cell, value: Int?) {
        if let val: Int = value {
            self.mCageSubset[mapFromCellToCageNumber[cell]!][val - 1] = false
            self.deductFromCageSum(cell, valueToDeduct: -val)
        } else {
            // Do nothing.
        }

    }

    internal func cellToCageSum(_ cell: Cell) -> Int {
        let cageNum: Int = self.mapFromCellToCageNumber[cell]!
        return self.mapFromCageNumberToCurrentCageSum[cageNum]!
    }

}
