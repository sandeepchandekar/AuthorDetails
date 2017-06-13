//
//  ViewController.swift
//  AuthorDetails
//
//  Created by Sandeep Chandekar on 13/06/17.
//  Copyright © 2017 Sandeep_Chandekar. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, AuthorTableViewCellDelegate{
    
    @IBOutlet weak var tableViewAuthors: UITableView!
    var author_details: [AnyObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        // Do any additional setup after loading the view, typically from a nib.
        self.getAllAuthors()
        self.title = "Authors"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.author_details.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 175
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: AuthorTableViewCell = tableView.dequeueReusableCell(withIdentifier: "AuthorTableViewCell", for: indexPath) as! AuthorTableViewCell
        cell.delegate = self

        if let urlString = self.author_details[indexPath.row].value(forKey: IMAGEURL) as? String {
            
        let imageURL = URLRequest(url: URL(string: urlString.replacingOccurrences(of: "\\", with: ""))!)
        
        cell.imageViewAuthor.contentMode = UIViewContentMode.scaleAspectFit

        // Use Alamofire to download the image
        Alamofire.request(imageURL as URLRequestConvertible).responseData { (response) in
            if response.error == nil {
                print(response.result)
                // Show the downloaded image:
                if let data = response.data {
                    cell.imageViewAuthor.image = UIImage(data: data)
                }
            }
        }
            
        }else{
            cell.imageViewAuthor.image = UIImage(named: "user")

        }
        cell.imageViewAuthor.layer.borderWidth = 1.0
        cell.imageViewAuthor.layer.masksToBounds = false
        cell.imageViewAuthor.layer.borderColor = UIColor.lightGray.cgColor
        cell.imageViewAuthor.layer.cornerRadius = cell.imageViewAuthor.frame.size.width/2
        cell.imageViewAuthor.clipsToBounds = true

        
        
        let blogDateString: String = self.author_details[indexPath.row].value(forKey: BLOGDATE) as! String
//        let dateFormatter: DateFormatter = DateFormatter()
//        dateFormatter.timeZone = TimeZone.current
//        dateFormatter.dateFormat = "yyyy-mm-dd HH:mm:ss"
//        let blogDate: Date = dateFormatter.date(from: blogDateString)!
//        dateFormatter.dateFormat = "yyyy-mm-dd"
//        cell.labelBlogDate.text = dateFormatter.string(from: blogDate)
        cell.labelBlogDate.text = blogDateString.components(separatedBy: " ")[0]
        
        cell.labelAuthorUrl.setTitle(self.author_details[indexPath.row].value(forKey: AUTHORURL) as? String, for: .normal)
        cell.labelAuthorName.text = self.author_details[indexPath.row].value(forKey: AUTHORNAME) as? String
        cell.labelAuthorTitle.text = self.author_details[indexPath.row].value(forKey: AUTHORTITLE) as? String
        
        cell.viewParent.layer.shadowColor = UIColor.lightGray.cgColor
        cell.viewParent.layer.shadowOpacity = 1
        cell.viewParent.layer.shadowOffset = CGSize.zero
        cell.viewParent.layer.shadowRadius = 10
        
        return cell
        
    }
    
    func getAllAuthors() {
        Alamofire.request(
            URL(string: "http://blog.teamtreehouse.com/api/get_recent_summary/")!,
            method: .get,
            parameters: ["include_docs": "true"])
            .validate()
            .responseJSON { (response) -> Void in
                guard response.result.isSuccess else {
                    print("Error while fetching Authors: \(response.result.error)")
                    return
                }
                
                guard let value = response.result.value as? [String: Any],
                    let authors = value["posts"] as? [AnyObject] else {
                        print("Malformed data received from GetAllAuthors service")
                        return
                }
                
                self.author_details = authors
                self.tableViewAuthors.dataSource = self
                self.tableViewAuthors.delegate = self
                self.tableViewAuthors.reloadData()
        }
    }
    
    func buttonURLAction(cell: AuthorTableViewCell) {
        let detailView: DetailsViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        detailView.webViewURLString = ""
        let string = self.author_details[cell.tag].value(forKey: AUTHORURL) as? String
        detailView.webViewURLString = string?.replacingOccurrences(of: "\\", with: "")
        self.navigationController?.pushViewController(detailView, animated: true)
    }

}

