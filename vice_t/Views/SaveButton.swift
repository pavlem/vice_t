//
//  SaveButton.swift
//  vice_t
//
//  Created by Pavle Mijatovic on 27.5.21..
//

import UIKit

class SaveButton: UIButton {
    
    var color: UIColor? {
        didSet {
            backgroundColor = color
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

        contentMode = .scaleToFill
        layer.cornerRadius = 10
        clipsToBounds = true
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        setTitleColor(.darkGray, for: .normal)
        setTitleColor(.darkGray, for: .selected)
        tintColor = .clear
        
        setTitle("Save", for: .normal)
        setTitle("Remove", for: .selected)
    }
}
