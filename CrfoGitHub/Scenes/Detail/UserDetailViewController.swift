import UIKit

final class UserDetailViewController: UIViewController {
    private lazy var userImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
//        imageView.layer.cornerRadius = (frame.height / 2)
        return imageView
    }()
    
    private lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var repoTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    var login: String?
    private var userInfo: UsersModel?
    
    private var reposList: DetailModel? {
        didSet {
            self.repoTableView.reloadData()
        }
    }
    
    
    private var viewModel: UserDetailViewModel
    
    init(viewModel: UserDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.delegate = self
        DispatchQueue.main.async {
            self.viewModel.loadData(login: self.login ?? String())
        }
    }
    
    private func setupTableView() {
        repoTableView.delegate = self
        repoTableView.dataSource = self
        repoTableView.register(RepoTableViewCell.self, forCellReuseIdentifier: Constants.repoCellIdentifier)
    }
}

extension UserDetailViewController: UserDetailViewModelProtocol {
    func repositoryListSuccess(model: DetailModel) {
        guard let user = model?.first?.owner else {
            return
        }
        
        DispatchQueue.main.async {
            self.userNameLabel.text = user.login?.uppercased()
            self.reposList = model
            self.viewModel.imageService(urlAvatar: user.avatarURL ?? String())
        }
    }
    
    func userImageSuccess(avatar: UIImage) {
        self.userImage.image = avatar
    }
}

extension UserDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        reposList??.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.repoCellIdentifier,
                                                       for: indexPath) as? RepoTableViewCell else {
            return UITableViewCell()
        }
        
        if let data = reposList??[indexPath.item] {
            let created = data.createdAt?.formatStringDate() ?? String()
            cell.setupCellInfo(name: data.name ?? String(), created: created)
        }
        
        return cell
    }
}

extension UserDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        76
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if let model = self.reposList?[indexPath.item] {
////            coordinator?.moveToDetail(login: model.login ?? String())
//            print(model.first)
//        }
    }
}


extension UserDetailViewController : ViewCode {
    func buildHierarchy() {
        view.addSubview(userImage)
        view.addSubview(userNameLabel)
        view.addSubview(repoTableView)
    }
    
    func setupConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            userImage.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 24),
            userImage.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            userImage.heightAnchor.constraint(equalToConstant: 150),
            userImage.widthAnchor.constraint(equalToConstant: 150),
            
            userNameLabel.topAnchor.constraint(equalTo: userImage.bottomAnchor, constant: 16),
            userNameLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            userNameLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            
            repoTableView.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 16),
            repoTableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            repoTableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            repoTableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -8)
        ])
    }
    
    func applyAdditionalChanges() {
        view.backgroundColor = .white
        userImage.clipsToBounds = true
        userImage.layer.masksToBounds = false
        userImage.layer.cornerRadius = (userImage.frame.height / 2)
    }
}
