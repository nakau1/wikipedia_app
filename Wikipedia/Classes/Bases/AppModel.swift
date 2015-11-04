// =============================================================================
// wikipedia app
// Copyright (C) 2015年 NeroBlu. All rights reserved.
// =============================================================================
import UIKit
import TemporaryLibrary

enum AppModels : String
{
	case Article
}

/// アプリ内モデルの基底クラス
class AppModel: NBModel
{
	class func load(model: AppModels)->AppModel?
	{
		return super.loadModel("\(model.rawValue)Model") as? AppModel
	}
}
