//
//  MinionModeViewModel.swift
//  SwiftPractice
//
//  Created by lizhu on 15/11/10.
//  Copyright © 2015年 zhuli. All rights reserved.
//

import UIKit

class MinionModeViewModel: SwitchWithTextCellProtocol {
    var title="Minion Mode"
    var switchOn=true
    func onSwitchTogleOn(on: Bool) {
        if on{
            print("the minions are here to stay")
        }else{
            print("the minions went out to play")
        }
    }
    
    func switchColor() -> UIColor {
        return .yellowColor()
    }
}
