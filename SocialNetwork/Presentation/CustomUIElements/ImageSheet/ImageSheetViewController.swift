//
//  ImageSheetViewController.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 6.5.24..
//

import UIKit
import PhotosUI
import AVFoundation

final class ImageSheetViewController: UIViewController {
    
    //MARK: Properties
    
    typealias ViewModel = ImageSheetViewModel
    let viewModel: ViewModel
    
    private var photoPicker: PHPickerViewController?
    private var cameraPicker: UIImagePickerController?
    private var onImageSelected: ((UIImage) -> Void)?
    
    private var sizeView: CGFloat = 210
    private var imageData = Data()
    
    private lazy var changeImageLabel: UILabel = {
        $0.text = "Изменить аватар"
        $0.font = .interSemiBold600Font.withSize(22)
        $0.textColor = .textAndButtonColor
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private lazy var tableView: UITableView = {
        $0.dataSource = self
        $0.delegate = self
        $0.backgroundColor = .clear
        $0.estimatedSectionHeaderHeight = 56
        $0.estimatedRowHeight = 64
        $0.separatorStyle = .none
        $0.register(MakePhotoTableViewCell.self, forCellReuseIdentifier: MakePhotoTableViewCell.reuseID)
        $0.register(ChooseFromGalleryTableViewCell.self, forCellReuseIdentifier: ChooseFromGalleryTableViewCell.reuseID)
        $0.isScrollEnabled = false
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UITableView(frame: .zero, style: .grouped))
    
    private lazy var grabberView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .textAndButtonColor
        $0.layer.cornerRadius = 2
        return $0
    }(UIView())
    
    //MARK: Init
    
    init(viewModel: ImageSheetViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mainBackgroundColor
        
        setupUI()
        actionChangeImage()
        bindViewModel()
    }
    
    //MARK: Methods
    
    func bindViewModel() {
        viewModel.onStateDidChange = { [weak self] state in
            guard let self else { return }
            switch state {
            case .initial:
                break
                     
            case .showCamera:
                checkCameraPermission()
                
            case .showGallery:
                checkGalleryPermission()
                
            case .save:
                self.dismiss(animated: true)
                
            case .showAlertOnImageCompressionFailure:
                self.presentAlert(message: "Не удалось обработать выбранное изображение. Пожалуйста, попробуйте снова.",
                                  title: "Возникла ошибка")
            }
        }
    }
    
    private func actionChangeImage() {
        onImageSelected = { [weak self] selectedImage in
            guard let self else { return }
            let compressionQueue = DispatchQueue(label: "imageCompression",
                                                 qos: .userInitiated)
            compressionQueue.sync {
                do {
                    guard let jpegData = try selectedImage.jpegData(ofSizeLessThenOrEqualTo: 1) else { return }
                    DispatchQueue.main.async {
                        self.imageData = jpegData
                        self.viewModel.updateState(with: .didGetImage(self.imageData))
                    }
                } catch {
                    self.viewModel.updateState(with: .showAlertOnImageCompressionFailure)
                }
            }
        }
        
        if let sheet = sheetPresentationController {
            if #available(iOS 16.0, *) {
                sheet.detents = [
                    .custom { _ in
                        return self.sizeView //210
                    }]
            } else {
                sheet.detents = [.medium()]
            }
            sheet.prefersGrabberVisible = false
            sheet.preferredCornerRadius = 8
            sheet.largestUndimmedDetentIdentifier = .medium
        }
    }
    
    private func checkCameraPermission() {
        let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
        
        switch cameraAuthorizationStatus {
        case .authorized:
            openCamera()
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                if granted {
                    DispatchQueue.main.async {
                        self?.openCamera()
                    }
                } else {
                    print("Camera access denied.")
                }
            }
        case .denied, .restricted:
            print("Camera access denied.")
        @unknown default:
            break
        }
    }
    
    private func openCamera() {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            print("Camera is not available on this device.")
            return
        }
        cameraPicker = UIImagePickerController()
        cameraPicker?.sourceType = .camera
        cameraPicker?.delegate = self
        present(cameraPicker!, animated: true)
    }
    
    private func checkGalleryPermission() {
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        
        switch photoAuthorizationStatus {
        case .authorized:
            openGallery()
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { [weak self] status in
                if status == .authorized {
                    DispatchQueue.main.async {
                        self?.openGallery()
                    }
                } else {
                    print("Gallery access denied.")
                }
            }
        case .denied, .restricted, .limited:
            print("Gallery access denied.")
        @unknown default:
            break
        }
    }
    
    private func openGallery() {
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = 1
        photoPicker = PHPickerViewController(configuration: config)
        photoPicker?.delegate = self
        present(photoPicker!, animated: true)
    }
    
    private func setupUI() {
        view.addSubview(grabberView)
        view.addSubview(changeImageLabel)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            grabberView.heightAnchor.constraint(equalToConstant: 4),
            grabberView.widthAnchor.constraint(equalToConstant: 50),
            grabberView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            grabberView.topAnchor.constraint(equalTo: view.topAnchor, constant: 6),
            
            changeImageLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 36),
            changeImageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            tableView.topAnchor.constraint(equalTo: changeImageLabel.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -6),
        ])
    }
}

// MARK: - UITableViewDataSource

extension ImageSheetViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let makePhoto = tableView.dequeueReusableCell(withIdentifier: MakePhotoTableViewCell.reuseID, for: indexPath) as? MakePhotoTableViewCell,
            let chooseFromGallery = tableView.dequeueReusableCell(withIdentifier: ChooseFromGalleryTableViewCell.reuseID, for: indexPath) as? ChooseFromGalleryTableViewCell
        else { return UITableViewCell() }
        
        switch indexPath.row {
        case 0:
            return makePhoto
        case 1:
            return chooseFromGallery
        default:
            return UITableViewCell()
        }
    }
}

// MARK: - UITableViewDelegate

extension ImageSheetViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            viewModel.updateState(with: .didTapOpenCamera)
        case 1:
            viewModel.updateState(with: .didTapOpenGallery)
        default:
            break
        }
    }
}

// MARK: - PHPickerViewControllerDelegate

extension ImageSheetViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        guard let itemProvider = results.first?.itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) else {
            print("No valid image results")
            return
        }
        
        itemProvider.loadObject(ofClass: UIImage.self) { [weak self] (object, error) in
            if let error = error {
                print("Error loading image: \(error.localizedDescription)")
                return
            }
            
            if let selectedImage = object as? UIImage {
                DispatchQueue.main.async {
                    print("Selected Image set successfully")
                    self?.onImageSelected?(selectedImage)
                }
            }
        }
    }
}

// MARK: - UIImagePickerControllerDelegate & UINavigationControllerDelegate

extension ImageSheetViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let cameraImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.onImageSelected?(cameraImage)
        }
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
