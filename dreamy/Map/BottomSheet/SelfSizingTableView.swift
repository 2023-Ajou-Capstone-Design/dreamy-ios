//
//  SelfSizingTableView.swift
//  dreamy
//
//  Created by 장준모 on 2023/03/25.
//

import Foundation
import UIKit

final class SelfSizingTableView: UITableView {
    private let maxHeight: CGFloat
    
    override var intrinsicContentSize: CGSize {
        CGSize(width: contentSize.width, height: min(contentSize.height, maxHeight))
    }
    
    init(maxHeight: CGFloat) {
        self.maxHeight = maxHeight
        super.init(frame: .zero, style: .grouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        invalidateIntrinsicContentSize()
    }
}
