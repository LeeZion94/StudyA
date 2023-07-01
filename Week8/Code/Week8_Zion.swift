//
//  main.swift
//  HigherOrderFunction
//
//  Created by Hyungmin Lee on 2023/06/30.
//

import Foundation


typealias Skill = () -> Void

func tabShiftKey(skill: Skill) {
    skill()
}

struct Character {
    let powerStrikeSkill: Skill = {
        print("Power Strike 사용")
    }
    let slashStrikeSkill: Skill = {
        print("Slash Strike 사용")
    }
    let holySymbolSkill: Skill = {
        print("Holy Symbol 사용")
    }
    let bigBangSkill: Skill = {
        print("Bigbang 사용")
    }
}

let zion = Character()

tabShiftKey(skill: zion.powerStrikeSkill)
tabShiftKey(skill: zion.slashStrikeSkill)
tabShiftKey(skill: zion.holySymbolSkill)
tabShiftKey(skill: zion.bigBangSkill)

extension Array {
    func myMap<T>(_ transform: (Element) -> T) -> Array<T> {
        var result: [T] = []
        
        self.forEach{ result.append(transform($0)) }
        return result
    }
    
    func myFilter(_ transform: (Element) -> Bool) -> Self {
        var result: [Element] = []
        
        self.forEach {
            if transform($0) {
                result.append($0)
            }
        }
        
        return result
    }
    
    func myReduce<T>(_ initialResult: T, _ transform: (T ,Element) -> T) -> T {
        var result = initialResult
        
        self.forEach { result = transform(result, $0) }
        return result
    }
}

let test1 = [1, 2, 3].myMap { String($0) }
let test2 = [1, 2, 3].myFilter { $0 % 2 == 1 }
let test3 = [1, 2, 3].myReduce("") { partialResult, element in partialResult + String(element) }

print(test1)
print(test2)
print(test3)
