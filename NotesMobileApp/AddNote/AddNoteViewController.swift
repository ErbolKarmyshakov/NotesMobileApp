//
//  AddNoteViewController.swift
//  NotesMobileApp
//
//  Created by Mac User on 17/12/23.
//

import Foundation
import UIKit

class AddNoteViewController: UIViewController {
    
    private let noteData = NoteDataManager.shared
    
    var note: Note?
    
    var isNewNote = true
    
    private let titleTF: UITextField = {
        let view = UITextField()
        view.placeholder = "Title"
        view.layer.cornerRadius = 18
        view.backgroundColor = .systemBackground
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor(red: 0.012, green: 0.012, blue: 0.012, alpha: 1).cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let viewAnderNoteTf: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        view.backgroundColor = .systemGray3
        return view
    }()
    
    private let noteText: UITextView = {
        let view = UITextView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray3
        return view
    }()
    
    private let data: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .systemGray3
        label.textAlignment = .center
        label.backgroundColor = .red
        return label
    }()

    private let saveBtn: UIButton = {
        let view = UIButton(type: .system)
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitleColor(.white, for: .normal)
        view.layer.cornerRadius = 20
        view.setTitle("Сохранить", for: .normal)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = "Заметки"
        allSetUpConstraints()
        if let note = note {
            titleTF.text = note.title
            noteText.text = note.details
        }
        
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
    
    private func allSetUpConstraints() {
        trushBtnSetUp()
        setupConstraintsForTitleTF()
        setupConstraintsForGrayView()
        setUpConstaintsForNotesTf()
        setUpConstaintsForDateLbl()
        setUpConstaintsForSaveBtn()
    }
    
    private func trushBtnSetUp(){
        if isNewNote == false{
            let trush = UIBarButtonItem(image: UIImage(systemName: "trash"), style: .plain, target: self, action: #selector(trushBtnTapped))
                    navigationItem.rightBarButtonItem = trush
        }else{
            let settings = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .plain, target: self, action: #selector(settingBtnTapped))
                    navigationItem.rightBarButtonItem = settings
        }
    }
    
    @objc private func settingBtnTapped(_ sender: UIButton ) {
        let vc = SetingsViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func trushBtnTapped() {
        let alert = UIAlertController(title: "Удалить заметку?", message: "Вы уверены, что хотите удалить эту заметку?", preferredStyle: .alert)
        
        let actionAccept = UIAlertAction(title: "Да", style: .cancel) { action in
            self.noteData.deleteNote(id: self.note?.id ?? "")
            self.navigationController?.popViewController(animated: true)
        }
        
        let actionCancel = UIAlertAction(title: "Нет", style: .default) { action in

        }
        
        alert.addAction(actionAccept)
        alert.addAction(actionCancel)
        
        present(alert, animated: true)
    }
    
    private func setupConstraintsForTitleTF() {
        view.addSubview(titleTF)
        NSLayoutConstraint.activate([
            titleTF.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 6),
            titleTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            titleTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -18),
            titleTF.heightAnchor.constraint(equalToConstant: 34)
        ])
        titleTF.addTarget(self, action: #selector(titleEdit), for: .editingChanged)
       addLeftPaddingToTitleTextField()
    }
    
    @objc private func titleEdit(){
        saveBtn.backgroundColor = UIColor(red: 1, green: 0.237, blue: 0.237, alpha: 1)
    }
    
    private func addLeftPaddingToTitleTextField() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: titleTF.frame.height))
        titleTF.leftView = paddingView
        titleTF.leftViewMode = .always
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    private func setupConstraintsForGrayView() {
        view.addSubview(viewAnderNoteTf)
        NSLayoutConstraint.activate([
            viewAnderNoteTf.topAnchor.constraint(equalTo: titleTF.bottomAnchor, constant: 26),
            viewAnderNoteTf.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            viewAnderNoteTf.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -18),
            viewAnderNoteTf.heightAnchor.constraint(equalToConstant: 474)
        ])
    }
    
    private func setUpConstaintsForNotesTf() {
        viewAnderNoteTf.addSubview(noteText)
        NSLayoutConstraint.activate([
            noteText.topAnchor.constraint(equalTo: viewAnderNoteTf.topAnchor, constant: 18),
            noteText.leadingAnchor.constraint(equalTo: viewAnderNoteTf.leadingAnchor, constant: 18),
            noteText.trailingAnchor.constraint(equalTo: viewAnderNoteTf.trailingAnchor, constant: -18),
            noteText.bottomAnchor.constraint(equalTo: viewAnderNoteTf.bottomAnchor, constant: -18)
        ])
    }
    
    private func setUpConstaintsForDateLbl() {
        view.addSubview(data)
        NSLayoutConstraint.activate([
            data.topAnchor.constraint(equalTo: viewAnderNoteTf.bottomAnchor, constant: 6),
            data.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -17)
        ])
    }
    
    private func updateDateLabel() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        
        let currentDate = Date()
        let formattedDate = dateFormatter.string(from: currentDate)
        
        data.text = formattedDate
    }
    
    private func setUpConstaintsForSaveBtn() {
        view.addSubview(saveBtn)
        NSLayoutConstraint.activate([
            saveBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
            saveBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
            saveBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22),
            saveBtn.heightAnchor.constraint(equalToConstant: 45)
        ])
        saveBtn.addTarget(self, action: #selector(saveBtnTapped), for: .touchUpInside)
    }
    
    @objc private func saveBtnTapped(){
        let id = UUID().uuidString
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = dateFormatter.string(from: date)
        
        showAlert(id: id, title: titleTF.text ?? "", descrition: noteText.text ?? "", date: dateString)
    }
    
    private func showAlert(id: String, title: String, descrition: String, date: String) {
        let alert = UIAlertController(title: "Сохранение", message: "Вы хотите сохранить?", preferredStyle: .alert)
        
        let actionAccept = UIAlertAction(title: "Да", style: .cancel) { action in
            if self.isNewNote == true {
                self.noteData.addNote(id: id, title: title, descrition: self.noteText.text ?? "", date: date)
            } else {
                self.noteData.updateNote(id: self.note?.id ?? "", title: title, description: self.noteText.text ?? "", date: date)
            }
            self.navigationController?.popViewController(animated: true)
        }
        
        let actionCancel = UIAlertAction(title: "Нет", style: .default) { action in
           
        }
        
        alert.addAction(actionAccept)
        alert.addAction(actionCancel)
        
        present(alert, animated: true)
    }
}
