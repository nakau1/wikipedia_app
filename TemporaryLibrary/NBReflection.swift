// =============================================================================
// NerobluCore
// Copyright (C) NeroBlu. All rights reserved.
// =============================================================================
import UIKit

/// パッケージ名を抜いたクラス名を取得する
/// - parameters:
///   - target: 対象の値
/// - returns: パッケージ名を抜いたクラス名
public func getShortClassName(target: Any?)->String
{
	func name(cls: AnyClass?)->String {
		guard
			let cls = cls,
			let name = NSStringFromClass(cls).componentsSeparatedByString(".").last else {
				return "unkown"
		}
		return name
	}
	
	if let target = target {
		if let cls = target as? AnyClass {
			return name(cls)
		} else if let obj = target as? AnyObject {
			return name(obj.dynamicType)
		} else {
			return name(nil)
		}
	}
	else {
		return "nil"
	}
}

/// パッケージ名を含めたクラス名を取得する
/// - parameters:
///   - target: 対象の値
/// - returns: パッケージ名を含めたクラス名
public func getFullClassName(target: Any?)->String
{
	func name(cls: AnyClass?)->String {
		guard let cls = cls else {
			return "unkown"
		}
		return NSStringFromClass(cls)
	}
	
	if let target = target {
		if let cls = target as? AnyClass {
			return name(cls)
		} else if let obj = target as? AnyObject {
			return name(obj.dynamicType)
		} else {
			return name(nil)
		}
	}
	else {
		return "nil"
	}
}

/// パッケージ名を取得する
/// - parameters:
///   - target: 対象の値
/// - returns: パッケージ名
public func getPackageName(target: Any?)->String?
{
	let full  = getFullClassName(target)
	let short = getShortClassName(target)
	
	if full == short {
		return nil
	}
	guard let range = full.rangeOfString(".\(short)") else {
		return nil
	}
	return full.substringToIndex(range.startIndex)
}
