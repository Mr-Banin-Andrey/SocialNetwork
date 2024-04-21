//
//  ProfileViewController.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 17.3.24..
//

import UIKit

final class ProfileViewController: UIViewController, Coordinatable {
    
    //MARK: Properties
    
    typealias CoordinatorType = ProfileCoordinator
    var coordinator: CoordinatorType?
    
    private let viewModel: ProfileViewModel
    
    private lazy var profileTable: UITableView = {
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
        $0.text = viewModel.user.nickname
        return $0
    }(UILabel())
    
    //MARK: Init
    
    init(viewModel: ProfileViewModel) {
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
        let titleLabel = UIBarButtonItem(customView: titleLabel)
        self.navigationItem.leftBarButtonItems = [titleLabel]
                
        let rightButton = UIBarButtonItem(image: .burgerImage, style: .plain, target: self, action: #selector(didTapSettings))
        rightButton.tintColor = .textTertiaryColor
        self.navigationItem.rightBarButtonItems = [rightButton]
    }
    
    private func setupUI() {
        view.backgroundColor = .mainBackgroundColor
        self.view.addSubview(profileTable)
        
        NSLayoutConstraint.activate([
            self.profileTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            self.profileTable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            self.profileTable.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            self.profileTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    @objc private func didTapSettings() {
        
    }
}

//MARK: - UITableViewDataSource

extension ProfileViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if viewModel.posts.count != 0 {
            return viewModel.posts.count + 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard section != 0 else { return 0 }
        let postsCount = viewModel.posts[section-1].posts.count
        return postsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostCell.reuseID, for: indexPath) as? PostCell else {
            return UITableViewCell()
        }
        
        cell.delegate = self
        cell.setupCellForUser()
        let post = viewModel.posts[indexPath.section-1].posts[indexPath.row]
        cell.setupCell(post: post)
        return cell
    }
}

//MARK: - UITableViewDelegate

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            let view = ProfileHeaderAssembly(type: .profileView, user: viewModel.user).view()
            view.setupHeader(numberOfPhoto: viewModel.user.photos.count)
            view.delegate = self
            return view
        default:
            guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: DateHeader.reuseID) as? DateHeader else { return nil }
            let date = viewModel.posts[section-1].date
            header.setupHeader(date: DateConverter.dateString(from: date))
            return header
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 423
        default:
            return 24
        }
    }
    
}

//MARK: - ProfileHeaderViewDelegate

extension ProfileViewController: ProfileHeaderViewDelegate {
    func openScreenGallery() {
        let gallery = PhotoGalleryAssembly(photoGalleryType: .forUser).viewController()
        navigationController?.pushViewController(gallery, animated: true)
    }
    
    func openScreenCreatePost() {
        return
    }
    
    func subscribeToProfile() {
        return
    }
    
    func editProfile() {
        return
    }
}

//MARK: - PostCellDelegate

extension ProfileViewController: PostCellDelegate {
    
    func openScreenSubscriber(userID: String) {
        return
    }
    
    func openScreenMenuSheet() {
        let settings = SettingsSheetAssembly().viewController()
        present(settings, animated: true)
    }
    
    func openScreenWholePost() {
        let wholePost = WholePostAssembly().viewController()
        navigationController?.pushViewController(wholePost, animated: true)
    }
}


