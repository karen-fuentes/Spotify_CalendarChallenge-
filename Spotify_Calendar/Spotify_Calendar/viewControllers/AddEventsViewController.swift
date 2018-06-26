//
//  AddEventsViewController.swift
//  Spotify_Calendar
//
//  Created by Karen Fuentes on 6/25/18.
//  Copyright © 2018 Karen Fuentes. All rights reserved.
//


import UIKit

protocol CreateEventViewControllerDelegate: class {
    func didCreateNewEvent()
}

class AddEventVC: UIViewController {
    
    let addEventView = AddEventView()
    var day: Int?
    var month: Int?
    var year: Int?

    weak var delegate: CreateEventViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        addEventView.submitBtn.addTarget(self, action: #selector(saveTask), for: .touchUpInside)
        addEventView.closeBtn.addTarget(self, action: #selector(closeAddEvent), for: .touchUpInside)
        
        self.day = 28
        self.month = 6
        self.year = 2018
    }
    
    @objc private func saveTask() {
        guard let day = day, let month = month, let year = year else {
            print("error here")
            return
        }

        let units: Set<Calendar.Component> = [.hour, .minute]
        let compsStart = Calendar.current.dateComponents(units, from: addEventView.startTime.date)
        let startTimeStr = "\(compsStart.hour!):\(compsStart.minute!)"
        let compsEnd = Calendar.current.dateComponents(units, from: addEventView.endTime.date)
        let endTimeStr = "\(compsEnd.hour!):\(compsEnd.minute!)"
        
        let eventToCreate = Event(_id: nil, title: addEventView.descriptionTxtField.text!, description: addEventView.descriptionTxtField.text!, startTime: addEventView.startTime.date.timeIntervalSince1970, endTime: addEventView.endTime.date.timeIntervalSince1970, day: day, month: month, year: year, startTimeStr: startTimeStr, endTimeStr: endTimeStr)
        EventsAPIClient.manager.createEvent(event: eventToCreate, completionHandler: { (response) in
            print((response as! HTTPURLResponse).statusCode)
            self.delegate?.didCreateNewEvent()
        }, errorHandler: { print($0) })
        self.dismiss(animated: true, completion: nil)    }
    
    @objc private func closeAddEvent() {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func setupViews() {
        view.addSubview(addEventView)
        addEventView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addEventView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            addEventView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            addEventView.leftAnchor.constraint(equalTo: view.leftAnchor),
            addEventView.rightAnchor.constraint(equalTo: view.rightAnchor)])
    }
}
