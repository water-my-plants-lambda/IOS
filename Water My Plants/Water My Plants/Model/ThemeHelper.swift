//
//  ThemeHelper.swift
//  Water My Plants
//
//  Created by Mitchell Budge on 5/30/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

import UIKit

enum ThemeHelper {
    static var lightGreen = UIColor(red: 98/255, green: 151/255, blue: 73/255, alpha: 1.0)
    static var darkGreen = UIColor(red: 0/255, green: 149/255, blue: 136/255, alpha: 1.0)
    static var lightBeige = UIColor(red: 255/255, green: 255/255, blue: 176/255, alpha: 1.0)
    static var darkBeige = UIColor(red: 255/255, green: 229/255, blue: 127/255, alpha: 1.0)
    static var lightBlue = UIColor(red: 232/255, green: 245/255, blue: 243/255, alpha: 1.0)
    static let textAttributes = [NSAttributedString.Key.foregroundColor: ThemeHelper.lightBeige, NSAttributedString.Key.font: UIFont(name: "Bad Script", size: 20)]
    
    static func badScriptFont(with textStyle: UIFont.TextStyle, pointSize: CGFloat) -> UIFont {
        let font = UIFont(name: "Bad Script", size: pointSize)!
        return UIFontMetrics(forTextStyle: textStyle).scaledFont(for: font)
    }
    
    static func setTheme() {
        UINavigationBar.appearance().barTintColor = lightGreen
        UINavigationBar.appearance().titleTextAttributes = textAttributes as [NSAttributedString.Key : Any]
        UIBarButtonItem.appearance().tintColor = lightBeige
        UIBarButtonItem.appearance().setTitleTextAttributes(textAttributes as [NSAttributedString.Key : Any], for: .normal)
    }
}


