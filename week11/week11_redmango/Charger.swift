//
//  Charger.swift
//  PopEasyTest
//
//  Created by redmango1446 on 2023/07/24.
//

struct Charger: Chargeabel, Portable{
    var maximumWattPerHour: WattPerHour
    
    func convert(chargeableWattPerHour: WattPerHour) -> WattPerHour {
        
        if maximumWattPerHour > chargeableWattPerHour {
            return chargeableWattPerHour
        }
        
        return maximumWattPerHour
    }
}
