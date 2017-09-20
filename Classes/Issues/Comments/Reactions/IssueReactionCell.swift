//
//  IssueReactionCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/1/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import SnapKit

final class IssueReactionCell: UICollectionViewCell {

    let label = ShowMoreDetailsLabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        accessibilityTraits |= UIAccessibilityTraitButton
        isAccessibilityElement = true

        label.textAlignment = .center
        label.backgroundColor = .clear
        label.font = Styles.Fonts.body
        label.textColor = Styles.Colors.Blue.medium.color
        contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var accessibilityLabel: String? {
        get {
            return contentView.subviews
                .flatMap { $0.accessibilityLabel }
                .reduce("", { "\($0 ?? "").\n\($1)" })
        }
        set { }
    }
    
}
