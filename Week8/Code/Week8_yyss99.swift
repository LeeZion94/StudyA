//
//  main.swift
//  closureSkillSet
//
//  Created by yyss99 on 2023/06/17.
//

class Character {
    let name: String
    var hp: Int = 100
    var mp: Int = 100
    var normalAttackSkill: () -> Void
    var magicAttackSkill: () -> Void
    
    init(name: String,
         normalAttackSkill: @escaping () -> Void,
         magicAttackSkill: @escaping () -> Void) {
        self.name = name
        self.normalAttackSkill = normalAttackSkill
        self.magicAttackSkill = magicAttackSkill
    }
    
    func tabShiftKey(skill: () -> Void) {
        print("플레이어가 shift키를 눌렀습니다.")
        skill()
    }
}

class LolChampion: Character {
    var flashSpell: () -> Void
    var healSpell: () -> Void
    
    init(name: String,
         normalAttackSkill: @escaping () -> Void,
         magicAttackSkill: @escaping () -> Void,
         flashSpell: @escaping () -> Void,
         healSpell: @escaping () -> Void) {
        self.flashSpell = flashSpell
        self.healSpell = healSpell
        super.init(name: name,
                   normalAttackSkill: normalAttackSkill,
                   magicAttackSkill: magicAttackSkill)
    }
    
    func tabDkey(spell: () -> Void) {
        print("플레이어가 D를 눌렀습니다")
        spell()
    }
    
    func tabFkey(spell: () -> Void) {
        print("플레이어가 F키를 눌렀습니다")
        spell()
    }
}

// 실험 1: Closure를 활용해 게임 캐릭터에 스킬 적용하기

let mint = Character(name: "민트", normalAttackSkill: {
    print("-민트가 일반 공격을 합니다!-")
}, magicAttackSkill: {
    mint.mp -= 10
    print("-민트가 마법 공격을 합니다!-")
})

mint.tabShiftKey(skill: mint.magicAttackSkill)
mint.tabShiftKey(skill: mint.normalAttackSkill)

// 추가 실험: 롤 캐릭터

let ash = LolChampion(name: "애쉬", normalAttackSkill: {
    print("-애쉬가 일반 화살을 쏩니다.-")
}, magicAttackSkill: {
    ash.mp -= 20
    print("-애쉬가 궁극기 마법의 수정화살을 쏩니다.-")
}, flashSpell: {
    print("-애쉬가 점멸을 써서 순간이동을 합니다!-")
}, healSpell: {
    ash.hp += 10
    print("-애쉬가 회복을 사용해서 hp를 올립니다!-")
    print("<애쉬의 hp: \(ash.hp)>")
})

ash.tabDkey(spell: ash.flashSpell)
ash.tabFkey(spell: ash.healSpell)



// 실험 2: 고차함수 활용해보기

//map : 각 요소에 대해 특정 작업을 한 뒤에 새로운 배열을 생성함
let numberExamples = [1, 2, 3, 4, 5]
let squaredNumbers = numberExamples.map { $0 * $0 }
print(squaredNumbers) // [1, 4, 9, 16, 25]

let studyA = [ "mint", "yyss99", "redmango", "yetti", "Zion"]
let studyAFirstLetters = studyA.map {  $0.first ?? "?" }
print(studyAFirstLetters) // ["m", "y", "r", "y", "Z"]

//filter : 각 요소에 대해 조건을 만족하는 요소로만 새로운 배열을 생성함
let longNames = studyA.filter { $0.count > 4 }
print(longNames) // ["yyss99", "redmango", "yetti"]

let nameStartWithY = studyA.filter { $0.first == "y"}
print(nameStartWithY) // ["yyss99", "yetti"]

//reduce : 각 요소를 결합하여 하나의 값으로 만듦 (모든 요소를 순회하면서 누적연산함)

let allNames = studyA.reduce("") { $0 + $1 }
print(allNames) // mintyyss99redmangoyettiZion

let sum = numberExamples.reduce(0) { $0 + $1 }
print(sum) // 15

// 실험 3: Custom 고차함수 직접 만들기

extension Array {
    func myMap(_ transform: (Element) -> Element) -> Self {
        var result: [Element] = []
        
        for item in self {
            result.append(transform(item))
        }
        return result
    }
    
    func myFilter(_ included: (Element) -> Bool) -> Self {
        var result: [Element] = []
        
        for item in self {
            if included(item) {
                result.append(item)
            }
        }
        return result
    }
    
    func myReduce(_ initialResult: Element, _ nextPartialResult: (Element, Element) -> Element) -> Element {
        var partialResult = initialResult
        
        for item in self {
            partialResult = nextPartialResult(partialResult, item)
        }
        return partialResult
    }
}

let numbers = [1, 2, 3, 4, 5, 6]
let mappingNumbers = numbers.myMap { number in
    return number + 2 // [3, 4, 5, 6, 7, 8]
}

let filteringNumbers = numbers.myFilter { number in
    return number > 3 // [4, 5, 6]
}

let reducingNumbers = numbers.myReduce(0) { partialResult, number in
    return partialResult + number // 21
}
