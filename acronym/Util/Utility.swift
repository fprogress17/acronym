//
//  Utility.swift
//  acronym
//
//  Created by Choonghun Lee on 1/26/23.
//

import Foundation
import UIKit

public struct Utility {
   public static func createTableView(delegate: UITableViewDelegate, dataSource: UITableViewDataSource,
                         cellClass: AnyClass, cellReuseIdentifier: String,
                         backgroundColor: UIColor? = .clear,
                         estimatedRowHeight: CGFloat? = UITableView.automaticDimension,
                                      rowHeight: CGFloat? = UITableView.automaticDimension) -> UITableView {
       let table = UITableView()
       table.delegate = delegate
       table.dataSource = dataSource
       table.isScrollEnabled = false
       table.alwaysBounceVertical = false
       table.clipsToBounds = false
       table.backgroundColor = backgroundColor
       table.separatorStyle = .none
       table.isScrollEnabled = true
       table.register(cellClass, forCellReuseIdentifier: cellReuseIdentifier)
       
       table.translatesAutoresizingMaskIntoConstraints = false
       guard let estimatedRowHeight = estimatedRowHeight, let rowHeight = rowHeight
       else { print("tableview error"); return table }
       table.rowHeight = rowHeight
       table.estimatedRowHeight = estimatedRowHeight
        
        return table
    }
    
    public static func createSearchbar(delegate: UISearchBarDelegate) -> UISearchBar {
        let searchBar = UISearchBar()
        searchBar.delegate = delegate
        return searchBar
    }
}
