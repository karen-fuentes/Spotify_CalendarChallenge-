//
//  CalendarView_Delegate.swift
//  Spotify_Calendar
//
//  Created by Karen Fuentes on 6/25/18.
//  Copyright © 2018 Karen Fuentes. All rights reserved.
//

import UIKit

//NOTE: Extension of CalendarViewController to declutter the class
//      contains flowlayout, collectionViewDelegate, collectionViewDataSource methods

extension CalendarViewController: UICollectionViewDelegate {
    
    // MARK: - Collection View Delegate Methods
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor.red
        let lbl = cell?.subviews[1] as! UILabel
        lbl.textColor = UIColor.white
        let eventsTBVC = DailyEventTableViewController()
        self.selectedDay = indexPath.row - firstWeekDayofMonth + 2
        
        eventsTBVC.day = self.selectedDay
        eventsTBVC.month = self.currentMonthIndex
        eventsTBVC.year = self.currentYear
        eventsTBVC.dateString = "\(monthView.monthArr[currentMonthIndex - 1] ) \(selectedDay), \(currentYear)"
        
        self.navigationController?.pushViewController(eventsTBVC, animated: true)
    }
}

extension CalendarViewController : UICollectionViewDataSource {
    
    // MARK: - Collection View Data Source Methods
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
}

extension CalendarViewController: UICollectionViewDelegateFlowLayout {
    
    // MARK: - CollectionView Flow layout
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
}
