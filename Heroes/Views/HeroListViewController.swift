//
//  HeroListViewController.swift
//  Heroes
//
//  Created by Jaime Escobar on 08/03/21.
//

import UIKit

class HeroListViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    let viewModel = HeroListViewModel()
    private let refreshControl = UIRefreshControl()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    // MARK: - Functions
    private func setUpView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        bindValues()
        fetchData()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    @objc private func refresh() {
        viewModel.reload()
    }
    
    private func fetchData() {
        viewModel.getHeroes()
    }
    
    private func presentAlert(with error: NetworkError) {
        let alert = UIAlertController(title: "Oops! something went wrong", message: error.localizedDescription, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default) { (action) in
            self.refresh()
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    // MARK:- Binding
    private func bindValues() {
        viewModel.requestStatus.bind { [weak self] status in
            switch status {
                case .loading:
                    // I'd add activity indicator
                    break
                case .didLoad:
                    guard let self = self else { return }
                    self.refreshControl.endRefreshing()
                    self.tableView.reloadData()
                case .error(let error):
                    guard let self = self else { return }
                    self.presentAlert(with: error)
                    self.refreshControl.endRefreshing()
            }
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetails" {
            guard let destination = segue.destination as? HeroDetailViewController, let hero = viewModel.selectedHero else {
                return
            }
            destination.configure(with: hero)
        }
    }
    
}

// MARK: - TableView
extension HeroListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HeroTableViewCell.identifier, for: indexPath) as? HeroTableViewCell else { return UITableViewCell() }
        guard let hero = viewModel.getHeroAt(indexPath.row) else {
            return UITableViewCell()
        }
        cell.configure(with: hero)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectedHero = viewModel.getHeroAt(indexPath.row)
        performSegue(withIdentifier: "goToDetails", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row > viewModel.numberOfRows - 2 {
            viewModel.loadMoreHeroes()
        }
    }
    
}
