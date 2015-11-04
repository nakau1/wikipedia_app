// =============================================================================
// NerobluCore
// Copyright (C) NeroBlu. All rights reserved.
// =============================================================================
import UIKit

/// タイマークラス
public class NBTimer : NSObject
{
	/// タイマー発火時のコールバックハンドラ
	public typealias NBTimerFiredHandler = ((Void)->Void)
	
	/// タイマーを開始する
	/// - parameters:
	///   - time: タイマー時間
	///   - firedHandler: タイマー発火時のコールバック
	public static func start(time: NSTimeInterval, firedHandler: NBTimerFiredHandler?)
	{
		let timer = NBTimer()
		NBTimer.timers.append(timer)
		
		timer.firedHandler = firedHandler
		timer.timer = NSTimer.scheduledTimerWithTimeInterval(time,
			target:   timer,
			selector: "didFireTimer",
			userInfo: nil,
			repeats:  false
		)
	}
	
	/// 自身をスタックする静的配列
	private static var timers: [NBTimer] = []
	
	/// コールバックハンドラ
	private var firedHandler: NBTimerFiredHandler?
	
	/// NSTimerオブジェクト
	private weak var timer: NSTimer?
	
	/// タイマー発火時
	internal func didFireTimer()
	{
		if let firedHandler = self.firedHandler {
			firedHandler()
		}
		self.timer = nil
		
		if let index = NBTimer.timers.indexOf(self) {
			NBTimer.timers.removeAtIndex(index.hashValue)
		}
	}
}
