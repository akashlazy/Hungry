//
//  PhotosVC.swift
//  Hungry
//
//  Created by lazy on 12/7/18.
//  Copyright © 2018 lazy. All rights reserved.
//

import UIKit
import WebKit

class PhotosVC: UIViewController, WKNavigationDelegate{
    
    var webView: WKWebView!
    
    @IBOutlet weak var loading: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()

        loading.startAnimating()
        loading.hidesWhenStopped = true
        
        webView = WKWebView()
        webView.navigationDelegate = self
        self.view = webView
        
        let url = URL(string: "https://www.zomato.com/mumbai/hardeep-punjab-sion/photos?utm_source=api_basic_user&utm_medium=api&utm_campaign=v2.1#tabtop")!
        webView.load(URLRequest(url: url))
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
