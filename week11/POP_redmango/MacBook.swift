//
//  MacBook.swift
//  PopEasyTest
//
//  Created by redmango1446 on 2023/07/24.
//

struct MacBook: Portable {
    private let 기기허용충전와트시: Watt = 20
    private let 현재저장된배터리용량 : Watt = 20
    private let 최대배터리용량: Watt = 100

    mutating func chargerBattery(charger: Chargeabel) {
        let 필요한배터리량 = 최대배터리용량 - 현재저장된배터리용량
        let 충전되는배터리량 = charger.convert(chargeableWattPerHour: 기기허용충전와트시)
        let 완충까지걸린시간 = 필요한배터리량/충전되는배터리량
        print("완충까지 걸린 시간: \(완충까지걸린시간)시간")
    }
}
