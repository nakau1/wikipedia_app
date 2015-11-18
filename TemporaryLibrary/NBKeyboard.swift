// =============================================================================
// NerobluCore
// Copyright (C) NeroBlu. All rights reserved.
// =============================================================================
import UIKit

// キーボードの挙動を制御する
public class NBKeyboard : NSObject, UITextFieldDelegate, UITextViewDelegate
{
	public weak var delegate: NBKeyboardDelegate? = nil
	
	private var inKeyboardAnimation = false
	
	public func start()
	{
		NSNotificationCenter.defaultCenter().observeNotifications(self.observingNotifications(), observer: self, start: true)
	}
	
	public func stop()
	{
		NSNotificationCenter.defaultCenter().observeNotifications(self.observingNotifications(), observer: self, start: false)
	}
	
	func willKeyboardChangeFrame(notify: NSNotification)
	{
		if self.inKeyboardAnimation { return }
		self.inKeyboardAnimation = true
		
		guard
			let userInfo   = notify.userInfo,
			let frameBegin = userInfo[UIKeyboardFrameBeginUserInfoKey]        as? NSValue,
			let frameEnd   = userInfo[UIKeyboardFrameEndUserInfoKey]          as? NSValue,
			let curve      = userInfo[UIKeyboardAnimationCurveUserInfoKey]    as? NSNumber,
			let duration   = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSTimeInterval
			else {
				return
		}
		
		let beginY   = frameBegin.CGRectValue().minY
		let endY     = frameEnd.CGRectValue().minY
		let options  = UIViewAnimationOptions(rawValue: UInt(curve))
		
		UIView.animateWithDuration(duration, delay: 0, options: options, 
			animations: {
				guard let delegate = self.delegate else { return }
				
				let distance = endY - beginY
				delegate.keyboardChangeFrameAnimation?(distance)
			},
			completion: {
				finished in
				self.inKeyboardAnimation = false
			}
		)
	}
	
	private func observingNotifications()->[String : String]
	{
		return [
			"willKeyboardChangeFrame:" : UIKeyboardWillChangeFrameNotification,
		]
	}
}

@objc public protocol NBKeyboardDelegate
{
	/// キーボードの移動アニメーションの設定を行う
	/// - parameters:
	///   - distance: キーボードが移動する距離
	optional func keyboardChangeFrameAnimation(distance: CGFloat)
}

/*
public protocol UITextFieldDelegate : NSObjectProtocol {
	

	optional public func textFieldShouldBeginEditing(textField: UITextField) -> Bool // return NO to disallow editing.
	optional public func textViewShouldBeginEditing(textView: UITextView) -> Bool


	optional public func textFieldDidBeginEditing(textField: UITextField) // became first responder
	optional public func textViewDidBeginEditing(textView: UITextView)


	optional public func textFieldShouldEndEditing(textField: UITextField) -> Bool
	optional public func textViewShouldEndEditing(textView: UITextView) -> Bool

	optional public func textFieldDidEndEditing(textField: UITextField)
	optional public func textViewDidEndEditing(textView: UITextView)

	optional public func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool
	optional public func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool

	optional public func textFieldShouldClear(textField: UITextField) -> Bool

	optional public func textFieldShouldReturn(textField: UITextField) -> Bool
}

public protocol UITextViewDelegate : NSObjectProtocol, UIScrollViewDelegate {
	
	

	optional public func textViewDidChange(textView: UITextView)
	

	optional public func textViewDidChangeSelection(textView: UITextView)
	

	optional public func textView(textView: UITextView, shouldInteractWithURL URL: NSURL, inRange characterRange: NSRange) -> Bool

	optional public func textView(textView: UITextView, shouldInteractWithTextAttachment textAttachment: NSTextAttachment, inRange characterRange: NSRange) -> Bool
}
*/

/*
/// キーボードのフレームが変更される時
func willKeyboardChangeFrame(notify: NSNotification) {
	// アニメーション中は他の同名通知を無視
	if inKeyboardAnimation { return }
	inKeyboardAnimation = true
	
	guard
		let userInfo = notify.userInfo,
		let frameBegin = userInfo[UIKeyboardFrameBeginUserInfoKey]        as? NSValue,
		let frameEnd   = userInfo[UIKeyboardFrameEndUserInfoKey]          as? NSValue,
		let curve      = userInfo[UIKeyboardAnimationCurveUserInfoKey]    as? NSNumber,
		let duration   = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSTimeInterval
		else {
			return
	}
	
	let beginY   = frameBegin.CGRectValue().minY
	let endY     = frameEnd.CGRectValue().minY
	let options  = UIViewAnimationOptions(rawValue: UInt(curve))
	
	UIView.animateWithDuration(duration, delay: 0, options: options,
		animations: {
			let diff = endY - beginY
			self.tableView.frame.origin.y += diff
		},
		completion: { finished in
			self.inKeyboardAnimation = false
	})
}

/// テーブル内からのイベント通知の監視を開始または終了する
/// - parameters:
///   - start: true=開始 / false=終了
func observeEventsOfContents(start: Bool) {
	let nc = NSNotificationCenter.defaultCenter()
	let eventsOfContents = [
		"willKeyboardChangeFrame:" : UIKeyboardWillChangeFrameNotification,
	]
	
	for (selector, name) in eventsOfContents {
		if start {
			nc.addObserver(self, selector: Selector(selector), name: name, object: nil)
		} else {
			nc.removeObserver(self, name: name, object: nil)
		}
	}
}
*/