//
//  SwitchWithTextTableViewCell.swift
//  SwiftPractice
//
//  Created by lizhu on 15/11/10.
//  Copyright © 2015年 zhuli. All rights reserved.
//

import UIKit

protocol SwitchWithTextCellProtocol{
    var title:String{get}
    var switchOn:Bool{get}
    
    func onSwitchTogleOn(on:Bool)
}

extension SwitchWithTextCellProtocol{
    func switchColor()->UIColor{
        return .purpleColor()
    }
}

class SwitchWithTextTableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var swich: UISwitch!
    
    var delegate:SwitchWithTextCellProtocol?

    typealias onSwichToggleHandlerType=(switchOn:Bool)->Void
    var onSwichToggleHanderler:onSwichToggleHandlerType?

    //MARK: - life cycles
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(withTitle title:String,swichOn:Bool,swichColor:UIColor = UIColor.purpleColor(),onSwichToggleHanderler:onSwichToggleHandlerType?=nil){
        label.text=title
        swich.on=swichOn
        self.onSwichToggleHanderler=onSwichToggleHanderler
    }
    
    func configure(withDelegate delegate:SwitchWithTextCellProtocol){
        self.delegate=delegate;
        label.text=delegate.title
        swich.on=delegate.switchOn
        
        swich.onTintColor=delegate.switchColor()
    }
    
    //MARK: - envent response
    @IBAction func onSwitchToggle(sender: UISwitch) {
//        onSwichToggleHanderler?(switchOn:sender.on)
        delegate?.onSwitchTogleOn(sender.on)
    }
}
