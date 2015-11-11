// =============================================================================
// wikipedia app
// Copyright (C) 2015年 NeroBlu. All rights reserved.
// =============================================================================
import UIKit
import TemporaryLibrary

/// メイン画面ビューコントローラ
class MainViewController: AppViewController, UITextFieldDelegate
{
	@IBOutlet private weak var webview: UIWebView!
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		
		webview.loadRequest(NSURLRequest(URL: NSURL(string: "https://translate.google.co.jp/")!))
	}
	
	@IBAction private func didTapMenu()
	{
		self.slideMenuController()?.openLeft()
	}
	
	@IBAction private func didTapSearchText()
	{
		
		self.presentViewController(SearchViewController(), animated: true) {
			
		}
	}
}
