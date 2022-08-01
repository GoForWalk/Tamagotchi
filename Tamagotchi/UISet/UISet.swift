//
//  UISet.swift
//  Tamagotchi
//
//  Created by sae hun chung on 2022/07/23.
//

import UIKit

enum UISet {
    static let bgColor: UIColor = UIColor(red: 245/255, green: 252/255, blue: 252/255, alpha: 1)
    static let fontColor: UIColor = UIColor(red: 77/255, green: 106/255, blue: 120/255, alpha: 1)
    static let fontSize: CGFloat = 13
    static let noImage: String = "noImage"
    static let bubbleImage: String = "bubble"
    
    static var storyboardID: String { return "Tamagotchi" }
    
}

final class NameLabel: UILabel {
    
    @IBInspectable var topInset: CGFloat = 2.0
    @IBInspectable var bottomInset: CGFloat = 2.0
    @IBInspectable var leftInset: CGFloat = 4.0
    @IBInspectable var rightInset: CGFloat = 4.0
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
     override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset, height: size.height + topInset + bottomInset)
    }
    
}

