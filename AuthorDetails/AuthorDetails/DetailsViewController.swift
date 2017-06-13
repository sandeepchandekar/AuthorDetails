//
//  DetailsViewController.swift
//  AuthorDetails
//
//  Created by Apoorva Bansal on 13/06/17.
//  Copyright © 2017 Sandeep_Chandekar. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var webViewAuthorUrl: UIWebView!
    @IBOutlet weak var activityWebView: UIActivityIndicatorView!
    var webViewURLString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityWebView.isHidden = true
        self.webViewAuthorUrl.loadHTMLString(self.webViewURLString!, baseURL: nil)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func webViewDidStartLoad(_ webView: UIWebView) {
        self.activityWebView.isHidden = !self.activityWebView.isHidden
        self.activityWebView.startAnimating()
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        self.activityWebView.isHidden = !self.activityWebView.isHidden
        self.activityWebView.stopAnimating()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        self.activityWebView.isHidden = !self.activityWebView.isHidden
        self.activityWebView.stopAnimating()
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
