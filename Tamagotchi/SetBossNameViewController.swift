//
//  SetBossNameViewController.swift
//  Tamagotchi
//
//  Created by sae hun chung on 2022/07/24.
//

import UIKit

class SetBossNameViewController: UIViewController, NavSet {

    static let identifier = "SetBossNameViewController"
    
    var petDB = PetDB.shared
    
    @IBOutlet weak var bossNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }

    func setUI() {
        self.view.backgroundColor = UISet.bgColor
        setNav()
        setTextField()
        setData()
    }
    
    func setNav() {
        title = "\(petDB.getBossName())님 이름 정하기"
        setNavOnProtocol(nav: self.navigationController!, backButtontitle: "설정")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveBossName))
        
        
    }
    
    func setTextField() {
        bossNameTextField.textColor = UISet.fontColor
        bossNameTextField.borderStyle = .none
        bossNameTextField.backgroundColor = UISet.bgColor
    }
    
    func setData() {
        bossNameTextField.text = petDB.getBossName()
    }
    
    @IBAction func bossNameJustTapped(_ sender: UITextField) {
        bossNameTextField.text = ""
    }
    
    @IBAction func keyboardReturnTapped(_ sender: UITextField) {
        bossNameTextField.resignFirstResponder()
    }
    
    @objc
    func saveBossName() {
        
        guard let newBossName = bossNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !newBossName.isEmpty, newBossName != petDB.getBossName() else {
            // TODO: Toast
            return }
        
        petDB.setBossName(newBossName: newBossName)
    
        navigationController?.popViewController(animated: true)
    }
    
    
}
