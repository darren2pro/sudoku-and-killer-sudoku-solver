protocol Sudoku {
    mutating func set(cell: Cell, to value: Int?)

    func options(in cell: Cell) -> Set<Int>

    var emptyCells: Set<Cell> { get }

    var isSolved: Bool { get }

    // I added these additional methods to help me solve the problem.

    var mBoardSize: Int { get }

    func printBoard()

    func setSubsetValue(cell: Cell, value: Int, _ isPresent: Bool)
}
