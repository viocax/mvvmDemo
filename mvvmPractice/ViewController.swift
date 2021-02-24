//
//  ViewController.swift
//  mvvmPractice
//
//  Created by Jie liang Huang on 2021/2/17.
//

import UIKit
import RxSwift
import RxRelay
import RxCocoa

class ViewController: UIViewController {
    private let tableView: UITableView = .init()
    private let viewModel: ViewModel = .init()
    private let disposeBag: DisposeBag = .init()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindView()
    }
}

// MARK: - private
private extension ViewController {
    func setupView() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.registerClass(UITableViewCell.self)
    }
    func bindView() {
        let input = ViewModel.Input(trigger: rx.viewWillAppear.asDriver())
        let output = viewModel.transform(input)

        output.item
            .drive(tableView.rx.items)(cellforRowAt)
            .disposed(by: disposeBag)
        
    }
    func cellforRowAt(_ tableView: UITableView, row: Int, element: String) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(UITableViewCell.self, indexPath: IndexPath(row: row, section: 0)) ?? .init()
        cell.textLabel?.text = element
        return cell
    }
}
