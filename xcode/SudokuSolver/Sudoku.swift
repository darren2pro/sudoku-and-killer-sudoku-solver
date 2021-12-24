protocol Sudoku {
    mutating func set(cell: Cell, to value: Int?)

    func options(in cell: Cell) -> Set<Int>

    var emptyCells: Set<Cell> { get }

    var isSolved: Bool { get }
}
