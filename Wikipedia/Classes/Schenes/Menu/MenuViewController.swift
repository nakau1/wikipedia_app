// =============================================================================
// wikipedia app
// Copyright (C) 2015年 NeroBlu. All rights reserved.
// =============================================================================
import UIKit

/// メニュー画面ビューコントローラ
class MenuViewController: AppViewController
{
	typealias ItemInfo = (icon:AppImage.ButtonIcon, title:String)
	
	enum Item : String {
		case Reload
		case Prev
		case Next
		case Safari
		case Setting
		case Clear
		case Bookmarks
		case AboutMe
		
		var info: ItemInfo {
			get {
				switch self {
				case Reload:    return (icon: .Reload,   title: "再読込をする")
				case Prev:      return (icon: .Prev,     title: "前の記事に戻る")
				case Next:      return (icon: .Next,     title: "次の記事に進む")
				case Safari:    return (icon: .Safari,   title: "現在の記事をSafariで開く")
				case Setting:   return (icon: .Setting,  title: "各種設定")
				case Clear:     return (icon: .Suggest,  title: "記事のクリア")
				case Bookmarks: return (icon: .Bookmark, title: "ブックマークの管理")
				case AboutMe:   return (icon: .Suggest,  title: "このアプリについて")
				}
			}
		}
		
		var selector: Selector {
			get {
				return Selector("didTap\(self.rawValue)")
			}
		}
	}
	
	@IBOutlet weak var scrollView: UIScrollView!
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		setupMenu()
	}
	
	
	// MARK: メニュー押下時
	
	// "再読込をする"押下時
	func didTapReload()
	{
		// TODO: 未実装
	}
	
	// "前の記事に戻る"押下時
	func didTapPrev()
	{
		// TODO: 未実装
	}
	
	// "次の記事に進む"押下時
	func didTapNext()
	{
		// TODO: 未実装
	}
	
	// "現在の記事をSafariで開く"押下時
	func didTapSafari()
	{
		// TODO: 未実装
	}
	
	// "各種設定"押下時
	func didTapSetting()
	{
		// TODO: 未実装
	}
	
	// "記事のクリア"押下時
	func didTapClear()
	{
		// TODO: 未実装
	}
	
	// "ブックマークの管理"押下時
	func didTapBookmarks()
	{
		// TODO: 未実装
	}
	
	// "このアプリについて"押下時
	func didTapAboutMe()
	{
		// TODO: 未実装
	}
	
	// MARK: メニュー項目設定
	
	private var orderedItems: [Item] {
		get {
			return [
				.Reload,
				.Prev,
				.Next,
				.Safari,
				.Setting,
				.Clear,
				.Bookmarks,
				.AboutMe,
			]
		}
	}
	
	private func setupMenu()
	{
		let contentView     = UIView(frame: CGRectZero)
		let menuWidth       = CGRectGetWidth(scrollView.bounds)
		let criteriaFrame   = CGRectMake(0, 0, menuWidth, 0)
		var offsetY:CGFloat = 0.0
		
		for item in self.orderedItems {
			let button = self.makeButton(criteriaFrame: criteriaFrame, offsetY: offsetY, item: item)
			contentView.addSubview(button)
			offsetY += CGRectGetHeight(button.bounds)
			
			let border = self.makeBorder(criteriaFrame: criteriaFrame, offsetY: offsetY)
			contentView.addSubview(border)
			offsetY += CGRectGetHeight(border.bounds)
		}
		
		contentView.frame = CGRectMake(0, 0, menuWidth, offsetY)
		
		scrollView.contentSize = contentView.bounds.size
		scrollView.addSubview(contentView)
	}
	
	private func makeButton(criteriaFrame f: CGRect, offsetY: CGFloat, item: Item) -> UIButton
	{
		var frame = f
		frame.size.height = 50.0
		frame.origin.y = offsetY
		
		let ret = UIButton(type: .Custom)
		ret.frame = (frame: frame)
		
		// タイトル文字
		ret.setTitle(item.info.title, forState: .Normal)
		ret.setTitleColor(AppColor.Keynote, forState: .Normal)
		ret.setTitleColor(AppColor.KeynoteDark, forState: .Highlighted)
		ret.titleLabel?.font = UIFont.systemFontOfSize(14.0)
		ret.titleEdgeInsets = UIEdgeInsetsMake(4.0, 20.0, 0.0, 0.0)
		
		// アイコン画像
		ret.setImage(UIImage(buttonIcon: item.info.icon), forState: .Normal)
		ret.imageEdgeInsets = UIEdgeInsetsMake(6.0, 10.0, 6.0, 0.0)
		
		// コンテンツの揃え
		ret.contentHorizontalAlignment = .Left
		
		// タップイベント付与
		ret.addTarget(self, action: item.selector, forControlEvents: .TouchUpInside)
		
		return ret
	}
	
	private func makeBorder(criteriaFrame f: CGRect, offsetY: CGFloat) -> UIView
	{
		var frame = f
		frame.size.height = 1.0
		frame.origin.y = offsetY
		
		let ret = UIView(frame: frame)
		ret.backgroundColor = AppColor.KeynoteDark
		
		return ret
	}
}
