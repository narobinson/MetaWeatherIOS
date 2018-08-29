//
//  NetworkService.swift
//  MetaWeather
//
//  Created by Admin on 8/27/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation

class NetworkService{
    
    static let shared = NetworkService()
    
    private init() {}
    
    private let decoder = JSONDecoder()
    
    private let url = "https://www.metaweather.com/api/location/"
    
    typealias weatherHandler = (Weather?, ServiceError?) -> Void
    
    func getWeather(locationId: String, completion: @escaping weatherHandler){
        
        let urlString = url + locationId
        
        guard let weatherUrl = URL(string: urlString) else {
            print("Bad URL")
            return
        }
        
        URLSession.shared.dataTask(with: weatherUrl){ data, response, error in
            
            var _error: ServiceError?
            
            if error != nil {
                _error = .serverError
                completion(nil, _error)
                return
            }
            
            guard let serverData = data else{
                _error = .noData
                completion(nil, _error)
                return
            }
            
            do{
                let weather = try self.decoder.decode(Weather.self, from: serverData)
                completion(weather, _error)
                
            } catch {
                _error = .serverError
                completion(nil, _error)
                print(error.localizedDescription)
            }
            }.resume()
        
    }
}
