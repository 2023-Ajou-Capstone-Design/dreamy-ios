//
//  MapPin.swift
//  dreamy
//
//  Created by 장준모 on 2023/03/25.
//

import Foundation

// 마커 추가 함수
//func makeMarker(result: Model){
//
//        /*
//        저는 서버 api를 통해 가져온 데이터를 resultList에 담았어요
//        이름, 좌표, 주소 등을 담은 구조체를 담은 배열이에요
//        */
//
//        // cnt로 마커의 tag를 구분
//        var cnt = 0
//    for item in result.items {
//        self.mapPoint1 = MTMapPoint(geoCoord: MTMapPointGeo(latitude: item.storePointLat, longitude: item.storePointLng
//            ))
//            poiItem1 = MTMapPOIItem()
//            // 핀 색상 설정
//            poiItem1?.markerType = MTMapPOIItemMarkerType.redPin
//            poiItem1?.mapPoint = mapPoint1
//            // 핀 이름 설정
//            poiItem1?.itemName = item.placeName
//            // 태그 설정
//            poiItem1?.tag = cnt
//            // 맵뷰에 추가!
//            mapView!.add(poiItem1)
//            cnt += 1
//        }
//    }
//
//func mapView(_ mapView: MTMapView!, touchedCalloutBalloonOf poiItem: MTMapPOIItem!) {//마커 클릭 이벤트
//        // 인덱스는 poiItem의 태그로 접근
//        let index = poiItem.tag
//    }
