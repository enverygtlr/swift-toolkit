//
//  Copyright 2023 Readium Foundation. All rights reserved.
//  Use of this source code is governed by the BSD-style license
//  available in the top-level LICENSE file of the project.
//

import Foundation
import UIKit
//Drag Begin
extension PaginationView {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.delegate?.paginationViewWillBeginDragging(self)
    }
}

extension PaginationViewDelegate {
    func paginationViewWillBeginDragging(_ paginationView: PaginationView) {
        
    }
}

extension EPUBNavigatorViewController {
    func paginationViewWillBeginDragging(_ paginationView: PaginationView) {
        self.delegate?.chapterWillBeginDragging()
    }
}

public extension EPUBNavigatorDelegate {
    func chapterWillBeginDragging() {
        
    }
}
