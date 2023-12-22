//
//  OnBoargingCollectionViewCell.swift
//  NotesMobileApp
//
//  Created by Mac User on 17/12/23.
//

import Foundation
import UIKit

class OnBoargingCollectionViewCell: UICollectionViewCell {
    
    static var reuseId = "OnBoarding"

    private let mainPhoto: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let mainLbl: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 22, weight: .semibold)
        return view
    }()
    
    private let secondLbl: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 14, weight: .regular)
        view.textColor = .systemGray
        view.textAlignment = .left
        view.numberOfLines = 0
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        allSetUpConstraints()
    }
    
    private func allSetUpConstraints(){
        setUpConstraintsForMainImage()
        setUpConstraintsForMainLbl()
        setUpConstraintsForSecondLbl()
    }
    
    private func setUpConstraintsForMainImage(){
        contentView.addSubview(mainPhoto)
        NSLayoutConstraint.activate([
            mainPhoto.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 136),
            mainPhoto.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            mainPhoto.heightAnchor.constraint(equalToConstant: 140)
        ])
    }
    
    private func setUpConstraintsForMainLbl(){
        contentView.addSubview(mainLbl)
        NSLayoutConstraint.activate([
            mainLbl.topAnchor.constraint(equalTo: mainPhoto.bottomAnchor, constant: 52),
            mainLbl.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
    
    private func setUpConstraintsForSecondLbl() {
        contentView.addSubview(secondLbl)
        NSLayoutConstraint.activate([
            secondLbl.topAnchor.constraint(equalTo: mainLbl.bottomAnchor, constant: 16),
            secondLbl.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }

    func setUp(_ onboard: OnBoarding) {
        mainPhoto.image = UIImage(named: onboard.image)
        mainLbl.text = onboard.mainLbl
        secondLbl.text = onboard.secondLbl
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
