//
//  TableViewCell.swift
//  dreamy
//
//  Created by 장준모 on 2023/03/25.
//

import Foundation
import UIKit

class TableViewCell: UITableViewCell{   //테이블뷰에 들어갈 셀 클래스
    static let identifier = "TableViewCell"
    
    let storeImage: UIImageView = { //테이블에 들어갈 가게 이미지
        let imgView = UIImageView()
        imgView.image = UIImage(named:"home")
        return imgView
    }()
    
    private let storeName: UILabel = {  //테이블에 들어갈 가게명
        let label = UILabel()
        label.text = "스타벅스"
        label.textColor = UIColor.gray
        return label
    }()
    
    private let categoryName: UILabel = {  //테이블에 들어갈 카테고리명
        let label = UILabel()
        label.text = "카페"
        label.textColor = UIColor.gray
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {// 셀에 들어갈 내용(이미지, 가게명, 카테고리) snapkit으로 설정
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        [storeImage, storeName, categoryName].forEach{
//            contentView.addSubview($0)
            contentView.addSubview($0)
        }
        storeImage.snp.makeConstraints{ (make) in
            make.top.leading.bottom.equalToSuperview().inset(10)
            make.width.height.equalTo(50)
        }
        storeName.snp.makeConstraints{ (make) in
            make.centerY.equalTo(storeImage)
            make.leading.equalTo(storeImage.snp.trailing).offset(10)
        }
        categoryName.snp.makeConstraints{ (make) in
            make.top.equalTo(storeName.snp.bottom)
            make.leading.equalTo(storeImage.snp.trailing).offset(10)
            
        }
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension TableViewCell {   //cell에 들어갈 내용 처리 configure 함수
    public func configure(image: UIImage, storename: String, categoryname: String ) {   // configure: 가게명, 이미지 초기화 메소드
        self.storeName.text = storename
        self.imageView?.image = image
        self.categoryName.text = categoryname
    }
    public func configure(storename: String, categoryname: String){
        self.storeName.text = storename
        switch categoryname{
        case "1":
            self.categoryName.text = "음식점"
        case "2":
            self.categoryName.text = "마트"
        case "4":
            self.categoryName.text = "교육"
        case "5":
            self.categoryName.text = "생활"
        case "99":
            self.categoryName.text = "기타"
        default:
            self.categoryName.text = "알 수 없음"
        }
//        self.categoryName.text = categoryname
    }
    
}

