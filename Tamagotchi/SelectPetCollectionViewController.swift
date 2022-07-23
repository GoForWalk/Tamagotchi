//
//  SelectPetCollectionViewController.swift
//  Tamagotchi
//
//  Created by sae hun chung on 2022/07/23.
//

import UIKit

class SelectPetCollectionViewController: UICollectionViewController {

    static let identifier = "SelectPetCollectionViewController"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectPetCollectionViewCell.identifier, for: indexPath) as? SelectPetCollectionViewCell else { return UICollectionViewCell() }
        
        cell.configureCell()
        
        return cell
    }
    
    func setCellSize() {
        let layout = UICollectionViewFlowLayout()
        
        let spacing: CGFloat = 8
        let numOfCell: CGFloat = 3
        let numOfSpace: CGFloat = numOfCell + 1
        
        let width = (UIScreen.main.bounds.width) - (spacing * numOfSpace) / numOfCell
        
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.itemSize = CGSize(width: width, height: width * 1.2)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        collectionView.collectionViewLayout = layout
    }
}
