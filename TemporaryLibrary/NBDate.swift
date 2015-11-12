// =============================================================================
// NerobluCore
// Copyright (C) NeroBlu. All rights reserved.
// =============================================================================
import Foundation

/// NSDateの拡張
public extension NSDate
{
	//MARK: コンポーネント値
	
	/// 年
	public var year: Int {
		get { return self.componentValue(.Year) { c in return c.year } ?? 0 } 
	}
	
	/// 月
	public var month: Int {
		get { return self.componentValue(.Month) { c in return c.month } ?? 0 } 
	}
	
	/// 日
	public var day: Int {
		get { return self.componentValue(.Day) { c in return c.day } ?? 0 } 
	}
	
	/// 時
	public var hour: Int {
		get { return self.componentValue(.Hour) { c in return c.hour } ?? NSNotFound } 
	}
	
	/// 分
	public var minute: Int {
		get { return self.componentValue(.Minute) { c in return c.minute } ?? NSNotFound } 
	}
	
	/// 秒
	public var second: Int {
		get { return self.componentValue(.Second) { c in return c.second } ?? NSNotFound } 
	}
	
	/// 曜日インデックス
	public var weekIndex: Int {
		get { return self.componentValue(.Weekday) { c in return c.weekday - 1 } ?? NSNotFound } 
	}
	
	private func componentValue(unit: NSCalendarUnit, closure: ((NSDateComponents)->Int)) -> Int?
	{
		guard let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian) else {
			return nil
		}
		let comps = calendar.components(unit, fromDate: self)
		return closure(comps)
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
		fmt.locale = (locale == nil) ? NSLocale(localeIdentifier: "ja") : locale
		
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
			return closure(fmt, self.month - 1)
		} else {
			return fmt.shortMonthSymbols[self.month - 1]
		}
	}
	
	//MARK: 比較
	
	public var isToday: Bool {
		get {
			return false
		}
	}
	
	
	
	/*
	/// 渡した日付が本日の日付かどうかを取得する
	/// - parameters:
	///   - date: 対象の日付
	/// - returns: 本日の日付かどうか(時刻は比較しません)
	class func isToday(date: NSDate?)->Bool {
		return compareDate(date, comparingDate: NSDate())
	}
	
	/// 渡した日付が明日の日付かどうかを取得する
	/// - parameters:
	///   - date: 対象の日付
	/// - returns: 明日の日付かどうか(時刻は比較しません)
	class func isTomorrow(date: NSDate?)->Bool {
		return compareDate(date, comparingDate: NSDate(timeIntervalSinceNow: 24*60*60))
	}
	
	/// 日付を比較して同じ日付かどうかを取得する
	/// - parameters:
	///   - date: 対象の日付
	///   - comparingDate: 比較する日付
	/// - returns: 同じ日付かどうか(時刻は比較しません)
	class func compareDate(date: NSDate?, comparingDate: NSDate)->Bool {
		guard
			let date = date,
			let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
			else {
				return false
		}
		
		let flags: NSCalendarUnit = [.Era, .Year, .Month, .Day]
		let comps1 = calendar.components(flags, fromDate: date)
		let comps2 = calendar.components(flags, fromDate: comparingDate)
		
		return ((comps1.era == comps2.era) && (comps1.year == comps2.year) && (comps1.month == comps2.month) && (comps1.day == comps2.day))
	}
	*/
	
	//MARK: 文字列変換
	
	/// 指定したフォーマットを基に文字列に変換する
	/// 
	///	var str = NSDate().toString("yyyy年MM月dd日") 
	/// 
	/// - parameters:
	///   - format: 日付フォーマット
	/// - returns: 日付文字列
	public func toString(format: String) -> String
	{
		let fmt = NSDateFormatter()
		fmt.dateFormat = format
		fmt.locale     = NSLocale(localeIdentifier: "en_US_POSIX")
		fmt.timeZone   = NSTimeZone(forSecondsFromGMT: 0)
		return fmt.stringFromDate(self)
	}
}

/// 文字列の拡張
public extension String
{
	/// 文字列を指定したフォーマットを基にNSDateに変換する
	/// 
	///	var date = "2014-3-15".toNSDate("yyyy-MM-dd") 
	/// 
	/// - parameters:
	///   - format: 日付フォーマット
	/// - returns: NSDateオブジェクト(変換不可時はnil)
	public func toNSDate(format: String) -> NSDate?
	{
		let fmt = NSDateFormatter()
		fmt.dateFormat = format
		fmt.locale     = NSLocale(localeIdentifier: "en_US_POSIX")
		fmt.timeZone   = NSTimeZone(forSecondsFromGMT: 0)
		return fmt.dateFromString(self)
	}
}
