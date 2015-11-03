// =============================================================================
// wikipedia app
// Copyright (C) 2015年 NeroBlu. All rights reserved.
// =============================================================================
import UIKit
import TemporaryLibrary

/// メイン画面ビューコントローラ
class MainViewController: AppViewController
{
	typealias H = (String)->Void
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		
		NBLogConfig.enabled = (DEBUG == 1)
		NBLogConfig.configureSimply()
		
		NBLog(self)
		NBLog(1)
		NBLog(true)
		NBLog("1")
		NBLog("")
		NBLog(NSURL(string: "http://www.www.ww"))
		NBLog(1.0 * 3.56)
		NBLog(Character("a"))
		NBLog(["1", "2"])
		NBLog([String]())
		NBLog([Int!]())
		NBLog(["1" : ""])
		NBLog([String:String]())
		NBLog(MainViewController.self)
		NBLog((o: "o", 21, pot: NSDate()))
    
		let h : H = {_ in }
		NBLog(h)
		NBLog(NBLogLevel.Error)
		NBLog(nil)
		
		
	}
}
