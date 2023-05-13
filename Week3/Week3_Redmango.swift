//
// © 2021. yagom academy all rights reserved
// This tutorial is produced by Yagom Academy and is prohibited from redistributing or reproducing.
//

import UIKit

struct Registrant {
    var name: String
    var phoneNumber: String
}

class ViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    
    var registrantList: [Registrant] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(changeLabel), name: NSNotification.Name("newRegistrant"), object: nil)
    }
    @IBAction func hitRegisterButton(_ sender: Any) {
        register()
        
        NotificationCenter.default.post(name: NSNotification.Name("newRegistrant"), object: nil)
    }
    
    @IBAction func hitCheckButton(_ sender: Any) {
        nameLabel.text = registrantList.last?.name
        phoneNumberLabel.text = registrantList.last?.phoneNumber
    }
    
    func register() {
        guard let name = nameTextField.text,
              let phoneNumber = phoneNumberTextField.text else {
           return
        }
        
        let registrant = Registrant(name: name, phoneNumber: phoneNumber)
        registrantList.append(registrant)
    }
    
    @objc func changeLabel() {
        nameLabel.text = registrantList.last?.name
        phoneNumberLabel.text = registrantList.last?.phoneNumber
    }

}
