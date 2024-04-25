//
//  PhotoGalleryViewController.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 5.4.24..
//

import UIKit

final class PhotoGalleryViewController: UIViewController {
    
    enum PhotoGalleryType {
        case forUser
        case forSubscriber
    }
    
    //MARK: Properties
    
    private let viewModel: PhotoGalleryViewModel
    
    private lazy var titleLabel: UILabel = {
        $0.font = .interMedium500Font
        $0.textColor = .textAndButtonColor
        $0.text = "Фотографии"
        return $0
    }(UILabel())
    
    private lazy var firstLineView = UIView().lineView
    
    private lazy var galleryTable: UITableView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .clear
        $0.delegate = self
        $0.separatorStyle = .none
        return $0
    }(UITableView(frame: .zero, style: .grouped))
    
    private let type: PhotoGalleryType
    
    //MARK: Init
    
    init(viewModel: PhotoGalleryViewModel, type: PhotoGalleryType) {
        self.viewModel = viewModel
        self.type = type
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar(type: type)
        setupUI()
        bindViewModel()
    }
    
    //MARK: Methods
    
    func bindViewModel() {

    }
    
    private func setupNavBar(type: PhotoGalleryType) {
        let backButton = UIBarButtonItem(image: .arrowLeftImage, style: .plain, target: self, action: #selector(comeBack))
        backButton.tintColor = .textTertiaryColor
        
        let titleLabel = UIBarButtonItem(customView: titleLabel)
        self.navigationItem.leftBarButtonItems = [backButton, titleLabel]
        
        switch type {
        case .forUser:
            let rightButton = UIBarButtonItem(image: .plusImage, style: .plain, target: self, action: #selector(didTapAddPhoto))
            rightButton.tintColor = .textTertiaryColor
            self.navigationItem.rightBarButtonItem = rightButton
        case .forSubscriber:
            break
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .mainBackgroundColor
        view.addSubview(firstLineView)
        view.addSubview(galleryTable)
        
        NSLayoutConstraint.activate([
            firstLineView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            firstLineView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            firstLineView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16),

            galleryTable.topAnchor.constraint(equalTo: firstLineView.bottomAnchor),
            galleryTable.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            galleryTable.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            galleryTable.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    @objc private func didTapAddPhoto() {
        
    }
    
    @objc private func comeBack() {
        navigationController?.popViewController(animated: true)
    }
}

//MARK: - UITableViewDelegate

extension PhotoGalleryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return GalleryHeaderAssembly(galleryType: .album, albums: viewModel.albums).view()
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return GalleryHeaderAssembly(galleryType: .photosInCollection, albums: viewModel.albums).view()
    }
}
