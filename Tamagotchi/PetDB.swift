//
//  PetDB.swift
//  Tamagotchi
//
//  Created by sae hun chung on 2022/07/23.
//

import Foundation

struct PetDB {
    
    var bossName: String
    var currentPet: Pet
    
    var petList: [Pet] = [
        Pet(petType: .따끔따끔),
        Pet(petType: .반짝반짝),
        Pet(petType: .방실방실)
    ]
    
    
    
}
