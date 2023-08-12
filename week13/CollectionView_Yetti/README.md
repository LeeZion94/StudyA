# 13주차_1: Collection View 

![](https://hackmd.io/_uploads/S15rism33.png)

![CollectionView](https://hackmd.io/_uploads/SyVCqo7hn.png)
- 정렬된 데이터 항목 모음을 그리드나 다른 커스텀 레이아웃으로 표시하는 유연하고 강력한 UI요소
- 테이블 뷰처럼 data source로 데이터를 관리하고 delegate로 유저와의 상호작용을 관리

![](https://hackmd.io/_uploads/HJ_aws7nn.png)
![](https://hackmd.io/_uploads/BJ0avjmhn.png)
### Collection View 구성요소 4가지
1. 셀(Cell)
2. 보충 뷰(Supplementary View)
3. 데코레이션 뷰(Decoration View)
4. 레이아웃 객체(Layout Object)

![](https://hackmd.io/_uploads/ryvOtiQh3.png)
- Line같은 경우도 메신저 내에서 테이블뷰를 사용하다가 콜렉션뷰로 리팩토링하였다.

![CollectionViewFlowLayout](https://hackmd.io/_uploads/Bk6_qiQh3.png)
![](https://hackmd.io/_uploads/rymKqiQnh.png)
![](https://hackmd.io/_uploads/B1vKcjXn2.png)

### CollectionView 구성단계
1. FlowLayout객체 생성 후 CollectionView에 할당
2. 셀의 너비와 높이를 설정
3. 필요시 item, lines의 간견을 설정
4. header, footer사용시 사이즈 명시
5. 레이아웃의 스크롤 방향 설정. 기본값은 세로

![](https://hackmd.io/_uploads/BJKK9sQh3.png)
![](https://hackmd.io/_uploads/rJyc5om2n.png)
![](https://hackmd.io/_uploads/S1Xq5om3h.png)

### UICollectionViewDataSource
- 여러가지 메서드를 통해 UICollectionView의 데이터와 뷰를 관리
- 데이터 변경 시에는 reloadData()를 호출하여 전체 데이터를 다시 로드해야함
- 세부적인 데이터 변경을 처리하기 위해서는 추가적인 로직 및 애니메이션 코드가 필요
    - 따로 애니메이션 코드가 없다면 뚝뚝 끊겨서 보이는 단점 -> 사용자 경험(UX) 감소
- 복잡한 데이터 구조를 다루기에는 유지보수가 어려울 수 있음

### UICollectionViewDiffableDataSource
- UICollectionViewDiffableDataSource클래스를 사용하여 데이터를 관리하며, 데이터 변경을 더 쉽게 처리할 수 있음
- CollectionView와 DataSource 간에 데이터 자동으로 동기화되어 편리함
- 데이터 스냅샷(snapshot)을 사용하여 섹션과 아이템의 구성을 관리 (스냅샷: 현재 UICollectionView의 표시 상태를 뜻함)
- 데이터 변경 사항을 처리하는 데 있어서 별도의 라이브러리 없이도 빠른 성능 및 적절한 애니메이션을 자동으로 제공 -> 사용자 경험(UX) 향상
- 복잡한 데이터 구조의 경우에도 더 효율적으로 데이터 관리 및 업데이트를 할 수 있음
![](https://hackmd.io/_uploads/BySq9sQnh.png)
![](https://hackmd.io/_uploads/BJqq9o7nh.png)
![](https://hackmd.io/_uploads/r1TcqjX2n.png)

- 유튜브뮤직, 인스타그램, 앱스토어 등등 많은 곳에서 사용되고 있다.

![](https://hackmd.io/_uploads/Bygicj733.png)
