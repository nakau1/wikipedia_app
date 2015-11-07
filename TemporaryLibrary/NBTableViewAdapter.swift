// =============================================================================
// NerobluCore
// Copyright (C) NeroBlu. All rights reserved.
// =============================================================================
import UIKit

/// テーブルビューアダプタクラス
public class NBTableViewAdapter : NSObject, UITableViewDelegate, UITableViewDataSource
{
	private let tableView: UITableView
	
	public var sections: [NBTableViewSection] = []
	
	public init(_ tableView: UITableView, sections: [NBTableViewSection] = [])
	{
		self.tableView = tableView
		self.sections  = sections
		
		super.init()
		
		tableView.delegate   = self
		tableView.dataSource = self
	}
	
	public func reload()
	{
		
	}
	
	
	/*
	self.detail = detail
	
	// 使用するセクションを定義
	sections = []
	if let detail = detail {
		switch (mode) {
		case .Browse:  self.setupSectionsAsBrowse(detail)
		case .Confirm: self.setupSectionsAsConfirm(detail)
		}
	}
	
	// 使用するセルのXIBを登録
	registerNibs(sections)
	
	self.tableView.reloadData()
	*/
	
	
	
	
	
	
	public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
	{
		let section = sections[indexPath.section]
		let cellIdentifier = section.cellIdentifier(indexPath.row)
		
		guard let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) else {
			return UITableViewCell()
		}
		section.setupCell(cell, row: indexPath.row)
		
		return cell
	}
	
	public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
		return sections[section].rowNumber
	}
	
	public func numberOfSectionsInTableView(tableView: UITableView) -> Int
	{
		return sections.count
	}
}

/// テーブルセクションクラス
public class NBTableViewSection : NSObject
{
	/// セクションのタイトル
	public var sectionTitle: String? { get { return nil } }
	
	/// セクションの行数
	public var rowNumber: Int { get { return 0 } }
	
	/// 使用するセルのクラス
	/// 
	/// 例えば継承先で以下のように返します
	/// 
	///	overide func cellClass(row: Int)->NSObject.Type {
	///	  if row == 0 {
	///	    return FirstRowCell.self
	///	  } else {
	///	    return OtherRowCell.self
	///	  }
	///	}
	/// 
	/// - parameters:
	///   - row: 行インデックス
	/// - returns: テーブルセルのクラス
	public func cellClass(row: Int)->NSObject.Type
	{
		return NBTableViewCell.self
	}
	
	/// 使用するセルの再利用用識別子(=クラス名)
	/// - parameters:
	///   - row: 行インデックス
	/// - returns: テーブルセルのクラス
	public func cellIdentifier(row: Int)->String
	{
		return NBReflection(self.cellClass(row)).shortClassName()
	}
	
	/// 使用するセルの再利用用識別子(=クラス名)
	/// - parameters:
	///   - row: 行インデックス
	/// - returns: テーブルセルのクラス
	public func setupCell(originalCell: UITableViewCell, row: Int) {} // NOP.
	
	/// 使用するセルの再利用用識別子(=クラス名)
	/// - parameters:
	///   - row: 行インデックス
	/// - returns: テーブルセルのクラス
	public func didSelectRow(row: Int) {} // NOP.
}

/// テーブルセルクラス
public class NBTableViewCell : UITableViewCell
{

}

/// 
public extension NBViewController
{
	public var tableViewAdapter: NBTableViewAdapter? {
		get {
			return self.externalProperties["tableViewAdapter"] as? NBTableViewAdapter
		}
		set(val) {
			self.externalProperties["tableViewAdapter"] = val
		}
	}
}

