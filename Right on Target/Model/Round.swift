//
//  Round.swift
//  Right on Target
//
//  Created by Veniamin on 28.01.2023.
//

import UIKit

protocol GameRoundProtocol{
    var score: Int {get}
    var currentSecretValue: Int {get}
    func calculateScore(with value: Int)
}

class Round: GameRoundProtocol{
    
    var score: Int = 0
    var currentSecretValue: Int
    
    init(currentSecretValue: Int){
        self.currentSecretValue = currentSecretValue
    }
    
    //метод, который будет вызываться во вью контроллере и куда будет
    //передаваться текущее значения со слайдера
    func calculateScore(with value: Int){
        if value > self.currentSecretValue {
            self.score += 50 - value + self.currentSecretValue
        } else if value < self.currentSecretValue {
            self.score += 50 - self.currentSecretValue + value
        } else {
            self.score += 50
        }
    }
    
}
