//
//  LanguageCell.swift
//  NotesMobileApp
//
//  Created by Mac User on 21/12/23.
//

import Foundation
import UIKit

class Language: UITableViewCell {
    
    static var reuseId = "language"
    
    private let lanImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let lanLbl: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false 
        view.font = .systemFont(ofSize: 17, weight: .bold)
        view.textAlignment = .center
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        allSetUpConstraints()
    }
    
    private func allSetUpConstraints() {
        setUpConstraintsForLanImage()
        setUpConstraintsForLanLbl()
        backgroundColor = .systemGray
    }
    
    private func setUpConstraintsForLanImage(){
        contentView.addSubview(lanImage)
        NSLayoutConstraint.activate([
            lanImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            lanImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            lanImage.widthAnchor.constraint(equalToConstant: 32),
            lanImage.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
    
    private func setUpConstraintsForLanLbl() {
        contentView.addSubview(lanLbl)
        NSLayoutConstraint.activate([
            lanLbl.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            lanLbl.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    func setUp(language: LanguageST) {
        lanImage.image = UIImage(named: language.image)
        lanLbl.text = language.title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
