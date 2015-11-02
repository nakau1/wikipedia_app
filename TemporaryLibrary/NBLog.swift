// =============================================================================
// NerobluCore
// Copyright (C) NeroBlu. All rights reserved.
// =============================================================================
import Foundation

// MARK: PUBLIC

public func NBLog(target: Any?, title: String? = nil, level: NBLogLevel = .Debug, functionName: String = __FUNCTION__, fileName: String = __FILE__, lineNumber: Int = __LINE__)
{
	let option = NBLogOption(
		title:        title,
		level:        level,
		functionName: functionName,
		fileName:     fileName,
		lineNumber:   lineNumber
	)
	
	NBLogger(target, option).execute()
}

public class NBLogConfig
{
	public static var level = NBLogLevel.Debug // .All
	
	public static var filterTitles: [String]? = nil
	
	public static var showTitle = true
	
	public static var showLogInformation = true
	
	public static var showLevel = true
	
	public static var showFunctionName = true
	
	public static var showFileName = true
	
	public static var showLineNumber = true
	
	public static var showThread = true
	
	public static var showDateTime = true
	
	public static var isShortFileName = true
	
	public static var dateTimeFormatter: NSDateFormatter {
		get {
			if let dtf = _dateTimeFormatter {
				return dtf
			}
			
			let dtf = NSDateFormatter()
			dtf.locale     = NSLocale.currentLocale()
			dtf.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
			
			_dateTimeFormatter = dtf
			return dtf
		}
	}
	private static var _dateTimeFormatter: NSDateFormatter?
}

public enum NBLogLevel
{
	case Debug
	case Information
	case Warning
	case Error
	case Fetal
	case Query
	case Request
	case Response
	case Event
	
	internal var shortName: String {
		get {
			switch self {
				case .Debug:       return "D"
				case .Information: return "I"
				case .Warning:     return "W"
				case .Error:       return "E"
				case .Fetal:       return "F"
				case .Query:       return "Q"
				case .Request:     return "q"
				case .Response:    return "r"
				case .Event:       return "e"
			}
		}
	}
}

// MARK: PRIVATE (Not-Accessable)

internal struct NBLogOption
{
	var title:        String?
	var level:        NBLogLevel
	var functionName: String
	var fileName:     String
	var lineNumber:   Int
}

internal class NBLogger
{
	let target: Any?
	let option: NBLogOption
	
	init(_ target: Any?, _ option: NBLogOption)
	{
		self.target = target
		self.option = option
	}
	
	internal func execute()
	{
		var logInformation = ""
		if NBLogConfig.showLogInformation {
			logInformation = self.logInformationsText()
			if !logInformation.isEmpty {
				logInformation = "[\(logInformation)] "
			}
		}
		
		print(logInformation)
	}
	
	private func logInformationsText()->String
	{
		let logInformationTextClosures: [()->String?] = [
			{ return self.dateTimeLogInformationText() },
			{ return self.logLevelLogInformationText() },
			{ return self.threadNameLogInformationText() },
			{ return self.fileNameLogInformationText() },
			{ return self.lineNumberLogInformationText() },
			{ return self.functionNameLogInformationText() },
		]
		
		var texts = [String]()
		for logInformationTextClosure in logInformationTextClosures {
			if let logInformationText = logInformationTextClosure() {
				texts.append(logInformationText)
			}
		}
		
		return (texts as NSArray).componentsJoinedByString(" ")
	}
	
	private func titleLogInformationText()->String?
	{
		if !NBLogConfig.showTitle { return nil }
		return self.option.title
	}
	
	private func dateTimeLogInformationText()->String?
	{
		if !NBLogConfig.showDateTime { return nil }
		return NBLogConfig.dateTimeFormatter.stringFromDate(NSDate())
	}
	
	private func logLevelLogInformationText()->String?
	{
		if !NBLogConfig.showLevel { return nil }
		return "\(self.option.level.shortName):"
	}
	
	private func fileNameLogInformationText()->String?
	{
		if !NBLogConfig.showFileName { return nil }
		
		if NBLogConfig.isShortFileName {
			return (self.option.fileName as NSString).lastPathComponent
		} else {
			return self.option.fileName			
		}
	}
	
	private func lineNumberLogInformationText()->String?
	{
		if !NBLogConfig.showLineNumber { return nil }
		return "line:\(self.option.lineNumber)"
	}
	
	private func functionNameLogInformationText()->String?
	{
		if !NBLogConfig.showFunctionName { return nil }
		return self.option.functionName
	}
	
	private func threadNameLogInformationText()->String?
	{
		if !NBLogConfig.showThread { return nil }
		
		var name = "main"
		if !NSThread.isMainThread() {
			if let threadName = NSThread.currentThread().name where threadName != "" {
				name = threadName
			} else {
				name = String(format: "%p", NSThread.currentThread())
			}
		}
		return "[\(name)]"
	}
}

