//
//  ResultViewController.swift
//  Gasungbi
//
//  Created by 강선미 on 27/11/2019.
//  Copyright © 2019 Sunmi Kang. All rights reserved.
//

import UIKit
import CoreData


class ResultViewController: UIViewController, NSFetchedResultsControllerDelegate {

    // MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
 
    var totalCount: Int = 0
    var pageCount: Int = 1
    var keyword: String = ""
    var cellData = [SearchResults]()
    var searchItem: SearchItem!
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerTableViewCell()
        self.searchBar.delegate = self
        self.tableView.delegate = self
        self.tableView.dataSource = self
        navigationItem.hidesSearchBarWhenScrolling = true
       // Register Notification Observer for SearchBar Keyboard Close
        NotificationCenter.default.addObserver(self,
                                            selector: #selector(searchBarResignFirstResponder),
                                            name: NSNotification.Name("searchBarResignFirstResponder"),
                                            object: nil)
     
    }
    
    deinit {
           // Delete Notification Observer
           NotificationCenter.default.removeObserver(self,
                                                     name: NSNotification.Name("searchBarResignFirstResponder"),
                                                     object: nil)
       }
    
    
    // MARK: - Notification Methods
    // close keyboard
     @objc private func searchBarResignFirstResponder() {
         if self.searchBar.isFirstResponder {
             self.searchBar.resignFirstResponder()
         }
     }
       
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.hidesSearchBarWhenScrolling = false
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
        self.tableView.register(UINib(nibName: "ResultTableViewCell", bundle: nil), forCellReuseIdentifier: "ResultTableViewCell")
    }

    // MARK: - Search Keyword
    func configureTable(data: [SearchResults]) {
        
        self.showIndicator()
        APIManager.search(item: self.keyword) { searchResult,error in
        
            if searchResult.error != nil {
                                    
                self.hideIndicator()
                self.cellData.removeAll()
                self.tableView.reloadData()
                self.presentErrorAlert(title: "Failed to search data", message: error!.localizedDescription)
            }
            else {
          
                if let count = searchResult.value?.total { self.totalCount = Int(count)! }
                if let results = searchResult.value?.items {
                    self.cellData = data.isEmpty ? [SearchResults]() : self.cellData
                
                    for result in results {
                        self.cellData.append(result)
                    }
                   self.tableView.reloadData()
                    
                    self.hideIndicator()
                }
                else {
                    
                    debugPrint("Empty searchResult.value")
                }
                
            }
        }

    }
    
    var selectedItems: [SearchResults] {
        return cellData.filter { return $0.isSelected }
    }
    
    func deleteData() {
        
       let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorites")
       let result = try? DataController.shared.viewContext.fetch(request)
       let resultData = result as! [NSManagedObject]

       for object in resultData {
           DataController.shared.viewContext.delete(object)
       }

       do {
           try DataController.shared.viewContext.save()
        
       } catch let error as NSError  {
           debugPrint("Could not save \(error), \(error.userInfo)")
       }

    }
 
    
    func saveCellDataFromSearchKeyword(searchResult: SearchResults) {

        let index: Int = 0
        searchItem = SearchItemCoreData.shared.saveResults(searchResult: searchResult, fromContext: DataController.shared.viewContext, index: index)
        // Save newly created pin.
        do {
            try DataController.shared.save()
        } catch {
            debugPrint("Error saving new pin: \(error)")
        }
    }

    @IBAction func addFavoriteItem(_ sender: Any) {
        
        guard selectedItems.count > 0 else { return }
        FavoritesCoreData.shared.createFavorites(selectedItems: selectedItems,forSearch: searchItem)
      
        // find selected row and change value
        if let selectedIndexPaths = tableView.indexPathsForSelectedRows {
            for indexPath in selectedIndexPaths {
                  tableView.deselectRow(at: indexPath, animated: false)
                   self.cellData[indexPath.row].isSelected = false
            }
        }
        
        tableView.reloadData()
    }
    
    func tableViewClear() {
       self.cellData.removeAll()
       self.tableView.reloadData()
    }
    
    
    // MARK: - Indicator Methods
    private func showIndicator() {
        self.activityIndicator.startAnimating()
    }
      
    private func hideIndicator() {
        self.activityIndicator.stopAnimating()
    }
}

// MARK: - UISearchBarDelegate
// hide & show searchbar
extension ResultViewController: UISearchBarDelegate {

    // MARK: - Methods
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.totalCount = 0
        self.pageCount = 1

        self.keyword = searchBar.text!
        guard let query = searchBar.text, query.trimmingCharacters(in: .whitespaces) != "" else {
            self.cellData.removeAll()
            self.tableView.reloadData()
            hideIndicator()
            return
        }
        
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.reload(_:)), object: searchBar)
        perform(#selector(self.reload(_:)), with: searchBar, afterDelay: 0.2)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.resignFirstResponder()
        if searchBar.text != "" {
                  
           self.configureTable(data: [SearchResults]())
        }
    }

    @objc func reload(_ searchBar: UISearchBar) {
       
        if !searchBar.text!.isEmpty {
            self.configureTable(data: [SearchResults]())
        }
    }
}


