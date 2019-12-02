//
//  FavoriteTableViewController.swift
//  Gasungbi
//
//  Created by 강선미 on 20/11/2019.
//  Copyright © 2019 Sunmi Kang. All rights reserved.
//

import UIKit
import CoreData

class FavoriteTableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var fetchedFavoriteItem:NSFetchedResultsController<FavoriteItem>!
    
    var favoriteItem: FavoriteItem!
    var favoriteArray  = [FavoriteItem]()
    fileprivate func setFetchedFavoriteController() {
        fetchedFavoriteItem = FavoriteItemCoreData.shared.setFetchedResultsController(fromContext: DataController.shared.viewContext)
        fetchedFavoriteItem.delegate = self
        
        // use the results to populate the notes array
        do {
            try fetchedFavoriteItem.performFetch()
        } catch {
            fatalError("The fetch could not be performed: \(error.localizedDescription)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        // load data
        setFetchedFavoriteController()
        getFavoriteItemArray()
        registerTableViewCell()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setFetchedFavoriteController()
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: false)
            tableView.reloadRows(at: [indexPath], with: .fade)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        fetchedFavoriteItem = nil
    }
    // register TableViewCell
    func registerTableViewCell() {
        self.tableView.register(UINib(nibName: "EmptyTableViewCell", bundle: nil), forCellReuseIdentifier: "EmptyTableViewCell")
        self.tableView.register(UINib(nibName: "FavoriteTableViewCell", bundle: nil), forCellReuseIdentifier: "FavoriteTableViewCell")
    }
    
// MARK: - delete items
    @IBAction func deleteItems(_ sender: Any) {

    }
    
    
    func getFavoriteItemArray() {
    
     

      do {
            var fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteItem")
            favoriteArray = try DataController.shared.viewContext.fetch(fetchRequest) as! [FavoriteItem]

            var i = 0

            self.tableView.reloadData()

         } catch let error as NSError {
            print("Could not fetch \(error)")
        }

    }
    /// Deletes the notebook at the specified index path
    func deleteFavoriteItem(at indexPath: IndexPath) {
        let itemToDelete = fetchedFavoriteItem.object(at: indexPath)
        DataController.shared.viewContext.delete(itemToDelete)
        try?  DataController.shared.viewContext.save()
    }
    
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension FavoriteTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedFavoriteItem.sections?.count ??  1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedFavoriteItem.sections?[section].numberOfObjects ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
  
        let currentItem = fetchedFavoriteItem.object(at: indexPath)
        guard currentItem.title?.isEmpty == true else {
            return 88
        }
        return self.tableView.bounds.height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 검색 결과값이 없을 때
        let currentItem = fetchedFavoriteItem.object(at: indexPath)
        guard currentItem.title != nil else { return UITableViewCell() }
       // 결과값 있을 때, 없을 때
        if currentItem.title!.isEmpty == true {
            self.tableView.setContentOffset(CGPoint.zero, animated: false)
            return tableView.dequeueReusableCell(withIdentifier: "EmptyTableViewCell", for: indexPath) as? EmptyTableViewCell ?? UITableViewCell()
        }
        else {
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteTableViewCell", for: indexPath) as? FavoriteTableViewCell {
                
              print(currentItem.title!)
               let replaced = currentItem.title?.replacingOccurrences(of: "<b>", with: " ")
               let newTitle = replaced?.replacingOccurrences(of: "</b>", with: " ")
               currentItem.title = newTitle
               cell.favoriteItem = currentItem
                    
               cell.configure()
            
                do {
                    try DataController.shared.viewContext.save()
                } catch {
                    print("Unable to save photo from flickr")
                }

                return cell
              }
                
              return UITableViewCell()
           }
            
    }
    
// TableView 데이터 더 불러오기
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // 북마크된 데이터를 갯수만큼 받아서 출력하기
        let currentItem = fetchedFavoriteItem.sections?[0].numberOfObjects

        
    }
    
    //MARK: - get data index
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        
       // print(indexPath.item)
        return indexPath
    }

     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        guard let numberOfItem = fetchedFavoriteItem.sections?[0].numberOfObjects,numberOfItem > 0 else {
            return
        }
        let selectedCell:UITableViewCell = tableView.cellForRow(at: indexPath)!
        selectedCell.contentView.backgroundColor = .gray
       // favoriteArray[indexPath.row].selected = true
      }
       
       func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard let numberOfItem = fetchedFavoriteItem.sections?[0].numberOfObjects,numberOfItem > 0 else {
                return
        }
        let selectedCell:UITableViewCell = tableView.cellForRow(at: indexPath)!
        selectedCell.contentView.backgroundColor = .clear
       // favoriteArray[indexPath.row].selected = false
       }
       
    //when select row, url website opened
    
//    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
//        let app = UIApplication.shared
//        app.open(URL(string: self.cellData[indexPath.row].link!)!, options: [:], completionHandler: nil)
//    }
}


extension FavoriteTableViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anyObject: Any,
                    at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .fade)
            break
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .fade)
            break
        case .update:
            tableView.reloadRows(at: [indexPath!], with: .fade)
        case .move:
             tableView.moveRow(at: indexPath!, to: newIndexPath!)

        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        let indexSet = IndexSet(integer: sectionIndex)
        switch type {
        case .insert: tableView.insertSections(indexSet, with: .fade)
        case .delete: tableView.deleteSections(indexSet, with: .fade)
        case .update, .move:
            fatalError("Invalid change type in controller(_:didChange:atSectionIndex:for:). Only .insert or .delete should be possible.")
        }
    }

}

