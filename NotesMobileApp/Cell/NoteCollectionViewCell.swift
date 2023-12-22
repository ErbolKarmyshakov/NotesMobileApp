//
//  NoteCollectionViewCell.swift
//  NotesMobileApp
//
//  Created by Mac User on 17/12/23.
//

import Foundation
import UIKit

class NoteCollectionViewCell: UICollectionViewCell {
    
    static var reuseId = "mainCell"
    
    private let titleLbl: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        allSetUpConstraints()
    }
    
    private func allSetUpConstraints() {
        setUpConstraintsForTitleLbl()
        layer.cornerRadius = 10
    }
    
    private func setUpConstraintsForTitleLbl() {
        contentView.addSubview(titleLbl)
        NSLayoutConstraint.activate([
            titleLbl.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            titleLbl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
    }
    
    func setUp(title: String){
        titleLbl.text = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
