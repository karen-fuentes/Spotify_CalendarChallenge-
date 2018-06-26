//
//  APIRequestManager.swift
//  Spotify_Calendar
//
//  Created by Karen Fuentes on 6/26/18.
//  Copyright © 2018 Karen Fuentes. All rights reserved.
//
import Foundation

enum AppError: Error {
    case noData
    case noResponse
    case couldNotParseJSON(rawError: Error)
    case badURL(str: String)
    case urlError(rawError: URLError)
    case otherError(rawError: Error)
}

class APIRequestManager {
    private init() {}
    
    static let manager = APIRequestManager()
    private let urlSession = URLSession(configuration: URLSessionConfiguration.default)
    
    func performDataTask(with request: URLRequest, completionHandler: @escaping (Data) -> Void, errorHandler: @escaping (Error) -> Void) {
        self.urlSession.dataTask(with: request){(data: Data?, response: URLResponse?, error: Error?) in
            DispatchQueue.main.async {
                guard let data = data else {
                    errorHandler(AppError.noData)
                    return
                }
                if let error = error {
                    errorHandler(error)
                }
                completionHandler(data)
            }
            }.resume()
    }
    
    
    func performDataTask(with request: URLRequest, completionResponse: @escaping (URLResponse) -> Void, errorHandler: @escaping (Error) -> Void) {
        self.urlSession.dataTask(with: request){(data: Data?, response: URLResponse?, error: Error?) in
            DispatchQueue.main.async {
                guard let response = response else {
                    errorHandler(AppError.noResponse)
                    return
                }
                if let error = error {
                    errorHandler(error)
                }
                completionResponse(response)
            }
            }.resume()
    }
    
}

