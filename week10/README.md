# 10주차: Concyrrency Programing
![](https://hackmd.io/_uploads/H1SfJ-19h.png)
![](https://hackmd.io/_uploads/S1YXMkJc2.png)
![](https://hackmd.io/_uploads/SyMFfyk92.png)
- 컴퓨터에는 CPU라는 장치가 있다. 이는 컴퓨터에서 기억, 해석, 연산, 제어라는 4대 주요 기능을 관할하는 장치인데 그 중에서도 일을 처리하는 CPU의 핵심을 코어라고 한다. CPU와 코어는 동일한 것이 아니며, CPU는 여러 개의 코어를 가질 수 있다. 이는 하드웨어의 스레드라고도 볼 수 있는데, 스레드는 일을 처리하는 곳이기 때문. 소프트웨어의 스레드는 현실에 구현되어 있지는 않지만 논리적인 스레드로 컴퓨터에서 만들어내는 것들로 볼 수 있다. 앞으로 말하는 스레드는 전부 소프트웨어의 스레드이다.

![](https://hackmd.io/_uploads/SJ8C7J1qh.png)
- 병렬: 여러 개의 코어가 하나의 일을 나눠서 처리
- 동시성: 하나의 코어가 하나의 일을 여러 개의 스레드로 나눠서 처리

![](https://hackmd.io/_uploads/ByV-4y1cn.png)
- 동기: 작업이 끝날때까지 나머지는 모두 멈추고 기다림
- 비동기: 기다리지 않게 비켜 준 상태에서 작업.

![](https://hackmd.io/_uploads/H1z4N1Jq3.png)
- 스위프트에서 동시성 처리를 해주기 위해서는 이와 같은 것들이 있다.

![](https://hackmd.io/_uploads/BJUwVJ193.png)
- Grand Central Dispatch
- 코드로서 동기 / 비동기 처리만 해주면 알아서 스레드 관리

![](https://hackmd.io/_uploads/rJnvV1y9n.png)
- Dispatch 프레임워크, DispatchQueue 클래스 사용
- DispatchQueue라는 GCD를 사용하기 위한 대기열에 보내면 알아서 관리, 작업 처리
- 선입 선출로 작업 처리

![](https://hackmd.io/_uploads/r1GCHJkqn.png)
- 이러한 DispatchQueue를 사용하기 위해서 반드시 정해주어야 하는 조건이 있다.
- 단일 스레드인 Serial에서 처리할지
- 다중 스레드인 Concurrent에서 처리할지

![](https://hackmd.io/_uploads/Sk-J8J153.png)
- DispatchQueue.main과 DispatchQueue.global()은 기본적으로 구현되어 있는 큐이다.
- main은 Serial이며
- global()은 Concurrent이다.
- 여기서 sync 동기와 async 비동기를 선택해줄 수 있다.

![](https://hackmd.io/_uploads/HkxpIJkqn.png)
- 사용하면 이와 같다.
- main은 async라도 스레드가 하나밖에 없기에 global()의 sync일 때와 똑같이 동작한다.
- main에서는 sync를 사용할 수 없는데 이는 차차 알아보자.

![](https://hackmd.io/_uploads/HyqUvyk9n.png)
- workitem을 사용하여 클로저 처럼 코드블록을 캡슐화 해줄 수 있다. 
- excute 파라미터를 통해 사용.

![](https://hackmd.io/_uploads/r1ugOkk5h.png)
- 작업을 원하는 시간에 시작할 수 있게 하는 메서드들.
- deadline은 0초부터 시작해 5초가 되었을 때 시작하고
- walldeadline은 지금 당장의 시스템 시간에서 시작에 5초가 지난 시간에 시작.

![](https://hackmd.io/_uploads/SJXmKJyc3.png)
- 비동기로 되어 있는 특정 작업이 끝나기를 기다리게 한다.
- 위의 내용들이 defer와도 같다고 볼 수 있는지 생각해보자.
- 함수의 실행이 끝나면 실행되는 클로저인 escaping과도 유사하고
- 비동기 작업이 종료되는 시점을 추적하여 순서를 보장하는 completionHandler와도 유사해 보인다.

![](https://hackmd.io/_uploads/By-5h11c2.png)
- 앞서 나왔던 메인 스레드에 대한 이야기를 해보자.
- 메인 스레드는 기본 스레드로 여러가지 특징을 지닌다.
- 전역적으로 사용이 가능하고
- run loop 가 자동으로 설정되어 실행되는데 이때 run loop는 이벤트 처리 루프이다. 모든 스레드는 각자의 run loop를 가질 수 있지만 이는 자동적으로 설정되지는 않는다.run loop는 두 가지 이벤트를 처리하는데 하나는 Input Source로 다른 Thread나 Application으로부터 온 비동기 이벤트를 전달하는 것이고 다른 하나는 Timer라고 예약 된 시간 또는 반복 간격으로 발생하는 동기 이벤트를 전달하는 것.
- 마지막으로 UI 작업은 메인 스레드에서만 가능.

![](https://hackmd.io/_uploads/HyxO-lkqn.png)
- 앞서 메인 스레드에서는 sync를 부를 수 없는 이유도 이 특징들과 연관이 있다.
- sync의 특징으로 인해 메인 스레드는 sync가 끝날 때까지 스레드를 멈춘다.
- 그리고 sync는 코드 블록의 작업이 끝나기를 기다린다. (block wait)
- 그런데 메인 스레드가 멈추면서 메인 스레드에서 실행되고 있던 코드 블록도 멈춘다.
- DeadLock

![](https://hackmd.io/_uploads/By1tZl1q2.png)
- 그렇다면 UI 작업이 메인 스레드에서만 가능한 이유는 뭘까?

![](https://hackmd.io/_uploads/BJRyzgJqn.png)
- Race Condition이 일어날 수 있다면 Thread Unsafe 한다.

![](https://hackmd.io/_uploads/rJV-fg1c2.png)
- 마치 열쇠더미와 같다.

![](https://hackmd.io/_uploads/SkoVGe1ch.png)
- main과 global()은 기본 구현되어 있던 큐들이었는데 이를 convenience init 해주며 커스텀 해줄 수 있다.

![](https://hackmd.io/_uploads/SJQFzxkq3.png)
- label: 디버깅 시 구분

![](https://hackmd.io/_uploads/rktPOekq3.png)
- 무엇에 더 많은 에너지를 쏟을 지를 결정(더 많은 스레드를 할당할지) -> 순서를 결정 짓지는 않으나 영향 미칠 수 있음.
- User_interactive가 가장 높고 -> Unspecified가 가장 낮음
- 시스템이 알아서 조절

![](https://hackmd.io/_uploads/ryrrtxy53.png)
- serial: 단일
- concurrent: 다중
- initiallyinactive: activate()전까지 작동 x, 배열로 설정 받을 수 있음. [.concurrent, .initiallyInactive]

![](https://hackmd.io/_uploads/SJJhKgJc2.png)
- 디스패치큐가 작업을 스레드에 넘긴 후에 해당 작업을 큐에서 할당 해제하는 빈도
- inherit: 기본적인 ARC 참조 해제처럼 공간이 필요할 때마다 해제
- workitem: autoreleasePool과 같이 공간이 남아 있어도 매번 해제
- never: 해제 x

![](https://hackmd.io/_uploads/ByG65lJ5n.png)
- target 큐가 부모큐로 작업을 모조리 넘깁니다.
- 앱에서 사용하는 총 스레드 수를 최소화하기 위해 수행.
- 여러 개의 큐를 사용해야하는 작업들을 실제로는 하나의 큐에서 작업, 총 스레드 수 최소화.

![](https://hackmd.io/_uploads/BJoHjl1qh.png)
- async에는 사용할 수 있는 파라미터들이 있다. 
- 이들은 보통 기본값을 가지고 있어 구현해줄 필요는 없지만 필요시 수정하여 사용할 수 있다.
- 첫번째로 group이다.
- 서로 다른 큐에 있는 async 작업들도 그룹에 넣을 수 있음.
- 그룹의 작업들이 다 끝나면 다음 작업을 실행한다.
- sync는 작업 종료 시점을 알 필요가 없기에 async 작업에서만 사용 가능하다.

![](https://hackmd.io/_uploads/SJPV2e192.png)
- 두 가지 방법으로 등록 가능.
- 1. 파라미터
- 2. enter()부터 leave()까지 포함한다.

![](https://hackmd.io/_uploads/B1Lnng1cn.png)
- 1. notify: group이 끝나면 파라미터 queue에서 코드블럭 내용 실행
- 2. wait: 끝나기만 기다림. timeout으로 기다릴 시간도 정할 수 있음. wallTimeout도 사용 가능.

![](https://hackmd.io/_uploads/SkW4Tlk9h.png)
- 다음으로 qos와 flag라는 파라미터가 있다.
- qos: 앞서 설명한 DispatchQoS와 같다.
- flags: 코드 블럭 실행 시 적용할 추가 속성. 필요할 때 확인~

![](https://hackmd.io/_uploads/Sy3BAly5h.png)
![](https://hackmd.io/_uploads/SyQIRlJ52.png)
![](https://hackmd.io/_uploads/H1-vAl1c3.png)
![](https://hackmd.io/_uploads/rk5v0l15n.png)
![](https://hackmd.io/_uploads/rJG_Axy9n.png)
![](https://hackmd.io/_uploads/Sy8u0ek9n.png)
![](https://hackmd.io/_uploads/Hy3uAx1qh.png)
