/**
 *  Transformable.swift
 *
 *  Copyright (c) 2019 Chris Martin. Licensed under the MIT license, as follows:
 *
 *  Permission is hereby granted, free of charge, to any person obtaining a copy
 *  of this software and associated documentation files (the "Software"), to deal
 *  in the Software without restriction, including without limitation the rights
 *  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 *  copies of the Software, and to permit persons to whom the Software is
 *  furnished to do so, subject to the following conditions:
 *
 *  The above copyright notice and this permission notice shall be included in all
 *  copies or substantial portions of the Software.
 *
 *  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 *  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 *  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 *  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 *  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 *  SOFTWARE.
 */

import Foundation

/// Decorator protocol allowing a transform function to be applied to the
/// calling object.
///
/// Extensions conforming to this protocol automatically gain access to the
/// `applying(transform:)` function, giving you the ability to customize an
/// object before it enters a scope. When `applying(transform:)` is called, you
/// are given a mutable copy of the calling object in the closure, where you
/// are free to modify as needed. The post-transformation object will then be
/// returned by the `applying(transform:)` function, where you can then store
/// the value as needed.
///
///     extension ImmutableStruct: Transformable { }
///
///     let valueType = ImmutableStruct().applying { value in
///         value.subValue = OtherValue()
///         value.performMutatingTransformation()
///     }
///
/// Because `applying(_:)` returns a copy of the calling object, calls of
/// `applying(_:)` may be chained, allowing you to focus your transformations.
///
///     let valueType = ImmutableStruct()
///         .applying { value in value.subValue = OtherValue() }
///         .applying { value in value.performMutatingTransformation() }
///
/// Assume that calls of `applying(_:)` are _not_ thread-safe. Additionally, do
/// not attempt to use the value provided in the closure in a different thread.
public protocol Transformable { }

public extension Transformable {
    
    /// Applies a transform to the calling object, returning the modified
    /// version.
    ///
    ///     extension UILabel: Transformable { }
    ///
    ///     var greenLabel = UILabel().applying { label in
    ///         label.textColor = .green
    ///         label.text = "This is a green label"
    ///     }
    ///
    /// - Parameter transform: Function transforming the calling object.
    /// - Returns: Modified version of the calling object after applying the
    ///            transform
    /// - Throws: Error thrown within transform function
    func applying(transform: (inout Self) throws -> Void) rethrows -> Self {
        
        var mutableSelf = self
        try transform(&mutableSelf)
        return mutableSelf
    }
}
