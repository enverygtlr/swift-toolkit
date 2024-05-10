//
//  Copyright 2024 Readium Foundation. All rights reserved.
//  Use of this source code is governed by the BSD-style license
//  available in the top-level LICENSE file of the project.
//

import Foundation
import WebKit

/// A custom web view which:
///  - Forwards copy: menu action to an EditingActionsController.
final class WebView: WKWebView {
    private let editingActions: EditingActionsController

    init(editingActions: EditingActionsController) {
        self.editingActions = editingActions

        let config = WKWebViewConfiguration()
        config.mediaTypesRequiringUserActionForPlayback = .all
        super.init(frame: .zero, configuration: config)

        #if DEBUG && swift(>=5.8)
            if #available(macOS 13.3, iOS 16.4, *) {
                isInspectable = true
            }
        #endif
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func clearSelection() {
        evaluateJavaScript("window.getSelection().removeAllRanges()")
        // Before iOS 12, we also need to disable user interaction to get rid of the selection overlays.
        isUserInteractionEnabled = false
        isUserInteractionEnabled = true
    }
}
