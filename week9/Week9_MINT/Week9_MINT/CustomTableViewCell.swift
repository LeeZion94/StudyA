//
//  CustomTableViewCell.swift
//  Week9_MINT
//
//  Created by minsong kim on 2023/07/07.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var menuLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    func insert(data: (menu: String, price: Int)) {
        cellImageView.image = UIImage(systemName: "circle")
        menuLabel.text = data.menu
        priceLabel.text = String(data.price) + " 원"
    }
}
