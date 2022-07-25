//
//  SelectPetCollectionViewCell.swift
//  Tamagotchi
//
//  Created by sae hun chung on 2022/07/23.
//

import UIKit

class SelectPetCollectionViewCell: UICollectionViewCell, NameLabelSet, ImageSet {
        
    static let identifier = "SelectPetCollectionViewCell"
    
    @IBOutlet weak var petImageView: UIImageView!
    @IBOutlet weak var petNameLabel: NameLabel!
        
    func configureCell(pet: Pet? = nil) {
        
        setImageViewToCircle(imageView: petImageView)
        setNameLabel(nameLabel: petNameLabel)

        guard let pet = pet else {
            petImageView.image = UIImage(named: UISet.noImage)
            petNameLabel.text = "준비중이에요"
            return
        }
        
        setPetInfo(pet: pet)
    }
        
    func setPetInfo(pet: Pet) {
        petImageView.image = UIImage(named: pet.presentationImageName)
        petNameLabel.text = "\(pet.petType) 다마고치"
    }
    
}
