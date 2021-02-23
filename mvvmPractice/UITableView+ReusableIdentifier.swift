//
//  UITableView+ReusableIdentifier.swift
//  mvvmPractice
//
//  Created by Jie liang Huang on 2021/2/23.
//

import UIKit

protocol ReusableCellProtocol: AnyObject {
    static var reusableID: String { get }
}

extension UITableViewCell: ReusableCellProtocol {
    static var reusableID: String {
        return String(describing: self)
    }
}

extension UITableView {

    @discardableResult
    func registerClass<T: ReusableCellProtocol>(_ type: T.Type) -> UITableView {
        register(type.self, forCellReuseIdentifier: type.reusableID)
        return self
    }

    @discardableResult
    func registerNib<T: ReusableCellProtocol>(_ type: T.Type) -> UITableView {
        register(UINib(nibName: type.reusableID, bundle: nil), forCellReuseIdentifier: type.reusableID)
        return self
    }

    @discardableResult
    func registerForCell<T: ReusableCellProtocol>(_ type: T.Type) -> UITableView {
        let nibName = String(describing: type.self)
        if Bundle.main.path(forResource: nibName, ofType: "nib") != nil {
            let nib = UINib(nibName: nibName, bundle: nil)
            register(nib, forCellReuseIdentifier: type.reusableID)
        } else {
            register(type.self, forCellReuseIdentifier: type.reusableID)
        }
        return self
    }

    @discardableResult
    func registerHeaderFooterView<T: ReusableCellProtocol>(_ type: T.Type) -> UITableView {
        register(UINib(nibName: type.reusableID, bundle: nil), forHeaderFooterViewReuseIdentifier: type.reusableID)
        return self
    }

    func dequeueReusableHeaderFooterView<T: ReusableCellProtocol>(_ type: T.Type) -> T? {
        return dequeueReusableHeaderFooterView(withIdentifier: type.reusableID) as? T
    }

    func dequeueReusableCell<T: UITableViewCell>(_ type: T.Type, indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withIdentifier: type.reusableID, for: indexPath) as? T
    }
}
