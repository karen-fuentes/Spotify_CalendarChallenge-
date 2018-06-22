//
//  DateCollectionViewCell.swift
//  Spotify_Calendar
//
//  Created by Karen Fuentes on 6/20/18.
//  Copyright © 2018 Karen Fuentes. All rights reserved.
//

import UIKit

class DateCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        layer.cornerRadius = 5
        layer.masksToBounds = true
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
        addSubview(label)
        let _ = [label.topAnchor.constraint(equalTo: self.topAnchor),
                 label.leftAnchor.constraint(equalTo: self.leftAnchor),
                 label.rightAnchor.constraint(equalTo: self.rightAnchor),
                 label.bottomAnchor.constraint(equalTo: self.bottomAnchor)
                ].map({$0.isActive = true})
    }
    
    let label : UILabel = {
        let lbl = UILabel()
        lbl.text = "00"
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textColor = UIColor.darkGray
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
}
