//
//  MailCell.swift
//  Outlook-oauth2
//
//  Created by Yusuf ali cezik on 25.12.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import UIKit
import Letters

class MailCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var mailImageView: UIImageView!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var senderNameLabel: UILabel!
    @IBOutlet weak var senderEmailLabel: UILabel!
    @IBOutlet weak var subjectLabel: UILabel!
    
    public var mail:Mail!{
        didSet{
            self.senderNameLabel.text = mail.fromUser?.emailAddress?.name!
            self.senderEmailLabel.text = mail.fromUser?.emailAddress?.address!
            self.subjectLabel.text = mail.subject!
            self.mailImageView.setImage(string: self.senderNameLabel.text!, color: #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 0.7215325342), circular: true, textAttributes: [NSAttributedString.Key.font: UIFont(name: "Arial", size: 30.0)!, NSAttributedString.Key.foregroundColor:#colorLiteral(red: 0.1900072992, green: 0.3403339386, blue: 0.4397745132, alpha: 1)])
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.containerView.layer.cornerRadius = 10
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
