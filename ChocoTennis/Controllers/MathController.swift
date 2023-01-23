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
    

    var math: Math?
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
