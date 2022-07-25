//
//  MainPetViewController.swift
//  Tamagotchi
//
//  Created by sae hun chung on 2022/07/24.
//

import UIKit
import IQKeyboardManagerSwift

class MainPetViewController: UIViewController, ImageSet, NameLabelSet, NavSet {

    static let identifier = "MainPetViewController"
    
    var petDB = PetDB.shared
    
    enum FoodType: String {
        case water = "물방울"
        case rice = "밥알"
    }
    
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var lineLabel: UILabel!
    
    @IBOutlet weak var petNameLabel: NameLabel!
    @IBOutlet weak var petEatLabel: UILabel!
    @IBOutlet weak var petTalkLabel: UILabel!
    
    @IBOutlet weak var riceEatTextField: UITextField!
    @IBOutlet weak var waterDrinkTextField: UITextField!
    
    @IBOutlet weak var riceEatButton: UIButton!
    @IBOutlet weak var waterDrinkButton: UIButton!

    @IBOutlet weak var petMainImageView: UIImageView!
    
    @IBOutlet var seperatorViews: [UIView]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    // setUI
    func setUI() {
        mainView.backgroundColor = UISet.bgColor
        setNav(petDB: petDB)
        setNameLabel(nameLabel: petNameLabel)
        setButtons()
        setLabels()
        setTextFields()
        setData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        randomTalk()
        resetData()
    }
    
    func randomTalk() {
        let bossName = petDB.getBossName()
        
        petTalkLabel.text = [
            "\(bossName)님 오늘 깃허브 푸시 하셧어영?",
            "복습을 아직 안하셨다구요? 지금 잠이 오세여? \(bossName)",
            "테이블 뷰 컨트롤러와 뷰 컨트롤러는 어떤 차이가 있을까요?"
        ].randomElement()
    }
    
    func setNav(petDB: PetDB) {
        title = "\(petDB.getBossName())님의 다마고치"
        setRootNavOnProtocol(nav: self.navigationController!, navItem: self.navigationItem)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.circle"), style: .plain, target: self, action: #selector(pushSettingVC))        
    }
    
    func setButtons() {
        
        let buttons = [riceEatButton, waterDrinkButton]
        
        buttons.forEach {
            $0?.titleLabel?.font = UIFont.systemFont(ofSize: UISet.fontSize)
            $0?.setTitleColor(UISet.fontColor, for: .normal)
            $0?.clipsToBounds = true
            $0?.layer.cornerRadius = 8
            // TODO: 다른 패딩 코드 찾아보기...
            $0?.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 6)
            $0?.layer.borderWidth = 1
            $0?.layer.borderColor = UISet.fontColor.cgColor
            $0?.imageView?.tintColor = UISet.fontColor
        }
        
    }
    
    func setLabels() {
        let labels = [petTalkLabel, petEatLabel]
        
        labels.forEach {
            $0?.textColor = UISet.fontColor
            $0?.font = UIFont.systemFont(ofSize: UISet.fontSize, weight: .regular)
            $0?.textAlignment = .center
        }
    }
    
    func setTextFields() {
        let textFields = [riceEatTextField, waterDrinkTextField]
        
        riceEatTextField.placeholder = "밥주세용"
        waterDrinkTextField.placeholder = "물주세용"
        
        textFields.forEach {
            $0?.textColor = UISet.fontColor
            $0?.textAlignment = .center
            $0?.font = UIFont.systemFont(ofSize: UISet.fontSize)
            $0?.borderStyle = .none
            $0?.keyboardType = .numberPad
        }
        
        seperatorViews.forEach {
            $0.backgroundColor = UISet.fontColor
        }
    }
    
    func setData() {
        
        guard let currentPet = petDB.getCurrentPet() else { return }
        petNameLabel.text = "\(currentPet.petType) 다마고치"
        resetData()
    }
    
    func resetData() {
        let currentPet = petDB.getCurrentPet()!
        title = "\(petDB.getBossName())님의 다마고치"

        petEatLabel.text = "Lv\(currentPet.lv) ∙ 밥알 \(currentPet.riceNum)개 ∙ 물방울 \(currentPet.waterNum)개"
        petMainImageView.image = UIImage(named: currentPet.imageName)
    }
    
    @IBAction func viewTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func riceButtonTapped(_ sender: UIButton) {
        addFoodAndWater(textField: riceEatTextField, maxInt: 100, foodType: .rice)
    }
    
    @IBAction func waterButtonTapped(_ sender: UIButton) {
        addFoodAndWater(textField: waterDrinkTextField, maxInt: 50, foodType: .water)
    }
    
    @IBAction func returnKeyboardTapped(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    
    func addWaterNum(addNum: Int) {
        petDB.addFoodAndWater(waterNum: addNum)
        waterDrinkTextField.text = ""
        resetData()
    }
    
    func addRiceNum(addNum: Int) {
        petDB.addFoodAndWater(riceNum: addNum)
        riceEatTextField.text = ""
        resetData()
    }
    
    func addFoodAndWater(textField: UITextField, maxInt: Int, foodType: FoodType) {
                
        guard let addString = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !addString.isEmpty else {
            addFoodAsType(foodType: foodType, addNum: 1, textField: textField)
            textField.resignFirstResponder()
            return
        }
        
        guard let addNum = Int(addString), (0..<maxInt).contains(addNum) else {
            self.view.makeToast("\(foodType.rawValue)은 \(maxInt - 1)을 초과할 수 없습니다.", duration: 2.0, position: .center)
            textField.text = ""
            textField.resignFirstResponder()
            return
        }
        
        textField.resignFirstResponder()
        addFoodAsType(foodType: foodType, addNum: addNum, textField: textField)
    }
    
    func addFoodAsType(foodType: FoodType, addNum: Int, textField: UITextField){
        
        switch foodType {
        case .water:
            petDB.addFoodAndWater(waterNum: addNum)
            randomTalk()
        case .rice:
            petDB.addFoodAndWater(riceNum: addNum)
        }
        resetData()
    }
    
    @objc
    func pushSettingVC() {
        let vc = UIStoryboard(name: UISet.storyboardID, bundle: nil).instantiateViewController(withIdentifier: SettingTableViewController.identifier)
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
