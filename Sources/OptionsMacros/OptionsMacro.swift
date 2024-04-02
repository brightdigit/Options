//
//  OptionsMacro.swift
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

import Foundation
import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxMacros

@main
struct MacrosPlugin: CompilerPlugin {
  let providingMacros: [Macro.Type] = [
    OptionsMacro.self
  ]
}

enum CustomError: Error { case message(String) }
extension EnumDeclSyntax {
  var caseElements: [EnumCaseElementSyntax] {
    memberBlock.members.flatMap { member in
      guard let caseDecl = member.decl.as(EnumCaseDeclSyntax.self) else {
        return [EnumCaseElementSyntax]()
      }

      return Array(caseDecl.elements)
    }
  }
}

extension DeclModifierSyntax {
  var isNeededAccessLevelModifier: Bool {
    switch name.tokenKind {
    case .keyword(.public): return true
    default: return false
    }
  }
}

extension ArrayExprSyntax {
  init<T>(from items: some Collection<T>, _ closure: @escaping @Sendable (T) -> some ExprSyntaxProtocol) {
    let values = items.map(closure).map{ArrayElementSyntax(expression: $0)}
    var arrayElement = ArrayElementListSyntax {
      .init(values)
    }
    self.init(elements: arrayElement)
  }
}

public struct OptionsMacro: ExtensionMacro {
  public static func expansion(
    of _: SwiftSyntax.AttributeSyntax,
    attachedTo declaration: some SwiftSyntax.DeclGroupSyntax,
    providingExtensionsOf type: some SwiftSyntax.TypeSyntaxProtocol,
    conformingTo _: [SwiftSyntax.TypeSyntax],
    in _: some SwiftSyntaxMacros.MacroExpansionContext
  ) throws -> [SwiftSyntax.ExtensionDeclSyntax] {
    guard let enumDecl = declaration.as(EnumDeclSyntax.self) else {
      throw CustomError.message("Type must be struct.")
    }

    let access = enumDecl.modifiers.first(where: \.isNeededAccessLevelModifier)

    let values = enumDecl.caseElements.map { caseElement in
      ArrayElementSyntax(expression: StringLiteralExprSyntax(content: caseElement.name.trimmed.text))
    }

    var arrayElement = ArrayElementListSyntax {
      .init(values)
    }

    let arrayExpression = ArrayExprSyntax(elements: arrayElement)

    let typeName = enumDecl.name

    let typeAlias = TypeAliasDeclSyntax(
      name: "MappedType",
      initializer: .init(value: IdentifierTypeSyntax(name: "String"))
    )

    let inheritanceClause = InheritanceClauseSyntax(
      inheritedTypes: .init(itemsBuilder: {
        InheritedTypeSyntax(type: IdentifierTypeSyntax(name: "MappedValueRepresentable"))
        InheritedTypeSyntax(type: IdentifierTypeSyntax(name: "MappedValueCollectionRepresented"))

      })
    )

    let mappedValuesSyntax = VariableDeclSyntax(
      modifiers: .init(itemsBuilder: {
        DeclModifierSyntax(name: .keyword(.static))

      }),
      bindingSpecifier: .keyword(.let),
      bindings: .init(itemsBuilder: {
        PatternBindingSyntax(
          pattern: IdentifierPatternSyntax(identifier: .identifier("mappedValues")),
          initializer: .init(value: arrayExpression)
        )

      })
    )

//    static let mappedValues = [
//      "github",
//      "travisci",
//      "circleci",
//      "bitrise"
//    ]
    let extensionDecl = ExtensionDeclSyntax(
      modifiers: DeclModifierListSyntax([access].compactMap { $0 }),
      extendedType: IdentifierTypeSyntax(name: typeName),
      inheritanceClause: inheritanceClause,
      memberBlock: MemberBlockSyntax(members: MemberBlockItemListSyntax(itemsBuilder: {
        typeAlias
        mappedValuesSyntax
      }))
    )
    return [extensionDecl]
  }
}
