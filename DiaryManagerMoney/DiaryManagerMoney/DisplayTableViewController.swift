//
//  DisplayTableViewController.swift
//  DiaryManagerMoney
//
//  Created by Cuong on 4/28/19.
//  Copyright © 2019 Cuong. All rights reserved.
//

import UIKit

class DisplayTableViewController: UITableViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var items: [Item] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.tableView.rowHeight = UITableView.automaticDimension
        tableView.allowsMultipleSelectionDuringEditing = true
    }


    override func viewWillAppear(_ animated: Bool) {
        //super.viewWillAppear(animated)
        fetchData()
    }
    
    func fetchData() {
        do {
            items = try context.fetch(Item.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
            print("Couldn't Fetch Data")
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell

        
        let date = items.reversed()[indexPath.row].date
        let time = items.reversed()[indexPath.row].time
        
        cell.titleLabel.text = items[indexPath.row].title
        print(items[indexPath.row].title)
        if let date = date, let time = time {
            let timeStamp = "Add on \(date) at \(time)"
            cell.dateLabel.text = timeStamp
        }
        return cell
    }
    

    @IBAction func startEditting(_ sender: UIBarButtonItem) {
        isEditing = !isEditing
    }
    
    @IBAction func deleteRowsButton(_ sender: UIButton) {
        if let selectedRows = tableView.indexPathsForSelectedRows {
            // 1
            var itemsForDelete = [Item]()
            
            let indexPath = tableView.indexPathForSelectedRow
            
//            let item = self.items[indexPath!.row]
//
//            self.context.delete(item)
//            (UIApplication.shared.delegate as! AppDelegate).saveContext()
           
            
            
            for indexPath in selectedRows {
                itemsForDelete.append(items[indexPath.row])
            }
            
            // 2
            for item in itemsForDelete {
                if let index = items.index(of: item) {
                    items.remove(at: index)
                }
            }
            
            // 3
            
            tableView.beginUpdates()
            tableView.deleteRows(at: selectedRows, with: .automatic)
            tableView.endUpdates()
        } else {
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            items.removeAll()
        }
        tableView.reloadData()
        
    }
    
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let cellToDeSelect: UITableViewCell = tableView.cellForRow(at: indexPath)!
//        cellToDeSelect.contentView.backgroundColor = #colorLiteral(red: 0.7411764706, green: 0.7843137255, blue: 0.4980392157, alpha: 1)
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
    
    
//    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//        let delete = UITableViewRowAction(style: .default, title: "Delete") { (action, indexPath) in
//            // delete item at indexPath
//            let item = self.items[indexPath.row]
//            self.context.delete(item)
//            (UIApplication.shared.delegate as! AppDelegate).saveContext()
//
//
//            self.items.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//
//        }
//
//        return [delete]
//    }

}
