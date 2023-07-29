# 12주차: Responder Chain
## 🔥실험목표
### 👨‍🔬 실험 1: UIKit이 가장 끝 View를 찾아내는 방법
### 👨‍🔬 실험 2: ResponderChain 활용해보기

## 💻 발표자료
![](https://hackmd.io/_uploads/BydNtlfjn.png)

![](https://hackmd.io/_uploads/Hkk7qezin.png)
**< Outline >**
1.Responder chain
2.hitTest 
3.hitTest Logic
4.hitTest Code
![](https://hackmd.io/_uploads/BkewYefih.png)
**Responder**: UIResponder는 일련의 이벤트를 받고 처리하거나 다른 객체에 이벤트를 전달하는 역할을 합니다.
**Responder chain**:여기서 이벤트를 처리하지 못해 넘겨질 경우 다음 개체로 연결되어 이동하는데 이처럼 이벤트 처리를 목적으로 연결되어 있는 Responder 개체들의 연결 관계가 Responder Chain 입니다.

![](https://hackmd.io/_uploads/Hko8YgMjh.png)
**First Responder**: UIKit은 자동으로 이벤트를 처리하기에 가장 적절한 Responder 객체를 찾아 이벤트를 전달하는데 이 객체가 First Responder입니다.

![](https://hackmd.io/_uploads/HkvOKgfj3.png)
UIEvent 타입의 종류와 이벤트를 전달 받는 First Reponder

![](https://hackmd.io/_uploads/HkskixMih.png)
**< Responder chain Logic >**
1. 이벤트가 발생하면, 해당 이벤트는 이벤트가 발생한 뷰를 기준으로 Responder Chain을 따라 이동합니다.
2. 뷰 계층 구조에서 가장 앞쪽에 있는 뷰부터 이벤트에 응답할 수 있는지 확인하고, 응답할 수 있다면 이벤트를 처리합니다. 응답할 수 없는 경우에는 상위 뷰로 이벤트가 전달됩니다.
3. 이벤트는 뷰 계층 구조에서 상위로 전달되며, UIView는 UIResponder의 서브클래스이므로, 이벤트를 처리할 수 있는 객체가 UIResponder의 서브클래스 중 하나라면 해당 이벤트를 처리할 수 있습니다.
4. 만약 이벤트가 최상위까지 전달되어도 해당 이벤트를 처리할 수 있는 객체를 찾지 못하면 이벤트는 무시됩니다.

![](https://hackmd.io/_uploads/r1utKefo3.png)
**hitTest**: UIView클래스에 정의된 메서드로, 터치 이벤트가 발생한 포인트에 해당하는 최상단의 뷰를 탐색하는 역할을 갖습니다. 이벤트를 처리하기 위해서는 사용자가 터치한 좌표가 어떤 뷰에 위치하는지 파악해야하는데 여기서 **hitTest**를 통해 탐색한 뷰에 대한 터치 이벤트를 처리할 수 있습니다.
![](https://hackmd.io/_uploads/BkWj6lMsh.png)
지금 보이는 코드는 UIView 클래스의 **hitTest** 메서드를 오버라이드하여 정의한 구현을 보여주고 있습니다. **hitTest** 메서드는 특정 좌표에 해당하는 뷰를 찾는 역할을 하죠. 이 코드는 뷰 계층 구조에서 터치 이벤트가 발생한 좌표에 해당하는 뷰를 찾기 위해 사용됩니다.

- `isUserInteractionEnabled`: false일 경우, 해당 뷰와 그 하위 뷰들은 사용자의 상호작용을 받을 수 없습니다.
- `isHidden`: true일 경우, 해당 뷰와 그 하위 뷰들은 화면에 표시되지 않습니다.
- `alpha`: 뷰의 불투명도를 나타냅니다. 0.0부터 1.0 사이의 값을 가지며, 0.01보다 작으면 뷰는 거의 투명한 상태가 됩니다.

만약 해당 뷰가 사용자 상호작용을 받을 수 없거나, 화면에 표시되지 않거나, 거의 투명한 상태라면, 해당 뷰는 이벤트를 처리할 수 없으므로 nil을 반환합니다.

그 다음, 이벤트가 발생한 좌표(point)가 현재 뷰의 범위에 속하는지 (self.point(inside: point, with: event))를 확인합니다. 만약 해당 좌표가 뷰의 범위에 속한다면, 뷰 계층 구조에서 하위 뷰들을 거꾸로 순회하며 터치 이벤트가 발생한 좌표에 해당하는 뷰를 찾습니다. 그리고 해당 뷰에 대해서 다시 **hitTest** 메서드를 재귀적으로 호출하여 하위 뷰들을 순회하고, 이벤트를 처리할 수 있는 뷰를 찾아서 반환합니다.

위의 코드를 요약하면, 터치 이벤트가 발생한 좌표를 기준으로 뷰 계층 구조에서 정의 조건에 따라 이벤트를 처리할 수 있는 뷰를 찾고, 해당 뷰를 반환하는 메서드입니다. 이를 통해 iOS 앱은 적절한 뷰에 대해 이벤트를 처리하고, 사용자와의 상호작용을 효과적으로 제어할 수 있습니다.

![](https://hackmd.io/_uploads/r1aqpgzin.png)
1. touches에서 첫 번째 터치 정보를 가져옵니다.
2. 좌표 정보를 가져옵니다.
3. hitTest를 통해서 해당 좌표를 포함하고 있는 뷰를 탐색합니다.
4. 만약 해당 뷰가 좌표를 갖고 있지 않다면 nil을 반환합니다.

![](https://hackmd.io/_uploads/Bye5Kgfin.png)
위와 같이 사용자가 View_B1(green)을 터치하면 상위뷰 계층부터 탐색하면서 내려오는데 View_C(grey)는 터치된 point를 갖고 있지 않기 때문에 false 반환하고 View B로 넘어와 hitTest를 수행하게 되면서 View_B1(green)를 반환합니다.

### 📋 실험 View
![](https://hackmd.io/_uploads/BJ3cYgzj3.png)

### 📋 실험 1
![](https://hackmd.io/_uploads/SJJjJ-fih.png)
사용자가 터치한 좌표를 포함하는 최상위 뷰의 `backgroundColor`가 출력되도록 코드를 수정헀습니다.

### 📋 실험 2
![](https://hackmd.io/_uploads/SyZCIWMo2.png)
GestureRecognizer 생성하고, 이벤트가 발생할 때 해당 `greenView`의 배경색을 black과 교차로 변경해주는 `tapView()`가 호출되도록 설정하였습니다. 

**✏️Tip**
- 뷰 객채의 배경 색상이 `System Color`일 경우에는 색상 변경이 불가능합니다. 따라서 해당 색을 `green`으로 수정해주었습니다.

### 실행화면
![](https://hackmd.io/_uploads/By9jwbGj3.gif)
