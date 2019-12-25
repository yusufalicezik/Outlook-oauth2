//
//  MailCell.swift
//  Outlook-oauth2
//
//  Created by Yusuf ali cezik on 25.12.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import UIKit

class MailCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var mailImageView: UIImageView!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var senderNameLabel: UILabel!
    @IBOutlet weak var senderEmailLabel: UILabel!
    @IBOutlet weak var subjectLabel: UILabel!
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
