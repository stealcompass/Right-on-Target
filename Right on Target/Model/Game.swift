//
//  Game.swift
//  Right on Target
//
//  Created by Veniamin on 28.01.2023.
//

import UIKit

protocol GameProtocol{
    var score: Int {get}
    //флаг проверка закончилась ли игра
    var isEnded: Bool {get}
    
    var currentRound: GameRoundProtocol {get} // чтобы иметь возможность вызывать все методы 
    var secretValueGenerator: RandomProtocol! {get}
    
    // функция перезапуска
    func restartGame()
    
    //функция запуска нового раунда
    func startNewRound()
}



class Game: GameProtocol{

    private var lastRound: Int //число раундов
    private var currentRoundNum: Int = 0
    
    var score: Int { //используем компьютед пропертис, чтобы при обращении к score мы получали сумму на основе результатов за игру
        var totalScore = 0
        for i in scoreArr{
            totalScore += i.score
        }
        return totalScore
    }
    var currentRound: GameRoundProtocol
    var secretValueGenerator: RandomProtocol!
    var secretValue: Int
    
    private var scoreArr: [GameRoundProtocol] = []
    
    
    var isEnded: Bool {
        if currentRoundNum >= lastRound {
            return true
        } else {
            return false
        }
    }
    
    init(startValue: Int, endValue: Int, rounds: Int){
        //стартовое значение для выбора случайного числа не может быть больше конечного
        lastRound = rounds
        
        secretValueGenerator = Random(minSecret: startValue, maxSecret: endValue)
        
        secretValue = secretValueGenerator.getNewSecretValue()
        currentRound = Round(currentSecretValue: secretValue)
        startNewRound()
    }
    
    func restartGame(){
        currentRoundNum = 0
        scoreArr = []
        startNewRound()
    }
    
    func startNewRound(){
        secretValue = self.secretValueGenerator.getNewSecretValue()
        currentRound = Round(currentSecretValue: secretValue)
        scoreArr.append(currentRound) // мы сохраняем объект в массив в который в дальнейшем будет добавляться свойство score
        //за счет того, что класс - это ссылка, мы можем в дальнейшем получить значение свойства score для каждого раунда
        
        self.currentRoundNum += 1
    }
    
//    func totalScore(){
//        for i in scoreArr {
//            self.score += i.score
//        }
//    }
    
}
