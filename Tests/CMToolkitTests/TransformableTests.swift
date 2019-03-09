//
//  SingleValueSettableTests.swift
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

import XCTest
import CMToolkit

class TransformableTests: XCTestCase {
    
    struct TestObject: Transformable {
        var testValue: Int
        var testSequence: [Int]
        var testClass: MyClass
        
        class MyClass {
            var value: Int
            init(value: Int) { self.value = value }
        }
        
        static let test = TestObject(
            testValue: 10,
            testSequence: [1, 2, 3, 4, 5],
            testClass: MyClass(value: 18)
        )
    }
    
    func testTransforming() {
        
        // Test value setting
        let eleven = TestObject.test
            .applying { $0.testValue = 11 }
        
        XCTAssertEqual(eleven.testValue, 11)
        
        // Test sequence setting (should be the same)
        let sequence = TestObject.test
            .applying { $0.testSequence = [5, 4, 3, 2, 1] }
        
        XCTAssertEqual(sequence.testSequence, [5, 4, 3, 2, 1])
        
        // Test Class setting
        let newClass = TestObject.test
            .applying { $0.testClass = TestObject.MyClass(value: 25) }
        
        XCTAssertEqual(newClass.testClass.value, 25)
        XCTAssertEqual(TestObject.test.testClass.value, 18)
        
        // Test Class modification
        let newClassValue = newClass
            .applying { $0.testClass.value = 30 }
        
        XCTAssertEqual(newClassValue.testClass.value, 30)
        
        // Since MyClass is a reference type, modification within should also
        // expect to apply to any other references.
        XCTAssertEqual(newClass.testClass.value, 30)
    }
}
