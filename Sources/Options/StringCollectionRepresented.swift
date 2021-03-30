

public protocol StringCollectionRepresented : StringRepresentable where RawValue == Int {
  static var strings : [String] { get }
}

enum StringCollectionRepresentedError : Error {
  case stringNotFound
}
extension StringCollectionRepresented  {
  
  
  public static func rawValue(basedOn string: String)  throws -> RawValue {
    guard let index = strings.firstIndex(of: string) else {
      throw StringCollectionRepresentedError.stringNotFound
    }
    
    return index
  }
  public static func string(basedOn rawValue: RawValue) throws -> String {
    
    guard rawValue < strings.count && rawValue >= 0 else {
      throw StringCollectionRepresentedError.stringNotFound
      
    }
    return Self.strings[rawValue]
  }
}
