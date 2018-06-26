//
//  AddEventsViewController.swift
//  Spotify_Calendar
//
//  Created by Karen Fuentes on 6/25/18.
//  Copyright © 2018 Karen Fuentes. All rights reserved.
//


import UIKit

class AddEventVC: UIViewController {
    
    let addEventView = AddEventView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        addEventView.submitBtn.addTarget(self, action: #selector(saveTask), for: .touchUpInside)
        addEventView.closeBtn.addTarget(self, action: #selector(closeAddEvent), for: .touchUpInside)
    }
    
    @objc private func saveTask() {
        //let calendarVC = CalendarVC()
        guard let task = addEventView.descriptionTxtField.text else {return}
        let startTime = addEventView.startTime.date
        let endTime = addEventView.endTime.date
//        let eventTask = Event(id: nil, startTime: startTime, endTime: endTime, task: task)
//        EventAPIClient.manager.post(event: eventTask, errorHandler: {print($0)})
        self.dismiss(animated: true, completion: nil)
    }
    
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
