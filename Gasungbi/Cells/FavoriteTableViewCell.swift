//
//  FavoriteTableViewCell.swift
//  GitSearch
//
//  Created by 강선미 on 2019. 11. 28..
//  Copyright © 2018년 강선미. All rights reserved.
//

import UIKit
import Kingfisher

protocol Label: class {
    func updateLabel()
}
class FavoriteTableViewCell: UITableViewCell,Label {

    
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    var favoriteItem: Favorites!
    
    var priceformatter = PriceForm()
    override func awakeFromNib() {
        super.awakeFromNib()
        self.priceLabel.text = ""
        self.priceformatter.delegate = self
    }

    func configure() {
        self.selectionStyle = .none
        
        if let imageURL = favoriteItem.image {
            self.itemImageView.kf.setImage(with: URL(string: imageURL))
        }
            
//      print(self.favoriteItem.title!)
//      print(self.favoriteItem.lprice!)
    
        self.itemLabel.text = self.favoriteItem.title
        self.priceLabel.text = self.favoriteItem.lprice
        self.priceformatter.priceString = self.priceLabel.text
        self.updateLabel()
        
    }


    func updateLabel() {
        guard priceformatter.updatePriceForm() else {
          self.priceLabel.text = "₩\(String(describing: self.priceformatter.priceString!))"
            return
        }
        
    }

}
// 참고: 친절한 어플리케이션(1) - 입력된 숫자를 콤마로 구분하기 https://baked-corn.tistory.com/76

class PriceForm: NSObject {
    weak var delegate: Label?
    var priceString: String?
    func updatePriceForm() -> Bool{
        // 1,000,000 - 입력 숫자를 콤마로 구분하기
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal  // 1,000,000
        formatter.locale = Locale.current
        formatter.maximumFractionDigits = 0 // 허용하는 소숫점 자리수
          // formatter.groupingSeparator // .decimal -> ,
        
            var beforeFormattedString = priceString!
            
            if formatter.number(from: priceString!) != nil {
                 if let formattedNumber = formatter.number(from: beforeFormattedString), let formattedString = formatter.string(from: formattedNumber){
                        priceString = formattedString
                        return false
                    }
                } else{ // 숫자가 아닐 때
                    if priceString == "" { // 백스페이스일때
                        let lastIndex = beforeFormattedString.index(beforeFormattedString.endIndex, offsetBy: -1)
                        beforeFormattedString = String(beforeFormattedString[..<lastIndex])
                        if let formattedNumber = formatter.number(from: beforeFormattedString), let formattedString = formatter.string(from: formattedNumber){
                            priceString = formattedString
                            return false
                        }
                    } else{ // 문자일 때
                        return false
                    }
                }
            
        return true
    }
}
    
