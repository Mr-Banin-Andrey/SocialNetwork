//
//  CreatePostViewController.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 7.5.24..
//

import UIKit

//MARK: - CreatePostViewController

final class CreatePostViewController: UIViewController {
    
    //MARK: Properties
    
    private let viewModel: CreatePostViewModel
    
    private lazy var titleLabel: UILabel = {
        $0.font = .interMedium500Font
        $0.textColor = .textAndButtonColor
        $0.text = "Создание поста"
        return $0
    }(UILabel())
    
    private lazy var textLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .interMedium500Font.withSize(14)
        $0.textColor = .textAndButtonColor
        $0.text = "Напишите что-нибудь в поле ниже"
        return $0
    }(UILabel())
    
    private var textView: UITextView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isScrollEnabled = true
        $0.textColor = .textAndButtonColor
        $0.layer.borderColor = UIColor.textSecondaryColor.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 10
        $0.font = .interMedium500Font.withSize(14)
        $0.contentInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        return $0
    }(UITextView())
    
    private lazy var lastNameLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Фотография"
        $0.font = .interMedium500Font.withSize(12)
        $0.textColor = .textSecondaryColor
        return $0
    }(UILabel())

    private lazy var pictureImage = PhotoAssembly(isEdit: true).view()
    
    private lazy var loadingViewController = LoadingDimmingViewController()
    
    private var imageData = UIImage.logInLogoImage.jpegData(compressionQuality: 0.5)
    
    //MARK: Initial
    
    init(viewModel: CreatePostViewModel) {
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
        pictureImage.delegate = self
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
                        message: "Пост не создан",
                        title: "Ошибка"
                    )
                }
            case .showAvatarSheet(let postID):
                let postSheet = ImageSheetAssembly(objectID: postID, objectType: .newPost).viewController
                self.present(postSheet, animated: true)
            }
        }
    }
    
    private func createPost() -> Post {
        return Post(id: viewModel.postID, nickname: viewModel.user.nickname, firstName: viewModel.user.firstName, lastName: viewModel.user.lastName, profession: viewModel.user.profession, dateCreated: Date(), userCreatedID: viewModel.user.id, text: textView.text, likes: [], comments: [], savedPost: false, likePost: false)
    }
    
    private func updateNewImage() {
        NotificationCenter.default.addObserver(forName: NotificationKey.newPostKey, object: nil, queue: .main) { [weak self] notification in
            guard let self else { return }
            if let data = notification.userInfo as? [String: Data] {
                DispatchQueue.main.async {
                    self.imageData = data["imageData"]
                    self.pictureImage.updatePhoto(data["imageData"] ?? Data())
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
        
        self.view.addSubview(self.textLabel)
        self.view.addSubview(self.textView)
        self.view.addSubview(self.lastNameLabel)
        self.view.addSubview(self.pictureImage)
        
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
                        
            self.textLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 24),
            self.textLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            
            self.textView.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 16),
            self.textView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            self.textView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            self.textView.heightAnchor.constraint(equalToConstant: 250),
            
            self.lastNameLabel.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 24),
            self.lastNameLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            
            self.pictureImage.topAnchor.constraint(equalTo: lastNameLabel.bottomAnchor, constant: 16),
            self.pictureImage.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            self.pictureImage.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            self.pictureImage.heightAnchor.constraint(equalToConstant: 150),
            
        ])
    }
    
    //MARK: @objc private methods
    
    @objc private func comeBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func saveData() {
        viewModel.updateState(with: .didTapSavePost(createPost(), imageData ?? Data()))
    }
}

//MARK: - PhotoViewDelegate

extension CreatePostViewController: PhotoViewDelegate {
    func didTapPhoto() {
        viewModel.updateState(with: .didTapAddPhoto)
    }
}
