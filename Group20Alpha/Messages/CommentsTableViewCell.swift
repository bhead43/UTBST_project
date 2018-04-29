//
//  CommentsTableViewCell.swift
//  Group20Alpha
//
//  Created by Brandon Head on 4/29/18.
//  Copyright © 2018 Group 20. All rights reserved.
//

import UIKit

class CommentsTableViewCell: UITableViewCell {

    @IBOutlet weak var commentLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    private func rowHeight(for indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
