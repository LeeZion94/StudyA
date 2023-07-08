# 9주차: Table View
## 🔥실험 목표
- TableView를 생성할 수 있다.
- TableView의 Section과 Row의 개념을 이해하고, 원하는 정보를 Cell 에 표현할 수 있다.
![](https://hackmd.io/_uploads/H1VniBLK2.png)
- 섹션과 행으로 이루어져 유저에게 스크롤 가능한 리스트를 제공하고 선택할 수 있는 항목들을 표시하는 UI요소
![](https://hackmd.io/_uploads/HyFThr8F2.png)
- 테이블 뷰는 3가지 스타일을 지정할 수 있다.
    - plain
    - grouped
    - inset grouped

![](https://hackmd.io/_uploads/Sy72y8LY3.png)
- 필수 구현조건
    - UITableViewDataSource
    - UITableViewDelegate
    - UITableViewCell
![](https://hackmd.io/_uploads/HJUayL8Fn.png)
- 테이블 뷰에 표시되는 각 행을 나타내는 뷰 요소로 내부에는 셀 컨텐츠 부분과 액세서리 뷰부분으로 나눠진다.
- 액세서리 뷰는 필수 구현 사항은 아님
![](https://hackmd.io/_uploads/SkZyxULK2.png)
- 테이블뷰의 데이터관리를 하는 프로토콜. 
- 섹션과 행을 관리하고 각 행에 cell을 제공하는 역할을 한다.
![](https://hackmd.io/_uploads/Hyxel8IFn.png)
- 테이블 뷰의 동작 및 유저와의 상호작용에 대한 응답을 처리하는 프로토콜. 
- 셀이 터치되거나 슬라이드되거나할 때의 반응들을 정해줄 수 있다.
![](https://hackmd.io/_uploads/rkTTkL8F2.png)
![](https://hackmd.io/_uploads/rJNCy8UK2.png)
- indexPath는 2개의 인덱스를 가진 배열로 이루어져있다.
- 0번째 인덱스 = section, 1번째 인덱스 = row
![](https://hackmd.io/_uploads/H1mbl8LFn.png)
- 커스텀한 테이블 뷰를 만들기 위해서는 UITableViewDataSource와 UITableViewDelegate를 직접 구현해주는 편이 좋다.
![](https://hackmd.io/_uploads/S1YblIIYn.png)
![](https://hackmd.io/_uploads/rJxMeUIY2.png)
![](https://hackmd.io/_uploads/S1wuEIUK3.png)
