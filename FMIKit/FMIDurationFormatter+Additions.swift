import Foundation

extension DurationFormatter {
  public func duration(from string: String) -> TimeInterval {
    duration(from: string).seconds
  }
  
  public func string(from duration: TimeInterval) -> String {
    string(from: FMIDuration(duration))
  }
  
  public func editingString(from duration: TimeInterval) -> String {
    editingString(from: FMIDuration(duration))
  }
}
