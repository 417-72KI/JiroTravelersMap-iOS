import Foundation

let calendar: Calendar = {
    var cal = Calendar.current
    cal.timeZone = TimeZone(identifier: "Asia/Tokyo")!
    return cal
}()
