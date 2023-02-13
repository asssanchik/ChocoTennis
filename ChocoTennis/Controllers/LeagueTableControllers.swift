//
//  LeagueTableControllers.swift
//  ChocoTennis
//
//  Created by Assan on 18.01.2023.
//
import UIKit
import CoreData
import SWDataManager

struct UserScore {
    var name: String
    var uuid: UUID
    var score: Int16
    var winMatchCount: Int
    
}

class LeagueTableControllers: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    static let isFirstLaunch = "isFirstLaunch"
    let dataManager = SWDataManager.main
    var userScores = [UserScore]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        let nib = UINib(nibName: "PlayerRatingCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "PlayerRatingCell")
        let nib2 = UINib(nibName: "PlayerRatingHeaderView", bundle: nil)
        tableView.register(nib2, forHeaderFooterViewReuseIdentifier: "PlayerRatingHeaderView")
        tableView.tableHeaderView = nib2.instantiate(withOwner: nil)[0] as! UIView
        tableView.dataSource = self
        print("Main Controller Loaded")
         updateTableView()
    }
    
    @IBAction func goDidClick(_ sender: UIButton) {
//        let alert = UIAlertController(title: "Напишите имена игроков!", message: nil, preferredStyle: .alert)
//        alert.addTextField { textField in
//            textField.placeholder = "Игрок 1"
//            
//        }
//        alert.addTextField { textField in
//            textField.placeholder = "Игрок 2"
//        }
//        alert.addAction(UIAlertAction(title: "OK", style: .default) { [unowned self] _ in
//            let playerName1 = alert.textFields![0].text ?? ""
//            let playerName2 = alert.textFields![1].text ?? ""
//            let player1 = getOrCreateUser(byName: playerName1)
//            let player2 = getOrCreateUser(byName: playerName2)
//            let mathScene = MathController(player1: player1, player2: player2)
//            mathScene.modalPresentationStyle = .fullScreen
//            mathScene.delegate = self
//            present(mathScene, animated: true)
//        })
//        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        // вызов другого контроллера
        let thankYouPageScene = ThankYouPageController()
        thankYouPageScene.modalPresentationStyle = .fullScreen
        present(thankYouPageScene, animated: true)
        
        
//        present(alert, animated: true)
        
    }
    
}

extension LeagueTableControllers {
    
    func loadData() {
        if !UserDefaults.standard.bool(forKey: LeagueTableControllers.isFirstLaunch) {
            sowUser()
            UserDefaults.standard.set(true, forKey: LeagueTableControllers.isFirstLaunch)
        }
    }
    
    func sowUser() {
        let userNames = ["Assan", "Mirsaid"]
        for userName in userNames {
            let userMo = dataManager.insert(for: UserMO.self)
            userMo.uuid = UUID()
            userMo.name = userName
            
        }
         dataManager.save()
    }
   
    
    func updateTableView() {
        var userScores = dataManager.aggregate(
            for: ScoreMO.self,
            attributes: [
                "player.uuid",
                "player.name",
                .sum("point", resultType: .decimalAttributeType)
            ],
            groupBy: [
                "player.uuid",
                "player.name"
            ]
        ) as! [[String: Any]]
        
        for userScore in userScores {
            let predicate = NSPredicate(format: "player.uuid == %@ AND point == %d", userScore["player.uuid"] as! CVarArg, 11)
            let result = dataManager.aggregate(
                for: ScoreMO.self,
                attributes: [
                    .count("point", nameAs: "winMatchCount", resultType: .decimalAttributeType)
                ],
                predicate: predicate,
                groupBy: [
                    "player.uuid"
                ]
            ) as! [[String: Any]]
            
            let winMatchCount = result.first?["winMatchCount"] ?? 0
            self.userScores.append(UserScore(
                name: userScore["player.name"] as! String,
                uuid: userScore["player.uuid"] as! UUID,
                score: userScore["sum"] as! Int16,
                winMatchCount: winMatchCount as! Int
            ))
            
        }
        
        self.userScores.sort {
            return $0.winMatchCount > $1.winMatchCount || $0.score > $1.score
        
        }
    }
}

extension LeagueTableControllers: MatchDelegate {
    func finished() {
        userScores.removeAll()
        updateTableView()
        tableView.reloadData()
    }
}

extension LeagueTableControllers: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userScores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let userScore = userScores[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerRatingCell", for: indexPath) as! PlayerRatingCell
        cell.nameLabel.text = userScore.name
        cell.matchCountLabel.text = String(userScore.winMatchCount)
        cell.pointLabel.text = String(userScore.score)
        return cell
    }
    
    
}
