//
//  BottomSheetVC.swift
//  dreamy
//
//  Created by 장준모 on 2023/03/25.
//

import Foundation

// ScrollableViewController: 클라이언트 코드에서 해당 프로토콜에 명시된 인터페이스에 접근
final class MyViewController: UIViewController, ScrollableViewController {
//    var datasource: [[String]] = []   //테스트용 가게명 및 카테고리
//    var dataSource = [StoreInformation]() // 임시 datasource
    var delegate: SendClickedStoreInfo?  //delegate 테스트 임시
    
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
        loadLocationsFromCSV()  //csv파일 데이터 로드
        tableView.dataSource = self //테이블뷰에 dataSource 지정
        tableView.delegate = self
    }
    
    
    
    private func loadLocationsFromCSV() {
           let path = Bundle.main.path(forResource: "1차_가게리스트", ofType: "csv")! // bundle에 있는 경로 > Calorie라는 이름을 가진 csv 파일 경로

           parseCSVAt(url: URL(fileURLWithPath: path))
           tableView.reloadData()
       }
    
    private func parseCSVAt(url:URL) {//파싱하고 데이터 삽입 함수
            do {
                
                let data = try Data(contentsOf: url)    //url을 받은 data
                let dataEncoded = String(data: data, encoding: .utf8)   //해당 date를 인코딩
                var i: Int = 0
                if let dataArr = dataEncoded?.components(separatedBy: "\n").map({$0.components(separatedBy: ",")}) {    //,로 구분해 만든
                    
                    
                    for item in dataArr where i <= 20{
                        datasource.append(item)
                        i += 1
                    }
                }
                
            } catch  {
                print("Error reading CSV file")
            }
        }
}



extension MyViewController: UITableViewDataSource { //테이블뷰 DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {   //테이블 행의 갯수 반환
        20  //일단 20개만
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {    //각 행에 대한 cell 객체 제공
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as? TableViewCell ?? TableViewCell() // 적절한 타입의 셀로 바꿈
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        cell.textLabel?.text = "cell\(indexPath.row)"
//        cell.configure(image: "home", storename: storeNameAndCategory., categoryname: <#T##String#>)
        cell.configure(storename: datasource[indexPath.row + 2][6], categoryname: datasource[indexPath.row + 2][2])
        return cell
    }
    
}

extension MyViewController: UITableViewDelegate {   //테이블뷰 Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { //셀 클릭 시

//        delegate?.sendClickedStoreGeo(Lat: Double(datasource[indexPath.row][4])!, Long: Double(datasource[indexPath.row][5])!)
        delegate?.sendClickedStoreInfo(storeInfo: datasource[indexPath.row + 2])    //델리게이트 구현 한거 보내기
        dismiss(animated: true)//바텀 시트 내리기
        print("selected \(indexPath.row)")
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {//셀 크기
        return 100
    }
}

protocol SendClickedStoreInfo{
    
    func sendClickedStoreInfo(storeInfo: [String])
}
