//
//  CustomTableViewCell.swift
//  TestTaskIOS
//
//  Created by Sergo on 27.01.2024.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()

    let contentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = UIColor.gray
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(titleLabel)
        addSubview(contentLabel)
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24).isActive = true

        contentLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2).isActive = true
        contentLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24).isActive = true
        contentLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        contentLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
