//
//  ViewController.swift
//  acronym
//
//  Created by Choonghun Lee on 1/26/23.
//

import UIKit


class ViewController: UIViewController {
    internal let viewModel: AcronymViewModel
    private typealias ViewModel = AcronymViewModel
    internal let contentView: AcronymContentView
    
    var pageContentView: UIView
    static let pageViewNibName = "ViewController"
   
    public init(viewModel: AcronymViewModel) {
        self.viewModel = viewModel
        self.contentView = AcronymContentView(viewModel: self.viewModel)
        self.pageContentView = contentView
       
        super.init(nibName: Self.pageViewNibName, bundle: Bundle.main)
    }
    
    @available (*, unavailable) required public init?(coder aDecoder: NSCoder) { nil }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addPageView()
    }

    func addPageView() {
        pageContentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pageContentView)
        let guide = view.layoutMarginsGuide
        guide.topAnchor.constraint(equalTo: pageContentView.topAnchor).isActive = true
        guide.bottomAnchor.constraint(equalTo: pageContentView.bottomAnchor).isActive = true
        guide.leadingAnchor.constraint(equalTo: pageContentView.leadingAnchor).isActive = true
        guide.trailingAnchor.constraint(equalTo: pageContentView.trailingAnchor).isActive = true
    }

    
}

