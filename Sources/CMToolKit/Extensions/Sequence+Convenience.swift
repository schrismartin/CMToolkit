//
//  Sequence+Convenience.swift
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

public extension Sequence {
    
    /// Returns an array containing the properties at the provided keypath
    /// over the sequence's elements.
    ///
    /// In this example, `map` is used to count the characters in each element.
    ///
    ///     let cast = ["Vivien", "Marlon", "Kim", "Karl"]
    ///     let letterCounts = cast.map(to: \.count)
    ///     // 'letterCounts' == [6, 6, 3, 4]
    ///
    /// - Parameter keyPath: A keyPath pointing to the extracted property.
    /// - Returns: An array containing the transformed elements of this
    ///   sequence.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the sequence.
    public func map<T>(to keyPath: KeyPath<Element, T>) -> [T] {
        return map { $0[keyPath: keyPath] }
    }
    
    /// Returns an array of elements sorted in _ascending_ order derived from
    /// the element at the provided keyPath for each operand.
    ///
    ///     let users = ["Chris", "Tom", "Jake", "Jeffery"]
    ///     let sorted = users.sorted(by: \.count)
    ///     // `sorted` == ["Tom", "Jake", "Chris", "Jeffery"]
    ///
    /// - Parameter keyPath: KeyPath pointing at the comparable operands
    /// - Returns: Array of elements sorted by the operands at the keyPath
    public func sorted<T: Comparable>(by keyPath: KeyPath<Element, T>) -> [Element] {
        return sorted { first, second in
            first[keyPath: keyPath] < second[keyPath: keyPath]
        }
    }
    
    /// Returns an array containing, in order, the elements of the sequence
    /// where the property at the keyPath equals the provided value.
    ///
    /// In this example, `filter(_:)` is used to include only names equaling
    /// five characters.
    ///
    ///     let cast = ["Vivien", "Marlon", "Kim", "Karol", "Chris"]
    ///     let shortNames = cast.filter(where: \.count, equals: 5)
    ///     print(shortNames)
    ///     // Prints "["Karol", "Chris"]"
    ///
    /// - Parameters:
    ///   - keyPath: A keyPath pointing to the property to be compared.
    ///   - other: The expected value of the value at the keyPath.
    /// - Returns: An array of the elements matching the equality comparison.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the sequence.
    public func filter<T: Equatable>(where keyPath: KeyPath<Element, T>, equals other: T) -> [Element] {
        return filter { $0[keyPath: keyPath] == other }
    }
}
