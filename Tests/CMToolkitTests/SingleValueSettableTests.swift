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

class SingleValueSettableTests: XCTestCase {
    
    struct TestObject: SingleValueSettable {
        var testValue: Int
        var testSequence: [Int]
        var testClass: MyClass
        var json: JSONType
        
        class MyClass {
            var value: Int
            init(value: Int) { self.value = value }
        }
        
        struct JSONType: Codable {
            var value: Int
        }
        
        static let test = TestObject(
            testValue: 10,
            testSequence: [1, 2, 3, 4, 5],
            testClass: MyClass(value: 18),
            json: JSONType(value: 42)
        )
    }

    func testSettingValueTypes() {
        
        // Test value setting
        let eleven = TestObject.test.setting(
            keyPath: \.testValue,
            to: 11
        )
        
        XCTAssertEqual(eleven.testValue, 11)
    }
    
    func testSettingSequences() {
        
        // Test sequence setting (should be the same)
        let sequence = TestObject.test.setting(
            keyPath: \.testSequence,
            to: [5, 4, 3, 2, 1]
        )
        
        XCTAssertEqual(sequence.testSequence, [5, 4, 3, 2, 1])
    }
    
    func testSettingReferenceTypes() {
        
        // Test Class setting
        let newClass = TestObject.test.setting(
            keyPath: \.testClass,
            to: TestObject.MyClass(value: 25)
        )
        
        XCTAssertEqual(newClass.testClass.value, 25)
        XCTAssertEqual(TestObject.test.testClass.value, 18)
        
        // Test Class modification
        let newClassValue = newClass
            .setting(keyPath: \.testClass.value, to: 30)
        
        XCTAssertEqual(newClassValue.testClass.value, 30)
        
        // Since MyClass is a reference type, modification within should also
        // expect to apply to any other references.
        XCTAssertEqual(newClass.testClass.value, 30)
    }
    
    func testSettingThrowingObject() {
        
        struct JSONType: Codable {
            var value: Int
        }
        
        // Assert No Throws
        let validJson = #"{"value":1}"#.data(using: .utf8)!
        XCTAssertNoThrow(try TestObject.test.setting(
            keyPath: \.json,
            to: try JSONDecoder().decode(
                TestObject.JSONType.self,
                from: validJson
            ))
        )
        
        // Assert Throws
        let invalidJson = #"{"value":"hey"}"#.data(using: .utf8)!
        XCTAssertThrowsError(try TestObject.test.setting(
            keyPath: \.json,
            to: try JSONDecoder().decode(
                TestObject.JSONType.self,
                from: invalidJson
            )
        ))
    }
    
    func testMapValueTypes() {
        
        // Test value mapping
        let eleven = TestObject.test
            .mapValue(at: \.testValue) { $0 + 1 }
        
        XCTAssertEqual(eleven.testValue, 11)
    }
    
    func testMapSequences() {
        
        // Test sequence mapping
        let sequence = TestObject.test
            .mapValue(at: \.testSequence) { $0 + [6, 7, 8, 9, 10] }
        
        XCTAssertEqual(sequence.testSequence, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
    }
    
    func testMapReferenceTypes() {
        
        // Test Class setting
        let newClass = TestObject.test
            .mapValue(at: \.testClass) { TestObject.MyClass(value: $0.value + 1) }
        
        XCTAssertEqual(newClass.testClass.value, 19)
        XCTAssertEqual(TestObject.test.testClass.value, 18)
        
        // Test Class modification
        let newClassValue = newClass
            .mapValue(at: \.testClass.value) { $0 + 1 }
        
        XCTAssertEqual(newClassValue.testClass.value, 20)
        
        // Since MyClass is a reference type, modification within should also
        // expect to apply to any other references.
        XCTAssertEqual(newClass.testClass.value, 20)
    }
}
