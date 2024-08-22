//
//  EditPersonalDataViewController.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 6.5.24..
//

import UIKit

//MARK: - EditPersonalDataViewController

final class EditPersonalDataViewController: UIViewController {
    
    //MARK: Properties
    
    private let viewModel: EditPersonalDataViewModel
    
    private lazy var avatarImage = AvatarAssembly(size: .sizeEighty, isBorder: false, isEdit: true).view()
    
    private lazy var mainView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .clear
        return $0
    }(UIView())
    
    private lazy var titleLabel: UILabel = {
        $0.font = .interMedium500Font
        $0.textColor = .textAndButtonColor
        $0.text = "Основная информация"
        return $0
    }(UILabel())
    
    private lazy var textFieldsStack: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.spacing = 35
        $0.backgroundColor = .clear
        return $0
    }(UIStackView())
    
    private lazy var lastNameLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Фамилия"
        $0.font = .interMedium500Font.withSize(12)
        $0.textColor = .textSecondaryColor
        return $0
    }(UILabel())
    
    private lazy var lastNameTextField = CustomTextField(
        placeholder: "Фамилия",
        mode: .forAll,
        borderColor: UIColor.textAndButtonColor.cgColor
    )
    
    private lazy var firstNameLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Имя"
        $0.font = .interMedium500Font.withSize(12)
        $0.textColor = .textSecondaryColor
        return $0
    }(UILabel())
    
    private lazy var firstNameTextField = CustomTextField(
        placeholder: "Имя",
        mode: .forAll,
        borderColor: UIColor.textAndButtonColor.cgColor
    )

    private lazy var nicknameLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Никнейм"
        $0.font = .interMedium500Font.withSize(12)
        $0.textColor = .textSecondaryColor
        return $0
    }(UILabel())
    
    private lazy var nicknameTextField = CustomTextField(
        placeholder: "Никнейм",
        mode: .forAll,
        borderColor: UIColor.textAndButtonColor.cgColor
    )
    
    private lazy var professionLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Профессия"
        $0.font = .interMedium500Font.withSize(12)
        $0.textColor = .textSecondaryColor
        return $0
    }(UILabel())
    
    private lazy var professionTextField = CustomTextField(
        placeholder: "Профессия",
        mode: .forAll,
        borderColor: UIColor.textAndButtonColor.cgColor
    )
    
    private lazy var checkMarkImage: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = .confirmationCheckMarkImage
        $0.contentMode = .scaleAspectFill
        return $0
    }(UIImageView())

    private lazy var loadingViewController = LoadingDimmingViewController()
    
    private var imageData = UIImage.logInLogoImage.jpegData(compressionQuality: 0.5)
    
    //MARK: Initial
    
    init(viewModel: EditPersonalDataViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupNavBar()
        self.setupUI()
        self.bindViewModel()
        avatarImage.delegate = self
        avatarImage.setupAvatar(viewModel.user.id)
        updateNewImage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: Private methods
    
    private func bindViewModel() {
        viewModel.onStateDidChange = { [weak self] state in
            guard let self = self else { return }
            switch state {
            case .initial:
                break
            case .tryingToSignUp:
                self.loadingViewController.show(on: self)
            case .savedChange:
                self.loadingViewController.hide {
                    self.navigationController?.popViewController(animated: true)
                }
            case .showAlertErrorSave:
                self.loadingViewController.hide {
                    self.presentAlert(
                        message: "Изменения не сохранены",
                        title: "Ошибка"
                    )
                }
            case .showAvatarSheet(let userID):
                let avatarSheet = ImageSheetAssembly(objectID: userID, objectType: .newAvatar).viewController
                self.present(avatarSheet, animated: true)
            }
        }
    }
    
    private func createUser() -> User {
        return User(id: viewModel.user.id, nickname: nicknameTextField.text?.replacingOccurrences(of: " ", with: "") ?? "", firstName: firstNameTextField.text?.replacingOccurrences(of: " ", with: "") ?? "", lastName: lastNameTextField.text?.replacingOccurrences(of: " ", with: "") ?? "", profession: professionTextField.text?.replacingOccurrences(of: " ", with: "") ?? "", following: [], followers: [], posts: [], photos: [], savedPosts: [])
    }
    
    private func updateNewImage() {
        NotificationCenter.default.addObserver(forName: NotificationKey.newAvatarKey, object: nil, queue: .main) { [weak self] notification in
            guard let self else { return }
            if let data = notification.userInfo as? [String: Data] {
                DispatchQueue.main.async {
                    self.imageData = data["imageData"]
                    self.avatarImage.updateAvatar(data["imageData"] ?? Data())
                }
            }
        }
    }
    
    private func setupNavBar() {
        
        let backButton = UIBarButtonItem(image: .arrowLeftImage, style: .plain, target: self, action: #selector(comeBack))
        backButton.tintColor = .textTertiaryColor
        
        let titleLabel = UIBarButtonItem(customView: titleLabel)
        self.navigationItem.leftBarButtonItems = [backButton, titleLabel]
                
        let rightButton = UIBarButtonItem(image: .checkmarkImage, style: .plain, target: self, action: #selector(saveData))
        rightButton.tintColor = .textTertiaryColor
        self.navigationItem.rightBarButtonItem = rightButton
    }
    
    private func setupUI() {
        self.view.backgroundColor = .mainBackgroundColor
        
        self.view.addSubview(self.mainView)
        self.view.addSubview(self.avatarImage)
        
        self.mainView.addSubview(self.textFieldsStack)
        self.textFieldsStack.addArrangedSubview(self.lastNameTextField)
        self.textFieldsStack.addArrangedSubview(self.firstNameTextField)
        self.textFieldsStack.addArrangedSubview(self.nicknameTextField)
        self.textFieldsStack.addArrangedSubview(self.professionTextField)

        self.mainView.addSubview(self.lastNameLabel)
        self.mainView.addSubview(self.firstNameLabel)
        self.mainView.addSubview(self.nicknameLabel)
        self.mainView.addSubview(self.professionLabel)
        
        NSLayoutConstraint.activate([
            
            avatarImage.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 30),
            avatarImage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            avatarImage.heightAnchor.constraint(equalToConstant: 80),
            avatarImage.widthAnchor.constraint(equalToConstant: 80),
            
            self.mainView.topAnchor.constraint(equalTo: self.avatarImage.bottomAnchor, constant: 24),
            self.mainView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            self.mainView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
   
            self.textFieldsStack.topAnchor.constraint(equalTo: self.mainView.topAnchor, constant: 16),
            self.textFieldsStack.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 8),
            self.textFieldsStack.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -8),
            self.textFieldsStack.bottomAnchor.constraint(equalTo: self.mainView.bottomAnchor, constant: -16),
            
            self.lastNameLabel.bottomAnchor.constraint(equalTo: self.lastNameTextField.topAnchor, constant: -8),
            self.lastNameLabel.leadingAnchor.constraint(equalTo: self.textFieldsStack.leadingAnchor),
            
            self.firstNameLabel.bottomAnchor.constraint(equalTo: self.firstNameTextField.topAnchor, constant: -8),
            self.firstNameLabel.leadingAnchor.constraint(equalTo: self.textFieldsStack.leadingAnchor),
            
            self.nicknameLabel.bottomAnchor.constraint(equalTo: self.nicknameTextField.topAnchor, constant: -8),
            self.nicknameLabel.leadingAnchor.constraint(equalTo: self.textFieldsStack.leadingAnchor),
            
            self.professionLabel.bottomAnchor.constraint(equalTo: self.professionTextField.topAnchor, constant: -8),
            self.professionLabel.leadingAnchor.constraint(equalTo: self.textFieldsStack.leadingAnchor),
        ])
    }
    
    //MARK: @objc private methods
    
    @objc private func comeBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func saveData() {
        viewModel.updateState(with: .didTapSaveChanges(createUser(), imageData ?? Data()))
    }
}

//MARK: - AvatarViewDelegate

extension EditPersonalDataViewController: AvatarViewDelegate {
    func didTapAvatar() {
        viewModel.updateState(with: .didTapAvatar)
    }
}
