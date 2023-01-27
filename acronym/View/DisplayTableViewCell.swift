//
//  DisplayTableViewCell.swift
//  acronym
//
//  Created by Choonghun Lee on 1/26/23.
//

import Foundation
import UIKit

public class DisplayTableViewCell: UITableViewCell  {
    var leadingConstraint: NSLayoutConstraint?
    var trailingConstraint: NSLayoutConstraint?
    var topConstraint: NSLayoutConstraint?
    var bottomConstraint: NSLayoutConstraint?
    
    // MARK: - INITIALIZERS:
    
    override init(style: UITableViewCell.CellStyle =  UITableViewCell.CellStyle.default, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

