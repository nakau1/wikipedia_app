// =============================================================================
// wikipedia app
// Copyright (C) 2015年 NeroBlu. All rights reserved.
// =============================================================================
import UIKit
import TemporaryLibrary

/// メイン画面ビューコントローラ
class MainViewController: AppViewController, NBKeyboardDelegate
{
	var kb = NBKeyboard()
	
	@IBOutlet private weak var v : UIView!
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
	}
	
	override func viewWillAppear(animated: Bool)
	{
		super.viewWillAppear(animated)
		self.kb.delegate = self
		self.kb.start()
	}
	
	override func viewWillDisappear(animated: Bool)
	{
		super.viewWillDisappear(animated)
		self.kb.stop()
	}
	
	func keyboardChangeFrameAnimation(distance: CGFloat)
	{
		v.frame.origin.y += distance
	}
}

