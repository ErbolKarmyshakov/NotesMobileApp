//
//  LanguageViewController.swift
//  NotesMobileApp
//
//  Created by Mac User on 17/12/23.
//

import Foundation
import UIKit

class LanguageViewController: UIViewController {
    
    private var language: [LanguageST] = [LanguageST(image: "kg", title: "Кыргызча"),
    LanguageST(image: "russia", title: "Русский"),
                                          LanguageST(image: "usa", title: "English")
    ]
    
    private let chooseLan: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "Выберете язык"
        view.font = .systemFont(ofSize: 17, weight: .bold)
        return view
    }()
    
    private let chooseTV: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        allSetUpConstraints()
    }
    
    private func allSetUpConstraints(){
        setUpConstraintsForChooseLbl()
        setUpConstraintsForChooseTableView()
    }

    private func setUpConstraintsForChooseLbl() {
        view.addSubview(chooseLan)
        NSLayoutConstraint.activate([
            chooseLan.topAnchor.constraint(equalTo: view.topAnchor, constant: 55),
            chooseLan.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 14)
        ])
    }
    
    private func setUpConstraintsForChooseTableView() {
        view.addSubview(chooseTV)
        NSLayoutConstraint.activate([
            chooseTV.topAnchor.constraint(equalTo: chooseLan.bottomAnchor, constant: 36),
            chooseTV.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 14),
            chooseTV.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -14),
            chooseTV.heightAnchor.constraint(equalToConstant: <#T##CGFloat#>)
        ])
        chooseTV.dataSource = self
        chooseTV.delegate = self
        chooseTV.register(Language.self, forCellReuseIdentifier: Language.reuseId)
        chooseTV.layer.cornerRadius = 10
    }
    
}

extension LanguageViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        language.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Language.reuseId, for: indexPath) as! Language
        cell.setUp(language: language[indexPath.row])
        return cell
    }
}

extension LanguageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
