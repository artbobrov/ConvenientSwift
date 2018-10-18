//
//  Date.swift
//  BetterSwift
//
//  Created by abobrov on 14/09/2018.
//  Copyright © 2018 Artem Bobrov. All rights reserved.
//

import Foundation

public extension Date {
    /// Creates string from date.
    ///
    /// - Parameter format: Date format
    /// - Returns: Date string.
    public func string(with format: String) -> String {
        let formatter = DateFormatter()
        formatter.calendar = .current
        formatter.locale = .current
        formatter.timeZone = .current
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}

public extension Date {
    /// User's current calendar.
    public var calendar: Calendar {
        return Calendar.current
    }

    /// Year.
    public var year: Int {
        get {
            return calendar.component(.year, from: self)
        }
        set {
            guard newValue > 0 else { return }
            let currentYear = calendar.component(.year, from: self)
            let yearsToAdd = newValue - currentYear
            if let date = calendar.date(byAdding: .year, value: yearsToAdd, to: self) {
                self = date
            }
        }
    }

    /// Month.
    public var month: Int {
        return calendar.component(.month, from: self)
    }

    /// Day.
    public var day: Int {
        get { return calendar.component(.day, from: self) }
        set {
            let allowedRange = calendar.range(of: .day, in: .month, for: self)!
            guard allowedRange.contains(newValue) else { return }

            let currentDay = calendar.component(.day, from: self)
            let daysToAdd = newValue - currentDay
            if let date = calendar.date(byAdding: .day, value: daysToAdd, to: self) {
                self = date
            }
        }
    }

    /// Era.
    public var era: Int {
        return calendar.component(.era, from: self)
    }

    /// Quarter.
    public var quarter: Int {
        let month = Double(calendar.component(.month, from: self))
        let numberOfMonths = Double(calendar.monthSymbols.count)
        let numberOfMonthsInQuarter = numberOfMonths / 4
        return Int(month / numberOfMonthsInQuarter)
    }

    /// Week of year.
    public var weekOfYear: Int {
        return calendar.component(.weekOfYear, from: self)
    }

    /// Week of month.
    public var weekOfMonth: Int {
        return calendar.component(.weekOfMonth, from: self)
    }

    /// Week day.
    public var weekday: Int {
        return calendar.component(.weekday, from: self)
    }

    /// Hour.
    public var hour: Int {
        get {
            return calendar.component(.hour, from: self)
        }
        set {
            let allowedRange = calendar.range(of: .hour, in: .day, for: self)!
            guard allowedRange.contains(newValue) else { return }

            let currentHour = calendar.component(.hour, from: self)
            let hoursToAdd = newValue - currentHour
            if let date = calendar.date(byAdding: .hour, value: hoursToAdd, to: self) {
                self = date
            }
        }
    }

    /// Minutes.
    public var minute: Int {
        get {
            return calendar.component(.minute, from: self)
        }
        set {
            let allowedRange = calendar.range(of: .minute, in: .hour, for: self)!
            guard allowedRange.contains(newValue) else { return }

            let currentMinutes = calendar.component(.minute, from: self)
            let minutesToAdd = newValue - currentMinutes
            if let date = calendar.date(byAdding: .minute, value: minutesToAdd, to: self) {
                self = date
            }
        }
    }

    /// Second.
    public var second: Int {
        get {
            return calendar.component(.second, from: self)
        }
        set {
            let allowedRange = calendar.range(of: .second, in: .minute, for: self)!
            guard allowedRange.contains(newValue) else { return }

            let currentSeconds = calendar.component(.second, from: self)
            let secondsToAdd = newValue - currentSeconds
            if let date = calendar.date(byAdding: .second, value: secondsToAdd, to: self) {
                self = date
            }
        }
    }

    /// Nanosecond.
    public var nanosecond: Int {
        get {
            return calendar.component(.nanosecond, from: self)
        }
        set {
            let allowedRange = calendar.range(of: .nanosecond, in: .second, for: self)!
            guard allowedRange.contains(newValue) else { return }

            let currentNanoseconds = calendar.component(.nanosecond, from: self)
            let nanosecondsToAdd = newValue - currentNanoseconds

            if let date = calendar.date(byAdding: .nanosecond, value: nanosecondsToAdd, to: self) {
                self = date
            }
        }
    }

    /// Millisecond.
    public var millisecond: Int {
        get {
            return calendar.component(.nanosecond, from: self) / 1_000_000
        }
        set {
            let nanoSeconds = newValue * 1_000_000
            let allowedRange = calendar.range(of: .nanosecond, in: .second, for: self)!
            guard allowedRange.contains(nanoSeconds) else { return }

            if let date = calendar.date(bySetting: .nanosecond, value: nanoSeconds, of: self) {
                self = date
            }
        }
    }

    /// A Boolean value that determines whether date is in the future.
    public var isInFuture: Bool {
        return self > Date()
    }

    /// A Boolean value that determines whether date is in the future.
    public var isInPast: Bool {
        return self < Date()
    }

    /// A Boolean value that determines whether date is today.
    public var isInToday: Bool {
        return calendar.isDateInToday(self)
    }

    /// A Boolean value that determines whether date is yesterday.
    public var isInYesterday: Bool {
        return calendar.isDateInYesterday(self)
    }

    /// A Boolean value that determines whether date is tomorrow.
    public var isInTomorrow: Bool {
        return calendar.isDateInTomorrow(self)
    }

    /// A Boolean value that determines whether date is weekend.
    public var isInWeekend: Bool {
        return calendar.isDateInWeekend(self)
    }

    /// A Boolean value that determines whether date is working days.
    public var isWorkday: Bool {
        return !calendar.isDateInWeekend(self)
    }

    /// A Boolean value that determines whether date is in a current week.
    public var isInCurrentWeek: Bool {
        return calendar.isDate(self, equalTo: Date(), toGranularity: .weekOfYear)
    }

    /// A Boolean value that determines whether date is in a current month.
    public var isInCurrentMonth: Bool {
        return calendar.isDate(self, equalTo: Date(), toGranularity: .month)
    }

    /// A Boolean value that determines whether date is in a current year.
    public var isInCurrentYear: Bool {
        return calendar.isDate(self, equalTo: Date(), toGranularity: .year)
    }

    /// ISO8601 string of format (yyyy-MM-dd'T'HH:mm:ss.SSS) from date.
    public var iso8601String: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"

        return dateFormatter.string(from: self).appending("Z")
    }

    /// Nearest five minutes to date.
    public var nearestFiveMinutes: Date {
        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second, .nanosecond], from: self)
        let min = components.minute!
        components.minute! = min % 5 < 3 ? min - min % 5 : min + 5 - (min % 5)
        components.second = 0
        components.nanosecond = 0
        return calendar.date(from: components)!
    }

    ///  Nearest ten minutes to date.
    public var nearestTenMinutes: Date {
        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second, .nanosecond], from: self)
        let min = components.minute!
        components.minute? = min % 10 < 6 ? min - min % 10 : min + 10 - (min % 10)
        components.second = 0
        components.nanosecond = 0
        return calendar.date(from: components)!
    }

    ///  Nearest quater hour to date.
    public var nearestQuarterHour: Date {
        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second, .nanosecond], from: self)
        let min = components.minute!
        components.minute! = min % 15 < 8 ? min - min % 15 : min + 15 - (min % 15)
        components.second = 0
        components.nanosecond = 0
        return calendar.date(from: components)!
    }

    /// Nearest half hour to date.
    public var nearestHalfHour: Date {
        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second, .nanosecond], from: self)
        let min = components.minute!
        components.minute! = min % 30 < 15 ? min - min % 30 : min + 30 - (min % 30)
        components.second = 0
        components.nanosecond = 0
        return calendar.date(from: components)!
    }

    /// Nearest hour to date.
    public var nearestHour: Date {
        let min = calendar.component(.minute, from: self)
        let components: Set<Calendar.Component> = [.year, .month, .day, .hour]
        let date = calendar.date(from: calendar.dateComponents(components, from: self))!

        if min < 30 {
            return date
        }
        return calendar.date(byAdding: .hour, value: 1, to: date)!
    }

    /// Time zone used currently by system.
    public var timeZone: TimeZone {
        return calendar.timeZone
    }
}

public extension Date {
    /// Date by adding multiples of calendar component.
    ///
    /// - Parameters:
    ///   - component: Component of a calendar date.
    ///   - value: Multiples of components to add.
    /// - Returns: Original date + multiples of component added.
    public func adding(_ component: Calendar.Component, value: Int) -> Date {
        return calendar.date(byAdding: component, value: value, to: self)!
    }

    /// Add calendar component to date.
    ///
    /// - Parameters:
    ///   - component: Component of a calendar date.
    ///   - value: Multiples of components to add.
    public mutating func add(_ component: Calendar.Component, value: Int) {
        if let date = calendar.date(byAdding: component, value: value, to: self) {
            self = date
        }
    }

    // swiftlint:disable cyclomatic_complexity
    /// Date by changing value of calendar component.
    ///
    /// - Parameters:
    ///   - component: Component of a calendar date.
    ///   - value: New value of component to change.
    /// - Returns: Original date after changing given component to given value.
    public func changing(_ component: Calendar.Component, value: Int) -> Date? {
        switch component {
        case .nanosecond:
            let allowedRange = calendar.range(of: .nanosecond, in: .second, for: self)!
            guard allowedRange.contains(value) else { return nil }
            let currentNanoseconds = calendar.component(.nanosecond, from: self)
            let nanosecondsToAdd = value - currentNanoseconds
            return calendar.date(byAdding: .nanosecond, value: nanosecondsToAdd, to: self)

        case .second:
            let allowedRange = calendar.range(of: .second, in: .minute, for: self)!
            guard allowedRange.contains(value) else { return nil }
            let currentSeconds = calendar.component(.second, from: self)
            let secondsToAdd = value - currentSeconds
            return calendar.date(byAdding: .second, value: secondsToAdd, to: self)

        case .minute:
            let allowedRange = calendar.range(of: .minute, in: .hour, for: self)!
            guard allowedRange.contains(value) else { return nil }
            let currentMinutes = calendar.component(.minute, from: self)
            let minutesToAdd = value - currentMinutes
            return calendar.date(byAdding: .minute, value: minutesToAdd, to: self)

        case .hour:
            let allowedRange = calendar.range(of: .hour, in: .day, for: self)!
            guard allowedRange.contains(value) else { return nil }
            let currentHour = calendar.component(.hour, from: self)
            let hoursToAdd = value - currentHour
            return calendar.date(byAdding: .hour, value: hoursToAdd, to: self)

        case .day:
            let allowedRange = calendar.range(of: .day, in: .month, for: self)!
            guard allowedRange.contains(value) else { return nil }
            let currentDay = calendar.component(.day, from: self)
            let daysToAdd = value - currentDay
            return calendar.date(byAdding: .day, value: daysToAdd, to: self)

        case .month:
            let allowedRange = calendar.range(of: .month, in: .year, for: self)!
            guard allowedRange.contains(value) else { return nil }
            let currentMonth = calendar.component(.month, from: self)
            let monthsToAdd = value - currentMonth
            return calendar.date(byAdding: .month, value: monthsToAdd, to: self)

        case .year:
            guard value > 0 else { return nil }
            let currentYear = calendar.component(.year, from: self)
            let yearsToAdd = value - currentYear
            return calendar.date(byAdding: .year, value: yearsToAdd, to: self)

        default:
            return calendar.date(bySetting: component, value: value, of: self)
        }
    }

    // swiftlint:enable cyclomatic_complexity

    /// Data at the beginning of calendar component.
    ///
    /// - Parameter component: Component of a calendar date.
    /// - Returns: Date at the beginning of calendar component (if applicable).
    public func beginning(of component: Calendar.Component) -> Date? {
        if component == .day {
            return calendar.startOfDay(for: self)
        }

        var components: Set<Calendar.Component> {
            switch component {
            case .second:
                return [.year, .month, .day, .hour, .minute, .second]

            case .minute:
                return [.year, .month, .day, .hour, .minute]

            case .hour:
                return [.year, .month, .day, .hour]

            case .weekOfYear, .weekOfMonth:
                return [.yearForWeekOfYear, .weekOfYear]

            case .month:
                return [.year, .month]

            case .year:
                return [.year]

            default:
                return []
            }
        }

        guard !components.isEmpty else { return nil }
        return calendar.date(from: calendar.dateComponents(components, from: self))
    }

    /// Date at the end of calendar component.
    ///
    /// - Parameter component: Component of a calendar date.
    /// - Returns: Date at the end of calendar component (if applicable).
    public func end(of component: Calendar.Component) -> Date? {
        switch component {
        case .second:
            var date = adding(.second, value: 1)
            date = calendar.date(from:
                calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date))!
            date.add(.second, value: -1)
            return date

        case .minute:
            var date = adding(.minute, value: 1)
            let after = calendar.date(from:
                calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date))!
            date = after.adding(.second, value: -1)
            return date

        case .hour:
            var date = adding(.hour, value: 1)
            let after = calendar.date(from:
                calendar.dateComponents([.year, .month, .day, .hour], from: date))!
            date = after.adding(.second, value: -1)
            return date

        case .day:
            var date = adding(.day, value: 1)
            date = calendar.startOfDay(for: date)
            date.add(.second, value: -1)
            return date

        case .weekOfYear, .weekOfMonth:
            var date = self
            let beginningOfWeek = calendar.date(from:
                calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date))!
            date = beginningOfWeek.adding(.day, value: 7).adding(.second, value: -1)
            return date

        case .month:
            var date = adding(.month, value: 1)
            let after = calendar.date(from:
                calendar.dateComponents([.year, .month], from: date))!
            date = after.adding(.second, value: -1)
            return date

        case .year:
            var date = adding(.year, value: 1)
            let after = calendar.date(from:
                calendar.dateComponents([.year], from: date))!
            date = after.adding(.second, value: -1)
            return date

        default:
            return nil
        }
    }

    /// Check if date is in current given calendar component.
    ///
    /// - Parameter component: Component of a calendar date.
    /// - Returns: True if date is in current given calendar component.
    public func isInCurrent(_ component: Calendar.Component) -> Bool {
        return calendar.isDate(self, equalTo: Date(), toGranularity: component)
    }

    /// Date string from date.
    ///
    /// - Parameter style: date formatter style (default is .medium).
    /// - Returns: date string.
    public func dateString(ofStyle style: DateFormatter.Style = .medium) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .none
        dateFormatter.dateStyle = style
        return dateFormatter.string(from: self)
    }

    /// Date and time string from date.
    ///
    /// - Parameter style: Date formatter style (default is .medium).
    /// - Returns: Date and time string.
    public func dateTimeString(ofStyle style: DateFormatter.Style = .medium) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = style
        dateFormatter.dateStyle = style
        return dateFormatter.string(from: self)
    }

    /// Time string from date.
    ///
    /// - Parameter style: Date formatter style (default is .medium).
    /// - Returns: Time string.
    public func timeString(ofStyle style: DateFormatter.Style = .medium) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = style
        dateFormatter.dateStyle = .none
        return dateFormatter.string(from: self)
    }

    /// Day name from date.
    ///
    /// - Parameter style: Style of day name (default is DayNameStyle.full).
    /// - Returns: Day name string (example: W, Wed, Wednesday).
    public func dayName(ofStyle style: DayNameStyle = .full) -> String {
        let dateFormatter = DateFormatter()
        var format: String {
            switch style {
            case .oneLetter:
                return "EEEEE"
            case .threeLetters:
                return "EEE"
            case .full:
                return "EEEE"
            }
        }
        dateFormatter.setLocalizedDateFormatFromTemplate(format)
        return dateFormatter.string(from: self)
    }

    /// Month name from date.
    ///
    /// - Parameter style: Style of month name (default is MonthNameStyle.full).
    /// - Returns: Month name string (example: D, Dec, December).
    public func monthName(ofStyle style: MonthNameStyle = .full) -> String {
        let dateFormatter = DateFormatter()
        var format: String {
            switch style {
            case .oneLetter:
                return "MMMMM"
            case .threeLetters:
                return "MMM"
            case .full:
                return "MMMM"
            }
        }
        dateFormatter.setLocalizedDateFormatFromTemplate(format)
        return dateFormatter.string(from: self)
    }

    /// Get number of seconds between two dates.
    ///
    /// - Parameter date: Date to compate self to.
    /// - Returns: Number of seconds between self and given date.
    public func secondsSince(_ date: Date) -> Double {
        return timeIntervalSince(date)
    }

    /// Get number of minutes between two dates.
    ///
    /// - Parameter date: Date to compate self to.
    /// - Returns: Number of minutes between self and given date.
    public func minutesSince(_ date: Date) -> Double {
        return timeIntervalSince(date) / 60
    }

    /// Get number of hours between two dates.
    ///
    /// - Parameter date: Date to compate self to.
    /// - Returns: Number of hours between self and given date.
    public func hoursSince(_ date: Date) -> Double {
        return timeIntervalSince(date) / 3600
    }

    /// Get number of hours between two dates.
    ///
    /// - Parameter date: Date to compate self to.
    /// - Returns: Number of days between self and given date.
    public func daysSince(_ date: Date) -> Double {
        return timeIntervalSince(date) / (3600 * 24)
    }

    /// Check if a date is between two other dates.
    ///
    /// - Parameters:
    ///   - startDate: Lower bound date to compare self to.
    ///   - endDate: Upper bound date to compare self to.
    ///   - includeBounds: True if the start and end date should be included (default is false).
    /// - Returns: True if the date is between the two given dates.
    public func isBetween(_ startDate: Date, _ endDate: Date, includeBounds: Bool = false) -> Bool {
        if includeBounds {
            return startDate.compare(self).rawValue * compare(endDate).rawValue >= 0
        }
        return startDate.compare(self).rawValue * compare(endDate).rawValue > 0
    }

    /// Check if a date is a number of date components of another date.
    ///
    /// - Parameters:
    ///   - value: Number of times component is used in creating range.
    ///   - component: Component of a calendar date.
    ///   - date: Date to compare self to.
    /// - Returns: True if the date is within a number of components of another date.
    public func isWithin(_ value: UInt, _ component: Calendar.Component, of date: Date) -> Bool {
        let components = calendar.dateComponents([component], from: self, to: date)
        let componentValue = components.value(for: component)!
        return abs(componentValue) <= value
    }

    /// Creates a random date within the specified range.
    ///
    /// - Parameter range: The range in which to create a random date. `range` must not be empty.
    /// - Returns: A random date within the specified range.
    public static func random(in range: Range<Date>) -> Date {
        return Date(timeIntervalSinceReferenceDate:
            TimeInterval.random(in: range.lowerBound.timeIntervalSinceReferenceDate ..< range.upperBound.timeIntervalSinceReferenceDate))
    }
}

public extension Date {
    /// Day name format.
    ///
    /// - threeLetters: 3 letter day abbreviation of day name.
    /// - oneLetter: 1 letter day abbreviation of day name.
    /// - full: Full day name.
    public enum DayNameStyle {
        case threeLetters
        case oneLetter
        case full
    }

    /// Month name format.
    ///
    /// - threeLetters: 3 letter month abbreviation of month name.
    /// - oneLetter: 1 letter month abbreviation of month name.
    /// - full: Full month name.
    public enum MonthNameStyle {
        case threeLetters
        case oneLetter
        case full
    }
}

public extension Date {
    /// Create a new date form calendar components.
    ///
    /// - Parameters:
    ///   - calendar: Calendar (default is current).
    ///   - timeZone: TimeZone (default is current).
    ///   - era: Era (default is current era).
    ///   - year: Year (default is current year).
    ///   - month: Month (default is current month).
    ///   - day: Day (default is today).
    ///   - hour: Hour (default is current hour).
    ///   - minute: Minute (default is current minute).
    ///   - second: Second (default is current second).
    ///   - nanosecond: Nanosecond (default is current nanosecond).
    public init?(
        calendar: Calendar? = Calendar.current,
        timeZone: TimeZone? = TimeZone.current,
        era: Int? = Date().era,
        year: Int? = Date().year,
        month: Int? = Date().month,
        day: Int? = Date().day,
        hour: Int? = Date().hour,
        minute: Int? = Date().minute,
        second: Int? = Date().second,
        nanosecond: Int? = Date().nanosecond
    ) {
        var components = DateComponents()
        components.calendar = calendar
        components.timeZone = timeZone
        components.era = era
        components.year = year
        components.month = month
        components.day = day
        components.hour = hour
        components.minute = minute
        components.second = second
        components.nanosecond = nanosecond

        if let date = calendar?.date(from: components) {
            self = date
        } else {
            return nil
        }
    }

    /// Create date object from ISO8601 string.
    ///
    /// - Parameter iso8601String: ISO8601 string of format (yyyy-MM-dd'T'HH:mm:ss.SSSZ).
    public init?(iso8601String: String) {
        let dateFormatter = DateFormatter()

        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        guard let date = dateFormatter.date(from: iso8601String) else { return nil }
        self = date
    }

    /// Create new date object from UNIX timestamp.
    ///
    /// - Parameter unixTimestamp: UNIX timestamp.
    public init(unixTimestamp: Double) {
        self.init(timeIntervalSince1970: unixTimestamp)
    }

    /// Create date object from Int literal
    ///
    /// 		let date = Date(integerLiteral: 2017_12_25) // "2017-12-25 00:00:00 +0000"
    ///
    /// - Parameter value: Int value, e.g. 20171225, or 2017_12_25 etc.
    public init?(integerLiteral value: Int) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        guard let date = formatter.date(from: String(value)) else { return nil }
        self = date
    }
}
