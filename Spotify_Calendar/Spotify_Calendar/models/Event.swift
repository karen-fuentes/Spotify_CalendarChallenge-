//
//  Event.swift
//  Spotify_Calendar
//
//  Created by Karen Fuentes on 6/26/18.
//  Copyright © 2018 Karen Fuentes. All rights reserved.
//

import Foundation

//Event is the container(object) that holds all the attributes(properties) that make
//makes up an event
struct Event: Codable {
    let _id: String?
    let title: String
    let description: String
    let startTime: Double
    let endTime: Double
    let day: Int
    let month: Int
    let year: Int
    let startTimeStr: String
    let endTimeStr: String
}
