//
//  TownRegisterVC.swift
//  dreamy
//
//  Created by 장준모 on 2023/05/08.
//

import UIKit

class TownRegisterVC: UIViewController {

    var dataSource: [String] = ["수원시 영통구 원천동", "수원시 영통구 매탄동", "수원시 팔달구 우만동", "수원시 팔달구 인계동", "수원시 영통구 광교동"]
        var filteredDataSource: [String] = []

        var isEditMode: Bool {
            let searchController = navigationItem.searchController
            let isActive = searchController?.isActive ?? false
            let isSearchBarHasText = searchController?.searchBar.text?.isEmpty == false
            return isActive && isSearchBarHasText
        }

        lazy var tableView: UITableView = {
            let view = UITableView()
            view.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
            view.delegate = self
            view.dataSource = self
            view.keyboardDismissMode = .onDrag

            return view
        }()
    
    override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .white
            title = "타이틀"

            view.addSubview(tableView)
            tableView.translatesAutoresizingMaskIntoConstraints = false
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true

            setupSearchController()
        }

        private func setupSearchController() {

            let searchController = UISearchController(searchResultsController: nil)
            searchController.searchBar.placeholder = "검색(placeholder)"
            // 내비게이션 바는 항상 표출되도록 설정
            searchController.hidesNavigationBarDuringPresentation = false
            /// updateSearchResults(for:) 델리게이트를 사용을 위한 델리게이트 할당
            searchController.searchResultsUpdater = self
            /// 뒷배경이 흐려지지 않도록 설정
            searchController.obscuresBackgroundDuringPresentation = false

            navigationItem.searchController = searchController
            navigationItem.hidesSearchBarWhenScrolling = false
        }
    

}


extension TownRegisterVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isEditMode ? filteredDataSource.count : dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {//셀 클릭시
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = isEditMode ? filteredDataSource[indexPath.row] : dataSource[indexPath.row]
        userInfo.set(dataSource[indexPath.row], forKey: "User_Town")
        return cell!
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(isEditing ? filteredDataSource[indexPath.row] : dataSource[indexPath.row])
    }
}

extension TownRegisterVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        filteredDataSource = dataSource.filter { $0.contains(text) }
        tableView.reloadData()
    }
}
