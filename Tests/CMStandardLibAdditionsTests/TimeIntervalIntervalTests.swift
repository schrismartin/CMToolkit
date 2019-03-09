//
//  TimeIntervalIntervalTests.swift
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

class TimeIntervalIntervalTests: XCTestCase {

    func testSeconds() {
        
        XCTAssertEqual(TimeInterval.seconds(10), 10)
        XCTAssertEqual(TimeInterval.seconds(27), 27)
        XCTAssertEqual(TimeInterval.seconds(193), 193)
        
        for seconds in 0 ..< 1000 {
            XCTAssertEqual(TimeInterval.seconds(seconds), TimeInterval(seconds))
        }
    }
    
    func testMinutes() {
        
        XCTAssertEqual(TimeInterval.minutes(10), 10 * 60)
        XCTAssertEqual(TimeInterval.minutes(27), 27 * 60)
        XCTAssertEqual(TimeInterval.minutes(193), 193 * 60)
        
        for minutes in 0 ..< 1000 {
            XCTAssertEqual(TimeInterval.minutes(minutes), TimeInterval(60 * minutes))
        }
    }
    
    func testHours() {
        
        XCTAssertEqual(TimeInterval.hours(10), 10 * 60 * 60)
        XCTAssertEqual(TimeInterval.hours(27), 27 * 60 * 60)
        XCTAssertEqual(TimeInterval.hours(193), 193 * 60 * 60)
        
        for hours in 0 ..< 1000 {
            XCTAssertEqual(TimeInterval.hours(hours), .seconds(hours * 60 * 60))
            XCTAssertEqual(TimeInterval.hours(hours), .minutes(hours * 60))
        }
    }
    
    func testDays() {
        
        XCTAssertEqual(TimeInterval.days(10), 10 * 24 * 60 * 60)
        XCTAssertEqual(TimeInterval.days(27), 27 * 24 * 60 * 60)
        XCTAssertEqual(TimeInterval.days(193), 193 * 24 * 60 * 60)
        
        for days in 0 ..< 1000 {
            XCTAssertEqual(TimeInterval.days(days), .seconds(days * 24 * 60 * 60))
            XCTAssertEqual(TimeInterval.days(days), .minutes(days * 24 * 60))
            XCTAssertEqual(TimeInterval.days(days), .hours(days * 24))
        }
    }
    
    func testWeeks() {
        
        XCTAssertEqual(TimeInterval.weeks(10), 10 * 7 * 24 * 60 * 60)
        XCTAssertEqual(TimeInterval.weeks(27), 27 * 7 * 24 * 60 * 60)
        XCTAssertEqual(TimeInterval.weeks(193), 193 * 7 * 24 * 60 * 60)
        
        for weeks in 0 ..< 1000 {
            XCTAssertEqual(TimeInterval.weeks(weeks), .seconds(weeks * 7 * 24 * 60 * 60))
            XCTAssertEqual(TimeInterval.weeks(weeks), .minutes(weeks * 7 * 24 * 60))
            XCTAssertEqual(TimeInterval.weeks(weeks), .hours(weeks * 7 * 24))
            XCTAssertEqual(TimeInterval.weeks(weeks), .days(weeks * 7))
        }
    }
    
    func testYears() {
        
        XCTAssertEqual(TimeInterval.years(10), 10 * 365 * 24 * 60 * 60)
        XCTAssertEqual(TimeInterval.years(27), 27 * 365 * 24 * 60 * 60)
        XCTAssertEqual(TimeInterval.years(193), 193 * 365 * 24 * 60 * 60)
        
        for years in 0 ..< 1000 {
            XCTAssertEqual(TimeInterval.years(years), .seconds(years * 365 * 24 * 60 * 60))
            XCTAssertEqual(TimeInterval.years(years), .minutes(years * 365 * 24 * 60))
            XCTAssertEqual(TimeInterval.years(years), .hours(years * 365 * 24))
            XCTAssertEqual(TimeInterval.years(years), .days(years * 365))
        }
    }
}
