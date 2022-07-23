//
//  Pet.swift
//  Tamagotchi
//
//  Created by sae hun chung on 2022/07/23.
//

import Foundation

enum PetType: Int{
    case 따끔따끔 = 1
    case 방실방실
    case 반짝반짝
    
}

struct Pet {
    
    var petType: PetType
    var waterNum: Int = 0
    var riceNum: Int = 0
    var calLevel: Int {
        return (waterNum / 5) + (waterNum / 2)
    }
    
    var lv: Int {
        if (0..<10).contains(calLevel) { return 1 }
        else if calLevel >= 100 { return 10 }
        else {return calLevel % 10 }
    }
    
    var imageName: String {
        return "\(petType.rawValue)-\(lv == 10 ? lv - 1 : lv)"
    }
    
    var presentationImageName: String {
        return "\(petType.rawValue)-6"
    }
    
    var talk: [String] = [
        
    ]
}
