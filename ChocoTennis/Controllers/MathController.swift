//
//  MathController.swift
//  ChocoTennis
//
//  Created by Assan on 18.01.2023.
//
import UIKit


class MathController: UIViewController {
    
    @IBOutlet weak var counterForPlayer1: UILabel!
    @IBOutlet weak var counterForPlayer2: UILabel!
    
    @IBOutlet weak var timer1Label: UILabel!
    @IBOutlet weak var timer2Label: UILabel!
    
    var math: Math?
    
    init(player1: User, player2: User) {
        super.init(nibName: nil, bundle: nil)
        setupMath(player1: player1, player2: player2)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        counterForPlayer1.transform = CGAffineTransform(rotationAngle: .pi)
        timer1Label.transform = CGAffineTransform(rotationAngle: .pi / 2)
        timer2Label.transform = CGAffineTransform(rotationAngle: .pi / -2)
        
        Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(processTimer), userInfo: nil, repeats: true)
    }
    
    @IBAction func counterDidClick(_ sender: UIControl) {
        switch sender.tag {
        case -1:
            math?.point1 += 1
        case 1:
            math?.point2 += 1
        default:
            break
        }

        
        
        // в случае превышение очков больше чем 11, переносимся на главный экран
        if math!.point1 >= 11 || math!.point2 >= 11 {
            math!.completedAt = Date()
            dismiss(animated: true)
            // как идея после завершения матча выводить победителя
        }

        counterForPlayer1.text = String(math!.point1)
        counterForPlayer2.text = String(math!.point2)
        
    }
    
    @objc func processTimer() {
        // это текущее время
        let currentDate = Date()
        // это разница во времени, между текущем и тем что у нас сохранилось
        let diff = currentDate.timeIntervalSince1970 - math!.createdAt.timeIntervalSince1970
        let d = floor(diff * 100) / 100
        timer1Label.text = String(d)
        timer2Label.text = String(d)
        
    }

    func setupMath(player1: User, player2: User) {
        math = Math(
            player1: player1,
            player2: player2,
            point1: 0,
            point2: 0,
            createdAt: Date(),
            completedAt: Date()
        )
    }
}
