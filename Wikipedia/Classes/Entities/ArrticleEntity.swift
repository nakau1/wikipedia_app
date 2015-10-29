// =============================================================================
// wikipedia app
// Copyright (C) 2015年 NeroBlu. All rights reserved.
// =============================================================================
import UIKit
import SwiftyJSON

/// 記事エンティティ
class ArrticleEntity: AppEntity
{
	required init?(json: JSON)
	{
		super.init(json: json)
	}
}
