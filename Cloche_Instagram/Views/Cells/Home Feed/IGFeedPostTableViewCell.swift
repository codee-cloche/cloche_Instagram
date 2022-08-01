//
//  IGFeedPostTableViewCell.swift
//  Instagram
//
//  Created by grace kim  on 2022/08/01.
//

import UIKit

class IGFeedPostTableViewCell: UITableViewCell {
    
 static let identifier = "IGFeedPostTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public func configure() {
        //configure with model the cell 
    }

}
