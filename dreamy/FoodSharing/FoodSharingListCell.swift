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
            make.top.left.bottom.right.equalTo(contentView)
        }
        return stackView
    }()

    lazy var foodImage: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(systemName: "star.fill")!
        imageView.image = image
        imageView.setContentHuggingPriority(.required, for: .horizontal)
        imageView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        imageView.snp.makeConstraints { (make) in
            make.width.equalTo(40)
        }
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
