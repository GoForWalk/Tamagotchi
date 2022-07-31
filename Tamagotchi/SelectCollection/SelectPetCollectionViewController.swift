//
//  SelectPetCollectionViewController.swift
//  Tamagotchi
//
//  Created by sae hun chung on 2022/07/23.
//

import UIKit
import Toast

class SelectPetCollectionViewController: UICollectionViewController, NavSet, SetViewController {

    static let identifier = "SelectPetCollectionViewController"
    
    var petDB = PetDB.shared
        
    @IBOutlet var bgView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    func setUI() {
        collectionView.collectionViewLayout = setCellSize()
        setRootNavOnProtocol(nav: self.navigationController!, navItem: self.navigationItem)
        setNav()
        bgView.backgroundColor = UISet.bgColor
    }

    
    func setNav() {
        petDB.hasCurrentPet() ? setTitle(str: "다마고치 변경하기") : setTitle(str: "다마고치 선택하기")
    }
    
    func setTitle(str: String) {
        title = str
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectPetCollectionViewCell.identifier, for: indexPath) as? SelectPetCollectionViewCell else { return UICollectionViewCell() }
                
        if(0...petDB.getPetList().count - 1).contains(indexPath.row) {
            
            let currentPet: Pet? = petDB.getPetList()[indexPath.row]
            cell.configureCell(pet: currentPet)
            
        } else {
            cell.configureCell()
        }
        
        return cell
    }
    
    func setCellSize() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        
        let spacing: CGFloat = 14
        let numOfCell: CGFloat = 3
        let numOfSpace: CGFloat = numOfCell + 1
        
        let width = (UIScreen.main.bounds.width - (spacing * numOfSpace)) / numOfCell
        
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.itemSize = CGSize(width: width, height: width * 1.3)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        
        return layout
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let vc = UIStoryboard(name: "Tamagotchi", bundle: nil).instantiateViewController(withIdentifier: PopupViewController.identifier)
                as? PopupViewController else { return }
        
        if !(0...petDB.getPetList().count - 1).contains(indexPath.row) {            
            self.view.makeToast("아직 준비중인 다마고치입니다.", position: .center)
            return
        }
        
        if !petDB.hasCurrentPet() {
            vc.currentPet = petDB.getPetList()[indexPath.row]
            
        } else {
            guard let tempPet = petDB.getCurrentPet() else { return }
            
            petDB.setCurrentPet(petType: petDB.getPetList()[indexPath.row].petType, waterNum: tempPet.waterNum, riceNum: tempPet.riceNum)
            
            vc.currentPet = petDB.getCurrentPet()
            
        }
        
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true)
        
    }
}
