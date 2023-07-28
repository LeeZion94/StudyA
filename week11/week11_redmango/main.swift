//
//  main.swift
//  PopEasyTest
//
//  Created by redmango1446 on 2023/07/24.
//

typealias WattPerHour = Int
typealias Watt = Int

let 애플워치충전기: Charger = Charger(maximumWattPerHour: 5)
let 아이폰고속충전기: Charger = Charger(maximumWattPerHour: 18)
let 아이패드충전기: Charger = Charger(maximumWattPerHour: 30)
let 맥북충전기: Charger = Charger(maximumWattPerHour: 96)
let 고속맥북충전기: Charger = Charger(maximumWattPerHour: 106)

var macBook = MacBook()

macBook.chargerBattery(charger: 아이폰고속충전기)


protocol Portable {}

struct Bag {
    private var items: [Portable] = []
    
    mutating func put(item: Portable) {
        items.append(item)
    }
}

var 구찌백 = Bag()
//이게 다 들어가는게 맞나...?
구찌백.put(item: macBook)
구찌백.put(item: 애플워치충전기)
구찌백.put(item: 아이폰고속충전기)
구찌백.put(item: 아이패드충전기)
구찌백.put(item: 맥북충전기)
구찌백.put(item: 고속맥북충전기)




