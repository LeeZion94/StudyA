//
//  ViewController.swift
//  SatTableView
//
//  Created by Yeseul Jang on 2023/07/07.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var MenuTableView: UITableView!
    
    let american = ["햄버거", "피자", "아메리카노"]
    let chinese = ["탕수육"]
    let korean = ["비빔밥", "돼지갈비"]
    let japanese = ["스시", "돈까스"]

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return american.count
        case 1:
            return chinese.count
        case 2:
            return korean.count
        case 3:
            return japanese.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        
        switch indexPath.section {
        case 0:
            cell.menuLabel.text = american[indexPath.row]
        case 1:
            cell.menuLabel.text = chinese[indexPath.row]
        case 2:
            cell.menuLabel.text = korean[indexPath.row]
        case 3:
            cell.menuLabel.text = japanese[indexPath.row]
        default:
            cell.menuLabel.text = ""
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "American"
        case 1:
            return "Chinese"
        case 2:
            return "Korean"
        case 3:
            return "Japanese"
        default:
            return nil
        }
    }
}

