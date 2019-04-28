//
//  Optional+Unwrapped.swift
//
//  Copyright (c) 2019 Chris Martin. Licensed under the MIT license, as follows:
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

import Foundation

public extension Optional {
    
    /// Unwrap the value, throwing an error if the unwrapping failed.
    ///
    /// In many cases, the `guard let` pattern is sufficient to unwrap a value
    /// and exit the scope if an optional value is nil. However, simply returning
    /// can fail to pass error information to the calling scope. This can result
    /// in unknown failures not being handled correctly. `unwrapped(throwing:)`
    /// provides an ergonomic way to leverage the Swift `try/catch` mechanism to
    /// notify the parent scope of a failure within a function.
    ///
    ///     func doSomethingCritical(using value: Value?) throws {
    ///         let value = try value.unwrapped()
    ///         use(value: value)
    ///     }
    ///
    /// - Parameters:
    ///   - error: Error to be thrown if unwrapping fails (optional)
    ///   - file: File containing the failed unwrap
    ///   - line: Line containing the failed unwrap
    /// - Returns: The unwrapped value inside the optional
    /// - Throws:
    ///   - Provided error, if available
    ///   - `Optional<Wrapped>.Error.optionalUnwrappingFailure` if unwrap fails
    func unwrapped(
        throwing error: Swift.Error? = nil,
        file: StaticString = #file,
        line: UInt = #line
    ) throws -> Wrapped {
        
        guard let value = self else {
            throw error ?? Error.optionalUnwrappingFailure(file: file, line: line)
        }
        
        return value
    }
    
    /// Unwrap the value, casting the result as the intended type.
    ///
    /// Grouped with `unwrapped()`, the next step to many `guard` flows is
    /// ensuring that the wrapped value can be casted to another type. Grouping
    /// the traditional `as?` clause returns us to working directly with
    /// optionals. Use `unwrapped(as:throwing:)` to cast the value in addition
    /// to unwrapping.
    ///
    ///     func decode(json: [String: Any]) -> User {
    ///         return try User(
    ///             name: json["name"].unwrapped(as: String.self),
    ///             age: json["age"].unwrapped(as: Int.self)
    ///         )
    ///     }
    ///
    /// - Parameters:
    ///   - other: Error to be thrown if casting or unwrapping fails (optional)
    ///   - file: File containing the failed unwrap
    ///   - line: File containing the failed unwrap
    /// - Returns: The unwrapped value casted to the intended type, if possible.
    /// - Throws:
    ///   - Provided error, if available
    ///   - `Optional<Wrapped>.Error.optionalUnwrappingFailure` if unwrap fails
    ///   - `Optional<Wrapped>.Error.castingFailure` if casting fails
    func unwrapped<T>(
        as other: T.Type,
        throwing error: Swift.Error? = nil,
        file: StaticString = #file,
        line: UInt = #line
    ) throws -> T {
        
        let value = try unwrapped(throwing: error, file: file, line: line)
        guard let castedValue = value as? T else {
            throw error ?? Error.castingFailure(from: value, to: T.self, file: file, line: line)
        }
        
        return castedValue
    }
    
    /// Errors returned via unwrapping.
    ///
    /// - optionalUnwrappingFailure: The value failed to be unwrapped (was nil)
    /// - castingFailure: The value was unable to be casted to the intended type
    enum Error: Swift.Error, CustomDebugStringConvertible {
        
        /// The value failed to be unwrapped (was nil)
        case optionalUnwrappingFailure(file: StaticString, line: UInt)
        
        /// The value was unable to be casted to the intended type
        case castingFailure(from: Wrapped, to: Any.Type, file: StaticString, line: UInt)
        
        public var localizedDescription: String {
            switch self {
            case .optionalUnwrappingFailure:
                return "Failed to extract necessary data"
            case .castingFailure:
                return "Failed to convert data to expected type"
            }
        }
        
        public var debugDescription: String {
            switch self {
            case .optionalUnwrappingFailure(file: let file, line: let line):
                let file = URL(staticString: file).lastPathComponent
                return "Failed to unwrap value in file \(file), line \(line)"
            case .castingFailure(from: let from, to: let toType, file: let file, line: let line):
                let file = URL(staticString: file).lastPathComponent
                return "Failed to convert value \(from) to type \(toType) in file \(file), line \(line)"
            }
        }
    }
}
