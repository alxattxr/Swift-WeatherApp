//
//  NetworkSessionManager.swift
//  WeatherApp
//
//  Created by Alexandre Attar on 2017-3-12.
//  Copyright © 2017 AADevelopment. All rights reserved.
//

import Foundation

class NetworkSessionManager {
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    func networkTask(with request: URLRequest, completionHandler completion: @escaping ([String: AnyObject]?, NetworkSessionError?) -> Void) -> URLSessionDataTask {
        let task = session.dataTask(with: request) { data, response, error in
            //convert to HTTP response
            if let data = data{
                guard let httpResponse = response as? HTTPURLResponse else {
                    completion(nil, .requestFail)
                    return
                }
                if httpResponse.statusCode == 200{
                    do{
                        let jSON = try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject]
                        completion(jSON, nil)
                    }catch{
                        completion(nil, .dataConversionFail)
                    }
                } else {
                    completion(nil, .responseUnsuccesful)
                }
            } else {
                completion (nil, .invalidData)
            }

        }
        return task
    }
    
}
