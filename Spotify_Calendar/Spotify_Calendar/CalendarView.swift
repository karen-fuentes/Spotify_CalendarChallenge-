//
//  CalendarView.swift
//  Spotify_Calendar
//
//  Created by Karen Fuentes on 6/20/18.
//  Copyright © 2018 Karen Fuentes. All rights reserved.
//

import UIKit

class CalendarView: UIView, UICollectionViewDelegate, UICollectionViewDataSource,
                    UICollectionViewDelegateFlowLayout, MonthViewDelegate {
    
    var daysInAMonth = [31,28,31,30,31,30,31,31,30,31, 30, 31]
    var currentMonthIndex = 0
    var currentYear = 0
    var presentMonthIndex = 0
    var presentYear = 0
    var todaysDate = 0
    var firstWeekDayofMonth = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initializeViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func initializeViews() {
        
        currentMonthIndex = Calendar.current.component(.month, from: Date())
        currentYear = Calendar.current.component(.year, from: Date())
        todaysDate = Calendar.current.component(.day, from: Date())
        firstWeekDayofMonth = getFirstWeekDay()
        
        if currentMonthIndex == 2  && currentYear % 4 == 0 {
            daysInAMonth[currentMonthIndex - 1 ] = 29
        }
        
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
        
        firstWeekDayofMonth = getFirstWeekDay()
        collectionView.reloadData()

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return daysInAMonth[currentMonthIndex - 1] + firstWeekDayofMonth - 1
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! DateCollectionViewCell
        cell.backgroundColor = UIColor.clear
        if indexPath.item <= firstWeekDayofMonth - 2 {
            cell.isHidden = true
        } else {
            let calcDate = indexPath.row - firstWeekDayofMonth + 2
            cell.isHidden = false
            cell.label.text = "\(calcDate)"
        }
        cell.isUserInteractionEnabled = true
        cell.label.textColor = UIColor.white
        
        return cell

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor.red
        let lbl = cell?.subviews[1] as! UILabel
        lbl.textColor = UIColor.white 
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.width/7 - 8
        let height: CGFloat = 40
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 8.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 8.0 
    }
   
    
    func setUpViews() {
        
        addSubview(monthView)
        let _ = [monthView.topAnchor.constraint(equalTo: self.topAnchor),
                 monthView.leftAnchor.constraint(equalTo: self.leftAnchor),
                 monthView.rightAnchor.constraint(equalTo: rightAnchor),
                 monthView.heightAnchor.constraint(equalToConstant: 35)
                ].map({$0.isActive = true})
        monthView.delegate = self
        
        addSubview(weekdayView)
        let _ = [weekdayView.topAnchor.constraint(equalTo: monthView.bottomAnchor),
                 weekdayView.leftAnchor.constraint(equalTo: self.leftAnchor),
                 weekdayView.rightAnchor.constraint(equalTo: self.rightAnchor),
                 weekdayView.heightAnchor.constraint(equalToConstant: 30)
                ].map({$0.isActive = true})
        
        addSubview(collectionView)
        let _ = [collectionView.topAnchor.constraint(equalTo: weekdayView.bottomAnchor, constant: 0),
                 collectionView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
                 collectionView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0),
                 collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
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
       // collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.clear
        collectionView.allowsMultipleSelection = false
        
        return collectionView
    }()
}
