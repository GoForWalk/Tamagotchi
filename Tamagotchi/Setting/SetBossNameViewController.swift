//
//  SetBossNameViewController.swift
//  Tamagotchi
//
//  Created by sae hun chung on 2022/07/24.
//

import UIKit

class SetBossNameViewController: UIViewController, NavSet, SetViewController {

    static let identifier = "SetBossNameViewController"
    
    var petDB = PetDB.shared
    
    @IBOutlet weak var bossNameTextField: UITextField!
    @IBOutlet weak var seperatorView: UIView!
    
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
        setNavOnProtocol(nav: self.navigationController!, backButtontitle: "설정", navItem: self.navigationItem)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveBossName))
    }
    
    func setTextField() {
        bossNameTextField.textColor = UISet.fontColor
        bossNameTextField.borderStyle = .none
        bossNameTextField.backgroundColor = UISet.bgColor
        
        seperatorView.backgroundColor = UISet.fontColor
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
                self.view.makeToast("이름을 다시 입력해주세요!", position: .center)
            return }
        
        petDB.setBossName(newBossName: newBossName)
        
        let navViewControllers = navigationController!.viewControllers
                
        guard let rootVC = navViewControllers[navViewControllers.count - 2] as? SettingTableViewController else { return }
        
        rootVC.tableView.reloadData()
        
        navigationController?.popViewController(animated: true)
    }
    
    
}
