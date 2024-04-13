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
    
    //MARK: Init
    
    init(viewModel: WholePostViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        setupUI()
        bindViewModel()
    }
    
    //MARK: Methods
    
    func bindViewModel() {
//        viewModel.onStateDidChange = { [weak self] state in
//            guard let self else { return}
//
//            switch state {
//            case .initial:
//                break
//            }
//        }
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
        let settings = SettingsSheetAssembly().viewController()
        present(settings, animated: true)
    }
    
    @objc private func comeBack() {
        navigationController?.popViewController(animated: true)
    }
}

//MARK: - UITableViewDataSource

extension WholePostViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CommentCell.reuseID, for: indexPath) as? CommentCell else {
            return UITableViewCell()
        }
        
        return cell
    }
}

//MARK: - UITableViewDelegate

extension WholePostViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return CommentHeader()
    }
}
