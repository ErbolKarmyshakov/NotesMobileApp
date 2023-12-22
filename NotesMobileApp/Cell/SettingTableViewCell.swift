//
//  SettingTableViewCell.swift
//  NotesMobileApp
//
//  Created by Mac User on 17/12/23.
//

import Foundation
import UIKit

protocol SettingCellDelegate: AnyObject{
    func didSwitchOn(isOn: Bool)
    func didSelectLanguage()
}

class SettingTableViewCell: UITableViewCell {
    
    var delegate: SettingCellDelegate?
    
    static var reuseId = "Setting_Cell"
    
    private let languageBtn: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Русский >", for: .normal)
        view.tintColor = .darkText
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let setImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let setLbl: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let serSwitch: UISwitch = {
        let view = UISwitch()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isOn = UserDefaults.standard.bool(forKey: "theme")
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        allSetUpConstraints()
    }
    
    private func allSetUpConstraints(){
        setUpConstraintsForSetImage()
        setUpConstraintsForSetLbl()
        setUpConstraintsForSetSwitch()
    }
    
    private func setupConstraintsForLanguageBtn() {
        contentView.addSubview(languageBtn)
        NSLayoutConstraint.activate([
            languageBtn.centerYAnchor.constraint(equalTo: centerYAnchor),
            languageBtn.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            languageBtn.widthAnchor.constraint(equalToConstant: 100)
        ])
        print("language work")
    }
    
    @objc private func selectLanguage() {
        delegate?.didSelectLanguage()
    }

    
    private func setUpConstraintsForSetImage(){
        contentView.addSubview(setImage)
        NSLayoutConstraint.activate([
            setImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            setImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15)
        ])
        print("i working")
    }
    
    private func setUpConstraintsForSetLbl(){
        contentView.addSubview(setLbl)
        NSLayoutConstraint.activate([
            setLbl.centerYAnchor.constraint(equalTo: centerYAnchor),
            setLbl.leadingAnchor.constraint(equalTo: setImage.trailingAnchor, constant: 10)
        ])
    }
    
    private func setUpConstraintsForSetSwitch(){
        contentView.addSubview(serSwitch)
        NSLayoutConstraint.activate([
            serSwitch.centerYAnchor.constraint(equalTo: centerYAnchor),
            serSwitch.rightAnchor.constraint(equalTo: rightAnchor, constant: -10)
        ])
        serSwitch.addTarget(self, action: #selector(switchTapped), for: .valueChanged)
    }
    
    @objc func switchTapped(){
        delegate?.didSwitchOn(isOn: serSwitch.isOn)
    }
    
    func setUp(image: String, title: String, type: Types){
        setImage.image = UIImage(named: image)
        setLbl.text = title
        
        if type == .show {
            languageBtn.isHidden = false
            setupConstraintsForLanguageBtn()
            languageBtn.addTarget(self, action: #selector(selectLanguage), for: .touchUpInside)
        } else {
            languageBtn.isHidden = true
        }
        
//        if title == "Выбрать язык" {
//            contentView.addSubview(languageBtn)
//            setupConstraintsForLanguageBtn()
//            languageBtn.addTarget(self, action: #selector(selectLanguage), for: .touchUpInside)
//
//            let isSwitchOn = serSwitch.isOn
////            updateLanguageButtonTitleColor(isSwitchOn: isSwitchOn)
//        } else {
//            languageBtn.removeFromSuperview()
//        }
        
        if type == .configure {
            serSwitch.isHidden = false
        }else{
            serSwitch.isHidden = true
        }
    }
    
//    @objc private func switchStateChanged() {
//        let isSwitchOn = serSwitch.isOn
//        updateLanguageButtonTitleColor(isSwitchOn: isSwitchOn)
//    }
    
//    private func updateLanguageButtonTitleColor(isSwitchOn: Bool) {
//        let titleColor: UIColor = isSwitchOn ? .white : .black
//        languageBtn.setTitleColor(titleColor, for: .normal)
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
