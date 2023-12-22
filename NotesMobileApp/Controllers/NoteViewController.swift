//
//  ViewController.swift
//  NotesMobileApp
//
//  Created by Mac User on 17/12/23.
//

import UIKit

class NoteViewController: UIViewController {

    private let noteDataManager = NoteDataManager.shared
    
    private var notes: [Note] = []
    
    private let colors: [String] = ["customLightBLue", "customYellow", "customBlue", "custemPurple"]
    
    private var filteredNotes: [Note] = []
    
    private let notesSearchBar: UISearchBar = {
        let view = UISearchBar()
        view.placeholder = "Поиск"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let notesLbl: UILabel = {
        let view = UILabel()
        view.text = "Notes"
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        view.font = .systemFont(ofSize: 16, weight: .regular)
        return view
    }()
    
    private let notesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let addBtn: UIButton = {
        let view = UIButton(type: .system)
        view.backgroundColor = UIColor(red: 1, green: 0.237, blue: 0.237, alpha: 1)
        view.setTitle("+", for: .normal)
        view.titleLabel?.font = UIFont(name: "Avenir-Medium", size: 30)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 42 / 2
        view.setTitleColor(.systemBackground, for: .normal)
        return view
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let theme = UserDefaults.standard.bool(forKey: "theme")
        
        if theme == true {
            navigationController?.overrideUserInterfaceStyle = .dark
            overrideUserInterfaceStyle = .dark
        }else{
            overrideUserInterfaceStyle = .light
            navigationController?.overrideUserInterfaceStyle = .light
        }
        
        navigationItem.hidesBackButton = true
        
        notes = noteDataManager.fethNotes()
        filteredNotes = notes
        notesCollectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = "Заметки"
    
        allSetUpConstraints()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updateSettingsButtonColor()
    }
    
    private func updateSettingsButtonColor() {
        let isDarkTheme = traitCollection.userInterfaceStyle == .dark
        let buttonColor: UIColor = isDarkTheme ? .white : .black
        navigationItem.rightBarButtonItem?.tintColor = buttonColor
    }
    
    private func allSetUpConstraints(){
        setUpConstraintsForSettingsBtn()
        setUpConstraintsForSearcBar()
        setUpConstraintsForNotesLbl()
        setUpConstraintsForNotesCollectionView()
        setUpConstraintsForAddBtn()
    }
    
    private func setUpConstraintsForSettingsBtn() {
        let settings = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .plain, target: self, action: #selector(setingsTappedBtn))
        settings.tintColor = .darkText
        navigationItem.rightBarButtonItem = settings
    }
    
    @objc func setingsTappedBtn() {
        let vc = SetingsViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

    private func setUpConstraintsForSearcBar() {
        view.addSubview(notesSearchBar)
        NSLayoutConstraint.activate([
            notesSearchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 4),
            notesSearchBar.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            notesSearchBar.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            notesSearchBar.heightAnchor.constraint(equalToConstant: 36)
        ])
        notesSearchBar.searchTextField.addTarget(  self, action: #selector(searchBarInfo), for: .editingChanged)
    }
    
  @objc private func searchBarInfo() {
      filteredNotes = []
      
      guard let searchText = notesSearchBar.text?.uppercased() else {
          return
      }
      
      if searchText.isEmpty {
          filteredNotes = notes
      } else {
          filteredNotes = notes.filter { note in
              note.title?.uppercased().contains(searchText) == true
          }
      }
      
      notesCollectionView.reloadData()
    }
    
    private func setUpConstraintsForNotesLbl() {
        view.addSubview(notesLbl)
        NSLayoutConstraint.activate([
            notesLbl.topAnchor.constraint(equalTo: notesSearchBar.bottomAnchor, constant: 32),
            notesLbl.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 38)
        ])
    }
    
    private func setUpConstraintsForNotesCollectionView() {
        view.addSubview(notesCollectionView)
       NSLayoutConstraint.activate([
            notesCollectionView.topAnchor.constraint(equalTo: notesLbl.bottomAnchor, constant: 40),
            notesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            notesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            notesCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        notesCollectionView.dataSource = self
        notesCollectionView.delegate = self
        notesCollectionView.register(NoteCollectionViewCell.self, forCellWithReuseIdentifier: NoteCollectionViewCell.reuseId)
    }
    
    private func setUpConstraintsForAddBtn(){
        view.addSubview(addBtn)
        NSLayoutConstraint.activate([
            addBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            addBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addBtn.heightAnchor.constraint(equalToConstant: 42),
            addBtn.widthAnchor.constraint(equalToConstant: 42)
        ])
        addBtn.addTarget(self, action: #selector(addBtnTapped), for: .touchUpInside)
    }
    
    @objc private func addBtnTapped(){
        let add = AddNoteViewController()
        navigationController?.pushViewController(add, animated: true)
    }
}

extension NoteViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredNotes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = notesCollectionView.dequeueReusableCell(withReuseIdentifier: NoteCollectionViewCell.reuseId, for: indexPath) as! NoteCollectionViewCell
        let randomColor = colors.randomElement()
        cell.backgroundColor = UIColor(named: randomColor ?? "")
        cell.setUp(title: filteredNotes[indexPath.row].title ?? ""/* details: filteredNotes[indexPath.row].details ?? ""*/)
        return cell
    }
}
extension NoteViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width - 58) / 2, height: 100 )
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detail = AddNoteViewController()
        let item = filteredNotes[indexPath.row]
        detail.note = item
        detail.isNewNote = false
        navigationController?.pushViewController(detail, animated: true )
    }
}




