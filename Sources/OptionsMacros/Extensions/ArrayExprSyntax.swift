//
//  ArrayExprSyntax.swift
//  SimulatorServices
//
//  Created by Leo Dion.
//  Copyright © 2024 BrightDigit.
//
//  Permission is hereby granted, free of charge, to any person
//  obtaining a copy of this software and associated documentation
//  files (the “Software”), to deal in the Software without
//  restriction, including without limitation the rights to use,
//  copy, modify, merge, publish, distribute, sublicense, and/or
//  sell copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following
//  conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//  OTHER DEALINGS IN THE SOFTWARE.
//

import SwiftSyntax

extension DictionaryExprSyntax {
  internal init(keyValues: KeyValues) {
    let dictionaryElements = keyValues.dictionary.map { (key: Int, value: String) in
      
      return DictionaryElementSyntax(
        key: IntegerLiteralExprSyntax(integerLiteral: key),
        value: StringLiteralExprSyntax(
                                        openingQuote: .stringQuoteToken(),
                                        segments: .init([.stringSegment(.init(content: .stringSegment(value)))]),
                                        closingQuote: .stringQuoteToken()
                                      )
      )
    }
    let list = DictionaryElementListSyntax {
      .init(dictionaryElements)
    }
    self.init(content: .elements(list))
  }
}

extension Array where Element == String {
  init?(keyValues: KeyValues) {
    self.init()
    for key in 0..<keyValues.count {
//      guard self.count == key else {
//        return nil
//      }
      guard let value = keyValues.get(key) else {
        return nil
      }
      self.append(value)
    }
  }
}
extension ArrayExprSyntax {
  
  internal init<T>(
    from items: some Collection<T>,
    _ closure: @escaping @Sendable (T) -> some ExprSyntaxProtocol
  ) {
    let values = items.map(closure).map { ArrayElementSyntax(expression: $0) }
    let arrayElement = ArrayElementListSyntax {
      .init(values)
    }
    self.init(elements: arrayElement)
  }
}
