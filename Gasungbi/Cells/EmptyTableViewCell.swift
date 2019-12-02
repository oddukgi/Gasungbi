//
//  EmptyTableViewCell.swift
//  GitSearch
//
//  Created by 강선미 on 2019. 11. 27..
//  Copyright © 2019년 강선미. All rights reserved.
//

import UIKit

class EmptyTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
}
