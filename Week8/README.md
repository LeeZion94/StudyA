
# 8주차: 고차함수
## 🔥실험 목표
- 함수의 타입인 함수타입 을 이해할 수 있다.
- 클로저를 매개변수로 받는 함수를 정의할 수 있다.
- 고차함수의 작동 방식을 이해하고, 직접 내부를 구현해볼 수 있다.

## 👨‍🔬 실험 1: Closure를 활용해 게임 캐릭터에 스킬 적용하기
- Character 타입을 생성합니다.
`() → Void` 함수 타입을 갖는 `skill` 프로퍼티를 여러 개 만들어봅시다.
`() → Void` 함수 타입을 매개변수로 갖는 `tabShiftKey(skill: () → Void)` 함수를 만들어봅시다.
캐릭터를 생성하고, `skill`을 바꿔가며 `tabShiftKey` 메서드를 호출해봅시다.
![](https://hackmd.io/_uploads/rycjKbT_h.png)
![](https://hackmd.io/_uploads/SkU2YW6d2.png)
![](https://hackmd.io/_uploads/rJZTtZT_2.png)
![](https://hackmd.io/_uploads/SJYaFb6_3.png)

## 👨‍🔬 실험 2: 고차함수 활용해보기
- 원하는 형식의 배열을 생성합니다.
- 배열 안에 요소를 추가합니다.
- map, reduce, filter를 활용해보면서, 각 고차함수가 어떤 역할을 하는지 한마디로 표현해봅시다.

![](https://hackmd.io/_uploads/r1NzqZpu2.png)
![](https://hackmd.io/_uploads/rkqzq-pOn.png)
![](https://hackmd.io/_uploads/HkkQ5Zpu2.png)

## 👨‍🔬 실험 3: Custom 고차함수 직접 만들기
- map, reduce, filter의 각 기능을 떠올려보면서, 우리가 직접 같은 기능을 하는 고차 함수를 만들어보는건 어떨까요? 쉽진 않겠지만, 해낸 순간 느낄 무한한 뿌듯함은 보장합니다. <br>
![](https://hackmd.io/_uploads/rJh5cbp_3.png)
![](https://hackmd.io/_uploads/HyzocWpu3.png)
![](https://hackmd.io/_uploads/B1Ys9bTd3.png)
![](https://hackmd.io/_uploads/HJAjqWa_2.png)
