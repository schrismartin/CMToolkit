//
//  TimeInterval+Intervals.swift
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

public extension TimeInterval {
    
    /// A number of seconds.
    ///
    /// The returned number should only be considered a relative amount, and
    /// provides no guarantee of accuracy between two dates. If you're trying to
    /// represent the time interval between to specific dates, please use Apple's
    /// `Date` and `Calendar` API's.
    ///
    /// - Parameter count: The number of seconds.
    /// - Returns: The number of seconds equivalent to the provided number of seconds.
    public static func seconds(_ count: Int) -> TimeInterval {
        return TimeInterval(count)
    }
    
    /// A number of minutes.
    ///
    /// The returned number should only be considered a relative amount, and
    /// provides no guarantee of accuracy between two dates. If you're trying to
    /// represent the time interval between to specific dates, please use Apple's
    /// `Date` and `Calendar` API's.
    ///
    /// - Parameter count: The number of minutes.
    /// - Returns: The number of seconds equivalent to the provided number of minutes.
    public static func minutes(_ count: Int) -> TimeInterval {
        return .seconds(60 * count)
    }
    
    /// A number of hours.
    ///
    /// The returned number should only be considered a relative amount, and
    /// provides no guarantee of accuracy between two dates. If you're trying to
    /// represent the time interval between to specific dates, please use Apple's
    /// `Date` and `Calendar` API's.
    ///
    /// - Parameter count: The number of hours.
    /// - Returns: The number of seconds equivalent to the provided number of hours.
    public static func hours(_ count: Int) -> TimeInterval {
        return .minutes(60 * count)
    }
    
    /// A number of days.
    ///
    /// The returned number should only be considered a relative amount, and
    /// provides no guarantee of accuracy between two dates. If you're trying to
    /// represent the time interval between to specific dates, please use Apple's
    /// `Date` and `Calendar` API's.
    ///
    /// - Parameter count: The number of days.
    /// - Returns: The number of seconds equivalent to the provided number of days.
    public static func days(_ count: Int) -> TimeInterval {
        return .hours(24 * count)
    }
    
    /// A number of weeks.
    ///
    /// The returned number should only be considered a relative amount, and
    /// provides no guarantee of accuracy between two dates. If you're trying to
    /// represent the time interval between to specific dates, please use Apple's
    /// `Date` and `Calendar` API's.
    ///
    /// - Parameter count: The number of weeks.
    /// - Returns: The number of seconds equivalent to the provided number of weeks.
    public static func weeks(_ count: Int) -> TimeInterval {
        return .days(7 * count)
    }
    
    /// A number of years.
    ///
    /// The returned number should only be considered a relative amount, and
    /// provides no guarantee of accuracy between two dates. If you're trying to
    /// represent the time interval between to specific dates, please use Apple's
    /// `Date` and `Calendar` API's.
    ///
    /// - Parameter count: The number of years.
    /// - Returns: The number of seconds equivalent to the provided number of years.
    public static func years(_ count: Int) -> TimeInterval {
        return .days(365 * count)
    }
}
