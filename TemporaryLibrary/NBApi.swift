// =============================================================================
// NerobluCore
// Copyright (C) NeroBlu. All rights reserved.
// =============================================================================
import UIKit
import Alamofire
import SwiftyJSON

///
public typealias NBApiCompletionHandler = (NBApiResponse)->Void

///
public typealias NBApiMethod = Alamofire.Method

///
public typealias NBApiParameters = [String : AnyObject]

///
public typealias NBApiHeaders = [String : String]

///
public class NBApi
{
	public class func executeRequest<T: NBApiRequest>(request: T, completionHandler: NBApiCompletionHandler = {_ in})
	{
		let method     = request.method
		let urlString  = "\(request.baseURL)\(request.endpoint)"
		
		let parameters: NBApiParameters? = request.parameters.isEmpty ? nil : request.parameters
		let headers:    NBApiHeaders?    = request.headers   .isEmpty ? nil : request.headers
		
		let config = NSURLSessionConfiguration.defaultSessionConfiguration()
		if let rti = request.requestTimeoutInterval {
			config.timeoutIntervalForRequest = rti
		}
		
		let alamofireRequest = Alamofire.request(method, urlString,
			parameters: parameters,
			headers:    headers
		)
		
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
