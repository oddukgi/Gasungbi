//
//  PriceViewController.swift
//  Gasungbi
//
//  Created by 강선미 on 25/11/2019.
//  Copyright © 2019 Sunmi Kang. All rights reserved.
//

import UIKit
import WebKit
import WebViewWarmUper

class PriceViewController: UIViewController,WKUIDelegate {
    
    var webView: WKWebView!
    var detailUrl: String = ""
    var itemName: String = ""
    private var loadHTMLStart: TimeInterval = 0
    
    
    override func loadView() {
        
        let customWarmUper = WKWebViewWarmUper { () -> WKWebView in
          let configuration = WKWebViewConfiguration()
          // Setup configuration.
          return WKWebView(frame: .zero, configuration: configuration)
        }

        webView = customWarmUper.dequeue()
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
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        webView = nil
    }
    // Convert String into URL and load the URL
    private func sendRequest(urlString: String) {
        webView.navigationDelegate = self
        webView.scrollView.isScrollEnabled = false
        self.view = webView
        loadHTMLStart = CACurrentMediaTime()
        let request = URLRequest(url: URL(string: urlString)!)
        webView.load(request)
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

extension PriceViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
         updateResult()
     }
    
    // check loading time (sec)
    private func updateResult() {
        let delta = CACurrentMediaTime() - loadHTMLStart
        debugPrint(delta)
    }
}
