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
    var fetchedResultsController:NSFetchedResultsController<Favorites>!
    var favorites: Favorites!
    var searchItem: SearchItem!

    
    fileprivate func setFetchedFavoriteController() {
        fetchedResultsController = FavoritesCoreData.shared.getFetchedResultsController(fromContext: DataController.shared.viewContext)
        
        fetchedResultsController.delegate = self
        
        // use the results to populate the notes array
        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError("The fetch could not be performed: \(error.localizedDescription)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setFetchedFavoriteController()
        self.tableView.delegate = self
        self.tableView.dataSource = self

        registerTableViewCell()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setFetchedFavoriteController()
        tableView.reloadData()
        
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: false)
            tableView.reloadRows(at: [indexPath], with: .fade)
        }

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        fetchedResultsController = nil
       
    }
    // register TableViewCell
    func registerTableViewCell() {
        self.tableView.register(UINib(nibName: "EmptyTableViewCell", bundle: nil), forCellReuseIdentifier: "EmptyTableViewCell")
        self.tableView.register(UINib(nibName: "FavoriteTableViewCell", bundle: nil), forCellReuseIdentifier: "FavoriteTableViewCell")
    }
    
    /// Deletes the notebook at the specified index path
     func deleteFavoriteItem(at indexPath: IndexPath) {
         let itemToDelete = fetchedResultsController.object(at: indexPath )
         DataController.shared.viewContext.delete(itemToDelete)
         try?  DataController.shared.viewContext.save()
        
//        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteItem")
//        let result = try? DataController.shared.viewContext.fetch(request)
//        let resultData = result as! [NSManagedObject]
//
//        DataController.shared.viewContext.delete(resultData[indexPath.row])
//        do {
//            try DataController.shared.viewContext.save()
//            print("TABLEVIEW-EDIT: saved!")
//        } catch let error as NSError  {
//            print("Could not save \(error), \(error.userInfo)")
//        } catch {
//            // add general error handle here
//        }
     }
     
    
// MARK: - delete items
    @IBAction func deleteItems(_ sender: Any) {
         
//        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteItem")
//        let result = try? DataController.shared.viewContext.fetch(request)
//        let resultData = result as! [NSManagedObject]
//
//        DataController.shared.viewContext.delete(resultData[index])

//         do {
//             try DataController.shared.viewContext.save()
//             print("TABLEVIEW-EDIT: saved!")
//         } catch let error as NSError  {
//             print("Could not save \(error), \(error.userInfo)")
//         } catch {
//             // add general error handle here
//         }
    }
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension FavoriteTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ??  1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
  
        let currentItem = fetchedResultsController.object(at: indexPath)
        guard currentItem.title?.isEmpty == true else {
            return 88
        }
        return self.tableView.bounds.height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 검색 결과값이 없을 때
        let currentItem = fetchedResultsController.object(at: indexPath)
        guard currentItem.title != nil else { return UITableViewCell() }
       // 결과값 있을 때, 없을 때
        if currentItem.title!.isEmpty {
            self.tableView.setContentOffset(CGPoint.zero, animated: false)
            return tableView.dequeueReusableCell(withIdentifier: "EmptyTableViewCell", for: indexPath) as? EmptyTableViewCell ?? UITableViewCell()
        }
        else {
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteTableViewCell", for: indexPath) as? FavoriteTableViewCell {
                
               print(currentItem.title!)
               currentItem.title = currentItem.title!
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete: deleteFavoriteItem(at: indexPath)
        default: () // Unsupported
        }
    }

    // MARK: - select / deselct item
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // 북마크된 데이터를 갯수만큼 받아서 출력하기
        let currentItem = fetchedResultsController.sections?[0].numberOfObjects
        print(currentItem!)

    }

    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
    
        return indexPath
    }

     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        guard let numberOfItem = fetchedResultsController.sections?[0].numberOfObjects,numberOfItem > 0 else {
            return
        }
        
       // print(numberOfItem)
        let selectedCell:UITableViewCell = tableView.cellForRow(at: indexPath)!
        selectedCell.contentView.backgroundColor = .lightGray
      }
       
       func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard let numberOfItem = fetchedResultsController.sections?[0].numberOfObjects,numberOfItem > 0 else {
            return
        }
        let selectedCell:UITableViewCell = tableView.cellForRow(at: indexPath)!
        selectedCell.contentView.backgroundColor = .clear

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

