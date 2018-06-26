//
//  MonthView.swift
//  Spotify_Calendar
//
//  Created by Karen Fuentes on 6/19/18.
//  Copyright © 2018 Karen Fuentes. All rights reserved.
//

import UIKit

protocol MonthViewDelegate {
    func didChangeMonth(monthIndex: Int, year: Int)
}

class MonthView: UIView {
    
    var monthArr = ["January", "February", "March", "April", "May", "June",
                    "July", "August", "September", "October", "November", "December"]
    var currentMonthIndex = 0
    var currentYear = 0
    var delegate : MonthViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        
        currentMonthIndex = Calendar.current.component(.month, from: Date()) - 1
        currentYear = Calendar.current.component(.year, from: Date())
        
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func leftAndRightButtonAction(sender: UIButton) {
        if sender == rightButton {
            
            currentMonthIndex += 1
            
            if currentMonthIndex > 11 {
                currentMonthIndex = 0
                currentYear += 1
            }
        } else {
            currentMonthIndex -= 1
            
            if currentMonthIndex < 0 {
                currentMonthIndex = 11
                currentYear -= 1
            }
        }
        monthLabel.text = "\(monthArr[currentMonthIndex]) \(currentYear)"
        delegate?.didChangeMonth(monthIndex: currentMonthIndex, year: currentYear)
    }
    
    
    func setUpViews() {
        
        self.addSubview(monthLabel)
        let _ = [monthLabel.topAnchor.constraint(equalTo: self.topAnchor),
                 monthLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                 monthLabel.widthAnchor.constraint(equalToConstant: 150),
                 monthLabel.heightAnchor.constraint(equalTo: self.heightAnchor)
            ].map({$0.isActive = true})
        monthLabel.text = "\(monthArr[currentMonthIndex]) \(currentYear)"
        
        self.addSubview(rightButton)
        let _ = [rightButton.topAnchor.constraint(equalTo: self.topAnchor),
                 rightButton.rightAnchor.constraint(equalTo: self.rightAnchor),
                 rightButton.widthAnchor.constraint(equalToConstant: 50),
                 rightButton.heightAnchor.constraint(equalTo: self.heightAnchor)
            ].map({$0.isActive = true})
        
        self.addSubview(leftButton)
        let _ = [leftButton.topAnchor.constraint(equalTo: self.topAnchor),
                 leftButton.leftAnchor.constraint(equalTo: self.leftAnchor),
                 leftButton.widthAnchor.constraint(equalToConstant: 50),
                 leftButton.heightAnchor.constraint(equalTo: self.heightAnchor)
            ].map({$0.isActive = true})
    }
    
    let monthLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "PLACEHOLDERTEXT"
        lbl.textColor = UIColor.white
        lbl.textAlignment = .center
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let rightButton: UIButton = {
        let btn = UIButton()
        btn.setTitle(">", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(leftAndRightButtonAction(sender:)), for: .touchUpInside)
        return btn
    }()
    let leftButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("<", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(leftAndRightButtonAction(sender:)), for: .touchUpInside)
        return btn
    }()
    
}







