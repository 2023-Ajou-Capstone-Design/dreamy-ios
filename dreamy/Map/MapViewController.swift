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

class MapViewController: UIViewController, MTMapViewDelegate, SendClickedStoreInfo{

    
    @IBOutlet var mapSearchBar: UISearchBar!
//    var mapListVC: MapListViewController!
    
    var mapView: MTMapView? //카카오맵 뷰
    var myCurrentLocation: LocationInfo?
    
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
                    makeMarker(result: postMyPositionRequest())
//                    postMyPositionRequest()
                }
        
    }//end viewDidLoad()

//    override func viewWillDisappear(_ animated: Bool) { // mapView의 모든 마커 제거
//        for item in mapView!.poiItems{
//            mapView!.remove(item as? MTMapPOIItem)
//        }
//    }
    
//    func mapView(_ mapView: MTMapView, updateCurrentLocation location: MTMapPoint, withAccuracy accuracy: MTMapLocationAccuracy) {    //현 위치 받아오기
//            let currentLocationPointGeo = location.mapPointGeo
//        myCurrentLocation?.latitude = currentLocationPointGeo().latitude
//        myCurrentLocation?.longitude = currentLocationPointGeo().longitude
//        print("Current Location: (\(myCurrentLocation?.latitude!), \(myCurrentLocation?.longitude!))")
//        }
    
    func sendClickedStoreInfo(storeInfo: [String]) {    //셀 클릭시 화면 이동
        mapView?.setMapCenter(MTMapPoint(geoCoord: MTMapPointGeo(latitude: Double(storeInfo[4])!, longitude: Double(storeInfo[5])!)), zoomLevel: 1, animated: true)
        let poilItem = MTMapPOIItem()
        poilItem.mapPoint = MTMapPoint(geoCoord: MTMapPointGeo(latitude:Double(storeInfo[4])!, longitude: Double(storeInfo[5])!))
        poilItem.markerType = .redPin
        poilItem.itemName = storeInfo[6]
        mapView?.addPOIItems([poilItem])
        print("화면이동")
    }
    
    
    @IBAction func categoryBtn(_ sender: UIButton) {//카테고리 버튼
        let cVC: MyViewController = MyViewController()
//        let bottomSheetViewController = BottomSheetViewController(isTouchPassable: false, contentViewController: MyViewController() )
        let bottomSheetViewController = BottomSheetViewController(isTouchPassable: false, contentViewController: cVC )
        cVC.delegate = self
        present(bottomSheetViewController, animated: true)
        print("카테고리 버튼 클릭")
    }
    
    

//    prepare 함수 : 해당 세그웨이가 해당 뷰 컨트롤러로 전환되기 직전에 호출되는 함수
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//    }

    func makeMarker(result: MyPositionModel){

            /*
            저는 서버 api를 통해 가져온 데이터를 resultList에 담았어요
            이름, 좌표, 주소 등을 담은 구조체를 담은 배열이에요
            */

            // cnt로 마커의 tag를 구분
            var cnt = 0
        for item in result.items {
            self.mapPoint1 = MTMapPoint(geoCoord: MTMapPointGeo(latitude: item.storePointLat, longitude: item.storePointLng
                ))
                poiItem1 = MTMapPOIItem()
                // 핀 색상 설정
                poiItem1?.markerType = MTMapPOIItemMarkerType.redPin
                poiItem1?.mapPoint = mapPoint1
                // 핀 이름 설정
            poiItem1?.itemName = item.storeName
                // 태그 설정
                poiItem1?.tag = cnt
                // 맵뷰에 추가!
                mapView!.add(poiItem1)
                cnt += 1
            }
        }

    func mapView(_ mapView: MTMapView!, touchedCalloutBalloonOf poiItem: MTMapPOIItem!) {//마커 클릭 이벤트
            // 인덱스는 poiItem의 태그로 접근
            let index = poiItem.tag
        }

}//end of MapViewController Class


extension MapViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){//검색 버튼 누를 시
        
        dismissKeyboard()
    }

    func dismissKeyboard(){ //키보드 내리기
        mapSearchBar.resignFirstResponder()
    }
}
