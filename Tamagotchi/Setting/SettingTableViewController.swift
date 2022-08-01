//
//  SettingTableViewController.swift
//  Tamagotchi
//
//  Created by sae hun chung on 2022/07/24.
//

import UIKit

enum Setting: Int, CaseIterable{
    
    case bossNameSetting
    case petTypeChange
    case dataReset
 
    var mainLabel: String {
        switch self {
        case .bossNameSetting:
            return "내 이름 변경하기"
        case .petTypeChange:
            return "다마고치 변경하기"
        case .dataReset:
            return "데이터 초기화"
        }
    }
    
    var imageName: String {
        switch self {
        case .bossNameSetting:
            return "pencil"
        case .petTypeChange:
            return "moon.fill"
        case .dataReset:
            return "arrow.clockwise"
        }
    }
}


class SettingTableViewController: UITableViewController, NavSet {
    
    let petDB = PetDB.shared
    
    @IBOutlet var bgView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
        
    func setUI() {
        bgView.backgroundColor = UISet.bgColor
        title = "설정"
        setNavOnProtocol(nav: self.navigationController, backButtontitle: " ", navItem: self.navigationItem)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Setting.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier, for: indexPath) as? SettingTableViewCell else { return UITableViewCell() }
        
        cell.configureCell()
        cell.setData(setting: Setting.allCases[indexPath.row])
        
        if indexPath.row == 0 {
            cell.settingDetailLabel.text = petDB.getBossName()
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                
        switch indexPath.row {
        case Setting.bossNameSetting.rawValue:
            popBossNameVC()
        case Setting.petTypeChange.rawValue:
            resetPetType()
        case Setting.dataReset.rawValue:
            resetData()
        default:
            return
        }
    }
    
    func popBossNameVC() {
        
        guard let vc = UIStoryboard(name: UISet.storyboardID, bundle: nil).instantiateViewController(withIdentifier: SetBossNameViewController.identifier) as? SetBossNameViewController else { return }
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func resetPetType() {

        guard let vc = UIStoryboard(name: UISet.storyboardID, bundle: nil).instantiateViewController(withIdentifier: SelectPetCollectionViewController.identifier) as? SelectPetCollectionViewController else { return }
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func resetData() {
        
        let alert = UIAlertController(title: "데이터 초기화", message: "정말 다시 처음부터 시작하실 건가용?", preferredStyle: .alert)
        
        let no = UIAlertAction(title: "아냐!!", style: .default)
        let yes = UIAlertAction(title: "삭제 ㅠㅠ", style: .destructive) { _ in
            self.petDB.resetData()
            self.goToSelectVC()
        }
        
        alert.addAction(no)
        alert.addAction(yes)
        
        present(alert, animated: true)
    }
    
    func goToSelectVC() {
        
        guard let vc = UIStoryboard(name: UISet.storyboardID, bundle: nil).instantiateViewController(withIdentifier: SelectPetCollectionViewController.identifier) as? SelectPetCollectionViewController else { return }
        
        let nav = UINavigationController(rootViewController: vc)
        
        nav.modalPresentationStyle = .fullScreen
        nav.modalTransitionStyle = .crossDissolve
        
        present(nav, animated: true)
        
    }
}
