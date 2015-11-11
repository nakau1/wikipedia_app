// =============================================================================
// wikipedia app
// Copyright (C) 2015年 NeroBlu. All rights reserved.
// =============================================================================
import UIKit
import TemporaryLibrary

/// 検索画面ビューコントローラ
class SearchViewController: AppViewController
{
	@IBOutlet private weak var txfSearch: UITextField!
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		self.modalTransitionStyle = .CrossDissolve
		
		let placeholderText = AppString.Search.PlaceholderText
		txfSearch.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: [NSForegroundColorAttributeName : AppColor.Placeholder])
	}
	
	@IBAction private func didTapClose()
	{
		self.dismissViewControllerAnimated(true) {
			
		}
	}
}
