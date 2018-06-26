//
//  EventsTableViewCell.swift
//  Spotify_Calendar
//
//  Created by Karen Fuentes on 6/26/18.
//  Copyright © 2018 Karen Fuentes. All rights reserved.
//

import UIKit

class EventsTableViewCell: UITableViewCell {

    func setupViews() {
        self.backgroundColor = UIColor.clear
        layer.cornerRadius = 5
        layer.masksToBounds = true
        
        addSubview(label)
        let _ = [label.topAnchor.constraint(equalTo: self.topAnchor),
                 label.leftAnchor.constraint(equalTo: self.leftAnchor),
                 label.rightAnchor.constraint(equalTo: self.rightAnchor),
                 label.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            ].map({$0.isActive = true})
    }
    
   lazy var label : UILabel = {
        let lbl = UILabel()
        lbl.text = "00"
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textColor = UIColor.black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()

}
