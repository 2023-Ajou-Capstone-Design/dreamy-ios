//
//  MapViewController.swift
//  dreamy
//
//  Created by 장준모 on 2023/03/25.
//

import UIKit
import FloatingPanel
import SnapKit
import Then
import Alamofire


let dbUrl = "http://3.130.31.88:5000" //api url
let moMapPointGeo = MTMapPointGeo(latitude: 37.270126, longitude: 127.048794)   // 내 위치

var items: [StoreDB] = []


class MapViewController: UIViewController, MTMapViewDelegate, SendClickedStoreInfo{


    @IBOutlet var mapSearchBar: UISearchBar!
//    var mapListVC: MapListViewController!
    
    var mapView: MTMapView? //카카오맵 뷰

    var mapPoint1: MTMapPoint?
    var poiItem1: MTMapPOIItem?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        mapView = MTMapView(frame: self.view.bounds)
                if let mapView = mapView {
                    mapView.delegate = self //델리게이트 연결
                    mapView.baseMapType = .standard //기본지도
                    

                    //현재 위치 트래킹
//                    mapView.currentLocationTrackingMode = .onWithoutHeading
                    
//                    mapView.setMapCenter(MTMapPoint(geoCoord: MTMapPointGeo(latitude: (myCurrentLocation?.latitude)!, longitude: (myCurrentLocation?.longitude)!)), zoomLevel: 3, animated: true)//지도의 센터 설정(x,y좌표, 줌 레벨 설정)
                    mapView.setMapCenter(MTMapPoint(geoCoord: moMapPointGeo), zoomLevel: 1, animated: true) //내집 위치로 카메라 가운데 이동
                    
                    self.view.addSubview(mapView)   //뷰 추가
                    self.view.sendSubviewToBack(mapView)    //뷰 맨뒤로
                    
                    //서버 연결 테스트
                    MyPositionRequest(){
                        self.makeMarker()
                    }
//                    makeMarker()
                }
        
    }//end viewDidLoad()

    override func viewWillDisappear(_ animated: Bool) { // mapView의 모든 마커 제거
        for item in mapView!.poiItems{
            mapView!.remove(item as? MTMapPOIItem)
        }
    }
    
//    func mapView(_ mapView: MTMapView, updateCurrentLocation location: MTMapPoint, withAccuracy accuracy: MTMapLocationAccuracy) {    //현 위치 받아오기
//            let currentLocationPointGeo = location.mapPointGeo
//        myCurrentLocation?.latitude = currentLocationPointGeo().latitude
//        myCurrentLocation?.longitude = currentLocationPointGeo().longitude
//        print("Current Location: (\(myCurrentLocation?.latitude!), \(myCurrentLocation?.longitude!))")
//        }
    
    func sendClickedStoreInfo(storeItem: StoreDB) {    //셀 클릭시 화면 이동
        
        mapView?.setMapCenter(MTMapPoint(geoCoord: MTMapPointGeo(latitude: storeItem.StorePointLat, longitude: storeItem.StorePointLng)), zoomLevel: 1, animated: true)
                                         
        let poilItem = MTMapPOIItem()
        poilItem.mapPoint = MTMapPoint(geoCoord: MTMapPointGeo(latitude: storeItem.StorePointLat, longitude: storeItem.StorePointLng))
        poilItem.markerType = .yellowPin
        poilItem.itemName = storeItem.StoreName
        mapView?.addPOIItems([poilItem])
        print("화면이동")
        
        storeDetailRequest(StoreID: storeItem.StoreID, StoreType: storeItem.StoreType){ //가게 클릭 리퀘스트 요청
            
            
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let storeDetailVC = storyboard.instantiateViewController(identifier: "StoreDetailView") as? StoreDetailViewController
            
            
            guard let sheet = storeDetailVC?.presentationController as? UISheetPresentationController else{
                
                print("sheet를 불러오지 못함")
                return
            }
            storeDetailVC?.configure(item: items[0])
            sheet.detents = [.medium(), .large()]
            sheet.largestUndimmedDetentIdentifier = .large
            sheet.prefersGrabberVisible = true
            self.present(storeDetailVC!, animated: true)
            
            
//            StoreDetailViewController().configure(item: items[0])

        }

    }
    
    
   

//    prepare 함수 : 해당 세그웨이가 해당 뷰 컨트롤러로 전환되기 직전에 호출되는 함수
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        postMyPositionRequest()
    }

    func makeMarker(){

            /*
            저는 서버 api를 통해 가져온 데이터를 resultList에 담았어요
            이름, 좌표, 주소 등을 담은 구조체를 담은 배열이에요
            */

            // cnt로 마커의 tag를 구분
        
            var cnt = 0
        for item in items {
            self.mapPoint1 = MTMapPoint(geoCoord: MTMapPointGeo( latitude: Double(item.StorePointLat), longitude: Double(item.StorePointLng)) )
                poiItem1 = MTMapPOIItem()
                // 핀 색상 설정
                poiItem1?.markerType = MTMapPOIItemMarkerType.yellowPin
                poiItem1?.mapPoint = mapPoint1
                // 핀 이름 설정
            poiItem1?.itemName = item.StoreName
                // 태그 설정
            poiItem1?.tag = item.StoreID
                // 맵뷰에 추가!
                mapView!.add(poiItem1)
                cnt += 1
            }
        print(items)
        print("핀 추가 완료 - makeMarker")
        }

    func mapView(_ mapView: MTMapView!, touchedCalloutBalloonOf poiItem: MTMapPOIItem!) {//마커 클릭 이벤트
            // 인덱스는 poiItem의 태그로 접근
            let index = poiItem.tag
        }

    func presentationController(_ controller: UIPresentationController, viewControllerForAdaptivePresentationStyle style: UIModalPresentationStyle) -> UIViewController? {
        return self
    }

}//end of MapViewController Class


extension MapViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){//검색 버튼 누를 시
        let keyword = searchBar.text! // 검색바에 입력된 키워드 가져오기
        items.removeAll()   // 데이터 초기화
        viewWillDisappear(true) //모든 마커 지우기
        dismissKeyboard()   //키보드 내리기
        keywordSearchRequest(keyword: keyword){ //서버로 keyword request 날리기
            //Completion Handler
            
            keywordSearchRequest(keyword: keyword) {
                let cVC: CustomBottomSheetVC = CustomBottomSheetVC()
                let bottomSheetViewController = BottomSheetViewController(isTouchPassable: false, contentViewController: cVC )
                cVC.delegate = self // 바텀시트와 델리게이트 연결
                self.present(bottomSheetViewController, animated: true)
                print("키워드 검색 클릭")
                
            }
        }
        
        func dismissKeyboard(){ //키보드 내리기
            mapSearchBar.resignFirstResponder()
        }
    }
}

extension MapViewController{    //버튼 처리
    
    @IBAction func categoryBtn(_ sender: UIButton) {//음식점 카테고리 버튼
        chooseCategoryRequest(Category: 1) {
            
            let cVC: CustomBottomSheetVC = CustomBottomSheetVC()
            let bottomSheetViewController = BottomSheetViewController(isTouchPassable: false, contentViewController: cVC )
            cVC.delegate = self // 바텀시트와 델리게이트 연결
            self.present(bottomSheetViewController, animated: true)

            print("음식점 카테고리 버튼 클릭")
        }
       
    }
    
    @IBAction func cafeBtn(_ sender: UIButton) {
        chooseSubCategoryRequest(Category: 1, SubCategory: 6) {
            let cVC: CustomBottomSheetVC = CustomBottomSheetVC()
            let bottomSheetViewController = BottomSheetViewController(isTouchPassable: false, contentViewController: cVC )
            cVC.delegate = self // 바텀시트와 델리게이트 연결
            self.present(bottomSheetViewController, animated: true)
            print("카페 카테고리 버튼 클릭")
        }
    }
    
    @IBAction func convenienceBtn(_ sender: UIButton) { //편의점 버튼
        chooseSubCategoryRequest(Category: 2, SubCategory: 2) {
            let cVC: CustomBottomSheetVC = CustomBottomSheetVC()
            let bottomSheetViewController = BottomSheetViewController(isTouchPassable: false, contentViewController: cVC )
            cVC.delegate = self // 바텀시트와 델리게이트 연결
            self.present(bottomSheetViewController, animated: true)
            print("편의점 카테고리 버튼 클릭")
        }
    }
    @IBAction func martBtn(_ sender: UIButton) {    //마트 버튼
        chooseSubCategoryRequest(Category: 2, SubCategory: 1) {
            let cVC: CustomBottomSheetVC = CustomBottomSheetVC()
            let bottomSheetViewController = BottomSheetViewController(isTouchPassable: false, contentViewController: cVC )
            cVC.delegate = self // 바텀시트와 델리게이트 연결
            self.present(bottomSheetViewController, animated: true)
            print("마트 카테고리 버튼 클릭")
        }
    }
    @IBAction func eduBtn(_ sender: UIButton) { //교육 버튼
        chooseCategoryRequest(Category: 4) {
            let cVC: CustomBottomSheetVC = CustomBottomSheetVC()
            let bottomSheetViewController = BottomSheetViewController(isTouchPassable: false, contentViewController: cVC )
            cVC.delegate = self // 바텀시트와 델리게이트 연결
            self.present(bottomSheetViewController, animated: true)
            print("교육 카테고리 버튼 클릭")
        }

    }
    @IBAction func dreamBtn(_ sender: UIButton) {// 가맹점 버튼
//        let storeDetailVC = StoreDetailViewController()
//
//        if let sheet = storeDetailVC.sheetPresentationController{
//            sheet.detents = [.medium(), .large()]
//            print("바텀 시트 오픈")
//        }
//        self.present(storeDetailVC, animated: true, completion: nil)
        
//        let navi = UINavigationController(rootViewController: StoreDetailViewController())
//        self.present(navi, animated: true, completion: nil)

        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let storeDetailVC = storyboard.instantiateViewController(identifier: "StoreDetailView")
        
        guard let sheet = storeDetailVC.presentationController as? UISheetPresentationController else{
            print("sheet를 불러오지 못함")
            return
        }
        sheet.detents = [.medium(), .large()]
        sheet.largestUndimmedDetentIdentifier = .large
        sheet.prefersGrabberVisible = true
        
        self.present(storeDetailVC, animated: true)
        
    }
    @IBAction func goodBtn(_ sender: UIButton) {//선한영향력 버튼
    }
    
    @IBAction func bookMarkBtn(_ sender: UIButton) {
        bookMarkList(){
            let cVC: CustomBottomSheetVC = CustomBottomSheetVC()
            let bottomSheetViewController = BottomSheetViewController(isTouchPassable: false, contentViewController: cVC )
            cVC.delegate = self // 바텀시트와 델리게이트 연결
            self.present(bottomSheetViewController, animated: true)
            print("북마크 리스트 조회 버튼 클릭")
        }
    }
    
    
    
}


