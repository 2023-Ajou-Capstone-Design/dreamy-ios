//
//  TouchBlockIntrinsicPanelLayout.swift
//  dreamy
//
//  Created by 장준모 on 2023/03/25.
//

import Foundation
import FloatingPanel

final class TouchBlockIntrinsicPanelLayout: FloatingPanelBottomLayout {//bottomsheet의 뒷배경 dimmed, 터치시 dismiss
    override var initialState: FloatingPanelState { .full }
    override var anchors: [FloatingPanelState : FloatingPanelLayoutAnchoring] {
        return [
            .full: FloatingPanelIntrinsicLayoutAnchor(fractionalOffset: 0, referenceGuide: .safeArea)
        ]
    }

    override func backdropAlpha(for state: FloatingPanelState) -> CGFloat {
        0.5
    }
}

final class TouchPassIntrinsicPanelLayout: FloatingPanelBottomLayout {//bottom sheet 뒷배경 터치 가능
    override var initialState: FloatingPanelState { .tip }
    override var anchors: [FloatingPanelState : FloatingPanelLayoutAnchoring] {
        return [
            .tip: FloatingPanelIntrinsicLayoutAnchor(fractionalOffset: 0, referenceGuide: .safeArea)
        ]
    }
}
