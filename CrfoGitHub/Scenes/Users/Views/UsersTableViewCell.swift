import UIKit

final class UsersTableViewCell: UITableViewCell {
    private lazy var mainStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [avatar, labelsStack, icon])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.contentMode = .scaleAspectFit
        stack.spacing = 8
        return stack
    }()
    
    lazy var avatar: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = (self.frame.height / 2)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var labelsStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nameLabel, typeLabel])
        stack.axis = .vertical
        stack.contentMode = .scaleAspectFit
        stack.distribution = .fillProportionally
        return stack
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var typeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var icon: UIImageView = {
        let image = UIImage(systemName: Constants.rightArrow)
        image?.withTintColor(.darkGray)
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .center
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        self.avatar.image = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCellInfo(avatar: UIImage, loginName: String, type: TypeEnum) {
        self.avatar.image = avatar
        self.nameLabel.text = loginName
        self.typeLabel.text = type.rawValue.lowercased()
    }

}

extension UsersTableViewCell: ViewCode {
    func buildHierarchy() {
        contentView.addSubview(mainStack)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            avatar.heightAnchor.constraint(equalToConstant: 52),
            avatar.widthAnchor.constraint(equalToConstant: 52),
            
            icon.heightAnchor.constraint(equalToConstant: 32),
            icon.widthAnchor.constraint(equalToConstant: 32),
            
            mainStack.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mainStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func applyAdditionalChanges() {
    }
}


