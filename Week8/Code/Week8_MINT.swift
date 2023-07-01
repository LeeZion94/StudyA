//
//  main.swift
//  HigherOrderFunctionStudy
//
//  Created by mint on 2023/06/30.
//

import Foundation

protocol Character {
    var name: String { get set }
    var level: Int { get set }
    var strength: Int { get set }
    var health: Int { get set }
}

struct Farmer: Character {
    var name: String
    var level: Int = 1
    var strength: Int = 40
    var health: Int = 1000
    var plantLikeability: Int = 0
    
    var diggingHoles: () -> Void
    var pullingWeeds: () -> Void
    var rakingSoil: () -> Void
    var wateringPlants: () -> Void
    
    func tabShiftKey(skill: () -> Void) {
        //???
        //여기에 뭘 넣을 수 있지...?
        skill()
    }
}

var mint: Farmer = Farmer(name: "농부 민트" ,
                          diggingHoles: { mint.health += 10
                                            print("땅 파기를 해서 체력이 \(mint.health)가 되었습니다.") },
                          pullingWeeds: { mint.level += 1
                                            print("잡초 뽑기를 해서 레벨이 \(mint.level) 되었습니다.") },
                          rakingSoil: { mint.strength += 2
                                            print("흙을 갈퀴질 하여 힘이 \(mint.strength)가 되었습니다.")},
                          wateringPlants: { mint.plantLikeability += 10
                                            print("식물에 물을 줘서 호감도가 \(mint.plantLikeability)가 되었습니다.") })

mint.tabShiftKey(skill: mint.diggingHoles)
mint.tabShiftKey(skill: mint.pullingWeeds)
mint.tabShiftKey(skill: mint.rakingSoil)
mint.tabShiftKey(skill: mint.wateringPlants)


// MARK: STEP2

var mintFavorites = ["오뉴","바다","사진","초록색","민트초코","훈", "보라색", "슈팅스타 예티", "맹고", "와아이", "숀"]

//map: 조건에 따라 내부 변형
let deleteChoco = mintFavorites.map { $0.replacingOccurrences(of: "초코", with: "") }
print(deleteChoco)

//filter: 조건에 따라 참인 경우만 남김
let color = mintFavorites.filter { $0.contains("색") }
print(color)

//reduce: 하나로 만들기
let one = mintFavorites.reduce("", { $0 + $1 })

print(one)



// MARK: STEP3

extension Array {
    func myMap<T>(_ transfrom: (Element) -> T) -> [T] {
        var container: [T] = []
        
        for item in self {
            container.append(transfrom(item))
        }
        return container
    }

    func myFilter(_ transfrom: (Element) -> Bool) -> Self {
        var container: [Element] = []
        
        for item in self {
            if transfrom(item) {
                container.append(item)
            }
        }
        return container
    }

    func myReduce<T>(initialResult: (T), nextPartialResult: (T, Element) -> T) -> T {
        var result = initialResult
        
        for item in self {
            result = nextPartialResult(result, item)
        }
        return result
    }
}

let deleteMint = mintFavorites.myMap { $0.replacingOccurrences(of: "민트", with: "") }
