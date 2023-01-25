//
//  MainController.swift
//  ChocoTennis
//
//  Created by Assan on 18.01.2023.
//
import UIKit
import CoreData

class MainController: UIViewController {
    let player1 = User(name: "Mirsaid")
    let player2 = User(name: "Assan")
    static let isFirstLaunch = "isFirstLaunch"
    lazy var container: NSPersistentContainer = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        print("Main Controller Loaded")
        let request = NSFetchRequest<UserMO>(entityName: "User")
        request.predicate = NSPredicate(format: "name == %@", "Assan")
        let users = try! container.viewContext.fetch(request)
        print(users.count)
        for user in users {
            print(user.name)
        }
    }
    
    @IBAction func goDidClick(_ sender: UIButton) {
        let mathScene = MathController(player1: player1, player2: player2)
        mathScene.modalPresentationStyle = .fullScreen
        present(mathScene, animated: true)
    }
    
}

extension MainController {
    
    func loadData() {
        if !UserDefaults.standard.bool(forKey: MainController.isFirstLaunch) {
            sowUser()
            UserDefaults.standard.set(true, forKey: MainController.isFirstLaunch)
        }
    }
    
    func sowUser() {
        let userNames = ["Assan", "Mirsaid"]
        let context = container.viewContext
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        for userName in userNames {
            let userMo = NSEntityDescription.insertNewObject(forEntityName: "User", into: context) as! UserMO
            userMo.name = userName
            
        }
        try! context.save()
    }
}
