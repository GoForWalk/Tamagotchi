//
//  SelectPetCollectionViewCell.swift
//  Tamagotchi
//
//  Created by sae hun chung on 2022/07/23.
//

import UIKit

class SelectPetCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "SelectPetCollectionViewCell"
    
    @IBOutlet weak var petImageView: UIImageView!
    @IBOutlet weak var petNameLabel: UILabel!
    
    func configureCell() {
        setPetImageUI()
        setPetNameLabel()
    }
    
    func setPetImageUI() {
        petImageView.layer.cornerRadius = petImageView.frame.height/2
        petImageView.layer.borderColor = UISet.fontColor.cgColor
        petImageView.layer.borderWidth = 2
        petImageView.clipsToBounds = true
        petImageView.image = UIImage(named: UISet.noImage)
    }

    func setPetNameLabel() {
        petNameLabel.clipsToBounds = true
        petNameLabel.text = "준비중이에요"
        petNameLabel.textAlignment = .center
        petNameLabel.layer.borderWidth = 1
        petNameLabel.layer.borderColor = UISet.fontColor.cgColor
        petNameLabel.textColor = UISet.fontColor
        petNameLabel.layer.cornerRadius = 8
    }
    
}
