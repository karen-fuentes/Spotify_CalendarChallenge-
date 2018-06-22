//
//  ViewController.swift
//  Spotify_Calendar
//
//  Created by Karen Fuentes on 6/19/18.
//  Copyright © 2018 Karen Fuentes. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "My Calendar"
        self.navigationController?.navigationBar.isTranslucent = false
        self.view.backgroundColor = Style.backgroundColor
        
        view.addSubview(calendarView)
        let _ = [calendarView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
                 calendarView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12),
                 calendarView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12),
                 calendarView.heightAnchor.constraint(equalToConstant: 365)
                ].map({$0.isActive = true})

    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        calendarView.collectionView.collectionViewLayout.invalidateLayout()
    }

    let calendarView:  CalendarView = {
       let calendarView = CalendarView()
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        return calendarView
    }()

}

