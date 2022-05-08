//
//  SectionHeaderTile.swift
//  Exam
//
//  Created by Carlos Caraccia on 08/05/2022.
//

import UIKit

class SectionHeaderTitle:UICollectionReusableView {
    
    var sectionTitleLabel:UILabel = {
        let label = UILabel()
        label.text = "Section Name"
        label.font = .systemFont(ofSize: 24, weight: .heavy)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(sectionTitleLabel)
        
        NSLayoutConstraint.activate([
          sectionTitleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8),
          sectionTitleLabel.topAnchor.constraint(equalTo: self.topAnchor),
          sectionTitleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
          sectionTitleLabel.rightAnchor.constraint(equalTo: self.rightAnchor),
        ])
    }
}

