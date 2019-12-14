//
//  ResultViewController+TableView.swift
//  Gasungbi
//
//  Created by 강선미 on 09/12/2019.
//  Copyright © 2019 Sunmi Kang. All rights reserved.
//

import UIKit

// MARK: - UITableViewDelegate, UITableViewDataSource
extension ResultViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard self.cellData.isEmpty else {
            return self.cellData.count
        }
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
  
        guard self.cellData.isEmpty else {
            return 88
        }
        return self.tableView.bounds.height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 검색 결과값이 없을 때
        if self.cellData.isEmpty {
            self.tableView.setContentOffset(CGPoint.zero, animated: false)
            return tableView.dequeueReusableCell(withIdentifier: "EmptyTableViewCell", for: indexPath) as? EmptyTableViewCell ?? UITableViewCell()
        }
        else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "ResultTableViewCell", for: indexPath) as? ResultTableViewCell {
               
                let replaced = self.cellData[indexPath.row].title?.replacingOccurrences(of: "<b>", with: " ")
                let newTitle = replaced?.replacingOccurrences(of: "</b>", with: " ")
                self.cellData[indexPath.row].title = newTitle
                cell.configure(data: self.cellData[indexPath.row])
                saveCellDataFromSearchKeyword(searchResult: self.cellData[indexPath.row])
                
                return cell
            }
            
            return UITableViewCell()
        }
    }
    
    //MARK: - get data index
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if selectedItems.count > 10 {
            return nil
        }
        debugPrint("index array: \(indexPath.item)")
        return indexPath
    }

     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        guard self.cellData.count > 0 else {
            return
        }
         self.cellData[indexPath.row].isSelected = true
     }
       
       func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
           guard self.cellData.count > 0 else {
               return
           }
           
           self.cellData[indexPath.row].isSelected = false
       }
       
    //when select row, url website opened
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
     
        let url = self.cellData[indexPath.row].link!
        let title = self.cellData[indexPath.row].title!
        
        let priceVC = self.storyboard?.instantiateViewController(withIdentifier: "showPrice") as! PriceViewController
        
        priceVC.detailUrl = url
        priceVC.itemName = title
        navigationController?.pushViewController(priceVC, animated: true)
              
    }
    

}
