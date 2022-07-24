//
//  SelectPetCollectionViewController.swift
//  Tamagotchi
//
//  Created by sae hun chung on 2022/07/23.
//

import UIKit
import Toast

class SelectPetCollectionViewController: UICollectionViewController, NavSet {

    @IBOutlet var bgView: UICollectionView!
    
    var petDB = PetDB.shared
        
    static let identifier = "SelectPetCollectionViewController"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCellSize()
        setRootNavOnProtocol(nav: self.navigationController!)
        setNav()
        petDB.loadData()
        bgView.backgroundColor = UISet.bgColor
    }
    
    func setNav() {
        print(petDB.hasCurrentPet())
        petDB.hasCurrentPet() ? setTitle(str: "다마고치 변경하기") : setTitle(str: "다마고치 선택하기")
        
        let barAppearance = UINavigationBarAppearance()
        barAppearance.backgroundColor = UISet.bgColor
        navigationItem.scrollEdgeAppearance = barAppearance
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
    
    func setCellSize() {
        let layout = UICollectionViewFlowLayout()
        
        let spacing: CGFloat = 16
        let numOfCell: CGFloat = 3
        let numOfSpace: CGFloat = numOfCell + 1
        
        let width = (UIScreen.main.bounds.width - (spacing * numOfSpace)) / numOfCell
        
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.itemSize = CGSize(width: width, height: width * 1.3)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        
        collectionView.collectionViewLayout = layout
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let vc = UIStoryboard(name: "Tamagotchi", bundle: nil).instantiateViewController(withIdentifier: PopupViewController.identifier)
                as? PopupViewController else { return }
        
        if !(0...petDB.getPetList().count - 1).contains(indexPath.row) {
            // 토스트: 아직 준비중인 다마고치입니다.
            
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
