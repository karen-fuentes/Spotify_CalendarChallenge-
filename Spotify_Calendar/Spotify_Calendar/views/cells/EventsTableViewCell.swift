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
        
        setupStack()
    }
    
    func setupStack() {
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor)])
        
        stackView.addArrangedSubview(titlelabel)
        NSLayoutConstraint.activate([
            titlelabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            titlelabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.15)])

        stackView.addArrangedSubview(descriptionlabel)
        NSLayoutConstraint.activate([
            descriptionlabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            descriptionlabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.15)])
        
        stackView.addArrangedSubview(startTimeLabel)
        NSLayoutConstraint.activate([
            startTimeLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            startTimeLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.15)])
        
        stackView.addArrangedSubview(endTimelabel)
        NSLayoutConstraint.activate([
            endTimelabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            endTimelabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.15)])

    }
    
   lazy var titlelabel : UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textColor = UIColor.black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    lazy var descriptionlabel : UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textColor = UIColor.black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    lazy var startTimeLabel : UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textColor = UIColor.black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    lazy var endTimelabel : UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textColor = UIColor.black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var stackView: UIStackView = {
        let stView = UIStackView()
        stView.translatesAutoresizingMaskIntoConstraints = false
        stView.axis  = UILayoutConstraintAxis.vertical
        stView.distribution  = UIStackViewDistribution.fillEqually
        stView.alignment = UIStackViewAlignment.center
        stView.spacing = 2.0
        return stView
    }()
}
