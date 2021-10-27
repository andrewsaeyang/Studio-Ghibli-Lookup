//
//  NewsViewController.swift
//  Studio Ghibli Lookup
//
//  Created by Andrew Saeyang on 9/1/21.
//

import UIKit
import WebKit

class NewsViewController:UIViewController, WKNavigationDelegate{
    
    @IBOutlet weak var webView: WKWebView!
    
    var webContent = """
    <meta name='viewport' content='initial-scale=1.1'/>
    <a class="twitter-timeline" href="https://twitter.com/GhibliUSA?ref_src=twsrc%5Etfw">Tweets by GhibliUSA</a><script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
    """
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "News"
        
        webView.navigationDelegate = self
        
        webView.loadHTMLString(webContent, baseURL: nil)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if navigationAction.navigationType == .linkActivated  {
            if let url = navigationAction.request.url, UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
                //print(url)
                //print("Redirected to browser. No need to open it locally")
                decisionHandler(.cancel)
            } else {
                //print("Open it locally")
                decisionHandler(.allow)
            }
        } else {
            //print("not a user click")
            decisionHandler(.allow)
        }
    }
}
