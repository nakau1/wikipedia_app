// =============================================================================
// wikipedia app
// Copyright (C) 2015年 NeroBlu. All rights reserved.
// =============================================================================
import UIKit
import TemporaryLibrary

class AppApi: NBApi {
	
}

///
class AppApiRequest : NBApiRequest
{
	override var baseURL: String { return "http://ja.wikipedia.org/w/api.php" }
	
	override var method: NBApiMethod { return .GET }
	
	override var parameters: NBApiParameters {
		var ret = super.parameters
		ret["format"] = "json"
		ret["action"] = "query"
		return ret
	}
}
