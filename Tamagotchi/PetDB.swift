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
    // 나중에 접근 메서드 만들기 -> 프로퍼티는 private로 변경
    private var bossName: String = "대장"
    private var currentPet: Pet?
    
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
    }
    
    func getBossName() -> String {
        return bossName
    }
    
    func setCurrentPet(petType: PetType, waterNum: Int = 0, riceNum: Int = 0) {
        currentPet = Pet(petType: petType, waterNum: waterNum, riceNum: riceNum)
    }
        
    func addFoodAndWater(waterNum: Int = 0, riceNum: Int = 0) {
        guard let currentPet = currentPet else {
            return
        }
        
        setCurrentPet(petType: currentPet.petType, waterNum: currentPet.waterNum + waterNum, riceNum: currentPet.riceNum + riceNum)
    }
    
    func getCurrentPet() -> Pet? {
        return currentPet
    }
    
    func hasCurrentPet() -> Bool {
        if currentPet == nil { return false}
        return true
    }
    
    // TODO: UserDefault 사용
}
