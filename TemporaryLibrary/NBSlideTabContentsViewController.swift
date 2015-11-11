// =============================================================================
// NerobluCore
// Copyright (C) NeroBlu. All rights reserved.
// =============================================================================
import UIKit

/// スライドによるタブ移動ができるビューコントローラ
public class NBSlideTabContentsViewController : UINavigationController, UIPageViewControllerDelegate, UIPageViewControllerDataSource, UIScrollViewDelegate
{
	var pageScrollView: UIScrollView
	var pageController: UIPageViewController
	var navigationView: UIView
	var selectionBar:   UIView
	
	var navigationDelegate:   AnyObject?
	var panGestureRecognizer: UIPanGestureRecognizer?
	
	var currentPageIndex    = 0
//	var viewControllerArray = [UIViewController]()
	var buttonText          = [String]()
	
	let xBuffer: CGFloat = 0.0
	let xOffset: CGFloat = 8.0
	
	// MARK: イニシャライザ
	
	public required override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?)
	{
		self.pageScrollView = UIScrollView()
		self.pageController = UIPageViewController()
		self.navigationView = UIView()
		self.selectionBar   = UIView()
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
		self.viewControllers = [UIViewController]()
	}
	
	public required init?(coder aDecoder: NSCoder)
	{
		self.pageScrollView = UIScrollView()
		self.pageController = UIPageViewController()
		self.navigationView = UIView()
		self.selectionBar   = UIView()
		super.init(coder: aDecoder)
		self.viewControllers = [UIViewController]()
	}
	
	public required override init(rootViewController: UIViewController)
	{
		self.pageScrollView = UIScrollView()
		self.pageController = UIPageViewController()
		self.navigationView = UIView()
		self.selectionBar   = UIView()
		super.init(rootViewController: rootViewController)
		self.viewControllers = [UIViewController]()
	}
	
	// MARK: ライフサイクル
	
	public override func viewDidLoad()
	{
		super.viewDidLoad()
		self.navigationBar.barTintColor = UIColor(red: 0.01, green: 0.05, blue: 0.06, alpha: 1) //FIXME:カスタマイズ可能
		self.navigationBar.translucent = false
	}
	
	// MARK: UIScrollViewDelegate
	
	public func scrollViewDidScroll(scrollView: UIScrollView)
	{
		let xFromCenter: CGFloat = CGRectGetWidth(self.view.bounds) - pageScrollView.contentOffset.x
		let xCoor: CGFloat = xBuffer + (CGRectGetWidth(selectionBar.bounds) * CGFloat(self.currentPageIndex)) - xOffset
		
		var frame = selectionBar.frame
		frame.origin.x = xCoor - (xFromCenter / CGFloat(self.viewControllers.count))
		self.selectionBar.frame = frame
	}
	
	// MARK: UIPageViewControllerDelegate / UIPageViewControllerDataSource
	
	public func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController?
	{
		var index = self.indexOfViewController(viewController)
		if index == NSNotFound {
			return nil
		}
		index--
		if 0 <= index && index < self.viewControllers.count {
			return self.viewControllers[index]
		}
		return nil
	}
	
	public func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController?
	{
		var index = self.indexOfViewController(viewController)
		if index == NSNotFound {
			return nil
		}
		index++
		if 0 <= index && index < self.viewControllers.count {
			return self.viewControllers[index]
		}
		return nil
	}
	
	public func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool)
	{
		if !completed { return }
		guard let vc = self.pageController.viewControllers?.last else { return }
		
		self.updateCurrentPageIndex(self.indexOfViewController(vc))
	}
	
	// MARK: 汎用プライベート処理
	
	private func indexOfViewController(viewController: UIViewController) -> Int
	{
		var i = 0
		for vc in self.viewControllers {
			if vc == viewController {
				return i
			}
			i++
		}
		return NSNotFound
	}
	
	private func updateCurrentPageIndex(index: Int)
	{
		self.currentPageIndex = index
	}
}
