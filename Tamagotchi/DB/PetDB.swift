//
//  PetDB.swift
//  Tamagotchi
//
//  Created by sae hun chung on 2022/07/23.
//

import UIKit

class PetDB {
    
    static let shared = PetDB()
    
    private init() {}
    private var bossName: String = "대장"
    private var currentPet: Pet?
    
    private let currentPetID = "currentPet"
    private let bossNameID = "bossName"
    
    private var petList: [Pet] = [
        Pet(petType: .따끔따끔),
        Pet(petType: .반짝반짝),
        Pet(petType: .방실방실)
    ]
    
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
        guard let currentPet = currentPet else {
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
        saveBossNameAtUserDefault(bossName: "대장")
    }
    
    func loadData() {
        bossName = getBossNameFromUserDefaults()
        currentPet = getCurrentPetFromUserDefaults()
    }
    
    func saveCurrentPetAtUserDefault(currentPet: Pet?){
        UserDefaults.standard.set(currentPet?.petDataAsArray, forKey: currentPetID)
    }
    
    func saveBossNameAtUserDefault(bossName: String){
        UserDefaults.standard.set(bossName, forKey: bossNameID)
    }
    
    func getCurrentPetFromUserDefaults() -> Pet? {
        guard let tempArray = UserDefaults.standard.array(forKey: currentPetID) else { return nil }
        
        let rawValue = tempArray[0] as! Int
        
        guard let petType = PetType(rawValue: rawValue) else { return nil }
        
        let waterNum = tempArray[1] as! Int
        let riceNum = tempArray[2] as! Int
        return Pet(petType: petType, waterNum: waterNum, riceNum: riceNum)
    }
    
    func getBossNameFromUserDefaults() -> String {
        return UserDefaults.standard.string(forKey: bossNameID) ?? "대장"
    }
}
