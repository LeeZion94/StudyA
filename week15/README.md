# KeyChain Service 구현(add, update,read )

- KeyChain Service를 사용하여 암호화가 필요한 데이터를 저장하고 업데이트하고 읽어오는 코드를 직접작성해보고 KeyChain Service를 이해해보자.

### KeyChainService란 무엇일까?

- 중요!!! KeyChain은 App이 삭제되더라도 Data가 남아있다.
- https://medium.com/@LeeZion94/keychain-service-vs-userdefaults-1a550227d749

### KeyChain에 Data를 추가해보자

```swift
@IBAction func addNewPassword(_ sender: Any) {
    guard let password = pwTextField.text else { return }
    
    let passwordData = password.data(using: .utf8)!
    let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                kSecAttrAccount as String: keyName,
                                kSecValueData as String: passwordData]
    let status = SecItemAdd(query as CFDictionary, nil)
    
    switch status {
    case errSecSuccess:
        print("성공")
    case errSecDuplicateItem:
        updatePasswordOnKeyChain(keyName: keyName, password: passwordData)
    default:
        print("KeyChain 등록 실패")
    }
}
```

- 위의 코드는 KeyChainService를 활용하여 KeyChain에 User가 사용하는 Password를 저장(Add)하는 코드입니다. 유저가 입력한 password를 받아서 이를 data화 시킨뒤 keychain에 저장하기 위한 query로 변경하여 CFDictionary의 형태로 저장하고 저장된 결과에 대한 처리를 수행하는 코드입니다.

```swift
let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                      kSecAttrAccount as String: keyName,
                          kSecValueData as String: passwordData]
```

- kSecClass는 Keychain에 저장하려고 하는 data의 종류에 해당합니다. 해당 예시에서는 Keychain으로 User가 사용하는 Password를 저장하고 있으므로 kSecClassGenericPassword를 Value값으로 설정하였습니다.
- kSecAttr 키워드가 붙은 kSecAttrAccount는 Data를 구분짓기 위한 특성 값에 해당하는 값입니다. kSecAttr 키워드가 붙은 값들은 해당 Data를 구분 짓는 특성 값으로 활용될 수 있고 위의 예시에서는 User의 Account 값을 Data를 구분짓기 위한 특성 값으로 활용하고 있으므로 kSecAttrAccount 값을 특성 값으로 넣어주고 있습니다.
- kSecValueData는 실질적으로 저장하려고 하는 Data입니다. kSecClass에서 User의 Password를 저장하기 위해 kSecClassGenericPassword를 Value값으로 넣어줫으므로 Data 값으로는 User가 입력한 Password를 값으로 넣어줍니다.

```swift
let status = SecItemAdd(query as CFDictionary, nil)
        
switch status {
case errSecSuccess:
    print("성공")
case errSecDuplicateItem:
    updatePasswordOnKeyChain(keyName: keyName, password: passwordData)
default:
    print("")
}
```

- SecItemAdd은 지금까지 만든 query 값을 CFDictionary로 변환하여 실질적으로 Keychain으로 저장하게 만들어주는 메서드입니다. return 값으로 OSStatus 값을 가지며 저장이 올바르게 되었는지, 올바르게 되지 않았다면 어떤한 이유로 되지 않았는지를 status 값으로 return 해줍니다.
- errSecSuccess는 KeyChain에 data가 올바르게 저장이 되었다는 상태값입니다.
- errSecDuplicateItem는 해당 attr(속성) 값으로 이미 저장된 keyChain data가 존재한다는 상태값입니다. 아무런 처리를 하지 않을 수도 있지만 등록했었던 특성 값을 활용하여 기존에 존재했던 값을 새롭게 입력 받은 값으로 Update 해줄 수 있습니다.

### KeyChain에 Data를 업데이트 해보자

```swift
private func updatePasswordOnKeyChain(keyName: String, password: Data) {
    let previousQuery: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                        kSecAttrAccount as String: keyName]
    let updateQuery: [String: Any] = [kSecValueData as String: password]
    let state = SecItemUpdate(previousQuery as CFDictionary, updateQuery as CFDictionary)
    
    switch state {
    case errSecSuccess:
        print("update 성공")
    default:
        print("실패")
    }
}
```

- KeyChain 저장시 해당 attr 속성값에 대한 데이터가 이미 존재하는 경우 이를 업데이트하는 query를 만들어서 해당 KeyChain 속성 값에 저장된 data 값을 업데이트하는 코드입니다.

```swift
let previousQuery: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                kSecAttrAccount as String: keyName]
let updateQuery: [String: Any] = [kSecValueData as String: password]
```

- previouQuery는 어떤 data를 업데이트 할 것 인지 저장된 data의 종류와 속성 값을 명시해줘서 어떤 data를 업데이트 할 것인지를 query로 나타낼 수 있습니다.
- updateQuery의 경우에는 실질적으로 update 하려는 data의 값을 나타내고 갱신시켜줍니다.

```swift
let state = SecItemUpdate(previousQuery as CFDictionary, updateQuery as CFDictionary)

switch state {
case errSecSuccess:
    print("update 성공")
default:
    print("실패")
}
```

- SecItemUpdate 메서드를 사용하여 첫번째 인자로는 data를 찾아가기 위한 query, 두번째 인자로는 갱신하려고 하는 data의 query를 넣어줍니다.
- state 값을 return 값으로 받아와서 업데이트에 성공했는지 실패했는지 알 수 있습니다.

### KeyChain에서 Data를 읽어보자

```swift
private func readPasswordOnKeyChain(_ inputPassword: String) {
    let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                kSecAttrAccount as String: keyName,
                                kSecReturnAttributes as String: true,
                                kSecReturnData as String: true]
    var item: CFTypeRef?
    let status = SecItemCopyMatching(query as CFDictionary, &item)
    
    switch status {
    case errSecSuccess:
        guard let existingItems = item as? [String: Any],
              let passwordData = existingItems[kSecValueData as String] as? Data,
              let password = String(data: passwordData, encoding: .utf8), inputPassword == password else {
            fallthrough
        }
        
        print("비밀번호 - \(password)")
    default:
        print("로그인 실패")
    }
}
```

- 해당 로직은 저장된 키체인의 값을 부여한 attr 속성 값을 통해서 읽어오는 로직입니다.

```swift
let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                        kSecAttrAccount as String: keyName,
                kSecReturnAttributes as String: true,
                        kSecReturnData as String: true]
```

- 먼저 읽을 data의 종류를 kSecClassGenericPassword로 명시하고 등록한 Attr 값을 통해 어떠한 속성값을 가지는 Data를 읽어올지 설정합니다.
- 또한 kSecReturnAttributes 해당 옵션 값을 통해서 data를 읽어 올 때 등록해 두었던 attr 속성 값 또한 같이 Dictionary로 받아올지 지정해 줄 수 있습니다. true로 준다면 data를 저장할 때 같이 등록했던 attr 속성 값 또한 같이 load되고 false를 부여한다면 read 하기를 원했던 data만 받아오게 됩니다.
- kSecReturnData data 값을 받아오겠다는 옵션 값에 해당합니다.

```swift
var item: CFTypeRef?
let status = SecItemCopyMatching(query as CFDictionary, &item)
```

- SecItemCopyMatching 메서드를 사용해서 KeyChain에 저장된 값을 읽어오게 됩니다.
- 등록된 값을 읽어오기위해 만들어주엇던 query를 해당 메서드의 파라미터로 넣어주고, data 값을 받아오기위해 만들어 두었던 item변수의 주소값을 해당 메서드에 전달해주면서 item 값을 통해 원하는 data 및 attr 속성 값을 받아올 수 있게 됩니다.

```swift
case errSecSuccess:
  guard let existingItems = item as? [String: Any],
        let passwordData = existingItems[kSecValueData as String] as? Data,
        let password = String(data: passwordData, encoding: .utf8), inputPassword == password else {
      fallthrough
  }
```

- item을 올바르게 Read료 했다면 부여했던 옵션 값을 통해 data와 attr 속성 값들을 Dictionary로 전달받아오게 됩니다.
- kSecReturnAttributes 옵션 값을 true로 부여했으므로 Dictionary로 형변환 작업이 필요합니다. false로 부여했다면 attr 속성 값이 같이 read 되지 않기 때문에 Dictionary로 형변환을 할 필요가 없이 Data만 받게 됩니다.
- Data에 해당하는 Key값을 사용하여 data를 받고 이를 다시 encoding한다면 저장되어 있었던 password 값을 올바르게 읽어올 수 있습니다.

---

# CoreData

![‎CoreData_redmango ‎001](https://github.com/redmango1447/apple1446/assets/94215762/69a5d8e9-06eb-4b28-afc0-44707a493223)
---
![‎CoreData_redmango ‎002](https://github.com/redmango1447/apple1446/assets/94215762/b4176555-41f0-4fd6-991a-d07541df3090)

---
![‎CoreData_redmango ‎003](https://github.com/redmango1447/apple1446/assets/94215762/3e8fde49-5f55-4a02-a335-dbc64a1e2bff)

- 객체 관리 그래프란: 객체간의 관계를 그래프로 나타낸 것
---
![‎CoreData_redmango ‎004](https://github.com/redmango1447/apple1446/assets/94215762/b64890bd-a5d3-4f37-b79f-7f77d4febdd5)

- DB언어를 배울 필요가 없다는 점에서 매우 편리
---

![‎CoreData_redmango ‎005](https://github.com/redmango1447/apple1446/assets/94215762/35c50ce6-413a-420c-81b0-dbc086b63b35)

---
![‎CoreData_redmango ‎006](https://github.com/redmango1447/apple1446/assets/94215762/2f182f3b-8774-4368-a8d2-fc1f99dc02ec)

- 스레드 세이프를 고려하지 않았다는걸 주의
- mainQueue는 아무래도 UI때문인것으로 추측(데이터 처리때문에 UI먹통 될수도..)
---
![‎CoreData_redmango ‎007](https://github.com/redmango1447/apple1446/assets/94215762/32e73c8c-aff2-46e3-a7da-82853119bc55)

---
![‎CoreData_redmango ‎008](https://github.com/redmango1447/apple1446/assets/94215762/ca5abcda-a4ea-4048-bb98-2c5f393ad370)

- 마이그레이션을 하지 않을 경우 데이터가 날아가는 경우가 발생 할 수 있다.
---
![‎CoreData_redmango ‎009](https://github.com/redmango1447/apple1446/assets/94215762/95d1dd1c-89c2-4160-9594-0a7e70369ffc)
---
![‎CoreData_redmango ‎010](https://github.com/redmango1447/apple1446/assets/94215762/7e1a1797-4e56-4deb-ac42-27da91b71416)

