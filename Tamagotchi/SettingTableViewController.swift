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
    
    var petDB = PetDB.shared
    
    @IBOutlet var bgView: UITableView!
    
    static let identifier = "SettingTableViewController"

    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function, Self.identifier)
        setUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    func setUI() {
        bgView.backgroundColor = UISet.bgColor
        title = "설정"
        setNavOnProtocol(nav: self.navigationController!, backButtontitle: " ")
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
        case 0:
            popBossNameVC()
        case 1:
            resetPetType()
        case 2:
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
        
    }
    
    
}