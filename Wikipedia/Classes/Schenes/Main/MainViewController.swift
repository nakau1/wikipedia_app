// =============================================================================
// wikipedia app
// Copyright (C) 2015年 NeroBlu. All rights reserved.
// =============================================================================
import UIKit
import TemporaryLibrary

/// メイン画面ビューコントローラ
class MainViewController: AppViewController, UITextFieldDelegate
{
  @IBOutlet private weak var titleView: UIView!
  
	override func viewDidLoad()
	{
		super.viewDidLoad()
		self.navigationItem.titleView = self.titleView
	}
}
