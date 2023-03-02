//
//  MathController.swift
//  ChocoTennis
//
//  Created by Assan on 18.01.2023.
//
import UIKit
import CoreData
import SWDataManager


class MathController: UIViewController {
    
    @IBOutlet weak var player1View: PlayerScore!
    @IBOutlet weak var player2View: PlayerScore!
    
    @IBOutlet weak var timer1Label: UILabel!
    @IBOutlet weak var timer2Label: UILabel!
    
    let dataManager = SWDataManager.main
    
    var delegate: MatchDelegate?
    
    var player1: UserMO
    var player2: UserMO
    var point1 = 0
    var point2 = 0
    var createdAt = Date()
        
    init(player1: UserMO, player2: UserMO) {
        self.player1 = player1
        self.player2 = player2
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Match controller")
        player1View.transform = CGAffineTransform(rotationAngle: .pi)
        timer1Label.transform = CGAffineTransform(rotationAngle: .pi / 2)
        timer2Label.transform = CGAffineTransform(rotationAngle: .pi / -2)
        
        
        Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(processTimer), userInfo: nil, repeats: true)
        
        player1View.nameLabel.text = player1.name
        player2View.nameLabel.text = player2.name
    }
    
    @IBAction func counterDidClick(_ sender: UIControl) {
        switch sender.tag {
        case -1:
            point1 += 1
        case 1:
            point2 += 1
        default:
            break
        }

        
        
        // в случае превышение очков больше чем 11, переносимся на главный экран
        if point1 >= 11 || point2 >= 11 {
            let matchMo = dataManager.insert(for: MatchMO.self)
            matchMo.createdAt = createdAt
            matchMo.completedAt = Date()
            let score1 = dataManager.insert(for: ScoreMO.self)
            score1.player = player1
            score1.point = Int16(point1)
            score1.match = matchMo
            let score2 = dataManager.insert(for: ScoreMO.self)
            score2.player = player2
            score2.point = Int16(point2)
            score2.match = matchMo
            dataManager.save()
            delegate?.controllerWillDisappear()
            dismiss(animated: true) { [unowned self] in
                delegate?.controllerDidDisappear(match: matchMo)
            }
        }
        player1View.scoreLabel.text = String(point1)
        player2View.scoreLabel.text = String(point2)
    }
    
    @objc func processTimer() {
        // это текущее время
        let currentDate = Date()
        // это разница во времени, между текущем и тем что у нас сохранилось
        let diff = currentDate.timeIntervalSince1970 - createdAt.timeIntervalSince1970
        let d = Int(diff)
        timer1Label.text = String(d)
        timer2Label.text = String(d)
        
    }

}
