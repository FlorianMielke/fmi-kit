import UIKit

public protocol CellMarkable: AnyObject {
    var indexPaths: [IndexPath] { get set }
    var table: UITableView { get }
    var markedIndexPath: IndexPath { get }
    func markCell(at indexPath: IndexPath)
    func demarkCell(at indexPath: IndexPath)
    func demarkAllCells()
    func buildAvailableIndexPaths()
}

extension CellMarkable {
    public func markCell(at indexPath: IndexPath) {
        demarkAllCells()
        if let cell = table.cellForRow(at: indexPath) {
            cell.accessoryType = .checkmark
        }
    }
    
    public func demarkCell(at indexPath: IndexPath) {
        if let cell = table.cellForRow(at: indexPath) {
            cell.accessoryType = .none
        }
    }
    
    public func demarkAllCells() {
        _ = indexPaths.map { demarkCell(at: $0) }
    }
    
    public func buildAvailableIndexPaths() {
        for section in 0..<table.numberOfSections {
            for row in 0..<table.numberOfRows(inSection: section) {
                indexPaths.append(IndexPath(row: row, section: section))
            }
        }
    }
}
