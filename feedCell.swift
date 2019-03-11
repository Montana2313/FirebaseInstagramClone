//
//  feedCell.swift
//  FireBaseInstagramClone
//
//  Created by Özgür  Elmaslı on 10.03.2019.
//  Copyright © 2019 Özgür  Elmaslı. All rights reserved.
//

import UIKit

class feedCell: UITableViewCell {

    @IBOutlet weak var userimageview: UIImageView!
    @IBOutlet weak var userCommentLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
