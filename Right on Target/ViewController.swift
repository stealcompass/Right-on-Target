//
//  ViewController.swift
//  Right on Target
//
//  Created by Veniamin on 28.01.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var slider: UISlider!
    @IBOutlet var label: UILabel!

    var game = Game(startValue: 1, endValue: 50, rounds: 5)
    
    // MARK: Жизненный цикл ViewController (текущей сцены)
    override func loadView() {
        //в данном методе производится загрузка всех размещенных на сцене графических элементов
        //в нашем случае элементы - это наши аутлеты слайдер, лейбл, кнопка
        //этот метод вызывается только один раз за всю жизнь сцены
        
        super.loadView() // этот вызов необходим так как в нем содержится множество скрытых от разраб действий,
        //которые необходимы для выполнения жизненного цикла ViewController
        print("loadView")
        
        //метод loadView отлично подходит для создания дополнительный графических элементов
        let versionLabel = UILabel(frame: CGRect(x: 20, y: 10, width: 200, height: 20))
        versionLabel.text = "Версия 1.1"
        self.view.addSubview(versionLabel)
        
        //Если написать код создания метки до вызова super.loadView(), приложение экстренно завершит работу
        //уже в процессе загрузки. Это произойдет по причине того, что корневой view сцены еще не загружен,
        //и обращение к свойству self.view приводит к ошибке, так как до момента вызова
        //super.loadView() свойство self.view соответствует nil, т.е. в нем нет значения.
    }
    
    
    override func viewDidLoad() {
        //метод viewDidLoad срабатывает когда все View из которых состоит сцена уже загружены
        //и готовы к выводу на экран
        //с помошью viewDidLoad удается внести в графические элементы финальные корректировки перед их отображением
        // он вызывается только один раз за всю жизнь сцены
        
        super.viewDidLoad()
        print("viewDidLoad")
        // Do any additional setup after loading the view.
        game?.startNewRound()
        self.label.text = String(game?.currentSecretValue ?? 0)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        //вызывается перед тем, как графические элементы сцены будут добавлены в иерархию
        //графических элементов
        //этот метод вызывается каждый раз, когда сцена добавляется в иерархию
        
        super.viewWillAppear(animated)
        print("viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //вызывается после того, как графические элементы сцены были добавлены в иерархию
        //В данном методе вы можете произвести действия, которые должны быть выполнены уже после
        //отображения элементов на экране (например, запустить анимацию на сцене или синхронизировать
        //данные с сервером)
        super.viewDidAppear(animated)
        print("viewDidAppear")
    }
    
    
    //Методы ниже вызываются до и после удаления элементов сцены из иерархии View
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("viewWillDisappear")
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("viewDidDisappear")
    }
    

    // MARK: Взаимодействие с моделью
    @IBAction func checkNumber(){
        let numSlider = Int(self.slider.value)
        
        game?.calculateScore(with: numSlider)
        
        if game?.isEnded == true {
            
            guard let score = game?.score else {return}
            let alert = UIAlertController(title: "Игра окончена", message: "Вы заработали \(score)  очков", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Начать заново", style: .default))
            self.present(alert, animated: true)

            game?.restartGame()
        }

        game?.startNewRound()
        self.label.text = String(game?.currentSecretValue ?? 0)
    }
    
}

