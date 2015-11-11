// =============================================================================
// wikipedia app
// Copyright (C) 2015年 NeroBlu. All rights reserved.
// =============================================================================
import UIKit
import TemporaryLibrary

/// 検索履歴一覧画面ビューコントローラ
class SuggestListViewController: AppViewController
{
	@IBOutlet weak var tableView: UITableView!
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		
		self.tableViewAdapter = SuggestListAdapter(self, tableView)
		self.tableViewAdapter!.reload()
	}
}

class SuggestListAdapter : SearchListAdapter
{
	override func setupSections() -> [NBTableViewSection] {
		return [SuggestListSection()]
	}
}

class SuggestListSection : SearchListSection
{
	override var rowNumber : Int { get { return 50 } }
}
