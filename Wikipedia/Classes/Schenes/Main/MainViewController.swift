// =============================================================================
// wikipedia app
// Copyright (C) 2015年 NeroBlu. All rights reserved.
// =============================================================================
import UIKit
import TemporaryLibrary

/// メイン画面ビューコントローラ
class MainViewController: AppViewController
{
	override func viewDidLoad()
	{
		super.viewDidLoad()
		
		let d = "2015-11-12".toNSDate("yyyy-MM-dd")
		D(NSDate().compare(d!))
	}
}

