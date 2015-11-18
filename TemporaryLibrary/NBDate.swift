// =============================================================================
// NerobluCore
// Copyright (C) NeroBlu. All rights reserved.
// =============================================================================
import Foundation

public enum NSWeek : Int
{
	case Sunday
	case Monday
	case Tuesday
	case Wednesday
	case Thursday
	case Friday
	case Saturday
	
	public static let count = 7
}

/// NSDateの拡張
public extension NSDate
{	
	@nonobjc public static var localeIdentifier = "ja"
	
	@nonobjc public static let FormatDefault   = "\(NSDate.FormatYMD) \(NSDate.FormatHIS)"
	@nonobjc public static let FormatDefaultJp = "\(NSDate.FormatYMDJp)\(NSDate.FormatHISJp)"
	@nonobjc public static let FormatYMD       = "yyyy-MM-dd"
	@nonobjc public static let FormatHIS       = "HH:mm:ss"
	@nonobjc public static let FormatYMDJp     = "yyyy年MM月dd日"
	@nonobjc public static let FormatHISJp     = "HH時mm分ss秒"
	
	//MARK: コンポーネント値
	
	/// 年
	public var year: Int {
		get { return NSDate.calendar().components(.Year, fromDate: self).year }
	}
	
	/// 月
	public var month: Int {
		get { return NSDate.calendar().components(.Month, fromDate: self).month }
	}
	
	/// 日
	public var day: Int {
		get { return NSDate.calendar().components(.Day, fromDate: self).day }
	}
	
	/// 時
	public var hour: Int {
		get { return NSDate.calendar().components(.Hour, fromDate: self).hour }
	}
	
	/// 分
	public var minute: Int {
		get { return NSDate.calendar().components(.Minute, fromDate: self).minute }
	}
	
	/// 秒
	public var second: Int {
		get { return NSDate.calendar().components(.Second, fromDate: self).second }
	}
	
	/// 曜日インデックス
	public var weekIndex: Int {
		get { return NSDate.calendar().components(.Weekday, fromDate: self).weekday - 1 }
	}
	
	/// 月インデックス
	public var monthIndex: Int {
		get { return self.month - 1 }
	}
	
	/// 月の最終日
	public var lastDayOfMonth: Int {
		get { return NSDate.date(year: self.year, month: self.month + 1, day: 0).day }
	}
	
	/// 曜日
	public var week: NSWeek {
		get { return NSWeek(rawValue: self.weekIndex)! }
	}
	
	//MARK: 名称取得
	
	/// 曜日名を取得する
	/// 
	/// 引数"locale"を省略すると月曜日ならば"月"を返しますが
	/// 下記のように実装すると"Fri"という文字列が帰ります
	/// 
	///	NSDate().weekName(locale: NSLocale(localeIdentifier: "en"))
	/// 
	/// 引数"formatClosure"を省略すると月曜日ならば"月"を返しますが
	/// 下記のように実装すると"月曜日"という文字列が帰ります
	/// 
	///	NSDate().weekName() { fmt, i in
	///	  return fmt.weekdaySymbols[i]
	///	}
	/// 
	/// - parameters:
	///   - locale: ロケール
	///   - formatClosure: 曜日取得の処理
	/// - returns: 曜日文字列
	public func weekName(locale locale: NSLocale? = nil, formatClosure: ((NSDateFormatter, Int)->String)? = nil) -> String
	{
		let fmt = NSDateFormatter()
		fmt.locale = (locale == nil) ? NSDate.locale() : locale
		
		if let closure = formatClosure {
			return closure(fmt, self.weekIndex)
		} else {
			return fmt.shortWeekdaySymbols[self.weekIndex]
		}
	}
	
	/// 月名を取得する
	/// 
	/// 引数を省略すると11月ならば"11月"を返しますが
	/// 下記のように実装すると"November"という文字列が帰ります
	/// 
	/// NSDate().monthName(locale: NSLocale(localeIdentifier: "en")) { fmt, i in
	///	  return fmt.monthSymbols[i]
	///	}
	/// 
	/// - parameters:
	///   - locale: ロケール
	///   - formatClosure: 月取得の処理
	/// - returns: 月名文字列
	public func monthName(locale locale: NSLocale? = nil, formatClosure: ((NSDateFormatter, Int)->String)? = nil) -> String
	{
		let fmt = NSDateFormatter()
		fmt.locale = (locale == nil) ? NSLocale(localeIdentifier: "ja") : locale
		
		if let closure = formatClosure {
			return closure(fmt, self.monthIndex)
		} else {
			return fmt.shortMonthSymbols[self.monthIndex]
		}
	}
	
	//MARK: 比較
	
	/// 日付が今日かどうか
	public var isToday: Bool {
		get {
			return self.compareDate(NSDate())
		}
	}
	
	/// 日付が明日かどうか
	public var isTomorrow: Bool {
		get {
			return self.compareDate(NSDate(timeIntervalSinceNow: 24*60*60))
		}
	}
	
	/// 日付が一昨日かどうか
	public var isYesterday: Bool {
		get {
			return self.compareDate(NSDate(timeIntervalSinceNow: 24*60*60 * -1))
		}
	}
	
	/// 日付が日曜日かどうか
	public var isSunday: Bool {
		get {
			return self.week == .Sunday
		}
	}
	
	/// 日付が土曜日かどうか
	public var isSaturday: Bool {
		get {
			return self.week == .Saturday
		}
	}
	
	/// 日付が平日かどうか
	public var isUsualDay: Bool {
		get {
			return !self.isSunday && !self.isSaturday
		}
	}
	
	/// 日付を比較して同じ日付かどうかを取得する
	/// - parameters:
	///   - date: 比較対象の日付
	/// - returns: 同じ日付かどうか(時刻は比較しません)
	public func compareDate(target: NSDate) -> Bool
	{
		guard let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian) else {
			return false
		}
		let flags: NSCalendarUnit = [.Year, .Month, .Day]
		let comps1 = calendar.components(flags, fromDate: self)
		let comps2 = calendar.components(flags, fromDate: target)
		
		return ((comps1.year == comps2.year) && (comps1.month == comps2.month) && (comps1.day == comps2.day))
	}
	
	//MARK: インスタンス生成
	
	/// 各日付コンポーネントを指定して新しいインスタンスを取得する
	/// 
	/// 各値は省略またはnilを渡すことが可能、その場合は現在日時が適用される
	/// 
	/// - parameters:
	///   - year: 年
	///   - month: 月
	///   - day: 日
	///   - hour: 時
	///   - minute: 分
	///   - second: 秒
	/// - returns: 新しいNSDateインスタンス
	public class func date(year y:Int? = nil, month m:Int? = nil, day d:Int? = nil, hour h:Int? = nil, minute i:Int? = nil, second s:Int? = nil) -> NSDate
	{
		let now = NSDate()
		let comps = NSDateComponents()
		comps.year   = y ?? now.year
		comps.month  = m ?? now.month
		comps.day    = d ?? now.day
		comps.hour   = h ?? now.hour
		comps.minute = i ?? now.minute 
		comps.second = s ?? now.second
		return NSDate.calendar().dateFromComponents(comps)!
	}
	
	/// 時刻を0時に指定した新しいインスタンスを取得する
	/// - returns: 新しいNSDateインスタンス
	public func dateZeroTime() -> NSDate
	{
		return NSDate.date(year: self.year, month: self.month, day: self.day, hour: 0, minute: 0, second: 0)
	}
	
	/// 日付を1日に指定した新しいインスタンスを取得する
	/// - returns: 新しいNSDateインスタンス
	public func dateFirstDay() -> NSDate
	{
		return NSDate.date(year: self.year, month: self.month, day: 1, hour: 0, minute: 0, second: 0)
	}
	
	/// 指定した年数を足した新しいインスタンスを取得する
	/// - parameters:
	///   - add: 追加する年
	/// - returns: 新しいNSDateオブジェクト
	public func dateAddedYear(add: Int = 1) -> NSDate?
	{
		return self.dateByAddingComponents() { comp in comp.year = add }
	}
	
	/// 指定した月数を足した新しいインスタンスを取得する
	/// - parameters:
	///   - add: 追加する月
	/// - returns: 新しいNSDateオブジェクト
	public func dateAddedMonth(add: Int = 1) -> NSDate?
	{
		return self.dateByAddingComponents() { comp in comp.month = add }
	}
	
	/// 指定した日数を足した新しいインスタンスを取得する
	/// - parameters:
	///   - add: 追加する日
	/// - returns: 新しいNSDateオブジェクト
	public func dateAddedDay(add: Int = 1) -> NSDate?
	{
		return self.dateByAddingComponents() { comp in comp.day = add }
	}
	
	/// 指定した時数を足した新しいインスタンスを取得する
	/// - parameters:
	///   - add: 追加する時
	/// - returns: 新しいNSDateオブジェクト
	public func dateAddedHour(add: Int = 1) -> NSDate?
	{
		return self.dateByAddingComponents() { comp in comp.hour = add }
	}
	
	/// 指定した分数を足した新しいインスタンスを取得する
	/// - parameters:
	///   - add: 追加する分
	/// - returns: 新しいNSDateオブジェクト
	public func dateAddedMinute(add: Int = 1) -> NSDate?
	{
		return self.dateByAddingComponents() { comp in comp.minute = add }
	}
	
	/// 指定した秒数を足した新しいインスタンスを取得する
	/// - parameters:
	///   - add: 追加する秒
	/// - returns: 新しいNSDateオブジェクト
	public func dateAddedSecond(add: Int = 1) -> NSDate?
	{
		return self.dateByAddingComponents() { comp in comp.second = add }
	}
	
	//MARK: 配列取得
	
	/// 月の日付すべてを配列で取得
	/// - returns: NSDateオブジェクトの配列
	public func datesInMonth() -> [NSDate]
	{
		var ret = [NSDate]()
		
		let firstDate = self.dateFirstDay()
		let max = self.lastDayOfMonth
		
		for var i = 0; i < max; i++ {
			ret.append(firstDate.dateAddedDay(i)!)
		}
		return ret
	}
	
	/// 月の日付をカレンダー用にすべてを配列で取得
	/// - returns: NSDateオブジェクトの配列
	public func datesForCalendarInMonth() -> [NSDate]
	{
		var ret = [NSDate]()
		
		let firstDate = self.dateFirstDay()
		let max = self.lastDayOfMonth
		
		for var i = 0; i < max; i++ {
			let date = firstDate.dateAddedDay(i)!
			
			if i == 0 && 0 < date.weekIndex {
				for var j = 0; j < date.weekIndex; j++ {
					let n = (date.weekIndex - j) * -1
					ret.append(date.dateAddedDay(n)!)
				}
			}
			
			ret.append(date)
			
			if i == (max - 1) && (date.weekIndex + 1) < NSWeek.count {
				var n = 1
				for var j = (date.weekIndex + 1); j < NSWeek.count; j++ {
					ret.append(date.dateAddedDay(n++)!)
				}
			}
		}
		return ret
	}
	
	/// 日の1時間ごとにすべてを配列で取得
	/// - returns: NSDateオブジェクトの配列
	public func hoursInDay() -> [NSDate]
	{
		var ret = [NSDate]()
		
		let date = self.dateZeroTime()
		for var i = 0; i <= 23; i++ {
			ret.append(date.dateAddedHour(i)!)
		}
		return ret
	}
	
	//MARK: 文字列変換
	
	/// 指定したフォーマットを基に文字列に変換する
	/// 
	///	var str = NSDate().toString("yyyy年MM月dd日") 
	/// 
	/// - parameters:
	///   - format: 日付フォーマット
	/// - returns: 日付文字列
	public func toString(format: String = NSDate.FormatDefault) -> String
	{
		return NSDate.dateFormatter(format).stringFromDate(self)
	}
	
	//MARK: 汎用プライベート処理
	
	private class func calendar() -> NSCalendar
	{
		return NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
	}
	
	private class func dateFormatter(format: String) -> NSDateFormatter
	{
		let fmt = NSDateFormatter()
		fmt.dateFormat = format
		fmt.locale     = NSDate.locale()
		fmt.timeZone   = NSTimeZone.systemTimeZone()
		return fmt
	}
	
	private class func locale() -> NSLocale
	{
		return NSLocale(localeIdentifier: NSDate.localeIdentifier)
	}
	
	private func dateByAddingComponents(process: (NSDateComponents)->Void) -> NSDate?
	{
		let comp = NSDateComponents()
		process(comp)
		return NSDate.calendar().dateByAddingComponents(comp, toDate: self, options: NSCalendarOptions())
	}
}

/// 文字列の拡張
public extension String
{
	/// 文字列を指定したフォーマットを基にNSDateに変換する
	/// 
	///	var date = "2014-3-15".toDate("yyyy-MM-dd") 
	/// 
	/// - parameters:
	///   - format: 日付フォーマット
	/// - returns: NSDateオブジェクト(変換不可時はnil)
	public func toDate(format: String) -> NSDate?
	{
		return NSDate.dateFormatter(format).dateFromString(self)
	}
}
