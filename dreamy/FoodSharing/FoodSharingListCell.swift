//
//  FoodSharingListCell.swift
//  dreamy
//
//  Created by 장준모 on 2023/04/16.
//

import Foundation
import SnapKit

class CustomCell: UITableViewCell {
    
    static let identifier = "CustomCell"
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [foodImage, title, town, uploadTime])
        contentView.addSubview(stackView)
        
        stackView.snp.makeConstraints { (make) in
//            make.top.left.bottom.right.equalTo(contentView)
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))

        }
        
        stackView.distribution = .fill
        stackView.spacing = 5
        
        return stackView
    }()
    
    lazy var foodImage: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "home")
        imageView.image = image
//        imageView.setContentHuggingPriority(.required, for: .horizontal)
//        imageView.setContentHuggingPriority(.required, for: .vertical) // 추가

//        imageView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
//        imageView.snp.makeConstraints { (make) in
//            make.width.equalTo(40)
//            make.height.equalTo(imageView.snp.width)
//            make.top.left.equalToSuperview().offset(10)
//            make.bottom.equalToSuperview().inset(10)
//        }
        return imageView
    }()
    
    lazy var title: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    lazy var town: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    lazy var uploadTime: UILabel = {
        let label = UILabel()
       
        return label
    }()
    
    //    lazy var rightButton: UIButton = {
    //        let button = UIButton()
    //        button.setBackgroundImage(UIImage(systemName: "chevron.right"), for: .normal)
    //        return button
    //    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        print(stackView)
        
        contentView.addSubview(stackView)
            stackView.snp.makeConstraints { (make) in
                make.top.left.bottom.right.equalTo(contentView)
            }

        [foodImage, title, town, uploadTime].forEach{
//            contentView.addSubview($0)
            contentView.addSubview($0)
        }
        // foodImageView layout
        foodImage.contentMode = .scaleAspectFit
        foodImage.snp.makeConstraints { make in
            
            make.width.equalTo(40)
            make.height.equalTo(40)
            make.top.left.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().inset(5)
        }
        
        // titleLabel layout
        title.snp.makeConstraints { make in

            make.top.equalTo(foodImage.snp.top).offset(2)
                make.leading.equalTo(foodImage.snp.trailing).offset(10)
                make.trailing.equalToSuperview().inset(10)
            title.font = UIFont.systemFont(ofSize: 15)
        }
        
        // townLabel layout
        town.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(5)
            make.leading.equalTo(title)
            make.trailing.equalToSuperview().inset(10)
            town.font = UIFont.systemFont(ofSize: 10) // town 글씨 크기 조정

        }
        
        // uploadTimeLabel layout
        uploadTime.snp.makeConstraints { make in
            make.top.equalTo(town.snp.bottom).offset(5)
            make.leading.equalTo(title)
            make.trailing.equalToSuperview().inset(10)
            make.bottom.equalTo(foodImage.snp.bottom).offset(-2)
            uploadTime.font = UIFont.systemFont(ofSize: 10) // town 글씨 크기 조정

        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been impl")
    }
    
}

// MARK: - Utils

extension CustomCell {
    public func bind(model: FoodSharingCellModel) {
//        foodImage.image = model.Photo1
        title.text = model.Title
        town.text = model.Town
        uploadTime.text = model.UploadTime
    }
}
