//
//  AuthorTableViewCell.swift
//  AuthorDetails
//
//  Created by Apoorva Bansal on 13/06/17.
//  Copyright © 2017 Sandeep_Chandekar. All rights reserved.
//

import UIKit

protocol AuthorTableViewCellDelegate {
    func buttonURLAction(cell: AuthorTableViewCell)
}

class AuthorTableViewCell: UITableViewCell {

    @IBOutlet weak var imageViewAuthor: UIImageView!
    @IBOutlet weak var labelBlogDate: UILabel!
    @IBOutlet weak var labelAuthorName: UILabel!
    @IBOutlet weak var labelAuthorTitle: UITextView!
    @IBOutlet weak var labelAuthorUrl: UIButton!
    @IBOutlet weak var viewParent: UIView!

    var delegate: AuthorTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func buttonAuthorURLClickedAction(_ sender: Any) {
        if self.delegate != nil {
            self.delegate?.buttonURLAction(cell: self)
        }
    }
    

}
