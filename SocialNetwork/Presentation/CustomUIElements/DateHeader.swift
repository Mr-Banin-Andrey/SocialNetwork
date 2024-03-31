//
//  DateHeader.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 29.3.24..
//

import UIKit

final class DateHeader: UITableViewHeaderFooterView {
    
    static let reuseID = "DateHeaderID"
    
    //MARK: Properties
    
    private lazy var lineFirstView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.heightAnchor.constraint(equalToConstant: 1).isActive = true
        $0.backgroundColor = .textSecondaryColor
        return $0
    }(UIView())
    
    private lazy var lineSecondView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.heightAnchor.constraint(equalToConstant: 1).isActive = true
        $0.backgroundColor = .textSecondaryColor
        return $0
    }(UIView())
    
    private lazy var dateLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 10
        $0.layer.borderColor = UIColor.textSecondaryColor.cgColor
        $0.textColor = .textSecondaryColor
        $0.text = "12 июля"
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //TODO: - сделать загрузку данных из базы 
//    func setupHeader() {
//        dateLabel.text =
//    }
    
    private func setupUI() {
        self.addSubview(dateLabel)
        self.addSubview(lineFirstView)
        self.addSubview(lineSecondView)
        
        
        NSLayoutConstraint.activate([
            dateLabel.heightAnchor.constraint(equalToConstant: 24),
            dateLabel.widthAnchor.constraint(equalToConstant: 100),
            dateLabel.topAnchor.constraint(equalTo: self.topAnchor),
            dateLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            dateLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            lineFirstView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            lineFirstView.trailingAnchor.constraint(equalTo: self.dateLabel.leadingAnchor, constant: -10),
            lineFirstView.centerYAnchor.constraint(equalTo: self.dateLabel.centerYAnchor),
            
            lineSecondView.leadingAnchor.constraint(equalTo: self.dateLabel.trailingAnchor, constant: 10),
            lineSecondView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            lineSecondView.centerYAnchor.constraint(equalTo: self.dateLabel.centerYAnchor),
        ])
    }
}
