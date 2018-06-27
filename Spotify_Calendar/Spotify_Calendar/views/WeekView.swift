//
//  WeekView.swift
//  Spotify_Calendar
//
//  Created by Karen Fuentes on 6/20/18.
//  Copyright © 2018 Karen Fuentes. All rights reserved.
//

import UIKit
//class that sets up what the week looks like in out calendar view controller
class WeekView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - set up views
    func setUpViews() {
        addSubview(stackView)
        let _ = [stackView.topAnchor.constraint(equalTo: self.topAnchor),
                 stackView.leftAnchor.constraint(equalTo: self.leftAnchor),
                 stackView.rightAnchor.constraint(equalTo: self.rightAnchor),
                 stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            ].map({$0.isActive = true})
        
        var daysArr = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
        
        for i in 0..<7 {
            let lbl = UILabel()
            lbl.text = daysArr[i]
            lbl.textAlignment = .center
            lbl.textColor = UIColor.white
            stackView.addArrangedSubview(lbl)
        }
    }
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
}
