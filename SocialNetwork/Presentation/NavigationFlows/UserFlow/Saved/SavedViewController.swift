//
//  SavedViewController.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 17.3.24..
//

import UIKit

final class SavedViewController: UIViewController, Coordinatable {
    
    //MARK: Properties
    
    typealias CoordinatorType = SavedCoordinator
    var coordinator: CoordinatorType?
    
    private let viewModel: SavedViewModel
    
    private lazy var savedTable: UITableView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .clear
        $0.delegate = self
        $0.dataSource = self
        $0.register(DateHeader.self, forHeaderFooterViewReuseIdentifier: DateHeader.reuseID)
        $0.register(PostCell.self, forCellReuseIdentifier: PostCell.reuseID)
        $0.separatorStyle = .none
        return $0
    }(UITableView(frame: .zero, style: .grouped))
    
    //MARK: Init
    
    init(viewModel: SavedViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        bindViewModel()
    }
    
    //MARK: Methods
    
    func bindViewModel() {

    }
    
    
    private func setupUI() {
        navigationItem.title = "Сохраненные"
        view.backgroundColor = .mainBackgroundColor
        self.view.addSubview(savedTable)
        
        NSLayoutConstraint.activate([
            self.savedTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            self.savedTable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            self.savedTable.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            self.savedTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

//MARK: - UITableViewDataSource

extension SavedViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.posts.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let postsCount = viewModel.posts[section].posts.count
        return postsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostCell.reuseID, for: indexPath) as? PostCell else {
            return UITableViewCell()
        }

        cell.delegate = self
        cell.setupCellForUser()
        let post = viewModel.posts[indexPath.section].posts[indexPath.row]
        cell.setupCell(post: post)
        return cell
    }
}

//MARK: - UITableViewDelegate

extension SavedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: DateHeader.reuseID) as? DateHeader else { return nil }
        let date = viewModel.posts[section].date
        header.setupHeader(date: DateConverter.dateString(from: date))
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 24
    }
    
}

//MARK: - ProfileHeaderViewDelegate

extension SavedViewController: PostCellDelegate {
    func openScreenSubscriber(userID: String) {
        return
    }
    
    func openScreenMenuSheet() {
        return
    }
    
    func openScreenWholePost(post: Post) {
        let wholePost = WholePostAssembly(post: post).viewController()
        navigationController?.pushViewController(wholePost, animated: true)
    }
}
