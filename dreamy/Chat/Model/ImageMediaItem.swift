//
//  ImageMediaItem.swift
//  dreamy
//
//  Created by 장준모 on 2023/05/17.
//

import Foundation
import MessageKit

struct ImageMediaItem: MediaItem {
  var url: URL?
  var image: UIImage?
  var placeholderImage: UIImage
  var size: CGSize

  init(image: UIImage) {
    self.image = image
    self.size = CGSize(width: 240, height: 240)
    self.placeholderImage = UIImage()
  }
}

