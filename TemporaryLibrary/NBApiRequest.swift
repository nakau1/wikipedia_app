// =============================================================================
// NerobluCore
// Copyright (C) NeroBlu. All rights reserved.
// =============================================================================
import UIKit

/// 
public class NBApiRequest
{
	/// ベースURL
	public var baseURL: String { get { return "" }}
	
	/// APIエンドポイント
	public var endpoint: String { get { return "" }}
	
	/// APIメソッド(HTTPメソッド)
	public var method: NBApiMethod { get { return .POST }}
	
	/// パラメータ
	public var parameters: NBApiParameters { get { return [:] }}
	
	/// HTTPヘッダ
	public var headers: NBApiHeaders { get { return [:] }}
	
	/// リクエストタイムアウト時間
	public var requestTimeoutInterval: NSTimeInterval? { get { return nil }}
	
	public init() {}
}
