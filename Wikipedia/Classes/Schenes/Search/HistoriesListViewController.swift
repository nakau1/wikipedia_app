// =============================================================================
// wikipedia app
// Copyright (C) 2015年 NeroBlu. All rights reserved.
// =============================================================================
import UIKit
import TemporaryLibrary

/// 検索履歴一覧画面ビューコントローラ
class HistoriesListViewController: AppViewController
{
	@IBOutlet weak var tableView: UITableView!
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		
		self.tableViewAdapter = HistoriesListAdapter(self, tableView)
		self.tableViewAdapter!.reload()
	}
}

class HistoriesListAdapter : SearchListAdapter
{
	override func setupSections() -> [NBTableViewSection] {
		return [HistoriesListSection()]
	}
}

class HistoriesListSection : SearchListSection
{
	override var rowNumber : Int { get { return 50 } }
}
