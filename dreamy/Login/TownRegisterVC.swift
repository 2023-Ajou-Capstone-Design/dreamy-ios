//
//  TownRegisterVC.swift
//  dreamy
//
//  Created by 장준모 on 2023/05/08.
//

import UIKit

class TownRegisterVC: UIViewController {
    
    var dataSource: [String] = [
        "수원시 권선구 세류동", "수원시 권선구 평동", "수원시 권선구 서둔동", "수원시 권선구 구운동", "수원시 권선구 금곡동", "수원시 권선구 호매실동", "수원시 권선구 권선동", "수원시 권선구 곡선동", "수원시 권선구 입북동",
        "수원시 영통구 매탄동", "수원시 영통구 영통동", "수원시 영통구 원천동", "수원시 영통구 망포동", "수원시 영통구 광교동",
        "수원시 팔달구 행궁동", "수원시 팔달구 매교동", "수원시 팔달구 매산동", "수원시 팔달구 고등동", "수원시 팔달구 화서동", "수원시 팔달구 지동", "수원시 팔달구 우만동", "수원시 팔달구 인계동",
        "수원시 장안구 파장동", "수원시 장안구 율천동", "수원시 장안구 정자동", "수원시 장안구 영화동", "수원시 장안구 송죽동", "수원시 장안구 조원동", "수원시 장안구 연무동"
    ]
    var filteredDataSource: [String] = []
    
    var isEditMode: Bool {

        let isActive = searchController.isActive
        let isSearchBarHasText = searchController.searchBar.text?.isEmpty == false
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
    
    let searchController = UISearchController(searchResultsController: nil)
    
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
        
//        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "예시 : 수원시 영통구 원천동"
        // 내비게이션 바는 항상 표출되도록 설정
//        searchController.hidesNavigationBarDuringPresentation = false
        /// updateSearchResults(for:) 델리게이트를 사용을 위한 델리게이트 할당
        searchController.searchResultsUpdater = self
        /// 뒷배경이 흐려지지 않도록 설정
        searchController.obscuresBackgroundDuringPresentation = false
        
//        navigationItem.searchController = searchController
//        navigationItem.hidesSearchBarWhenScrolling = false
        tableView.tableHeaderView = searchController.searchBar
    }
    
    
}


extension TownRegisterVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isEditMode ? filteredDataSource.count : dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = isEditMode ? filteredDataSource[indexPath.row] : dataSource[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { //cell 클릭시
        userInfo.set(dataSource[indexPath.row], forKey: "User_Town")    // userdefault에 동네 추가
        print(isEditing ? filteredDataSource[indexPath.row] : dataSource[indexPath.row])
        
//        guard let pvc = self.presentingViewController else { return }//현재 vc

//        self.dismiss(animated: true)
        popNickname()
//        NotificationCenter.default.post(name: NSNotification.Name("TownregisterNotification"), object: nil) //동네 설정 완료 알림 보내기

    }
}

extension TownRegisterVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        filteredDataSource = dataSource.filter { $0.contains(text) }
        tableView.reloadData()
    }
}

extension TownRegisterVC{
    func popNickname() {
        print("닉네임 입력창 오픈")
        
        let nicknameAlert = UIAlertController(title: "닉네임 설정", message: nil, preferredStyle: .alert) // 닉네임 설정 알림창
        nicknameAlert.addTextField{ (nick) in
            nick.placeholder = "닉네임을 설정해주세요"
        }
        
        let okayAction = UIAlertAction(title: "등록하기", style: .default) { action in  //등록하기 버튼 클릭시 액션
            if let nickTextField = nicknameAlert.textFields?.first{
                userInfo.set(nickTextField.text, forKey: "User_AKA")
                self.dismiss(animated: false)
                NotificationCenter.default.post(name: NSNotification.Name("TownregisterNotification"), object: nil) //동네 설정 완료 알림 보내기

            }
        }   //end of registerAction
        
        nicknameAlert.addAction(okayAction)
        present(nicknameAlert, animated: false, completion: nil)
    }//end of popNickname
    
}
