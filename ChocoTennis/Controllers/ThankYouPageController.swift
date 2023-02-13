//
//  ThankYouPageController.swift
//  ChocoTennis
//
//  Created by Assan on 13.02.2023.
//

import UIKit

class ThankYouPageController: UIViewController {
    
    @IBOutlet weak var winMatchCountLabel: UILabel!
    
    
    @IBOutlet weak var scoresLabel: UILabel!
    
    
    @IBOutlet weak var winnerPlayerNameLabel: UILabel!
    
    
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
    
    
    
}
