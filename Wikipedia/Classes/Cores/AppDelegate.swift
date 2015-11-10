// =============================================================================
// wikipedia app
// Copyright (C) 2015年 NeroBlu. All rights reserved.
// =============================================================================
import UIKit
import TemporaryLibrary

/// アプリケーションデリゲート
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{
	var window: UIWindow?
	
	func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool
	{
//		NBSlideMenuOptions.leftViewWidth    = NB.SCREEN.WIDTH * 0.9
//		NBSlideMenuOptions.contentViewScale = 1.0
		
		let window = UIWindow(frame: UIScreen.mainScreen().bounds)
		window.rootViewController = NBSlideMenuViewController(mainViewController: MainViewController(), leftMenuViewController: MenuViewController())
		window.makeKeyAndVisible()
		
		self.window = window
		return true
	}
}
