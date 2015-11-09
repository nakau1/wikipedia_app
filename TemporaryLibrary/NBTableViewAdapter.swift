// =============================================================================
// NerobluCore
// Copyright (C) NeroBlu. All rights reserved.
// =============================================================================
import UIKit

/// テーブルビューアダプタクラス
public class NBTableViewAdapter : NSObject, UITableViewDelegate, UITableViewDataSource
{
	/// 管理するテーブルビューの参照
	public weak var tableView: UITableView!
	
	/// 親となるビューコントローラの参照
	public weak var parentViewController: UIViewController!
	
	/// 管理するセクション
	public var sections = [NBTableViewSection]()
	
	/// イニシャライザ
	public init(_ parentViewController: UIViewController, _ tableView: UITableView)
	{
		super.init()
		tableView.estimatedRowHeight  = 44.0
		tableView.delegate            = self
		tableView.dataSource          = self
		tableView.sectionHeaderHeight = 0.0
		tableView.sectionFooterHeight = 0.0
		self.tableView = tableView
		
		self.parentViewController = parentViewController
		
		self.adapterDidLoad()
	}
	/// デイニシャライザ
	deinit
	{
		self.adapterWillUnload()
	}
	
	//MARK: PUBLIC
	
	/// 監視する通知とそのセレクタの設定を返却する
	/// - returns: 通知時に実行するセレクタ名と通知文字列をセットにした辞書
	public func observingNotifications() -> [String : String] { return [:] }
	
	/// アダプタが初期化されたタイミングで呼ばれる
	public func adapterDidLoad()
	{
		NSNotificationCenter.defaultCenter().observeNotifications(self.observingNotifications(), observer:self, start: true)
	}
	
	/// アダプタが破棄されるタイミングで呼ばれる
	public func adapterWillUnload()
	{
		NSNotificationCenter.defaultCenter().observeNotifications(self.observingNotifications(), observer:self, start: false)
	}
	
	/// テーブルの再描画を行う
	public func reload()
	{
		let sections = self.setupSections()
		self.setParentAdadterToSections(sections)
		self.registerCells(sections)
		
		self.sections = sections
		self.tableView.reloadData()
	}
	
	/// アダプタで使用するセクション定義を取得する
	/// - returns: NBTableViewSectionを継承したオブジェクトの配列
	public func setupSections()->[NBTableViewSection] { return [] }
	
	//MARK: TABLE-VIEW DELEGATE
	
	public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
	{
		let section = sections[indexPath.section]
		let identifier = section.cellIdentifier(indexPath.row)
		
		guard let cell = tableView.dequeueReusableCellWithIdentifier(identifier) else {
			return UITableViewCell()
		}
		
		if let nbcell = cell as? NBTableViewCell {
			nbcell.parentSection = section
			nbcell.indexPath     = indexPath
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
	
	public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
	{
		tableView.deselectRowAtIndexPath(indexPath, animated: true)
		
		let section = sections[indexPath.section]
		section.didSelectRow(indexPath.row)
	}
	
	//MARK: PRIVATE
	
	/// テーブルビューに対してセルの登録を行う
	private func registerCells(sections: [NBTableViewSection])
	{
		var registered = [String]()
		for section in sections {
			for var row = 0; row < section.rowNumber; row++ {
				let identifier = section.cellIdentifier(row)
				if !registered.contains(identifier) {
					let nibName = section.cellNibName(row)
					if let _ = NSBundle.mainBundle().pathForResource(nibName, ofType: "nib") {
						let nib = UINib(nibName: nibName, bundle: nil)
						self.tableView.registerNib(nib, forCellReuseIdentifier: identifier)
					} else {
						let cls = section.cellClass(row)
						self.tableView.registerClass(cls, forCellReuseIdentifier: identifier)
					}
					registered.append(identifier)
				}
			}
		}
	}
	
	/// 親アダプタが設定されていないセクションに対して自身の参照を代入する
	private func setParentAdadterToSections(sections: [NBTableViewSection])
	{
		for section in sections {
			if section.parentAdapter == nil {
				section.parentAdapter = self
			}
		}
	}
}

/// テーブルセクションクラス
public class NBTableViewSection : NSObject
{
	/// 親となるアダブタの参照
	public weak var parentAdapter: NBTableViewAdapter!
	
	/// セクションのタイトル
	public var sectionTitle: String? { get { return nil } }
	
	/// セクションの行数
	public var rowNumber: Int { get { return 0 } }
	
	/// 使用するセルのクラスを返却する
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
	public func cellClass(row: Int) -> NSObject.Type
	{
		return NBTableViewCell.self
	}
	
	/// 使用するセルのXIBファイル名
	///
	/// 継承先で必要に応じてオーバライドしてください
	/// セルクラスの名前とXIBファイル名が異なる場合に継承先で設定します
	/// 特に内部クラスを使う場合は必要になります
	///
	/// - parameters:
	///   - row: 行インデックス
	/// - returns: セルのXIBファイル名
	public func cellNibName(row: Int) -> String
	{
		return NBReflection(cellClass(row)).shortClassName()
	}
	
	/// 使用するセルの再利用用識別子(=クラス名)
	///
	/// 継承先で必要に応じてオーバライドしてください
	///
	/// - parameters:
	///   - row: 行インデックス
	/// - returns: テーブルセルのクラス
	public func cellIdentifier(row: Int) -> String
	{
		return NBReflection(cellClass(row)).fullClassName()
	}
	
	/// 再利用されたセルに対して値を渡すなどのセットアップ処理を行う
	///
	/// 継承先で必要に応じてオーバライドしてください
	///
	/// - parameters:
	///   - originalCell: 再利用されたセル
	///   - row: 行インデックス
	public func setupCell(originalCell: UITableViewCell, row: Int) {} // NOP.
	
	/// セルが選択された時に呼ばれる
	///
	/// 継承先で必要に応じてオーバライドしてください
	///
	/// - parameters:
	///   - row: 行インデックス
	public func didSelectRow(row: Int) {} // NOP.
}

/// テーブルセルクラス
public class NBTableViewCell : UITableViewCell
{
	/// 親となるセクションの参照
	public weak var parentSection: NBTableViewSection!
	
	/// インデックスパス
	public var indexPath: NSIndexPath?
	
	/// セルの選択可否を簡易的に設定または取得する
	public var selectable: Bool {
		get {
			return self.selectionStyle != .None
		}
		set(val) {
			self.selectionStyle = val ? .Default : .None
		}
	}
}

/// NBViewController拡張
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

