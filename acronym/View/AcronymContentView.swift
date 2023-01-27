//
//  ContentView.swift
//  acronym
//
//  Created by Choonghun Lee on 1/26/23.
//

import Foundation
import UIKit
import Combine

extension AcronymContentView: UITableViewDataSource, UITableViewDelegate {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.acronymResult.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return displayTableViewCell(indexPath: indexPath)
    }
}

extension AcronymContentView: UISearchBarDelegate {
    
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        guard let searchText = searchBar.searchTextField.text else { print("error"); return }
        if searchText.isEmpty {
            print("no text")
            return
        }
        viewModel.fetchData(target: searchText)
        print(searchText)
    }

    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.acronymResult = [LFSData]()
    }
    
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    }

}

public class AcronymContentView: UIView {
    private let viewModel: AcronymViewModel
    private typealias ViewModel = AcronymViewModel
   
    private var cancellables: Set<AnyCancellable> = []
    
    lazy var tableView: UITableView = {
        let table = Utility.createTableView(delegate: self, dataSource: self, cellClass: DisplayTableViewCell.self,
                                            cellReuseIdentifier: viewModel.cellId, backgroundColor: .white,
                                            estimatedRowHeight: ViewModel.tableEstimatedRowHeight,
                                            rowHeight: UITableView.automaticDimension)
        
        table.translatesAutoresizingMaskIntoConstraints = false
      
        return table
    }()
    
    lazy var searchBar: UISearchBar = {
        let searchBar = Utility.createSearchbar(delegate: self)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "enter acronym"
        searchBar.isTranslucent = false
        searchBar.showsCancelButton = true
        return searchBar
    }()
    
    
    // MARK: - INITIALIZERS:
    init(viewModel: AcronymViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupUI()
    }
    
    @available (*, unavailable) required init?(coder: NSCoder) { nil }
    
    // MARK: - SETUP UI
    private func setupUI() {
        
        self.backgroundColor = .white
        addTableViewAndSearchBar()
        binding()
    }
    
    private func addTableViewAndSearchBar() {
        addSubview(tableView)
        addSubview(searchBar)
        tableView.backgroundColor = .yellow
        searchBar.backgroundColor = .red
        
        self.leadingAnchor.constraint(equalTo: tableView.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: tableView.trailingAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: tableView.bottomAnchor).isActive = true
        
        self.topAnchor.constraint(equalTo: searchBar.topAnchor).isActive = true
        searchBar.bottomAnchor.constraint(equalTo: tableView.topAnchor).isActive = true
        self.leadingAnchor.constraint(equalTo: searchBar.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: searchBar.trailingAnchor).isActive = true
    }
    
    private func displayTableViewCell(indexPath: IndexPath) -> DisplayTableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.cellId,
                                                       for: indexPath) as? DisplayTableViewCell
        else { print("cell error"); return DisplayTableViewCell() }
        let result = viewModel.acronymResult[indexPath.row]
        // cell.textLabel?.text = String(indexPath.row)
        cell.textLabel?.text = result.lf
        return cell
    }
    
    func binding() {
        viewModel.$acronymResult.sink { [weak self] _ in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
                    }.store(in: &cancellables)
    }
}
