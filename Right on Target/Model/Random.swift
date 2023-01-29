//
//  Random.swift
//  Right on Target
//
//  Created by Veniamin on 28.01.2023.
//

import UIKit

protocol RandomProtocol{
    func getNewSecretValue() -> Int
}

class Random: RandomProtocol{
    private var minSecretValue: Int
    private var maxSecretValue: Int
    
    init?(minSecret: Int, maxSecret: Int){
        guard minSecret <= maxSecret else {
            return nil // поэтому init - опциональный
        }
        
        minSecretValue = minSecret
        maxSecretValue = maxSecret
    }
    
    func getNewSecretValue() -> Int {
        //return 50 - для проверки
        (minSecretValue...maxSecretValue).randomElement()!
    }
}
