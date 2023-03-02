//
//  MainController.swift
//  ChocoTennis
//
//  Created by Assan on 13.02.2023.
//

import UIKit
import SWDataManager
import CoreData

class MainController: UIViewController {
    
    let dataManager = SWDataManager.main
    
    @IBOutlet weak var dayLabel: UILabel!
    
    
    @IBOutlet weak var weekLabel: UILabel!
    
    
    @IBOutlet weak var monthLabel: UILabel!
    
    
    @IBOutlet weak var allTimeLabel: UILabel!
    func getBestPlayerName(from: NSDate? = nil, to: NSDate? = nil) -> String {
        var predicate = NSPredicate(format: "point = %d", 11)
        if let from = from, let to = to {
            predicate = NSPredicate(format: "point = %d && match.completedAt >= %@ && match.completedAt < %@", 11, from, to)
        }
        
       var userScores = dataManager.aggregate(
        
            for: ScoreMO.self,
            attributes: [
                "player.uuid",
                "player.name",
                .count("point", resultType: .decimalAttributeType)
            ],
            predicate: predicate,
            groupBy: [
                "player.uuid",
                "player.name"
            ]
        ) as! [[String: Any]]
        
        
        userScores.sort {
            return $0["count"] as! Int > $1["count"] as! Int
        }
        print(userScores)
        
        return userScores.first?["player.name"] as! String ?? "-"
    }
    
    @IBAction func rulesDidClick(_ sender: UIButton) {
        let gameRuleScene = GameRuleController()
        navigationController?.pushViewController(gameRuleScene, animated: true)
    }
    
    @IBAction func leagueTableDidClick(_ sender: UIButton) {
        let tableScene = LeagueTableController()
        navigationController?.pushViewController(tableScene, animated: true)
    }
    
    
    @IBAction func matchDidClick(_ sender: UIButton) {
                let alert = UIAlertController(title: "Напишите имена игроков!", message: nil, preferredStyle: .alert)
                alert.addTextField { textField in
                    textField.placeholder = "Игрок 1"
        
                }
                alert.addTextField { textField in
                    textField.placeholder = "Игрок 2"
                }
                alert.addAction(UIAlertAction(title: "OK", style: .default) { [unowned self] _ in
                    let playerName1 = alert.textFields![0].text ?? ""
                    let playerName2 = alert.textFields![1].text ?? ""
                    let player1 = UserRepository.getOrCreateUser(byName: playerName1)
                    let player2 = UserRepository.getOrCreateUser(byName: playerName2)
                    let mathScene = MathController(player1: player1, player2: player2)
                    mathScene.modalPresentationStyle = .fullScreen
//                    mathScene.delegate = self
                    present(mathScene, animated: true)
                })
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
                   present(alert, animated: true)
    }
    
    
    func setupNavigationBar() {
        guard let navigationController = navigationController else { return }
        navigationItem.backButtonTitle = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        allTimeLabel.text = getBestPlayerName()

    }
 
}


