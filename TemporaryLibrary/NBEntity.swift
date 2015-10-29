// =============================================================================
// NerobluCore
// Copyright (C) NeroBlu. All rights reserved.
// =============================================================================
import UIKit
import SwiftyJSON

/// JSONからオブジェクトに変換可能であるインターフェイス
public protocol NBJsonDecodable
{
	init?(json: JSON)
}

/// エンティティクラス
public class NBEntity
{
	
}

/// JSONから変更可能なエンティティクラス
public class NBJsonDecodableEntity : NBEntity, NBJsonDecodable
{
	public required init?(json: JSON)
	{
		// NOP
	}
}
