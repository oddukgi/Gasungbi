//
//  PriceViewController.swift
//  Gasungbi
//
//  Created by 강선미 on 25/11/2019.
//  Copyright © 2019 Sunmi Kang. All rights reserved.
//

import UIKit
import WebKit


class PriceViewController: UIViewController,WKUIDelegate {
    
    var webView: WKWebView!
    var detailUrl: String = ""
    var itemName: String = ""
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }

    @objc func back(sender: UIBarButtonItem) {
        _ = navigationController?.popViewController(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.back(sender:)))
              self.navigationItem.leftBarButtonItem = newBackButton
        sendRequest(urlString: detailUrl)
    }
    
    
    // Convert String into URL and load the URL
    private func sendRequest(urlString: String) {
      DispatchQueue.main.async {
         self.webView.load(URLRequest(url: URL(string: urlString)!))
       }
    }
    
    @IBAction func back(_ sender: Any) {
        if self.webView.canGoBack {
            self.webView.goBack()
        }
    }

    @IBAction func sahrePriceInfo(_ sender: Any) {
        let itemUrl = NSURL(string: detailUrl)
        let sharedObjects:[AnyObject] = [itemName as AnyObject, itemUrl as AnyObject]
        let activityViewController = UIActivityViewController(activityItems: sharedObjects , applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    
    }
        
}

