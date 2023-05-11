//
//  FoodSharingListVC.swift
//  dreamy
//
//  Created by 장준모 on 2023/04/16.
//

import UIKit

var foodList: [FoodSharingCellModel] = []

class FoodSharingListVC: UIViewController {
    
    var delegate: sendFoodSharingDetail?    // 셀 클릭시 푸드쉐어링 글 상세 delegate
    let foodDetailVC = FoodDetailVC()


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
            
            self.view.sendSubviewToBack(tableView)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {// 셀 클릭시
        

//        FoodShareDetail(userID: foodList[indexPath.row].UserID, writingID: foodList[indexPath.row].WritingID){
//
//        }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let foodDetailVC = storyboard.instantiateViewController(withIdentifier: "FoodDetailVC") as? FoodDetailVC
        
        foodDetailVC?.foodGetDetail(foodDetail: foodList[indexPath.row]){
            self.navigationController?.pushViewController(foodDetailVC!, animated: true) // push

        }
        
//        delegate?.sendFoodSharingDetailInfo(foodDetail: foodList[indexPath.row])    //해당 가게 cell 전달
        
//        DispatchQueue.main.async{
//            self.show(foodDetailVC!, sender: self)
//        }

//        self.show(foodDetailVC!, sender: self)
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {   // 셀 개수
        return foodList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.identifier) as? CustomCell ?? CustomCell()
        cell.bind(model: foodList[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

protocol sendFoodSharingDetail{
    
    func sendFoodSharingDetailInfo(foodDetail: FoodSharingCellModel)
    
}


