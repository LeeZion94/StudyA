//
// © 2021. yagom academy all rights reserved
// This tutorial is produced by Yagom Academy and is prohibited from redistributing or reproducing.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    
    private var registrantList: [Registrant] = []
    private let notificationCenter = NotificationCenter.default
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        notificationCenter.addObserver(self, selector: #selector(catchNotification(noti:)), name: Notification.Name("checkRegistrant"), object: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        notificationCenter.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    private func clearTextField() {
        nameTextField.text = nil
        phoneNumberTextField.text = nil
    }
    
    private func showLastRegistrant() {
        guard let registrant = registrantList.last else { return }
        
        nameLabel.text = registrant.name
        phoneNumberLabel.text = registrant.phoneNumber
    }
    
    @objc
    func catchNotification(noti: Notification) {
        showLastRegistrant()
    }
}

// MARK: - Button Action
extension ViewController {
    @IBAction func hitRegisterButton(_ sender: Any) {
        guard let name = nameTextField.text, let phoneNumber = phoneNumberTextField.text else { return }
        let fanInformation = Registrant(name: name, phoneNumber: phoneNumber)
        
        registrantList.append(fanInformation)
        clearTextField()
        notificationCenter.post(name: Notification.Name("checkRegistrant"), object: nil)
        nameTextField.becomeFirstResponder()
        
    }
    
    @IBAction func hitCheckButton(_ sender: Any) {
//        showLastRegistrant()
        // Notification을 사용하기위한 예시이므로 사용하지 않습니다.
    }
}
