// =============================================================================
// wikipedia app
// Copyright (C) 2015年 NeroBlu. All rights reserved.
// =============================================================================
import UIKit

/// アプリ内で使用する画像素材の定義
class AppImage
{
	enum ButtonIcon : String
	{
		case Menu = "menu"
	}
	
	/// ON/OFFの切り替えがある画像素材
	enum Toggle : String
	{
		case Checkbox = "checkbox"
		case Favorite = "favorite"
		
		/// ON/OFFの画像素材名を取得する
		/// - parameter on: 画像のON/OFF
		/// - returns: 画像素材名
		func imageName(on: Bool)->String
		{
			return "\( rawValue )_\( on ? "on" : "off" )"
		}
	}
}

/// 画像素材を使用するためのUIImage拡張
extension UIImage
{
	/// コンビニエンスコンストラクタ
	/// - parameter buttonIcon: 定義された素材
	convenience init(buttonIcon e: AppImage.ButtonIcon) {
		self.init(named: e.rawValue)!
	}
	
	/// コンビニエンスコンストラクタ
	/// - parameter toggle: 定義された素材
	/// - parameter on: 画像のON/OFF
	convenience init(toggle e: AppImage.Toggle, on: Bool) {
		self.init(named: e.imageName(on))!
	}
}

