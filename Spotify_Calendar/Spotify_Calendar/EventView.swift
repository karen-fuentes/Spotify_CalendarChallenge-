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
        btn.setTitle("Submit", for: .normal)
        return btn
    }()
    
    lazy var closeBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        //btn.setImage(#imageLiteral(resourceName: "icoClose_32x32"), for: .normal)
        return btn
    }()
    
    lazy var stackView: UIStackView = {
        let stView = UIStackView()
        stView.translatesAutoresizingMaskIntoConstraints = false
        stView.axis  = UILayoutConstraintAxis.vertical
        stView.distribution  = UIStackViewDistribution.fill
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
        self.backgroundColor = UIColor(displayP3Red: 0.0, green: 166/255, blue: 237/255, alpha: 1.0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor)])
        
        stackView.addArrangedSubview(descriptionTxtField)
        NSLayoutConstraint.activate([
            descriptionTxtField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            descriptionTxtField.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.15)])
        stackView.addArrangedSubview(startTime)
        stackView.addArrangedSubview(endTime)
        stackView.addArrangedSubview(submitBtn)
        
        addSubview(closeBtn)
        NSLayoutConstraint.activate([
            closeBtn.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            closeBtn.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8)])
    }
    
}
