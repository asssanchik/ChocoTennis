//
//  MatchDelegate.swift
//  ChocoTennis
//
//  Created by Assan on 08.02.2023.
//

import Foundation

protocol MatchDelegate: NSObjectProtocol {
    func controllerWillDisappear()
    func controllerDidDisappear(match: MatchMO)
}
