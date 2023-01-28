//
//  Game.swift
//  Right on Target
//
//  Created by Veniamin on 28.01.2023.
//

import UIKit

protocol GameProtocol{
    var score: Int {get}
    var currentSecretValue: Int {get}
    //флаг проверка закончилась ли игра
    var isEnded: Bool {get}
    
    // функция перезапуска
    func restartGame()
    
    //функция запуска нового раунда
    func startNewRound()
    
    //подсчет очков
    func calculateScore(with value: Int)
    
}

class Game: GameProtocol{
    
    var score = 0
    private var minSecretValue: Int
    private var maxSecretValue: Int
    
    var currentSecretValue: Int = 0
    
    private var lastRound: Int //число раундов
    private var currentRound: Int = 1
    
    var isEnded: Bool {
        if currentRound >= lastRound {
            return true
        } else {
            return false
        }
    }
    
    init?(startValue: Int, endValue: Int, rounds: Int){
        //стартовое значение для выбора случайного числа не может быть больше конечного
        guard startValue <= endValue else {
            return nil // поэтому init - опциональный
        }
        minSecretValue = startValue
        maxSecretValue = endValue
        lastRound = rounds
        currentSecretValue = self.getNewSecretValue()
    }
    
    func restartGame(){
        score = 0
        currentSecretValue = 0
        currentRound = 1
        startNewRound()
    }
    
    func startNewRound(){
        currentSecretValue = getNewSecretValue()
        self.currentRound += 1
    }
    
    //метод, который будет вызываться во вью контроллере и куда будет
    //передаваться текущее значения со слайдера
    func calculateScore(with value: Int){
        
        if value > currentSecretValue {
            self.score += 50 - value + currentSecretValue
        } else if value < currentSecretValue {
            self.score += 50 - currentSecretValue + value
        } else {
            self.score += 50
        }
    }
    
    private func getNewSecretValue() -> Int {
        (minSecretValue...maxSecretValue).randomElement()!
    }
}
