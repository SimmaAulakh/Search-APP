//
//  Extensions.swift
//  TestTaskVajinder
//
//  Created by Simranjeet Aulakh on 04/02/22.
//

import UIKit

extension UILabel {
    func highlightSearchedText(text: String, searchedText: String){
              let attributedString = NSMutableAttributedString.init(string: text)
              let nsRange = NSString(string: text).range(of: searchedText, options: String.CompareOptions.caseInsensitive)
              attributedString.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.red, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17) as Any], range: nsRange)
              self.attributedText = attributedString
    }
}


