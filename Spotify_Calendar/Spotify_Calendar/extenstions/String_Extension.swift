//
//  String_Extension.swift
//  Spotify_Calendar
//
//  Created by Karen Fuentes on 6/20/18.
//  Copyright © 2018 Karen Fuentes. All rights reserved.
//

import Foundation
extension String {
    
    static var dateFormatter : DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    var date: Date? {
        return String.dateFormatter.date(from: self)
    }
}
