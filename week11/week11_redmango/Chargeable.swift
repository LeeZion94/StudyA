//
//  Chargeable.swift
//  PopEasyTest
//
//  Created by redmango1446 on 2023/07/24.
//

protocol Chargeabel {
    var maximumWattPerHour: WattPerHour { get }
    
    func convert(chargeableWattPerHour: WattPerHour) -> WattPerHour
}
