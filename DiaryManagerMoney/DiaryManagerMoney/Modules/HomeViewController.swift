//
//  DisplayTableViewController.swift
//  DiaryManagerMoney
//
//  Created by Cuong on 4/28/19.
//  Copyright © 2019 Cuong. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    
    private lazy var tableView: UITableView = {
       let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.keyboardDismissMode = .onDrag
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = UIColor.clear
        
        tableView.registerCell(CustomTableViewCell.self)
        
        return tableView
    }()
    
    private lazy var animationViewController: LoadingAnimationViewController = {
        let vc = LoadingAnimationViewController()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        return vc
    }()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var items: [DiaryModel] = []
    
    override func loadView() {
        super.loadView()
        prepareForViewController()
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.tableView.rowHeight = UITableView.automaticDimension
        tableView.allowsMultipleSelectionDuringEditing = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchData()
    }
    
    private func prepareForViewController() {
        addBackGround()
        addTitle("Home")
        view.layout(tableView)
            .below(titleLabel, 16)
            .left()
            .bottomSafe()
            .right()
        
        setupAddButton()
    }
    
    func fetchData() {
        present(animationViewController, animated: true)
        do {
            items = try context.fetch(DiaryModel.fetchRequest())
            DispatchQueue.main.async {
                self.animationViewController.dismiss(animated: true)
                self.tableView.reloadData()
            }
        } catch {
            print("Couldn't Fetch Data")
        }
    }
    
    // MARK: - Actions
    override func addButtonTapped(_ sender: UIButton) {
        let vc = DiaryDetailViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(cellType: CustomTableViewCell.self, forIndexPath: indexPath)
        
        let data = items[indexPath.row]
        cell.fillData(title: data.title, money: data.money, date: data.date)
        
        return cell
    }
    
    // M
    @IBAction func startEditting(_ sender: UIBarButtonItem) {
        isEditing = !isEditing
    }
    
    @IBAction func deleteRowsButton(_ sender: UIButton) {
        if let selectedRows = tableView.indexPathsForSelectedRows {
            // 1
            var itemsForDelete = [DiaryModel]()
            
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
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let item = self.items[indexPath.row]
            self.context.delete(item)
            do {
                try context.save()
            } catch {
                
            }
            //            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            //            tableView.reloadData()
            fetchData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DiaryDetailViewController()
        vc.diaryModel = items[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
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
