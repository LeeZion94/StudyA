//
// © 2021. yagom academy all rights reserved
// This tutorial is produced by Yagom Academy and is prohibited from redistributing or reproducing.
//

import UIKit

struct Registrant {
    var name: String? = "준비중입니다"
    var phoneNumber: String? = "준비중입니다"
}

class ViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField! //view
    @IBOutlet weak var phoneNumberTextField: UITextField! //view
    @IBOutlet weak var nameLabel: UILabel! //view
    @IBOutlet weak var phoneNumberLabel: UILabel! //view

    var registrantList: [Registrant] = [] // Model
    
    override func viewDidLoad() { //view
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector (register), name: Notification.Name("register"), object: nil)
        
    }

    @IBAction func hitRegisterButton(_ sender: Any) {
        var member: Registrant = Registrant()
        
        member.name = nameTextField.text
        member.phoneNumber = phoneNumberTextField.text
        
        registrantList.append(member)
        
        NotificationCenter.default.post(name: Notification.Name("register"), object: registrantList)
        
//        NotificationCenter.default.removeObserver(self, name: Notification.Name("register"), object: nil)
        
    }
    
    @IBAction func hitCheckButton(_ sender: Any) {
        //nameLabel.text = registrantList.last?.name
        //phoneNumberLabel.text = registrantList.last?.phoneNumber
    }
    
    @objc func register() {
        nameLabel.text = registrantList.last?.name
        phoneNumberLabel.text = registrantList.last?.phoneNumber
    }
}
