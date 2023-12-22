//
//  SetingsViewController.swift
//  NotesMobileApp
//
//  Created by Mac User on 17/12/23.
//

import Foundation
import UIKit

class SetingsViewController: UIViewController {
    
    let dataDelete = NoteDataManager.shared
    
    private let tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let settings: [Settings] = [
        Settings(images: "lan", title: "Выберете язык", type: .show),
        Settings(images: "Vector", title: "Темная тема", type: .configure),
        Settings(images: "trash", title: "Очистить данные", type: .none)]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = .systemBackground
        
        let theme = UserDefaults.standard.bool(forKey: "theme")
        
        if theme == true {
            navigationController?.overrideUserInterfaceStyle = .dark
            overrideUserInterfaceStyle = .dark
        }else{
            navigationController?.overrideUserInterfaceStyle = .light
            overrideUserInterfaceStyle = .light
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Настройки"
        setUpConstraintsForTableView()
    }
    
    private func setUpConstraintsForTableView(){
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        tableView.dataSource = self
        tableView.delegate =  self
        tableView.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.reuseId)
    }
    
}

extension SetingsViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.reuseId, for: indexPath) as! SettingTableViewCell
        let settingItem = settings[indexPath.row]
        cell.setUp(image: settingItem.images,  title: settingItem.title, type: settingItem.type)
        cell.delegate = self
        cell.clipsToBounds = true
        cell.backgroundColor = .systemGray5
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath ) {
        
        switch indexPath.row {
        case 0:
            ()
        case 1:
            //            let languageVC = LanguageViewController()
            //            if let bottomSheet = languageVC.sheetPresentationController{
            //                bottomSheet.detents = [.medium()]
            ()
        case 2:
            let alert = UIAlertController(title: "Очистить данные", message: "Вы уверены, что хотите удалить все заметки?", preferredStyle: .alert)
            
            let actionAccept = UIAlertAction(title: "Да", style: .cancel) { action in
                self.dataDelete.deleteAllNotes()
                self.navigationController?.popViewController(animated: true)
            }
            
            let actionCancel = UIAlertAction(title: "Нет", style: .default) { action in
                
            }
            
            alert.addAction(actionAccept)
            alert.addAction(actionCancel)
            
            present(alert, animated: true)
        default:
            ()
        }
        
    }
    
}

extension SetingsViewController: SettingCellDelegate{
    func didSelectLanguage() {
        let languageVC = LanguageViewController()
        present(languageVC, animated: true)
//        if let bottomSheet = languageVC.sheetPresentationController{
//            bottomSheet.detents = [.medium()]
//        }
    }
    
    
    func didSwitchOn(isOn: Bool) {
        UserDefaults.standard.set( isOn, forKey: "theme")
        if isOn == true {
            navigationController?.overrideUserInterfaceStyle = .dark
            overrideUserInterfaceStyle = .dark
        }else{
            overrideUserInterfaceStyle = .light
            navigationController?.overrideUserInterfaceStyle = .light
        }
    }
    
}
