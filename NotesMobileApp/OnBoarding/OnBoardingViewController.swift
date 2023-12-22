//
//  OnBoardingViewController.swift
//  NotesMobileApp
//
//  Created by Mac User on 17/12/23.
//

import UIKit

class OnBoardingViewController: UIViewController {

    static let onBoardingKey = "isOnboardingShown"
    
    private var onBoard: [OnBoarding] = []
    
    private let collect: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsHorizontalScrollIndicator = false
        view.isPagingEnabled = true
        return view
    }()
    
    
    private let pageControl: UIPageControl = {
        let view = UIPageControl()
        view.numberOfPages = 3
        view.currentPage = 0
        view.currentPageIndicatorTintColor = .black
        view.pageIndicatorTintColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let skipBtn: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Skip", for: .normal)
        view.setTitleColor(UIColor(red: 1, green: 0.237, blue: 0.237, alpha: 1), for: .normal)
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let nextBtn: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Next", for: .normal)
        view.backgroundColor = UIColor(red: 1, green: 0.237, blue: 0.237, alpha: 1)
        view.setTitleColor(.white, for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        allSetUpConstraints()
    }
    
    private func allSetUpConstraints(){
        setUpConstraintsForCollectionView()
        onBoardingSetUp()
        setUpConstraintsForPageControl()
        setUpConstraintsForNextBtn()
        setUpConstraintsForSkipBtn()
    }
    
    private func setUpConstraintsForCollectionView(){
        view.addSubview(collect)
        NSLayoutConstraint.activate([
            collect.topAnchor.constraint(equalTo: view.topAnchor),
            collect.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collect.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collect.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        collect.dataSource = self
        collect.delegate = self
        collect.register(OnBoargingCollectionViewCell.self, forCellWithReuseIdentifier: OnBoargingCollectionViewCell.reuseId)
    }
    
    private func setUpConstraintsForPageControl(){
        view.addSubview(pageControl)
        NSLayoutConstraint.activate([
            pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -290),
            pageControl.centerXAnchor.constraint (equalTo: view.centerXAnchor)
        ])
    }
    
    private func onBoardingSetUp() {
        onBoard = [
            OnBoarding(image: "Stuck at Home To Do List", mainLbl: "Welcome to The Note", secondLbl: "Welcome to The Note – your new companion \nfor tasks, goals, health – all in one place. \nLet's get started!"),
            OnBoarding(image: "Stuck at Home Shopping", mainLbl: "Set Up Your Profile", secondLbl: "Now that you're with us, let's get to know \neach other better. Fill out your profile, share \nyour interests, and set your goals."),
            OnBoarding(image: "Stuck at Home Working from Home", mainLbl: "Dive into The Note", secondLbl: "You're fully equipped to dive into the world \nof The Note. Remember, we're here to assist \nyou every step of the way. Ready to start? \nLet's go!")
        ]
    }
    
    private func setUpConstraintsForNextBtn() {
        view.addSubview(nextBtn)
        NSLayoutConstraint.activate([
            nextBtn.topAnchor.constraint(equalTo: pageControl.bottomAnchor, constant: 130),
            nextBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            nextBtn.widthAnchor.constraint(equalToConstant: 172),
            nextBtn.heightAnchor.constraint(equalToConstant: 42)
        ])
        nextBtn.addTarget(self, action: #selector(nextBtnTapped), for: .touchUpInside)
    }
    
    @objc private func nextBtnTapped(){
        let currentPage = pageControl.currentPage
        let nextPage = currentPage + 1
        
        collect.isPagingEnabled = false
    
        if nextPage != 3{
            collect.scrollToItem(at: [0, nextPage], at: .right, animated: true )
        }else{
            let main = NoteViewController()
            navigationController?.pushViewController(main, animated: true)
        }
        collect.isPagingEnabled = true
    }
    
    private func setUpConstraintsForSkipBtn(){
        view.addSubview(skipBtn)
        NSLayoutConstraint.activate([
            skipBtn.topAnchor.constraint(equalTo: pageControl.bottomAnchor, constant: 130),
            skipBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            skipBtn.widthAnchor.constraint(equalToConstant: 172),
            skipBtn.heightAnchor.constraint(equalToConstant: 42)
        ])
        skipBtn.addTarget(self, action: #selector(skipBtnTapped), for: .touchUpInside)
    }
    
    @objc private func skipBtnTapped(){
        let vc = NoteViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
extension OnBoardingViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        onBoard.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collect.dequeueReusableCell(withReuseIdentifier: OnBoargingCollectionViewCell.reuseId, for: indexPath) as! OnBoargingCollectionViewCell
        cell.setUp(onBoard[indexPath.row])
        return cell
    }
}

extension OnBoardingViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth  = scrollView.frame.size.width
        
        if pageWidth > 0 {
            let page: CGFloat = scrollView.contentOffset.x / pageWidth
            let roundedPage = round(Double(page))
            pageControl.currentPage = Int(roundedPage)
            print("Current page: \(roundedPage)")
            if roundedPage == 2 {
                UserDefaults.standard.setValue(true, forKey: OnBoardingViewController.onBoardingKey)
            }
        }else{
            print ("ScrollView width is zero or negative, cannot determine current page")
        }
    }
}
