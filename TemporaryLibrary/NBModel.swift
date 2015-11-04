// =============================================================================
// NerobluCore
// Copyright (C) NeroBlu. All rights reserved.
// =============================================================================
import UIKit

/// モデルの基底クラス
public class NBModel : NSObject
{
	private static var models = [String : NBModel]()
	
	public class func loadModel(name: String)->NBModel
	{
		if let val = models[name] {
			return val
		}
		
		let package = NBReflection(self).packageName() ?? ""
		let className = "\(package).\(name)"
		guard
			let cls = NSClassFromString(className) as? NSObject.Type,
			let ret = cls.init() as? NBModel
			else {
				// クラスが存在しない、またはモデルを継承していない場合は致命的エラー
				fatalError("model class of '\(className)' not exists.")
		}
		
		models[name] = ret
		return ret
	}
}
