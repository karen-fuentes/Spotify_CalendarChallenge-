//
//  CalendarView.swift
//  Spotify_Calendar
//
//  Created by Karen Fuentes on 6/20/18.
//  Copyright © 2018 Karen Fuentes. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController, MonthViewDelegate {
    
    var daysInAMonth = [31,28,31,30,31,30,31,31,30,31, 30, 31]
    var currentMonthIndex = 0
    var dateString = ""
    var currentYear = 0
    var presentMonthIndex = 0
    var selectedDay = 0
    var presentYear = 0
    var todaysDate = 0
    var firstWeekDayofMonth = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "My Calendar"
        self.navigationController?.navigationBar.isTranslucent = false
        self.view.backgroundColor = UIColor.darkGray
        self.dateString = "\(monthView.monthArr[currentMonthIndex]) \(selectedDay) \(currentYear)"
        initializeViews()
    }
    
    // MARK: - View initialization
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
    
    //logic to get the first day the month starts
    func getFirstWeekDay() -> Int {
        let day = ("\(currentYear)-\(currentMonthIndex) - 01".date?.firstDayOfTheMonth.weekday)!
        return day
    }
    
    
    //implementing delegate method to check for changing months
    func didChangeMonth(monthIndex: Int, year: Int) {
        currentMonthIndex = monthIndex + 1
        currentYear = year
        
        //leap year logic TODO:Refactor to make this more dynamic
        if (currentMonthIndex == 2)  && (currentYear % 4 == 0) {
            daysInAMonth[currentMonthIndex - 1 ] = 29
        }
        if (currentMonthIndex == 2)  && (currentYear % 4 != 0) {
            daysInAMonth[currentMonthIndex - 1 ] = 28
        }
        
        firstWeekDayofMonth = getFirstWeekDay()
        collectionView.reloadData()
    }
    
    // MARK: - Setting up
    //1. adding subviews to main view
    //2. then constraints
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
    
    // MARK: - Setting up view
    //set up different components of the calendar view controller -- lazy var to only instantiate them when needed
    
    lazy var weekdayView: WeekView = {
        let weekView = WeekView()
        weekView.translatesAutoresizingMaskIntoConstraints = false
        return weekView
    }()
    
    lazy var monthView: MonthView = {
        let monthView = MonthView()
        monthView.translatesAutoresizingMaskIntoConstraints = false
        return monthView
    }()
    
    lazy var collectionView: UICollectionView = {
        
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
