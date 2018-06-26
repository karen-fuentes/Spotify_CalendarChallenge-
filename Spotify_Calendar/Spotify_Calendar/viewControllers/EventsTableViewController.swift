//
//  EventsTableViewController.swift
//  Spotify_Calendar
//
//  Created by Karen Fuentes on 6/25/18.
//  Copyright © 2018 Karen Fuentes. All rights reserved.
//

import UIKit

class EventsTableViewController: UITableViewController {
    
    var events = [Int: [Event]]() {
        didSet {
            self.tableView.reloadData()
        }
    }

    var day: Int?
    var month: Int?
    var year: Int? 

    override func viewDidLoad() {
        
        super.viewDidLoad()
        let addTaskBtn = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTask))
        
        navigationItem.rightBarButtonItem = addTaskBtn
        
        self.tableView.register(EventsTableViewCell.self, forCellReuseIdentifier: "event cell")
        
        loadEvents()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadEvents()
    }
    

    private func loadEvents() {
        EventsAPIClient.manager.getAllEvents(completionHandler: {
            self.events = $0
        }, errorHandler: { print($0) })
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let currentDay = day else {
            return "Day Events"
        }
        return "June \(currentDay), 2018"
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let currentSelectedDay = self.day else {
            return 0
        }
        return (events[currentSelectedDay] ?? []).count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let eventCell = tableView.dequeueReusableCell(withIdentifier: "event cell", for: indexPath) as! EventsTableViewCell
        eventCell.setupViews()
        guard let currentSelectedDay = self.day, let arrayEvents =  events[currentSelectedDay] else {
            return UITableViewCell()
        }
        let event = arrayEvents[indexPath.row]
        eventCell.label.text = event.title
        return eventCell
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        EventsAPIClient.manager.deleteEvent(event: events[day!]![indexPath.row], completionHandler: { (response) in
            self.loadEvents()
        }, errorHandler: { print($0) })
    }


    @objc private func addTask() {
        let addEventVC = AddEventVC()
        addEventVC.day = self.day
        addEventVC.month = self.month
        addEventVC.year = self.year
        navigationController?.present(addEventVC, animated: true, completion: nil)
    }
}
