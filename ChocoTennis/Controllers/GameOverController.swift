//
//  ThankYouPageController.swift
//  ChocoTennis
//
//  Created by Assan on 13.02.2023.
//

import UIKit
import SWDataManager

class GameOverController: UIViewController {
    
    @IBOutlet weak var winMatchCountLabel: UILabel!
    
    
    @IBOutlet weak var scoresLabel: UILabel!
    
    
    @IBOutlet weak var winnerPlayerNameLabel: UILabel!
    
    var match: MatchMO
    
    private let dataManager = SWDataManager.main
    
    
    init(match: MatchMO) {
        self.match = match
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let winnerScore = match.scores.max(by: {$0.point < $1.point})!
        let loserScore = match.scores.min(by: {$0.point < $1.point})!
        scoresLabel.text = "\(winnerScore.point):\(loserScore.point)"
        let (winnerWinMatchCount, loserWinMatchCount) = getWinMatchCount(byWinner: winnerScore.player, loser: loserScore.player)
        winMatchCountLabel.text = "\(winnerWinMatchCount) : \(loserWinMatchCount)"
        winnerPlayerNameLabel.text = winnerScore.player.name
    }
    
    @IBAction func didWinPlayersClick(_ sender: UIButton) {
        
        dismiss(animated: true)
        
    }
    
    @IBAction func didNewMatchClick(_ sender: UIButton) {
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
//            mathScene.delegate = self
            present(mathScene, animated: true)
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
  
    }
    
    //  в winner отправляем игрока который выиграл данный матч.
    func getWinMatchCount(byWinner winner: UserMO, loser: UserMO) -> (Int, Int) {
        let predicate = NSPredicate(format: "point = %d AND (player.uuid = %@ OR player.uuid = %@)", 11, winner.uuid as CVarArg, loser.uuid as CVarArg)
       var userScores = dataManager.aggregate(
            for: ScoreMO.self,
            attributes: [
                "player.uuid",
                .count("point", resultType: .decimalAttributeType)
            ],
            where: predicate,
            groupBy: [
                "player.uuid"
            ]
        ) as! [[String: Any]]
        
        var winnerWinMatchCount = 0
        var loserWinMatchCount = 0
 
        if userScores[0]["player.uuid"] as! UUID == winner.uuid {
            winnerWinMatchCount = userScores[0]["count"] as! Int
            loserWinMatchCount = userScores[1]["count"] as! Int
        } else {
            winnerWinMatchCount = userScores[1]["count"] as! Int
            loserWinMatchCount = userScores[0]["count"] as! Int
        }
        return (winnerWinMatchCount, loserWinMatchCount)
    }
    
    
    
    
}
