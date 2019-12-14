//
//  FavoriteViewController+Extesion.swift
//  Gasungbi
//
//  Created by 강선미 on 11/12/2019.
//  Copyright © 2019 Sunmi Kang. All rights reserved.
//

import Foundation
import CoreData
import UIKit

// MARK: - UITableViewDelegate, UITableViewDataSource
extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ??  1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
  
        let currentItem = fetchedResultsController.object(at: indexPath)
       // let currentItem = favoriteItem[indexPath.row]
        guard currentItem.title?.isEmpty == true else {
            return 88
        }
        return self.tableView.bounds.height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let currentItem = fetchedResultsController.object(at: indexPath)
        
        if currentItem.title!.isEmpty {
            self.tableView.setContentOffset(CGPoint.zero, animated: false)
            return tableView.dequeueReusableCell(withIdentifier: "EmptyTableViewCell", for: indexPath) as? EmptyTableViewCell ?? UITableViewCell()
        }
        else {
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteTableViewCell", for: indexPath) as? FavoriteTableViewCell {
                
               debugPrint(currentItem.title!)
               currentItem.title = currentItem.title!
               cell.favoriteItem = currentItem
               cell.configure()

                return cell
              }
                
              return UITableViewCell()
           }
            
    }
    
    // MARK: - select / deselct item
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let currentItem = fetchedResultsController.sections?[0].numberOfObjects
        debugPrint(currentItem!)
    }

    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {

        return indexPath
    }
       
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        
        let currentItem = fetchedResultsController.object(at: indexPath)
        let title = currentItem.title!
        let url = currentItem.link!
        let priceVC = self.storyboard?.instantiateViewController(withIdentifier: "showPrice") as! PriceViewController
        
        priceVC.detailUrl = url
        priceVC.itemName = title
        navigationController?.pushViewController(priceVC, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath)-> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title:  "delete", handler: {(ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            let itemToDelete = self.fetchedResultsController.object(at: indexPath)
                
            debugPrint(indexPath.item)
            DataController.shared.viewContext.delete(itemToDelete)
            try? DataController.shared.viewContext.save()
            success(true)
        })
        return UISwipeActionsConfiguration(actions:[deleteAction])
    }
}


extension FavoriteViewController: NSFetchedResultsControllerDelegate {
    
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
                //   tableView.reloadRows(at: [indexPath!], with: .fade)
                break
            case .move:
                tableView.moveRow(at: indexPath!, to: newIndexPath!)
                break
            @unknown default:
                break
        }
    }
    

}
