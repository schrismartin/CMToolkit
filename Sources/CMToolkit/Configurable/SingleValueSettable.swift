/**
 *  SingleValueSettable.swift
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

/// Decorator protocol providing convenience functions for easily setting
/// individual properties in an object.
public protocol SingleValueSettable { }

public extension SingleValueSettable {
    
    /// Sets the property at the provided keypath to the specified new value.
    ///
    ///     var greenLabel = UILabel()
    ///         .setting(keyPath: \.textColor, to: .green)
    ///         .setting(keyPath: \.text, to: "This is a green label")
    ///
    /// - Parameters:
    ///   - keyPath: KeyPath of the property being modified
    ///   - newValue: Value replacing the old value at the KeyPath.
    /// - Returns: Modified version of the calling object
    func setting<T>(
        keyPath: WritableKeyPath<Self, T>,
        to newValue: @autoclosure () throws -> T
    ) rethrows -> Self {
        
        var mutableSelf = self
        mutableSelf[keyPath: keyPath] = try newValue()
        return mutableSelf
    }
    
    /// Applies a transform to the value at the provided keyPath, returning the
    /// modified version of the caller. Use this when the previous value needs
    /// to be used as a baseline.
    ///
    ///     let personInFiftyYears = person
    ///         .mapValue(at: \.age) { age in age + 50 }
    ///         .mapValue(at: \.height) { inches in inches - 5 }
    ///
    /// - Parameters:
    ///   - keyPath: KeyPath of the property being modified
    ///   - handler: Function transforming the value at the keyPath
    /// - Returns: Modified version of the calling object after applying the
    ///            transform to the property at the keyPath
    /// - Throws: Error throw within transform function
    func mapValue<T>(
        at keyPath: WritableKeyPath<Self, T>,
        handler: (T) throws -> T
    ) rethrows -> Self {
        
        var mutableSelf = self
        mutableSelf[keyPath: keyPath] = try handler(mutableSelf[keyPath: keyPath])
        return mutableSelf
    }
}
