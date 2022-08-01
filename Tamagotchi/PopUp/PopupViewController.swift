//
//  PopupViewController.swift
//  Tamagotchi
//
//  Created by sae hun chung on 2022/07/23.
//

import UIKit

class PopupViewController: UIViewController, NameLabelSet, ImageSet {
    
    let petDB = PetDB.shared
    
    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var petImageView: UIImageView!
    @IBOutlet weak var petNameLabel: NameLabel!
    @IBOutlet weak var petDetailLabel: UILabel!
    @IBOutlet weak var seperatorView: UIView!
    
    @IBOutlet var popUpButtons: [UIButton]!
    @IBOutlet weak var startButton: UIButton!
    
    var currentPet: Pet?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    func setUI() {
        backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        setPopViewUI()
        setImageViewToCircle(imageView: petImageView)
        setNameLabel(nameLabel: petNameLabel)
        setButtons()
        setDetailLabel()
        setData()
    }
    
    func setPopViewUI() {
        popUpView.clipsToBounds = true
        popUpView.layer.cornerRadius = 8
        popUpView.backgroundColor = UISet.bgColor
        seperatorView.backgroundColor = UISet.fontColor
    }
    
    func setDetailLabel() {
        petDetailLabel.textColor = UISet.fontColor
        petDetailLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        petDetailLabel.textAlignment = .center
    }
    
    func setButtons() {
        popUpButtons.forEach {
            $0.setTitleColor(UISet.fontColor, for: .normal)
            $0.titleLabel?.font = .systemFont(ofSize: 14, weight: .heavy)
            $0.layer.borderColor = UISet.fontColor.cgColor
            $0.layer.borderWidth = 0.2
        }
    }
        
    func setButtonTitle(str: String) {
        startButton.setTitle(str, for: .normal)
    }
    
    func setData() {
        petDB.hasCurrentPet() ? setButtonTitle(str: "변경하기") : setButtonTitle(str: "시작하기")
        
        guard let currentPet = currentPet else {
            return
        }
        
        petImageView.image = UIImage(named: currentPet.presentationImageName)
        petNameLabel.text = "\(currentPet.petType) 다마고치"
        petDetailLabel.text =
        """
        저는 \(currentPet.petType) 다마고치입니당. 키는 100Km
        몸무게는 150톤이에용
        성격은 화끈하고 날라다닙니당~!
        열심히 잘 먹고 잘 클 자신은
        있답니당 \(currentPet.petType)!
        """
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func sideViewTapped(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true)
    }
    
    @IBAction func startButtonTapped(_ sender: UIButton) {

        // iOS13+ SceneDelegate를 쓸 때 동작하는 코드
        // 앱을 처음 실행하는 것 처럼 동작하게 한다.
        // SceneDelegate 밖에서 window에 접근하는 방법
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        // 생명주기 담당
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        
        guard let vc = UIStoryboard(name: UISet.storyboardID, bundle: nil).instantiateViewController(withIdentifier: MainPetViewController.identifier) as? MainPetViewController, let currentPet = currentPet else { return }
        
        petDB.setCurrentPet(petType: currentPet.petType, waterNum: currentPet.waterNum, riceNum: currentPet.riceNum)
        
        let nav = UINavigationController(rootViewController: vc)
        
        // window에 접근
        sceneDelegate?.window?.rootViewController = nav
        sceneDelegate?.window?.makeKeyAndVisible()
    }
    
    
}
