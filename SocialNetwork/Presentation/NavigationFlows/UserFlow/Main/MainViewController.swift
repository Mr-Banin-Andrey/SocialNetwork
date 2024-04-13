//
//  MainViewController.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 14.3.24..
//

import UIKit

final class MainViewController: UIViewController, Coordinatable {
    
    //MARK: Properties
    
    typealias CoordinatorType = MainCoordinator
    var coordinator: CoordinatorType?
    
    private let viewModel: MainViewModel
    
    private lazy var mainTable: UITableView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .clear
        $0.delegate = self
        $0.dataSource = self
        $0.register(DateHeader.self, forHeaderFooterViewReuseIdentifier: DateHeader.reuseID)
        $0.register(PostCell.self, forCellReuseIdentifier: PostCell.reuseID)
        $0.separatorStyle = .none
        return $0
    }(UITableView(frame: .zero, style: .grouped))
    
    private lazy var titleLabel: UILabel = {
        $0.font = .interSemiBold600Font
        $0.textColor = .textAndButtonColor
        $0.text = "Главная"
        return $0
    }(UILabel())
    
    private lazy var buttonsStack: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .horizontal
        $0.spacing = 38
        $0.distribution = .fillEqually
        return $0
    }(UIStackView())
    
    private lazy var allPostsButton = CustomButton(
        title: "Новости",
        font: .interRegular400Font,
        titleColor: .textSecondaryColor,
        backgroundColor: .clear,
        forPosts: true
    ) { [weak self] in
        self?.viewModel.updateState(with: .didTapAllPosts)
    }
    
    private lazy var forUserButton = CustomButton(
        title: "Для вас",
        font: .interRegular400Font,
        titleColor: .textSecondaryColor,
        backgroundColor: .clear,
        forPosts: true
    ) { [weak self] in
        self?.viewModel.updateState(with: .didTapPostsForUser)
    }
    
    //MARK: Init
    
    init(viewModel: MainViewModel) {
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
        viewModel.updateState(with: .didTapAllPosts)
    }
    
    //MARK: Methods
    
    func bindViewModel() {
        viewModel.onStateDidChange = { [weak self] state in
            guard let self else { return}
            
            switch state {
            case .initial:
                break
            case .openScreenSubscriber:
                coordinator?.subscriber()
            case .openScreenMenu:
                let settings = SettingsSheetAssembly().viewController()
                present(settings, animated: true)
            case .openScreenPost:
                let wholePost = WholePostAssembly().viewController()
                navigationController?.pushViewController(wholePost, animated: true)
                
            case .showAllPosts:
                updateViewVisibility(isSelected: true)
            case .showPostsForUser:
                updateViewVisibility(isSelected: false)
            }
        }
    }
        
    private func setupNavBar() {
        let leftButtonTwo = UIBarButtonItem(customView: titleLabel)
        self.navigationItem.leftBarButtonItems = [leftButtonTwo]
    }
    
    private func setupUI() {
        view.backgroundColor = .mainBackgroundColor

        self.view.addSubview(buttonsStack)
        self.buttonsStack.addArrangedSubview(allPostsButton)
        self.buttonsStack.addArrangedSubview(forUserButton)
        self.view.addSubview(mainTable)
        
        NSLayoutConstraint.activate([
            self.buttonsStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            self.buttonsStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            self.mainTable.topAnchor.constraint(equalTo: allPostsButton.bottomAnchor, constant: 8),
            self.mainTable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            self.mainTable.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            self.mainTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func updateViewVisibility(isSelected: Bool) {
        allPostsButton.underlineSwitch(isSelect: isSelected)
        forUserButton.underlineSwitch(isSelect: !isSelected)
    }
}

//MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        8
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 0
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostCell.reuseID, for: indexPath) as? PostCell else {
            return UITableViewCell()
        }
        cell.delegate = self
        return cell
    }
}

//MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            let stories = StoriesAssembly().view()
            stories.coordinator = coordinator
            return stories
        default:
            guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: DateHeader.reuseID) as? DateHeader else { return nil }
            return header
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 76
        default:
            return 24
        }
    }
}

//MARK: - PostCellDelegate

extension MainViewController: PostCellDelegate {
    func addPostToSaved() {
        viewModel.updateState(with: .didTapAddPostToSaved)
    }
    
    func openScreenSubscriber() {
        viewModel.updateState(with: .didTapOpenSubscriberProfile)
    }
    
    func openScreenMenuSheet() {
        viewModel.updateState(with: .didTapOpenMenu)
    }
    
    func openScreenWholePost() {
        viewModel.updateState(with: .didTapOpenPost)
    }
}
