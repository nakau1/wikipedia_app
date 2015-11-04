// =============================================================================
// NerobluCore
// Copyright (C) NeroBlu. All rights reserved.
// =============================================================================
import UIKit

/// UIViewの拡張
public extension UIView
{
	/// XIBからビューインスタンスを生成する
	///
	/// 引数を省略した場合は、呼び出したクラス名からXIBファイル名を判定します
	///
	///	if let customView = CustmoView.loadFromNib() as? CustomView {
	///	  self.view.addSubview(customView)
	///	}
	///
	/// - parameters:
	///   - nibName: XIBファイル名
	///   - bundle: バンドル
	/// - returns: 新しいビュー
	public class func loadFromNib(nibName: String? = nil, bundle: NSBundle? = nil)->UIView?
	{
		var name = ""
		if let nibName = nibName {
			name = nibName
		} else {
			name = NBReflection(self).shortClassName()
		}
		
		let nib = UINib(nibName: name, bundle: bundle)
		return nib.instantiateWithOwner(nil, options: nil).first as? UIView
	}
	
	/// 最上部のビュー(自身が最上部ならば自身を返す)
	public var rootView : UIView {
		get {
			if let superview = self.superview {
				return superview.rootView
			}
			return self
		}
	}
}
