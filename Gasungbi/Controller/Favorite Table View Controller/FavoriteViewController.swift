//
//  FavoriteViewController.swift
//  Gasungbi
//
//  Created by 강선미 on 20/11/2019.
//  Copyright © 2019 Sunmi Kang. All rights reserved.
//

import UIKit
import CoreData

class FavoriteViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var fetchedResultsController:NSFetchedResultsController<Favorites>!
    var searchItem: SearchItem!
    var favoriteItem: [Favorites] = []

    
    fileprivate func setFetchedFavoriteController() {
        fetchedResultsController = FavoritesCoreData.shared.getFetchedResultsController(fromContext: DataController.shared.viewContext)
        fetchedResultsController.delegate = self
        
        do {
            try fetchedResultsController.performFetch()
            favoriteItem = fetchedResultsController.fetchedObjects!
            print(favoriteItem.count)
            
            
        } catch {
            fatalError("The fetch could not be performed: \(error.localizedDescription)")
        }

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setFetchedFavoriteController()
        registerTableViewCell()
        self.tableView.delegate = self
        self.tableView.dataSource = self
       
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setFetchedFavoriteController()
        tableView.reloadData()

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        fetchedResultsController = nil
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPrice" {
             let priceVC = segue.destination as! PriceViewController
             let priceInfo = sender as? (String, String)
               priceVC.detailUrl = (priceInfo?.0)!
               priceVC.itemName = (priceInfo?.1)!
           }
    }
    // register TableViewCell
    func registerTableViewCell() {
        self.tableView.register(UINib(nibName: "EmptyTableViewCell", bundle: nil), forCellReuseIdentifier: "EmptyTableViewCell")
        self.tableView.register(UINib(nibName: "FavoriteTableViewCell", bundle: nil), forCellReuseIdentifier: "FavoriteTableViewCell")
    }

        func deleteFavoriteItem() {
            
           if let indexPaths = tableView.indexPathsForSelectedRows  {
           //Sort the array so it doesn't cause a crash depending on your selection order.
           let sortedPaths = indexPaths.sorted {$0.row > $1.row}
                for indexPath in sortedPaths {

                    let count = fetchedResultsController.fetchedObjects?.count
                    let i = count! - 1
                    for i in stride(from: i, through: 0, by: -1) {

                        if(indexPath.row == i){
    
                            let itemToDelete = favoriteItem[i]
                            favoriteItem.remove(at: i)
                            DataController.shared.viewContext.delete(itemToDelete)
                            do {
                                try  DataController.shared.viewContext.save()
                            } catch {
                                print(error)
                            }

                        }
                    }
                }
            
            if favoriteItem.count == 0 {
                setFetchedFavoriteController()
                return
            }
            
            tableView.reloadData()
            }
         }
// MARK: - delete items for multiple selection
    @IBAction func deleteItems(_ sender: Any) {
        deleteFavoriteItem()
    }
    
}

