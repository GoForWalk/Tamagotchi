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

    func setNavOnProtocol(nav: UINavigationController?, backButtontitle: String, navItem: UINavigationItem)
    func setRootNavOnProtocol(nav: UINavigationController?, navItem: UINavigationItem)
}

extension NavSet {
    func setNavOnProtocol(nav: UINavigationController?, backButtontitle: String, navItem: UINavigationItem) {
        
        guard let nav = nav else { return }
        nav.navigationBar.topItem?.title = backButtontitle
        setRootNavOnProtocol(nav: nav, navItem: navItem)
    }
    
    func setRootNavOnProtocol(nav: UINavigationController?, navItem: UINavigationItem) {

        guard let nav = nav else { return }
        nav.navigationBar.tintColor = UISet.fontColor
        
        let barAppearance = UINavigationBarAppearance()
        barAppearance.backgroundColor = UISet.bgColor
        barAppearance.titleTextAttributes = [.foregroundColor: UISet.fontColor, .font: UIFont.systemFont(ofSize: 15, weight: .semibold)]
        
        let barButtonItemAppearance = UIBarButtonItemAppearance()
        barButtonItemAppearance.normal.titleTextAttributes = [.foregroundColor: UISet.fontColor, .font: UIFont.systemFont(ofSize: 15, weight: .semibold)]
        
        barAppearance.buttonAppearance = barButtonItemAppearance
        
        navItem.scrollEdgeAppearance = barAppearance
        navItem.standardAppearance = barAppearance
    }

}

protocol SetViewController {
    static var identifier: String { get }
    
    func setUI()
}
