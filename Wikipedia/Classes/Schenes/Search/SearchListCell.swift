// =============================================================================
// wikipedia app
// Copyright (C) 2015年 NeroBlu. All rights reserved.
// =============================================================================
import UIKit
import TemporaryLibrary

/// 検索履歴一覧画面ビューコントローラ
class SearchListCell : NBTableViewCell
{
	override func awakeFromNib() {
		super.awakeFromNib()
		self.selectable = false
	}
	
	@IBAction private func didTapButton()
	{
		if let vc = self.parentSection.parentAdapter.parentViewController as? HistoriesListViewController {
			vc.test(self.indexPath)
		}
	}
	
	deinit {
		D("deinit \(self.indexPath)")
	}
}
