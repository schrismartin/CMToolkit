//
//  OptionalUnwrappingTests.swift
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
import CMStandardLibAdditions

class OptionalUnwrappingTests: XCTestCase {
    
    let nilValue: Int? = nil
    let wrappedValue: Int? = 25
    let erasedWrappedValue: Any? = 25
    
    func testWorkingUnwrap() throws {
        
        XCTAssertEqual(try wrappedValue.unwrapped(), 25)
    }
    
    func testFailedUnwrap() throws {
        
        XCTAssertThrowsError(try nilValue.unwrapped(line: 1337)) { error in
            guard let optionalError = error as? Optional<Int>.Error else {
                XCTFail("Failed to convert error \(type(of: error)) to OptionalError"); return
            }
            
            XCTAssertEqual(optionalError.localizedDescription, "Failed to extract necessary data")
            XCTAssertEqual(optionalError.debugDescription, "Failed to unwrap value in file OptionalUnwrappingTests.swift, line 1337")
        }
    }
    
    func testFailedUnwrapWithCustomError() throws {
        
        let optionalUnwrappingError = NSError(domain: "OptionalUnwrappingError", code: 392)
        XCTAssertThrowsError(try nilValue.unwrapped(throwing: optionalUnwrappingError)) { error in
            XCTAssertEqual(error as NSError, optionalUnwrappingError)
        }
    }
    
    func testWorkingUnwrapCast() throws {
        
        XCTAssertEqual(try erasedWrappedValue.unwrapped(as: Int.self), 25)
    }
    
    func testFailedUnwrapCast() {
        
        XCTAssertThrowsError(try erasedWrappedValue.unwrapped(as: Double.self, line: 1337)) { error in
            guard let optionalError = error as? Optional<Any>.Error else {
                XCTFail("Failed to convert error \(type(of: error)) to OptionalError"); return
            }
            
            XCTAssertEqual(optionalError.localizedDescription, "Failed to convert data to expected type")
            XCTAssertEqual(optionalError.debugDescription, "Failed to convert value 25 to type Double in file OptionalUnwrappingTests.swift, line 1337")
        }
    }
    
    func testFailedUnwrapCastWhenNil() throws {
        
        XCTAssertThrowsError(try nilValue.unwrapped(as: Double.self, line: 1337)) { error in
            guard let optionalError = error as? Optional<Int>.Error else {
                XCTFail("Failed to convert error \(type(of: error)) to OptionalError"); return
            }
            
            XCTAssertEqual(optionalError.localizedDescription, "Failed to extract necessary data")
            XCTAssertEqual(optionalError.debugDescription, "Failed to unwrap value in file OptionalUnwrappingTests.swift, line 1337")
        }
    }
    
    func testFailedUnwrapCastWithCustomError() throws {
        
        let optionalUnwrappingError = NSError(domain: "OptionalUnwrappingError", code: 392)
        XCTAssertThrowsError(try erasedWrappedValue.unwrapped(as: Double.self, throwing: optionalUnwrappingError)) { error in
            XCTAssertEqual(error as NSError, optionalUnwrappingError)
        }
    }
}
