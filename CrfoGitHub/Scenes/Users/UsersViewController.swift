import UIKit

class UsersViewController: UIViewController {
    private lazy var userSearchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.translatesAutoresizingMaskIntoConstraints = false
        bar.searchBarStyle = .default
        bar.placeholder = "Type an username..."
        bar.delegate = self
        return bar
    }()
    
    private lazy var usersTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var emptyListLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        label.numberOfLines = 0
        label.text = Constants.emptyListMessage
        label.tintColor = .darkGray
        return label
    }()

    private var coordinator: UserCoordinator?
    private var viewModel: UsersViewModel
    
    private var model: AllUsersModel? {
        didSet {
           self.usersTableView.reloadData()
        }
    }
    
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
        setupView()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.delegate = self
        viewModel.loadServices()
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
        if let model = self.model?[indexPath.item] {
            coordinator?.moveToDetail(login: model.login ?? String())
        }
    }
}

extension UsersViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.usersCellIdentifier,
                                                       for: indexPath) as? UsersTableViewCell else {
            return UITableViewCell()
        }
        
        if let data = model?[indexPath.item] {
            let image = viewModel.imageService(urlAvatar: data.avatarURL ?? String())
            cell.configureCellInfo(avatar: image,
                                   loginName: data.login ?? String(),
                                   type: data.type ?? .user)
        }
        
        return cell
    }
}

extension UsersViewController: UsersViewModelDelegate {
    func successList(model: AllUsersModel) {
        DispatchQueue.main.async {
            self.model = model
        }
    }
    
    func errorList() {
        print(">>>>ERROR<<<<")
    }
}

extension UsersViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            self.model =  viewModel.usersList
            self.usersTableView.isHidden = false
            self.emptyListLabel.isHidden = true
        } else {
            let filteredUsers = model?.filter( { $0.login?.range(of: searchText, options: .caseInsensitive) != nil } )
            if filteredUsers?.count == 0 {
                self.usersTableView.isHidden = true
                self.emptyListLabel.isHidden = false
            } else {
                self.usersTableView.isHidden = false
                self.emptyListLabel.isHidden = true
            }
        }
    }
}

extension UsersViewController: ViewCode {
    func buildHierarchy() {
        view.addSubview(userSearchBar)
        view.addSubview(usersTableView)
        view.addSubview(emptyListLabel)
    }
    
    func setupConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            userSearchBar.topAnchor.constraint(equalTo: safeArea.topAnchor),
            userSearchBar.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            userSearchBar.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            userSearchBar.heightAnchor.constraint(equalToConstant: 48),
            
            emptyListLabel.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            emptyListLabel.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor),
            
            usersTableView.topAnchor.constraint(equalTo: userSearchBar.bottomAnchor),
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

