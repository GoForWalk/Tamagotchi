//
//  UIProtocol.swift
//  Tamagotchi
//
//  Created by sae hun chung on 2022/07/23.
//

import UIKit

protocol ImageSet {
    
    func setImageViewToCircle(imageView: UIImageView)
}

extension ImageSet {
    
    func setImageViewToCircle(imageView: UIImageView) {
        imageView.layer.borderColor = UISet.fontColor.cgColor
    }
}


protocol NameLabelSet {
    
    func setNameLabel(nameLabel: UILabel)
}

extension NameLabelSet {
    
    func setNameLabel(nameLabel: UILabel) {
        nameLabel.clipsToBounds = true
        nameLabel.textAlignment = .center
        nameLabel.layer.borderWidth = 1
        nameLabel.layer.borderColor = UISet.fontColor.cgColor
        nameLabel.textColor = UISet.fontColor
        nameLabel.layer.cornerRadius = 8
        nameLabel.font = UIFont.systemFont(ofSize: UISet.fontSize, weight: .regular)
        
    }
}

protocol NavSet {

    func setNavOnProtocol(nav: UINavigationController, backButtontitle: String)
    func setRootNavOnProtocol(nav: UINavigationController)
}

extension NavSet {
    
    func setNavOnProtocol(nav: UINavigationController, backButtontitle: String) {
        nav.navigationBar.titleTextAttributes = [.foregroundColor: UISet.fontColor, .font: UIFont.systemFont(ofSize: 15, weight: .semibold)]
        nav.navigationBar.topItem?.title = backButtontitle
        nav.navigationBar.tintColor = UISet.fontColor
        
    }
    
    func setRootNavOnProtocol(nav: UINavigationController) {
        nav.navigationBar.titleTextAttributes = [.foregroundColor: UISet.fontColor, .font: UIFont.systemFont(ofSize: 15, weight: .semibold)]
        nav.navigationBar.tintColor = UISet.fontColor
    }

}
