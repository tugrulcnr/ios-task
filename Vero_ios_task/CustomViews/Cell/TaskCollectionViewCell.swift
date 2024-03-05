//
//  TaskCollectionViewCell.swift
//  Vero_ios_task
//
//  Created by ertugrul on 4.03.2024.
//

import UIKit

class TaskCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "TaskCollectionViewCell"
    
    
    let taskLabel = UILabel()
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureSubviews() {
        // Configure taskLabel
        taskLabel.font = UIFont.boldSystemFont(ofSize: 16)
        taskLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(taskLabel)
        
        // Configure titleLabel
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        
        // Configure descriptionLabel
        descriptionLabel.font = UIFont.systemFont(ofSize: 12)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(descriptionLabel)
        
        
        NSLayoutConstraint.activate([
            taskLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            taskLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            
            titleLabel.leadingAnchor.constraint(equalTo: taskLabel.leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: taskLabel.bottomAnchor, constant: 4),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: taskLabel.leadingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -8)
        ])
    }
    
    func configure(with task: Task) {
        taskLabel.text = task.task
        titleLabel.text = task.title
        titleLabel.textColor = .systemBackground
        descriptionLabel.text = task.description
        if let color = UIColor(hex: task.colorCode) {backgroundColor = color}
        layer.cornerRadius = 10
    }
}

