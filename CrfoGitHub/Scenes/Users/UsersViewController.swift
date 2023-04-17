import UIKit

class UsersViewController: UIViewController {
    private lazy var usersTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    

    private var coordinator: UserCoordinator?
    private var viewModel: UsersViewModel
    
    init(coordinator: UserCoordinator? = nil,
         viewModel: UsersViewModel) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.loadServices()
        setupView()
        setupTableView()
    }
    
    private func setupTableView() {
        usersTableView.delegate = self
        usersTableView.dataSource = self
        usersTableView.register(UsersTableViewCell.self, forCellReuseIdentifier: Constants.usersCellIdentifier)
    }
}

extension UsersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        76
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(">>>>>>>Did click on \(indexPath)<<<<<<<")
    }
}

extension UsersViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        25
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.usersCellIdentifier,
                                                       for: indexPath) as? UsersTableViewCell else {
            return UITableViewCell()
        }
        
        if let data = viewModel.usersList?[indexPath.item] {
            let image = viewModel.imageService(urlAvatar: data.avatarURL ?? String())
            cell.configureCellInfo(avatar: image,
                                   loginName: data.login ?? String(),
                                   type: data.type ?? .user)
        }
        
        return cell
    }
}

extension UsersViewController: ViewCode {
    func buildHierarchy() {
        view.addSubview(usersTableView)
    }
    
    func setupConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            usersTableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            usersTableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            usersTableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            usersTableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
    
    func applyAdditionalChanges() {
        view.backgroundColor = .white
        usersTableView.reloadData()
    }
}

