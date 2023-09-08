//
//  FeedPostTableViewCell.swift
//  Mesh
//
//  Created by alkesh s on 06/09/23.
//

import UIKit

final class FeedPostTableViewCell: UITableViewCell {
    
    static let identifier = "FeedPostTableViewCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
