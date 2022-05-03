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
        searcBar.searchBar.delegate = self
    }
}

// MARK: -
extension MainViewController: UISearchBarDelegate {
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        guard let keyword = searchBar.text else { return}
        if keyword.isEmpty { return }
        presenter.fetchByKeyword(for: keyword)
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
        guard let photos = presenter.model else { return }
        presenter.tappedForCell(model: photos[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
}



// MARK: - MainViewProtocol
extension MainViewController: MainViewProtocol {
    func presentDetailVC(model: DetailModel) {
        let detailViewConroller = DetailViewController()
        let presenterDetail = DetailPresenter(view: detailViewConroller, model: model)
        detailViewConroller.presenter = presenterDetail
        navigationController?.pushViewController(detailViewConroller, animated: true)
    }
    
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
