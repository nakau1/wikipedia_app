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
		
		
		
		for k in NSDate.date(month:9).datesForCalendarInMonth() {
			D("\(k.toString())(\(k.isUsualDay))")
		}
		
//		D(NSDate().dateAddedYear(-2)?.toString(NSDate.FormatHIS))
	}
}

