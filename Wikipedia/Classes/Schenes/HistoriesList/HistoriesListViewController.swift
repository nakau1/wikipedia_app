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
		
		self.tableViewAdapter = NBTableViewAdapter(tableView, sections: [HistoriesListSection()])
	}
	
	class HistoriesListSection : NBTableViewSection
	{
		override var rowNumber : Int { get { return 10 } }
		
		override func cellClass(row: Int) -> NSObject.Type {
			return HistoriesListCell.self
		}
	}
	
	class HistoriesListCell : NBTableViewCell
	{
		
	}
}
