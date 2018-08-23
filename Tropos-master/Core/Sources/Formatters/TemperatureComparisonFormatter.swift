import Foundation

public struct TemperatureComparisonFormatter {
    public init() {}

    public func localizedStrings(fromComparison comparison: TemperatureComparison, precipitation: String, date: NSDate) -> (description: String, adjective: String) {
        let adjective = comparison.localizedAdjective
        let timeOfDay = NSCalendar.currentCalendar().localizedTimeOfDay(forDate: date)
        let timeOfYesterday = NSCalendar.currentCalendar().localizedTimeOfYesterday(relativeToDate: date)

        let format = comparison == .Same
            ? TroposCoreLocalizedString("SameTemperatureFormat")
            : TroposCoreLocalizedString("DifferentTemperatureFormat")

        return (
            description: String(format: format, adjective, timeOfDay, timeOfYesterday, precipitation),
            adjective: adjective
        )
    }
}
