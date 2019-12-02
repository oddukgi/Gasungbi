//
//  UIViewController+Extension.swift
//  Gasungbi
//
//  Created by 강선미 on 19/11/2019.
//  Copyright © 2019 Sunmi Kang. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    

    func presentErrorAlert(title: String, message: String){
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    
    
}
