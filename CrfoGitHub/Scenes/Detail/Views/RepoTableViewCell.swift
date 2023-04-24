//
//  RepoTableViewCell.swift
//  CrfoGitHub
//
//  Created by Fellipe Ricciardi Chiarello on 4/24/23.
//

import UIKit

final class RepoTableViewCell: UITableViewCell {
    private lazy var mainStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nameLabel,
                                                  dateLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.contentMode = .scaleAspectFit
        return stack
    }()
    
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCellInfo(name: String, created: String) {
        nameLabel.text = name
        dateLabel.text = created
    }
}

extension RepoTableViewCell: ViewCode {
    func buildHierarchy() {
        addSubview(mainStack)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: topAnchor),
            mainStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainStack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func applyAdditionalChanges() {}
}
