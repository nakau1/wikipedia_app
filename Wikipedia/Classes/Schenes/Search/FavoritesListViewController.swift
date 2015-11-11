// =============================================================================
// wikipedia app
// Copyright (C) 2015年 NeroBlu. All rights reserved.
// =============================================================================
import UIKit
import TemporaryLibrary

/// お気に入り一覧画面ビューコントローラ
class FavoritesListViewController: AppViewController
{
	@IBOutlet weak var tableView: UITableView!
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		
		self.tableViewAdapter = FavoritesListAdapter(self, tableView)
		self.tableViewAdapter!.reload()
	}
}

class FavoritesListAdapter : SearchListAdapter
{
	override func setupSections() -> [NBTableViewSection] {
		return [FavoritesListSection()]
	}
}

class FavoritesListSection : SearchListSection
{
	override var rowNumber : Int { get { return 50 } }
}
