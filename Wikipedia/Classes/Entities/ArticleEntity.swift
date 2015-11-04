// =============================================================================
// wikipedia app
// Copyright (C) 2015年 NeroBlu. All rights reserved.
// =============================================================================
import UIKit
import SwiftyJSON

/// 記事エンティティ
class ArticleEntity: AppEntity
{
	var title:    String = ""
	var id:       String?
	var summary:  String = ""
	var contents: String = ""
}
