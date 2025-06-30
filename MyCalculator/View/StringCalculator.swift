//
//  StringCalculator.swift
//  MyCalculator
//
//  Created by Dhaval Bhadania on 30/06/25.
//

import Foundation

//StringCalculator class creation and required methods nad enumsimport Foundation
class StringCalculator {
    
    enum CalculatorError: Error, LocalizedError {
            case negativeNumbersNotAllowed([Int])

            var errorDescription: String? {
                switch self {
                case .negativeNumbersNotAllowed(let negatives):
                    return "negative numbers not allowed: " + negatives.map(String.init).joined(separator: ", ")
                }
            }
        }

    // Adding numbers methods - add(_ numbers: String) -> Int
    func add(_ numbers: String) throws -> Int {
        if numbers.isEmpty {
            return 0
        }

        var delimiter = ",|\n"
        var numberString = numbers

        // Check for custom delimiter
        if numbers.hasPrefix("//") {
            let parts = numbers.components(separatedBy: "\n")
            if let delimiterLine = parts.first {
                let customDelimiter = delimiterLine.replacingOccurrences(of: "//", with: "")
                delimiter = NSRegularExpression.escapedPattern(for: customDelimiter)
            }
            numberString = parts.dropFirst().joined(separator: "\n")
        }

        // Split the numbers using regex pattern for delimiter
        let components = try! NSRegularExpression(pattern: delimiter).split(string: numberString)

        let intValues = components.compactMap { Int($0) }

        let negatives = intValues.filter { $0 < 0 }
        if !negatives.isEmpty {
            throw CalculatorError.negativeNumbersNotAllowed(negatives)//CalculatorError display
        }

        return intValues.reduce(0, +)
    }

    
}

extension NSRegularExpression {
    func split(string: String) -> [String] {
        let matches = self.matches(in: string, range: NSRange(string.startIndex..., in: string))
        var last = string.startIndex
        var results: [String] = []

        for match in matches {
            if let range = Range(match.range, in: string) {
                results.append(String(string[last..<range.lowerBound]))
                last = range.upperBound
            }
        }
        results.append(String(string[last...]))
        return results
    }
}
