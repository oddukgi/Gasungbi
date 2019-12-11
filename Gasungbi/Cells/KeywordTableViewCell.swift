//
//  KeywordTableViewCell.swift
//  Gasungbi
//
//  Created by 강선미 on 09/12/2019.
//  Copyright © 2019 Sunmi Kang. All rights reserved.
//

import Foundation
import UIKit

protocol KeywordTableViewCellDelegate: class {
    func keywordTableViewCell(_ cell: KeywordTableViewCell, removeBtnActionIndex: Int )
}

class KeywordTableViewCell: UITableViewCell {
    
    @IBOutlet weak var keywordLabel: UILabel!

    weak var delegate: KeywordTableViewCellDelegate?
    
    private var index: Int = 0      // cell index
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func removeKeyword(_ sender: Any) {
        self.delegate?.keywordTableViewCell(self, removeBtnActionIndex: self.index)
    }
    
    func setup(searchWord: Keyword, indexPath: IndexPath) {
        self.keywordLabel.text = searchWord.keyword
        self.index = indexPath.row
    }
}
