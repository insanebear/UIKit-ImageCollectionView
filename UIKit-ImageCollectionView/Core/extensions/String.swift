//
//  String.swift
//  UIKit-ImageCollectionView
//
//  Created by Yurim Jayde Jeong on 3/19/24.
//

import Foundation

extension String {
    func convertDateString(from input: String = "yyyy-MM-dd'T'HH:mm:ssZ",
                           to output: String = "yy/MM/dd HH:mm") -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = input
        guard let date = dateFormatter.date(from: self) else {
            fatalError("Not supported string")
        }
        
        let resDateFormatter = DateFormatter()
        resDateFormatter.dateFormat = output
        
        let res = resDateFormatter.string(from: date)
        return res
    }
}
