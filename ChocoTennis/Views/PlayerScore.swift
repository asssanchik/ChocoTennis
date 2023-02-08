//
//  PlayerScore.swift
//  ChocoTennis
//
//  Created by Assan on 08.02.2023.
//

import UIKit

class PlayerScore: UIView {
    
    @IBOutlet  weak var contentView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        initSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
    }
    
    func initSubviews() {
        let nib = UINib(nibName: "PlayerScore", bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        contentView.frame = bounds
        addSubview(contentView)
        
    }
    
}
