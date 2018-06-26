//
//  EventAPIClient.swift
//  Spotify_Calendar
//
//  Created by Karen Fuentes on 6/26/18.
//  Copyright © 2018 Karen Fuentes. All rights reserved.
//

import Foundation

struct EventsAPIClient {
    private init() { }
    static let manager = EventsAPIClient()
    
    func createEvent(event: Event, completionHandler: @escaping (URLResponse) -> Void, errorHandler: @escaping (Error) -> Void) {
        let stringURL = "http://localhost:3033/events/"
        guard let url = URL(string: stringURL) else {
            errorHandler(AppError.badURL(str: stringURL))
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        
        let postString = "title=\(event.title)&description=\(event.description)&startTime=\(event.startTime)&endTime=\(event.endTime)&day=\(event.day)&month=\(event.month)&year=\(event.year)&startTimeStr=\(event.startTimeStr)&endTimeStr=\(event.endTimeStr)"
        urlRequest.httpBody = postString.data(using: .utf8)
        APIRequestManager.manager.performDataTask(with: urlRequest, completionResponse: { (response) in
            completionHandler(response)
        }, errorHandler: { print($0) })
        
    }
    
    func getAllEvents(completionHandler: @escaping ([Int:[Event]]) -> Void, errorHandler: @escaping (Error) -> Void) {
        let stringURL = "http://localhost:3033/events/"
        guard let url = URL(string: stringURL) else {
            errorHandler(AppError.badURL(str: stringURL))
            return
        }
        let urlRequest = URLRequest(url: url)
        var organizedEvents = [Int: [Event]]()
        let completion: (Data) -> Void = {(data: Data) in
            do {
                let events = try JSONDecoder().decode([Event].self, from: data)
                for event in events {
                    if let eventsSoFar = organizedEvents[event.day] {
                        var toAddNewEvent: [Event] = eventsSoFar
                        toAddNewEvent.append(event)
                        organizedEvents.updateValue(toAddNewEvent, forKey: event.day)
                    } else {
                        organizedEvents[event.day] = [event]
                    }
                }
                completionHandler(organizedEvents)
            }
            catch {
                errorHandler(AppError.couldNotParseJSON(rawError: error))
            }
        }
        APIRequestManager.manager.performDataTask(with: urlRequest, completionHandler: completion, errorHandler: errorHandler)
    }
    
    
    func getEventWith(id: String, completionHandler: @escaping (Event) -> Void, errorHandler: @escaping (Error) -> Void) {
        let stringURL = "http://localhost:3033/events/\(id)"
        guard let url = URL(string: stringURL) else {
            errorHandler(AppError.badURL(str: stringURL))
            return
        }
        let urlRequest = URLRequest(url: url)
        let completion: (Data) -> Void = {(data: Data) in
            do {
                let event = try JSONDecoder().decode(Event.self, from: data)
                completionHandler(event)
            }
            catch {
                errorHandler(AppError.couldNotParseJSON(rawError: error))
            }
        }
        APIRequestManager.manager.performDataTask(with: urlRequest, completionHandler: completion, errorHandler: errorHandler)
    }
    
    
    func deleteEvent(event: Event, completionHandler: @escaping (URLResponse) -> Void, errorHandler: @escaping (Error) -> Void) {
        print(event._id!)
        let stringURL = "http://localhost:3033/events/\(event._id!)"
        guard let url = URL(string: stringURL) else {
            errorHandler(AppError.badURL(str: stringURL))
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "DELETE"
        APIRequestManager.manager.performDataTask(with: urlRequest, completionResponse: { (response) in
            completionHandler(response)
        }, errorHandler: { print($0) })
        
    }
}
