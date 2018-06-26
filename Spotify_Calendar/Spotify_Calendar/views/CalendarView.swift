//
//  CalendarView.swift
//  Spotify_Calendar
//
//  Created by Karen Fuentes on 6/20/18.
//  Copyright © 2018 Karen Fuentes. All rights reserved.
//

import UIKit

class CalendarView: UIViewController, MonthViewDelegate {
    
    var daysInAMonth = [31,28,31,30,31,30,31,31,30,31, 30, 31]
    var currentMonthIndex = 0
    var currentYear = 0
    var presentMonthIndex = 0
    var presentYear = 0
    var todaysDate = 0
    var firstWeekDayofMonth = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "My Calendar"
        self.navigationController?.navigationBar.isTranslucent = false
        self.view.backgroundColor = Style.backgroundColor
        
      initializeViews()
        
    }

    func initializeViews() {
        
        currentMonthIndex = Calendar.current.component(.month, from: Date())
        currentYear = Calendar.current.component(.year, from: Date())
        todaysDate = Calendar.current.component(.day, from: Date())
        firstWeekDayofMonth = getFirstWeekDay()

        presentMonthIndex = currentMonthIndex
        presentYear = currentYear
        
        setUpViews()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(DateCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        
    }
    
    func getFirstWeekDay() -> Int {
        let day = ("\(currentYear)-\(currentMonthIndex) - 01".date?.firstDayOfTheMonth.weekday)!
        return day
    }
    
    
    
    func didChangeMonth(monthIndex: Int, year: Int) {
        currentMonthIndex = monthIndex + 1
        currentYear = year
        
        if (currentMonthIndex == 2)  && (currentYear % 4 == 0) {
            daysInAMonth[currentMonthIndex - 1 ] = 29
        }
        
        if (currentMonthIndex == 2)  && (currentYear % 4 != 0) {
            daysInAMonth[currentMonthIndex - 1 ] = 28
        }
       
        
        firstWeekDayofMonth = getFirstWeekDay()
        collectionView.reloadData()
        
    }

    func setUpViews() {
        
        view.addSubview(monthView)
        let _ = [monthView.topAnchor.constraint(equalTo: self.view.topAnchor),
                 monthView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
                 monthView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
                 monthView.heightAnchor.constraint(equalToConstant: 35)
            ].map({$0.isActive = true})
        monthView.delegate = self
        
        view.addSubview(weekdayView)
        let _ = [weekdayView.topAnchor.constraint(equalTo: monthView.bottomAnchor),
                 weekdayView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
                 weekdayView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
                 weekdayView.heightAnchor.constraint(equalToConstant: 30)
            ].map({$0.isActive = true})
        
        view.addSubview(collectionView)
        let _ = [collectionView.topAnchor.constraint(equalTo: weekdayView.bottomAnchor, constant: 0),
                 collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0),
                 collectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0),
                 collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
            ].map({$0.isActive = true})
        
        
    }
    
    let weekdayView: WeekView = {
        let weekView = WeekView()
        weekView.translatesAutoresizingMaskIntoConstraints = false
        return weekView
    }()
    
    let monthView: MonthView = {
        let monthView = MonthView()
        monthView.translatesAutoresizingMaskIntoConstraints = false
        return monthView
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.clear
        collectionView.allowsMultipleSelection = false
        
        return collectionView
    }()
}
