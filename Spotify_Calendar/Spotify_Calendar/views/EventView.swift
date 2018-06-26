//
//  EventView.swift
//  Spotify_Calendar
//
//  Created by Karen Fuentes on 6/25/18.
//  Copyright © 2018 Karen Fuentes. All rights reserved.
//

import UIKit

class AddEventView: UIView {
    
    lazy var startTime: UIDatePicker = {
        let dp = UIDatePicker()
        dp.translatesAutoresizingMaskIntoConstraints = false
        dp.datePickerMode = UIDatePickerMode.time
        return dp
    }()
    
    lazy var endTime: UIDatePicker = {
        let dp = UIDatePicker()
        dp.translatesAutoresizingMaskIntoConstraints = false
        dp.datePickerMode = UIDatePickerMode.time
        return dp
    }()
    
    lazy var descriptionTxtField: UITextField = {
        let text = UITextField()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.placeholder = "Enter your task..."
        text.backgroundColor = UIColor.white
        return text
    }()
    
    lazy var submitBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = UIColor.blue
        btn.layer.cornerRadius = 10
        btn.clipsToBounds = true
        btn.setTitle("Submit", for: .normal)
        return btn
    }()
    
    lazy var closeBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = UIColor.red
        btn.setTitle("X", for: .normal)
        btn.layer.cornerRadius = 5
        btn.clipsToBounds = true
        return btn
    }()
    
    lazy var titleTxtField: UITextField = {
        let txt = UITextField()
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.placeholder = "Enter Title ..."
        return txt
    }()
    
    lazy var stackView: UIStackView = {
        let stView = UIStackView()
        stView.translatesAutoresizingMaskIntoConstraints = false
        stView.axis  = UILayoutConstraintAxis.vertical
        stView.distribution  = UIStackViewDistribution.equalSpacing
        stView.alignment = UIStackViewAlignment.center
        stView.spacing   = 0.0
        return stView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        self.layer.borderWidth = 2.0
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = 5
        self.backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor)])
        
        stackView.addArrangedSubview(titleTxtField)
        stackView.addArrangedSubview(descriptionTxtField)
        NSLayoutConstraint.activate([
            descriptionTxtField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            descriptionTxtField.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.15)])
        NSLayoutConstraint.activate([
            titleTxtField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            titleTxtField.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.15)])
        
        stackView.addArrangedSubview(startTime)
        stackView.addArrangedSubview(endTime)
        stackView.addArrangedSubview(submitBtn)
        stackView.addArrangedSubview(closeBtn)
        
        
        addSubview(closeBtn)
        NSLayoutConstraint.activate([
            closeBtn.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            closeBtn.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8)])
    }
        
}
