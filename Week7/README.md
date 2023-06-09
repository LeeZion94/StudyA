# 7주차: SOLID 원칙
## 🔥실험 목표
SOLID 원칙을 준수하도록, 작성했던 코드를 리팩토링 할 수 있다.
<br>
![](https://hackmd.io/_uploads/B1SE2DZwn.png)
- SOLID는 5개의 프로그래밍 디자인 원칙의 앞글자를 딴 합성어이다. 각 디자인 원칙들은 소프트웨어의 이해와 발전뿐 아니라 유연성과 유지보수성을 높여준다
<br>

![](https://hackmd.io/_uploads/r1hxaPWP2.png)
- 특정 Class를 변경할 이유가 하나 이상이 되면 이는 하나 이상의 책임을 가진 것이라고 판단할 수 있다.
- SRP위반시 특정 함수 하나에 대한 변경이 다른 책임에 영향을 끼칠 수 있고 그 반대의 경우도 발생 가능하다. 이러한 책임의 중복들은 테스트의 가능성을 방해할 뿐 아니라 코드를 읽고 이해하는 것에도 방해가 된다.
<br>

![](https://hackmd.io/_uploads/B1EC6vZPn.png)
- 어떤 모듈의 기능을 하나 수정할 때, 그 모듈을 이용하는 다른 모듈들 역시 줄줄이 고쳐야 한다면 유지보수가 복잡할 것이다.
- 변경(확장)될 것과 변하지 않을 것을 엄격히 구분해 인터페이스를 정의하고 구체적인 타입 대신에 인터페이스에 의존하도록 코드를 작성해야한다.
- 인터페이스를 설계할 때 주의할 점이 있는데, 가능하면 변경되어서는 안되므로 여러 경우의 수에 대한 고려와 예측이 필요하며, 잘못 분리하면 관계가 더 복잡해질 수 있으므로 적당한 추상화 레벨을 선택해야 한다.
<br>

![](https://hackmd.io/_uploads/H1jDCPWv3.png)
- 상속관계에서는 꼭 일반화 관계 (IS-A) 가 성립해야 한다는 의미 (일관성 있는 관계인지)
- 상속관계가 아닌 클래스들을 상속관계로 설정하면, 이 원칙이 위배됨 (재사용 목적으로 사용하는 경우)
- 결국은, 리스코프 치환 원칙을 지키지 않으면 개방 폐쇄 원칙을 위반하게 되는 것이다.
<br>

![](https://hackmd.io/_uploads/SJ9Nk_-Ph.png)
- 각 클라이언트가 필요로 하는 인터페이스들을 분리함으로써, 클라이언트가 사용하지 않는 인터페이스에 변경이 발생하더라도 영향을 받지 않도록 만들어야 하는 것이 핵심이다.
<br>

![](https://hackmd.io/_uploads/BkgKk_bD2.png)
- 구체화된 클래스에 의존하기 보다는 추상 클래스나 인터페이스에 의존해야 한다는 뜻
- DIP은 컴파일 타임에서만 일어난다. 런타임에서는 의존관계가 바뀌지 않는다. 프로그래머가 코드를 더 유연하게 작성하기 위해 DIP이 적용되는 것일 뿐이다.
- YAGNI
**y**ou **a**in't **g**onna **n**eed **i**t.
"DIP이 필요 없을 것이다" 가 기본 가정이다.
필요할 때 구현해주면 된다.
(third-party library를 추가할 때에는 DIP을 적용하는 것이 좋다고 한다.)

## 총 정리
- SRP 와 ISP 는 객체가 커지는 것을 막아준다. 객체가 단일 책임을 갖도록 하고 클라이언트마다 특화된 인터페이스를 구현하게 함으로써 한 기능의 변경이 다른 곳까지 미치는 영향을 최소화하고, 이는 기능 추가 및 변경에 용이하도록 만들어 준다.

- LSP 와 DIP 는 OCP 를 서포트한다. OCP 는 자주 변화되는 부분을 추상화하고 다형성을 이용함으로써 기능 확장에는 용이하되 기존 코드의 변화에는 보수적이도록 만들어 준다. 여기서 '변화되는 부분을 추상화'할 수 있도록 도와주는 원칙이 DIP 이고, 다형성 구현을 도와주는 원칙이 LSP 인 것이다.

## 명심할 것
The SOLID principles are not rules. They are not laws. They are not perfect truths. - Uncle Bob(로버트 C. 마틴 - SOLID를 제시한 사람)
(SOLID 원칙은 규칙이 아닙니다. 그것들은 법이 아닙니다. 그것들은 완전한 진리가 아닙니다.)
[출처]https://sites.google.com/site/unclebobconsultingllc/getting-a-solid-start
