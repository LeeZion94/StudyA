//
//  CustomTableViewCell.swift
//  SatTableView
//
//  Created by Yeseul Jang on 2023/07/08.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var circle: UIImageView!
    @IBOutlet weak var menuLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        circle.image = nil
        menuLabel.text = nil
    }
}
