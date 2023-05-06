//
//  main.swift
//  Week2_Zion
//
//  Created by Hyungmin Lee on 2023/05/06.
//

let yettie = Camper()

for _ in 0...7 {
    let yettieChoice = Int.random(in: 0...5)

    yettie.buy(productNumber: yettieChoice)
}
