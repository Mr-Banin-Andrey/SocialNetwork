//
//  SubscriberViewController.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 29.3.24..
//

import UIKit

final class SubscriberViewController: UIViewController, Coordinatable {
    
    //MARK: Properties
    
    typealias CoordinatorType = MainCoordinator
    var coordinator: CoordinatorType?
    
    private let viewModel: SubscriberViewModel
    
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
        $0.text = viewModel.subscriber.nickname
        return $0
    }(UILabel())
    
    //MARK: Init
    
    init(viewModel: SubscriberViewModel) {
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    //MARK: Methods
    
    func bindViewModel() {
        viewModel.onStateDidChange = { [weak self] state in
            guard let self else { return}

            switch state {
            case .initial:
                break
            case .openScreenMenu(let post):
                let settings = SettingsSheetAssembly(post: post).viewController()
                present(settings, animated: true)
            case .openScreenPost(let post):
                let wholePost = WholePostAssembly(post: post).viewController()
                navigationController?.pushViewController(wholePost, animated: true)
            case .openScreenGallery(let albums):
                let gallery = PhotoGalleryAssembly(photoGalleryType: .forUser, albums: albums).viewController()
                navigationController?.pushViewController(gallery, animated: true)
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
    
    @objc private func comeBack() {
        navigationController?.popViewController(animated: true)
    }
}

//MARK: - UITableViewDataSource

extension SubscriberViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.posts.count + 1
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
        let post = viewModel.posts[indexPath.section-1].posts[indexPath.row]
        cell.setupCell(post: post)
        return cell
    }
}

//MARK: - UITableViewDelegate

extension SubscriberViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            let view = ProfileHeaderAssembly(type: .subscriberView, user: viewModel.subscriber).view()
            view.setupHeader(numberOfPhoto: viewModel.subscriber.photos.count)
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

//MARK: - SubscriberHeaderViewDelegate

extension SubscriberViewController: ProfileHeaderViewDelegate {
    
    func openScreenGallery(albums: [AlbumCodable]) {
        viewModel.updateState(with: .didTapOpenGallery(albums))
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

extension SubscriberViewController: PostCellDelegate {
    
    func openScreenSubscriber(userID: String) {
        return
    }
    
    func openScreenMenuSheet(post: Post) {
        viewModel.updateState(with: .didTapOpenMenu(post))
    }
    
    func openScreenWholePost(post: Post) {
        viewModel.updateState(with: .didTapOpenPost(post))
    }
    
}
