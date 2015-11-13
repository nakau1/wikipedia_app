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
		case Bookmark = "btn_icon_bookmark"
		case Close    = "btn_icon_close"
		case Delete   = "btn_icon_delete"
		case History  = "btn_icon_history"
		case Info     = "btn_icon_info"
		case Menu     = "btn_icon_menu"
		case Next     = "btn_icon_next"
		case Prev     = "btn_icon_prev"
		case Reload   = "btn_icon_reload"
		case Safari   = "btn_icon_safari"
		case Setting  = "btn_icon_setting"
		case Suggest  = "btn_icon_suggest"
		case Trash    = "btn_icon_trash"
		case Twitter  = "btn_icon_twitter"
	}
	
	/// ON/OFFの切り替えがある画像素材
	enum Toggle : String
	{
		case Bookmark = "bookmarked"
		
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

