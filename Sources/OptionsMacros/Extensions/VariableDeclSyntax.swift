//
//  VariableDeclSyntax.swift
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

struct KeyValues {
  var lastKey : Int? = nil
  var dictionary = [Int: String]()
  
  var count : Int {
    return dictionary.count
  }
  
  var nextKey : Int {
    return (lastKey ?? -1) + 1
  }
  
  mutating func append(value: String, withKey key: Int? = nil) throws {
    let key = key ?? nextKey
    guard dictionary[key] == nil else {
      throw InvalidDeclError.rawValue(key)
    }
    lastKey = key
    dictionary[key] = value
  }
  
  func get(_ key: Int) -> String? {
    return dictionary[key]
  }
}

extension KeyValues {
  init(caseElements: [EnumCaseElementSyntax]) throws {
    self.init()
    for caseElement in caseElements {
      let key = (caseElement.rawValue?.value.as(IntegerLiteralExprSyntax.self)?.literal.text).flatMap{Int($0)}
      let value =
      caseElement.name.trimmed.text
      try self.append(value: value, withKey: key)
    }
  }
}
extension VariableDeclSyntax {
  internal init(
    keywordModifier: Keyword?,
    bindingKeyword: Keyword,
    variableName: String,
    initializerExpression: (some ExprSyntaxProtocol)?
  ) {
    let modifiers = DeclModifierListSyntax(keywordModifier: keywordModifier)

    let initializer: InitializerClauseSyntax? =
      initializerExpression.map { .init(value: $0) }

    self.init(
      modifiers: modifiers,
      bindingSpecifier: .keyword(bindingKeyword),
      bindings: .init {
        PatternBindingSyntax(
          pattern: IdentifierPatternSyntax(identifier: .identifier(variableName)),
          initializer: initializer
        )
      }
    )
  }
  
  internal static func initializerExpression(from caseElements: [EnumCaseElementSyntax]) throws -> any ExprSyntaxProtocol {
    let keyValues = try KeyValues(caseElements: caseElements)
    if let array = Array(keyValues: keyValues) {
      return ArrayExprSyntax(from: array) { value in
        StringLiteralExprSyntax(content: value)
      }
    } else {
      return DictionaryExprSyntax(keyValues: keyValues)
    }
  }

  internal static func mappedValuesDeclarationForCases(
    _ caseElements: [EnumCaseElementSyntax]
  ) throws -> VariableDeclSyntax {

    
    //DictionaryElementSyntax(key: IntegerLiteralExprSyntax(integerLiteral: ), value: <#T##ExprSyntaxProtocol#>)
    let arrayExpression = try Self.initializerExpression(from: caseElements)

    return VariableDeclSyntax(
      keywordModifier: .static,
      bindingKeyword: .let,
      variableName: "mappedValues",
      initializerExpression: arrayExpression
    )
  }
}
