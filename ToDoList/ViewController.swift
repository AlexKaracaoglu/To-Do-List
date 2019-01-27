//
//  ViewController.swift
//  ToDoList
//
//  Created by Alex Karacaoglu on 1/25/19.
//  Copyright © 2019 Alex Karacaoglu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var toDoArray = ["A", "B", "C", "D"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditItem" {
            let destination = segue.destination as! DetailViewController
            let index = tableView.indexPathForSelectedRow!.row
            destination.toDoItem = toDoArray[index]
        }
        else {
            if let selectedPath = tableView.indexPathForSelectedRow {
                tableView.deselectRow(at: selectedPath, animated: false)
            }
        }
    }
    
    @IBAction func unwindFromDetailViewController(segue: UIStoryboardSegue) {
        let sourceViewController = segue.source as! DetailViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            if sourceViewController.toDoItem! == "" {
                toDoArray.remove(at: indexPath.row)
                tableView.reloadData()
            }
            else {
                toDoArray[indexPath.row] = sourceViewController.toDoItem!
                tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }
        else {
            let newIndexPath = IndexPath(row: toDoArray.count, section: 0)
            if sourceViewController.toDoItem != "" {
                toDoArray.append(sourceViewController.toDoItem!)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = toDoArray[indexPath.row]
        return cell
    }
    
}
