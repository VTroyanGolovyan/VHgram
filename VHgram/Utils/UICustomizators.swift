//
//  UICustomizators.swift
//  VHgram
//
//  Created by Владислав on 24.04.2022.
//

import Foundation
import UIKit

func makeAttributedPlaceholder(text: String) -> NSAttributedString {
    return  NSAttributedString(string: text,
                               attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
}


class RoundedCellWithShadow: UITableViewCell {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 8
        self.layer.masksToBounds = true
        self.layer.shadowColor =  UIColor.gray.cgColor
        self.layer.shadowOpacity = 0.8
        self.layer.shadowRadius = 4
        self.layer.borderWidth = CGFloat(1)
        self.layer.borderColor = UIColor.lightGray.cgColor
    }
}

extension UIImage {
    func createSelectionIndicator(color: UIColor, size: CGSize, lineHeight: CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(CGRect(origin: CGPoint(x: size.width / 4,y :size.height - 12), size: CGSize(width: size.width / 2, height: lineHeight)))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
