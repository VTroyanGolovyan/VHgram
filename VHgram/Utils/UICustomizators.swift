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
