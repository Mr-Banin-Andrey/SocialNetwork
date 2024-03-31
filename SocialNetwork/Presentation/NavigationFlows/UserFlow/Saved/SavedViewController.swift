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
        navigationItem.title = "Сохранненые"
    }
    
    private func setupUI() {
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
        3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
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

extension SavedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: DateHeader.reuseID) as? DateHeader else { return nil }
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 24
    }
    
}

//MARK: - ProfileHeaderViewDelegate

extension SavedViewController: PostCellDelegate {
    func openScreenSubscriber() {
        return
    }
    
    func openScreenMenuSheet() {
        return
    }
    
    func openScreenWholePost() {
        return
    }
    
    func addPostToSaved() {
        return
    }
}
