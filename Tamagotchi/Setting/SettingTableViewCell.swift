//
//  SettingTableViewCell.swift
//  Tamagotchi
//
//  Created by sae hun chung on 2022/07/24.
//

import UIKit

class SettingTableViewCell: UITableViewCell {

    static let identifier = "SettingTableViewCell"
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var settingMainLabel: UILabel!
    @IBOutlet weak var settingDetailLabel: UILabel!
    @IBOutlet weak var settingImageView: UIImageView!
    
    func configureCell() {
        settingImageView.tintColor = UISet.fontColor
        settingDetailLabel.textColor = UISet.fontColor
        settingMainLabel.textColor = UIColor.label
        
        self.layer.borderColor = UISet.fontColor.cgColor
        self.layer.borderWidth = 0.1
        backView.backgroundColor = UISet.bgColor
        settingDetailLabel.text = ""

        self.accessoryView?.tintColor = UISet.fontColor
        self.accessoryView?.backgroundColor = UISet.bgColor
        self.backgroundColor = UISet.bgColor
    }
        
    func setData(setting: Setting) {
        settingImageView.image = UIImage(systemName: setting.imageName)
        settingMainLabel.text = setting.mainLabel
    }
}
