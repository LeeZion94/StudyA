//
//  CustomTableViewCell.swift
//  TableViewStudy
//
//  Created by Hyungmin Lee on 2023/06/29.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        backgroundColor = .white
    }
}
