# 3주차: MVC
## 🔥실험 목표
    
- 하나의 앱을 구성하고 MVC 구조를 이해할 수 있습니다.
- Notification Center를 활용해 이벤트를 처리할 수 있습니다.
    
* 주요 개념: `IBOutlet`, `IBAction`, `UIElement`, `Notification`

## 😎코드 예시

<details>
<summary> 1. 모델 타입을 활용해 앱을 구상해보자. </summary>
<div markdown="1">

```swift=
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
        
    }
    @IBAction func hitRegisterButton(_ sender: Any) {
        register()
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

```
        
</div>
</details>

    
<details>
<summary> 2. view controller를 view와 controll로 구분해보자. </summary>
<div markdown="1">

- Cocoa MVC에서는 이 둘을 따로 놓고 보기 힘들다고 판단했습니다. 이미 제공해주는 템플릿자체가 둘의 관계가 밀접한 관계를 가지고 있다고 생각합니다. 그 이유는 이미 ViewController내부에서 Storyboard의 UI Component들을 관리 할 수 있는 IBOutlet과 이벤트를 처리할 수 있는 IBAction이 존재하기도 하고 코드 베이스를 사용하여 UI를 구현하는 경우 또한 존재하니 Storyboard를 View와 동일시 하는 것은 무리가 있다고 생각합니다. 
    
- 또한, 모델의 데이터가 갱신되어 View를 갱신하여야 하는 경우 결국 갱신된 데이터는 ViewController에서의 UI Component를 다루는 IBOutlet을 통해 갱신되어지므로 온전히 Storyboard가 View와 동일시 되는 것은 불가하다 생각합니다.
        
</div>
</details>

<details>
<summary> 3. Notification Center를 활용해 변화를 감지해보자. </summary>
<div markdown="1">
    
보통 Notification Center는 화면과 화면 사이에서 사용한다. 
다만 이번 스터디 예제에서는 한 화면에서 버튼으로 구현하는 방법으로 연습하였다. 

```swift=
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
    
    @objc func register() {
        nameLabel.text = registrantList.last?.name
        phoneNumberLabel.text = registrantList.last?.phoneNumber
    }
}

```
        
</div>
</details>
