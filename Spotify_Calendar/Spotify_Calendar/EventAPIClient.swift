//
//  EventAPIClient.swift
//  Spotify_Calendar
//
//  Created by Karen Fuentes on 6/26/18.
//  Copyright © 2018 Karen Fuentes. All rights reserved.
//

import Foundation

enum HTTPVerb: String {
    case GET
    case POST
    case DELETE
}

struct EventAPIClient {
    private init() {}
    static let manager = EventAPIClient()
    func getEvents(completionHandler: @escaping ([Event]) -> Void,
                   errorHandler: @escaping (Error) -> Void) {
        let urlStr = "http://5b27c4b362e42b0014915702.mockapi.io/events"
        guard let authenticatedRequest = buildAuthRequest(from: urlStr, httpVerb: .GET) else { errorHandler(AppError.badURL); return }
        let parseDataIntoOrderArr = {(data: Data) in
            do {
                let onlineOrders = try JSONDecoder().decode([Event].self, from: data)
                completionHandler(onlineOrders)
            }
            catch let error {
                errorHandler(AppError.codingError(rawError: error))
            }
        }
        APIRequestManager.manager.performDataTask(with: authenticatedRequest, completionHandler: parseDataIntoOrderArr, errorHandler: errorHandler)
    }
    
    func post(event: Event, errorHandler: @escaping (Error) -> Void) {
        let urlStr = "http://5b27c4b362e42b0014915702.mockapi.io/events"
        guard var authPostRequest = buildAuthRequest(from: urlStr, httpVerb: .POST) else {errorHandler(AppError.badURL); return }
        do {
            let encodedOrder = try JSONEncoder().encode(event)
            authPostRequest.httpBody = encodedOrder
            APIRequestManager.manager.performDataTask(with: authPostRequest,
                                                  completionHandler: {_ in print("Made a post request")},
                                                  errorHandler: errorHandler)
        }
        catch {
            errorHandler(AppError.codingError(rawError: error))
        }
    }
    
    func delete(id: String, errorHandler: @escaping (Error) -> Void) {
        let urlStr = "http://5b27c4b362e42b0014915702.mockapi.io/events/\(id)"
        guard let authPostRequest = buildAuthRequest(from: urlStr, httpVerb: .DELETE) else {errorHandler(AppError.badURL); return }
        APIRequestManager.manager.performDataTask(with: authPostRequest,
                                              completionHandler: {_ in print("Made a delete request")},
                                              errorHandler: errorHandler)
    }
    
    private func buildAuthRequest(from urlStr: String, httpVerb: HTTPVerb) -> URLRequest? {
        guard let url = URL(string: urlStr) else { return nil }
        var request = URLRequest(url: url)
        if httpVerb == .POST {
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        if httpVerb == .DELETE {
            request.httpMethod = "DELETE"
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        return request
    }
}
