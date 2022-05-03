//
//  MainViewController.swift
//  Seek Photo
//
//  Created by BSergio on 02.05.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - Public Properties
    var presenter: MainPresenterProtocol!
    
    // MARK: - UI Elements
    lazy private var searcBar: UISearchController = {
        let searcher = UISearchController(searchResultsController: nil)
        searcher.searchResultsUpdater = self
        searcher.obscuresBackgroundDuringPresentation = false
        searcher.searchBar.placeholder = "Search Photo"
        
        return searcher
    }()
    
    lazy private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstaints()
        setupDelegate()
        registerCells()
    }
}

// MARK: - Setup View
extension MainViewController {
    private func setupView() {
        navigationItem.searchController = searcBar
        view.backgroundColor = .white
        view.addSubview(tableView)
    }
}

// MARK: - Setup Constraints
extension MainViewController {
    private func setupConstaints() {
        // tableView
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - Setup delegates
extension MainViewController {
    private func setupDelegate() {
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension MainViewController {
    private func registerCells() {
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.id)
    }
}

// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.model?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.id,
                                                 for: indexPath) as! MainTableViewCell
        guard let photos = presenter.model else { return cell }
        let presenterCell = MainTableViewCellPresenter(view: cell, model: photos[indexPath.row])
        cell.presenter = presenterCell
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // navigation
        let vc = DetailViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
}

// MARK: - UISearchResultsUpdating protocol
extension MainViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        print(searchText)
    }
}

extension MainViewController: MainViewProtocol {
    func setContent() {
        tableView.reloadData()
    }
    
    func success() {
        tableView.reloadData()
    }
    
    func failure(error: Error) {
        // TODO Allert
    }
}
