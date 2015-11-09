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
	
	func test(a:Any)
	{
		D(a)
	}
}

class HistoriesListAdapter : NBTableViewAdapter
{
	override func setupSections() -> [NBTableViewSection] {
		return [HistoriesListSection()]
	}
}

class HistoriesListSection : NBTableViewSection
{
	override var rowNumber : Int { get { return 50 } }
	
	override func cellClass(row: Int) -> NSObject.Type {
		return HistoriesListCell.self
	}
	
	override func cellNibName(row: Int) -> String {
		return "HistoriesListCell"
	}
	
	override func didSelectRow(row: Int) {
		
		self.parentAdapter.parentViewController.navigationController?.pushViewController(HistoriesListViewController(), animated: true)
	}
}

class HistoriesListCell : NBTableViewCell
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
