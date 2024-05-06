//
//  WholePostViewController.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 3.4.24..
//

import UIKit

final class WholePostViewController: UIViewController {
    
    //MARK: Properties
    
    private let viewModel: WholePostViewModel
    
    private lazy var titleLabel: UILabel = {
        $0.font = .interMedium500Font
        $0.textColor = .textAndButtonColor
        $0.text = "Публикация"
        return $0
    }(UILabel())
    
    private lazy var firstLineView = UIView().lineView
    
    private lazy var postTable: UITableView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .clear
        $0.delegate = self
        $0.dataSource = self
        $0.register(CommentCell.self, forCellReuseIdentifier: CommentCell.reuseID)
        $0.separatorStyle = .none
        return $0
    }(UITableView(frame: .zero, style: .grouped))
    
    private lazy var commentTextField = CustomTextField(
        placeholder: "оставить комментарий",
        mode: .forComment,
        backgroundColor: .secondaryBackgroundColor
    )
    
    private lazy var loadingViewController = LoadingDimmingViewController()
    
    //MARK: Init
    
    init(viewModel: WholePostViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        setupUI()
        bindViewModel()
        commentTextField.delegate = self
    }
    
    //MARK: Methods
    
    func bindViewModel() {
        viewModel.onStateDidChange = { [weak self] state in
            guard let self else { return }
            switch state {
            case .initial:
                break
            case .tryingToSendComment:
                self.loadingViewController.show(on: self)
            case .updateView:
                self.loadingViewController.hide {
                    self.postTable.reloadData()
                }
            case .failedAddComment:
                self.presentAlert(
                    message: "Не удалось оставить комментарий",
                    title: "Неудачно"
                )
            case .failedAddLike:
                self.presentAlert(
                    message: "Не удалось поставь ❤︎",
                    title: "Неудачно"
                )
            }
        }
    }
    
    private func setupNavBar() {
        let backButton = UIBarButtonItem(image: .arrowLeftImage, style: .plain, target: self, action: #selector(comeBack))
        backButton.tintColor = .textTertiaryColor
        
        let titleLabel = UIBarButtonItem(customView: titleLabel)
        self.navigationItem.leftBarButtonItems = [backButton, titleLabel]
                
        let rightButton = UIBarButtonItem(image: .verticalEllipseImage, style: .plain, target: self, action: #selector(didTapSettings))
        rightButton.tintColor = .textTertiaryColor
        self.navigationItem.rightBarButtonItem = rightButton
    }
    
    private func setupUI() {
        view.backgroundColor = .mainBackgroundColor
        view.addSubview(firstLineView)
        view.addSubview(postTable)
        view.addSubview(commentTextField)
        
        NSLayoutConstraint.activate([
            firstLineView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            firstLineView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            firstLineView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16),

            postTable.topAnchor.constraint(equalTo: firstLineView.bottomAnchor),
            postTable.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            postTable.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            postTable.bottomAnchor.constraint(equalTo: commentTextField.topAnchor),
            
            commentTextField.heightAnchor.constraint(equalToConstant: 44),
            commentTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            commentTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            commentTextField.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    @objc private func didTapSettings() {
        let settings = SettingsSheetAssembly(post: viewModel.post).viewController()
        present(settings, animated: true)
    }
    
    @objc private func comeBack() {
        navigationController?.popViewController(animated: true)
    }
}

//MARK: - UITableViewDataSource

extension WholePostViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.post.comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CommentCell.reuseID, for: indexPath) as? CommentCell else {
            return UITableViewCell()
        }
        
        let comment = viewModel.post.comments[indexPath.row]
        cell.setupCell(comment: comment)
        return cell
    }
}

//MARK: - UITableViewDelegate

extension WholePostViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = CommentHeader()
        header.setupHeader(post: viewModel.post)
        header.delegate = self
        return header
    }
}

//MARK: - UITextViewDelegate

extension WholePostViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textView: UITextField) -> Bool {
        if let text = textView.text {
            viewModel.updateState(with: .sendComment(text))
            textView.resignFirstResponder()
            self.commentTextField.text = ""
        }
        
        return true
    }
}


//MARK: - CommentHeaderDelegate

extension WholePostViewController: CommentHeaderDelegate {
    func didTapLike() {
        viewModel.updateState(with: .likePost)
    }
}
