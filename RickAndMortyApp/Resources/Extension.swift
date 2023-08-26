//
//  Extension.swift
//  RickAndMortyApp
//
//  Created by suraj kumar on 23/08/23.
//

import UIKit

extension UIView {
    
    func addSubView(_ view: UIView...) {
        
        view.forEach({addSubview($0)})
    }
}

