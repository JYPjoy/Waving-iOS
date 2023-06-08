//
//  SignupViewController.swift
//  Waving-iOS
//
//  Created by Jane Choi on 2023/06/03.
//

import UIKit

final class SignupViewController: UIViewController {

    private var buttonForPreviousStep: WVButton?
    private var buttonForNextStep: WVButton?
    private lazy var buttonModelForPreviousStep = WVButtonModel(title: "prev") { [weak self]
        <#code#>
    }
    
    private var buttonModelForNextStep: WVButtonModel?
    
    private lazy var collectionView = {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: self.collectionViewFlowLayout)
        return collectionView
    }()
    
    private lazy var collectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 10
        return flowLayout
    }()
    
    lazy private var buttonContainerView: UIView = {
        let containerView = UIView()
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        
        containerView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(50)
        }
        
        let buttonForPreviousStep = WVButton()
        self.buttonForPreviousStep = buttonForPreviousStep
        let buttomModel = WVButtonModel(title: "prev")
        buttonForPreviousStep.setup(model: buttomModel)
        stackView.addArrangedSubview(buttonForPreviousStep)
        
        let buttonForNextStep = WVButton()
        self.buttonForNextStep = buttonForNextStep
        let buttomModel2 = WVButtonModel(title: "next")
        buttonForNextStep.setup(model: buttomModel2)
        stackView.addArrangedSubview(buttonForNextStep)
        
        return containerView
    }()
    
    // MARK: - View Models
    private var collectionViewCellModels: [SignupStepViewModel] = []
    
    private var currentSignupStep: SignupStepType = .emailPassword
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()
        setupView()
        fetchData()
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func setupView() {
        view.backgroundColor = .main010
        
        view.addSubview(buttonContainerView)
        buttonContainerView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(buttonContainerView.snp_topMargin)
        }
        
        // test code
        collectionView.backgroundColor = .yellow
        
        collectionView.register(SignupStepCollectionViewCell.self, forCellWithReuseIdentifier: "SignupStepCollectionViewCell")
    }
    
    private func fetchData() {
        
        collectionViewCellModels = [.init(type: .emailPassword),
                                    .init(type: .username),
                                    .init(type: .birthdate),
                                    .init(type: .phoneNumber),
                                    .init(type: .termsOfUse),
                                    .init(type: .complete)]
        
    }

}

extension SignupViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        collectionViewCellModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard indexPath.row < collectionViewCellModels.count else { return UICollectionViewCell() }
        
        let cellModel = collectionViewCellModels[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SignupStepCollectionViewCell", for: indexPath) as! SignupStepCollectionViewCell
        cell.setup(with: cellModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        collectionView.frame.size
    }
}
