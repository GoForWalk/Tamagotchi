//
//  PetDB.swift
//  Tamagotchi
//
//  Created by sae hun chung on 2022/07/23.
//

import UIKit

final class PetDB {
    
    static let shared = PetDB()
    
    private var bossName: String = "대장"
    private var currentPet: Pet?
    
    private let defaultUserName: String = "대장"
    
    let userDefualts = UserDefaults.standard
    
    // Read-Only Computed Property
    private var currentPetID: String { return "currentPet" }
    private var bossNameID: String { return "bossName" }
    
    private var petList: [Pet] { return [
        Pet(petType: .따끔따끔),
        Pet(petType: .반짝반짝),
        Pet(petType: .방실방실)
    ] }
    
    private init() {}
    
    // methods
    func getPetList() -> [Pet] {
        return petList
    }
    
    func setBossName(newBossName: String) {
        bossName = newBossName
        saveBossNameAtUserDefault(bossName: newBossName)
    }
    
    func getBossName() -> String {
        self.bossName = getBossNameFromUserDefaults()
        return bossName
    }
    
    func setCurrentPet(petType: PetType, waterNum: Int = 0, riceNum: Int = 0) {
        currentPet = Pet(petType: petType, waterNum: waterNum, riceNum: riceNum)
        saveCurrentPetAtUserDefault(currentPet: currentPet)
    }
        
    func addFoodAndWater(waterNum: Int = 0, riceNum: Int = 0) {
        guard let currentPet = getCurrentPet() else {
            return
        }
        
        setCurrentPet(petType: currentPet.petType, waterNum: currentPet.waterNum + waterNum, riceNum: currentPet.riceNum + riceNum)
    }
    
    func getCurrentPet() -> Pet? {
        currentPet = getCurrentPetFromUserDefaults()
        return currentPet
    }
    
    func hasCurrentPet() -> Bool {
        if currentPet == nil { return false }
        return true
    }
    
    func resetData() {
        currentPet = nil
        saveCurrentPetAtUserDefault(currentPet: nil)
        saveBossNameAtUserDefault(bossName: defaultUserName)
    }
    
    func loadData() {
        bossName = getBossNameFromUserDefaults()
        currentPet = getCurrentPetFromUserDefaults()
    }
    
    func saveCurrentPetAtUserDefault(currentPet: Pet?){
        userDefualts.set(currentPet?.petDataAsArray, forKey: currentPetID)
    }
    
    func saveBossNameAtUserDefault(bossName: String){
        userDefualts.set(bossName, forKey: bossNameID)
    }
    
    func getCurrentPetFromUserDefaults() -> Pet? {
        guard let tempArray = userDefualts.array(forKey: currentPetID) else { return nil }
        
        let rawValue = tempArray[0] as! Int
        
        guard let petType = PetType(rawValue: rawValue) else { return nil }
        
        let waterNum = tempArray[1] as! Int
        let riceNum = tempArray[2] as! Int
        return Pet(petType: petType, waterNum: waterNum, riceNum: riceNum)
    }
    
    func getBossNameFromUserDefaults() -> String {
        return userDefualts.string(forKey: bossNameID) ?? defaultUserName
    }
}
