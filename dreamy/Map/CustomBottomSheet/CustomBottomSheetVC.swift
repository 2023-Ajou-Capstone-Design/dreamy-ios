//
//  BottomSheetVC.swift
//  dreamy
//
//  Created by 장준모 on 2023/03/25.
//

import Foundation

// ScrollableViewController: 클라이언트 코드에서 해당 프로토콜에 명시된 인터페이스에 접근
final class CustomBottomSheetVC: UIViewController, ScrollableViewController {

    var delegate: SendClickedStoreInfo?  //delegate 
    
    private let tableView = SelfSizingTableView(maxHeight: UIScreen.main.bounds.height * 0.7).then {    //tableView 셀프사이징
        $0.allowsSelection = true   //선택 가능한지
        $0.backgroundColor = UIColor.clear
        $0.separatorStyle = .none
        $0.bounces = true
        $0.showsVerticalScrollIndicator = true
        $0.contentInset = .zero
        $0.indicatorStyle = .black
        $0.estimatedRowHeight = 34.0
        $0.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
    }
    //end SelfSizing

    var scrollView: UIScrollView {
        tableView
    }

    init() {
        super.init(nibName: nil, bundle: nil)
        setUpView()
    }
    required init?(coder: NSCoder) {
        fatalError()
    }

    private func setUpView() {
        view.addSubview(tableView)

        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        tableView.dataSource = self //테이블뷰에 dataSource 지정
        tableView.delegate = self
    }
    
}//end CustomBottomSheetVC



extension CustomBottomSheetVC: UITableViewDataSource { //테이블뷰 DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {   //테이블 행의 갯수 반환
        20  //일단 20개만
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {    //각 행에 대한 cell 객체 제공
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as? TableViewCell ?? TableViewCell() // 적절한 타입의 셀로 바꿈
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        cell.textLabel?.text = "cell\(indexPath.row)"
//        cell.configure(image: "home", storename: storeNameAndCategory., categoryname: <#T##String#>)
//        cell.configure(storename: datasource[indexPath.row + 2][6], categoryname: datasource[indexPath.row + 2][2])
        
        cell.configure(storename: items[indexPath.row].StoreName, categoryname: items[indexPath.row].Category!) // 가게 이름, 카테고리, (운영시간) 띄우기
        
        return cell
    }
    
}

extension CustomBottomSheetVC: UITableViewDelegate {   //테이블뷰 Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { //셀 클릭 시

//        delegate?.sendClickedStoreInfo(storeInfo: datasource[indexPath.row + 2])    //셀 클릭 시 델리게이트 구현 한거 보내기
        delegate?.sendClickedStoreInfo(storeItem: items[indexPath.row])    //해당 셀의 가게 Item 전달
        dismiss(animated: true)//바텀 시트 내리기
        print("selected \(indexPath.row)")
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {//셀 크기
        return 50
    }
}

protocol SendClickedStoreInfo{  // 셀 클릭 프로토콜 
    
    func sendClickedStoreInfo(storeItem: StoreDB)
}


