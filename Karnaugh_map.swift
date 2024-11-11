import Foundation

// Define a 4-variable K-Map layout with 16 cells for a Boolean function.
class KarnaughMap {
    // 4-variable K-map (16 cells) initialized to 0 (false)
    private var map: [[Int]] = Array(repeating: Array(repeating: 0, count: 4), count: 4)
    
    // Initialize the K-Map with a given truth table
    init(truthTable: [Int]) {
        guard truthTable.count == 16 else {
            fatalError("Truth table must have 16 values for a 4-variable K-Map.")
        }
        
        // Map truth table values to K-Map cells
        for i in 0..<4 {
            for j in 0..<4 {
                map[i][j] = truthTable[getKMapIndex(row: i, col: j)]
            }
        }
    }
    
    // Convert row, col to Gray code ordering
    private func getKMapIndex(row: Int, col: Int) -> Int {
        let rowGray = row ^ (row >> 1) // Gray code for row
        let colGray = col ^ (col >> 1) // Gray code for col
        return rowGray * 4 + colGray
    }
    
    // Print the K-Map for visualization
    func printMap() {
        print("Karnaugh Map:")
        for row in map {
            print(row.map { String($0) }.joined(separator: " "))
        }
    }
    
    // Simplify the K-Map by grouping cells with 1s to minimize the Boolean expression
    func simplify() -> String {
        var simplifiedExpression = ""
        
        // This example performs a basic grouping. For simplicity, we'll only handle isolated cells (not groupings).
        for i in 0..<4 {
            for j in 0..<4 {
                if map[i][j] == 1 {
                    let term = getTermForCell(row: i, col: j)
                    simplifiedExpression += term + " + "
                }
            }
        }
        
        // Remove trailing " + " and return the simplified expression
        if !simplifiedExpression.isEmpty {
            simplifiedExpression.removeLast(3)
        }
        return simplifiedExpression
    }
    
    // Generate a Boolean term for a specific cell position in the K-Map
    private func getTermForCell(row: Int, col: Int) -> String {
        var term = ""
        
        // Define variables based on row and column Gray code values
        let rowGray = row ^ (row >> 1)
        let colGray = col ^ (col >> 1)
        
        // Determine terms based on Gray code row and column
        term += rowGray & 2 == 0 ? "A" : "!A"
        term += rowGray & 1 == 0 ? "B" : "!B"
        term += colGray & 2 == 0 ? "C" : "!C"
        term += colGray & 1 == 0 ? "D" : "!D"
        
        return term
    }
}

// Example usage:
let truthTable = [
    1, 0, 0, 1,
    0, 1, 1, 0,
    1, 0, 0, 1,
    0, 1, 1, 0
]

let kMap = KarnaughMap(truthTable: truthTable)
kMap.printMap()
print("Simplified Expression: \(kMap.simplify())")
