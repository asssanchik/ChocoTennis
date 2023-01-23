//
//  MainController.swift
//  ChocoTennis
//
//  Created by Assan on 18.01.2023.
//
import UIKit

class MainController: UIViewController {
    let player1 = User(name: "Mirsaid")
    let player2 = User(name: "Assan")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Main Controller Loaded")
    }
    
    @IBAction func goDidClick(_ sender: UIButton) {
        let mathScene = MathController()
        mathScene.modalPresentationStyle = .fullScreen
        present(mathScene, animated: true)
        
    }
}

