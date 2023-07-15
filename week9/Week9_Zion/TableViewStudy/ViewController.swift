//
//  ViewController.swift
//  TableViewStudy
//
//  Created by Hyungmin Lee on 2023/06/29.
//

import UIKit

enum TableViewCount {
    static var section: Int { 6 }
    static var row: Int { 3 }
}

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private let basicCellIdentifier = "basicCell"
    private let detailCellIdentifier = "detailCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.backgroundColor = .init(displayP3Red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0)
    }
}

// MARK: - TableView DataSource
extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        TableViewCount.section
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        TableViewCount.row
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = indexPath.row == 1 ? detailCellIdentifier : basicCellIdentifier
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier) else { return UITableViewCell() }

        cell.textLabel?.text = "\(indexPath.section), \(indexPath.row)"
        cell.backgroundColor = indexPath.row == 0 ? .systemPink : .white
        
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as? CustomTableViewCell else { return UITableViewCell() }
//        cell.textLabel?.text = "\(indexPath.section), \(indexPath.row)"
//
//        if indexPath.row == 0 {
//            cell.backgroundColor = .systemPink
//        }
        
        return cell
    }
}
