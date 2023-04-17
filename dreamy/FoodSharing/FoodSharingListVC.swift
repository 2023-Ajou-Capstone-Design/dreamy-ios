//
//  FoodSharingListVC.swift
//  dreamy
//
//  Created by 장준모 on 2023/04/16.
//

import UIKit

var foodList: [FoodSharingCellModel] = []

class FoodSharingListVC: UIViewController {

    private lazy var tableView: UITableView = {
            let tableView = UITableView()
            view.addSubview(tableView)
            tableView.snp.makeConstraints { (make) in
                make.left.right.bottom.equalTo(view)
                make.top.equalTo(view).offset(40)
            }
            return tableView
        }()

//        var dataSource = [FoodSharingCellModel]()

        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .white
            setupView()
            loadData()
        }

        private func setupView() {
            tableView.register(CustomCell.self, forCellReuseIdentifier: CustomCell.identifier)
            tableView.delegate = self
            tableView.dataSource = self
        }

        private func loadData() {
//            dataSource.append(.init(leftImage: UIImage(systemName: "pencil")!, leftTitle: "연필"))
//            dataSource.append(.init(leftImage: UIImage(systemName: "bookmark.fill")!, leftTitle: "북마크"))
            FoodShareGetList {
                self.tableView.reloadData()
            }
//            tableView.reloadData()
        }

}

extension FoodSharingListVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {   // 셀 개수
        return foodList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.identifier) as? CustomCell ?? CustomCell()
        cell.bind(model: foodList[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
}
