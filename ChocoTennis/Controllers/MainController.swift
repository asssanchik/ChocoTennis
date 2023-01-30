//
//  MainController.swift
//  ChocoTennis
//
//  Created by Assan on 18.01.2023.
//
import UIKit
import CoreData

class MainController: UIViewController {
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
        let users = try! container.viewContext.fetch(request)
        for user in users {
            print(user.name)
        }
        
        let requestForMatch = NSFetchRequest<MatchMO>(entityName: "Match")
        let matches = try! container.viewContext.fetch(requestForMatch)
        for match in matches {
            let player1 = getUser(byUUID: match.playerUUID1)
            let player2 = getUser(byUUID: match.playerUUID2)
            print(player1.name, match.point1)
            print(player2.name, match.point2)
        }
    }
    
    @IBAction func goDidClick(_ sender: UIButton) {
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
            let player1 = getOrCreateUser(byName: playerName1)
            let player2 = getOrCreateUser(byName: playerName2)
            let mathScene = MathController(player1: player1, player2: player2)
            mathScene.modalPresentationStyle = .fullScreen
            present(mathScene, animated: true)
        })
        
        // вызов другого контроллера
        present(alert, animated: true)
        
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
            userMo.uuid = UUID()
            userMo.name = userName
            
        }
        try! context.save()
    }
    func getUser(byUUID uuid: UUID) -> UserMO {
        let request = NSFetchRequest<UserMO>(entityName: "User")
        request.predicate = NSPredicate(format: "uuid = %@", uuid as CVarArg)
       return try! container.viewContext.fetch(request).first!
    }
    //
    func getOrCreateUser(byName name: String) -> UserMO {
        let request = NSFetchRequest<UserMO>(entityName: "User")
        request.predicate = NSPredicate(format: "name = %@", name)
        var  user = try! container.viewContext.fetch(request).first
        if let user = user {
            return user
        }
        let context = container.viewContext
        user = NSEntityDescription.insertNewObject(forEntityName: "User", into: context) as? UserMO
        user?.uuid = UUID()
        user?.name = name
        try! context.save()
        return user!
    }
}
