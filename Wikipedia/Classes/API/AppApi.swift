// =============================================================================
// wikipedia app
// Copyright (C) 2015年 NeroBlu. All rights reserved.
// =============================================================================
import UIKit
import Alamofire
import SwiftyJSON

///
class NBApi {
	
	class func executeRequest<T: NBApiRequest>(request: T, completionHandler: (NBApiResponse)->Void = {r in}) {
		let method = request.method
		let urlString = "\(request.baseURL)\(request.endpoint)"
		let parameters = request.parameters
		
		let alamofireRequest = Alamofire.request(method, urlString, parameters: parameters)
		alamofireRequest.responseJSON() { response in
			guard let result = response.result.value else {
				return
			}
			let json = JSON(result)
			
			print(response.request?.URLString)
			print(json.description)
		}
	}
}

typealias NBApiMethod = Alamofire.Method

class NBApiRequest {
	
	var baseURL: String { get { return "" }}
	
	var endpoint: String { get { return "" }}
	
	var method: NBApiMethod { get { return .POST }}
	
	var parameters: [String : AnyObject] { get { return [:] }}
}

class NBApiResponse {
	
}




class AppApi: NBApi {
	
}

///
class AppApiRequest : NBApiRequest
{
	override var baseURL: String { return "http://ja.wikipedia.org/w/api.php" }
	
	override var method: NBApiMethod { return .GET }
	
	override var parameters: [String : AnyObject] {
		var ret = super.parameters
		ret["format"] = "json"
		ret["action"] = "query"
		return ret
	}
}

extension AppApi
{
	class Article
	{
		class Info : AppApiRequest
		{
			var titles: String
			
			init(keyword titles: String)
			{
				self.titles = titles
			}
			
			override var parameters: [String : AnyObject] {
				var ret = super.parameters
				ret["prop"]   = "info"
				ret["titles"] = self.titles
				return ret
			}
		}
		
		class Content : AppApiRequest
		{
			var titles: String
			
			init(keyword titles: String)
			{
				self.titles = titles
			}
			
			override var parameters: [String : AnyObject] {
				var ret = super.parameters
				ret["prop"]    = "revisions"
				ret["rvprop"]  = "content"
				ret["rvparse"] = true
				ret["titles"]  = self.titles
				return ret
			}
		}
		
		class List : AppApiRequest
		{
			var srsearch:  String
			var srlimit:   Int
			var sroffset:  Int
			
			init(keyword srsearch: String, limit srlimit:Int = 30, offset sroffset: Int = 0)
			{
				self.srsearch = srsearch
				self.srlimit  = srlimit
				self.sroffset = sroffset
			}
			
			override var parameters: [String : AnyObject] {
				var ret = super.parameters
				ret["list"]     = "search"
				ret["srsearch"] = self.srsearch
				ret["srlimit"]  = self.srlimit
				ret["sroffset"] = self.sroffset
				
				ret["srprop"] = "redirecttitle"
				return ret
			}
		}
		
		class BackLinks : AppApiRequest
		{
			var bltitle:  String
			var bllimit:   Int
			
			init(keyword bltitle: String, limit bllimit:Int = 30)
			{
				self.bltitle = bltitle
				self.bllimit  = bllimit
			}
			
			override var parameters: [String : AnyObject] {
				var ret = super.parameters
				ret["list"]    = "backlinks"
				ret["bltitle"] = self.bltitle
				ret["bllimit"] = self.bllimit
				return ret
			}
		}
	}
}