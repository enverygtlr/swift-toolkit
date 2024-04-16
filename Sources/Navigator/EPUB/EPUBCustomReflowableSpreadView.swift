//
//  Copyright 2023 Readium Foundation. All rights reserved.
//  Use of this source code is governed by the BSD-style license
//  available in the top-level LICENSE file of the project.
//

import Foundation
import WebKit

protocol JSMessageListener: AnyObject {
    func didReceive(message body: Any)
}

class EPUBCustomReflowableSpreadView: EPUBReflowableSpreadView {
    weak var messageListener: JSMessageListener?
    var messageNames: [String]
    
    init(viewModel: EPUBNavigatorViewModel,
         spread: EPUBSpread,
         scripts: [WKUserScript],
         animatedLoad: Bool,
         messageListener: JSMessageListener,
         messageNames: [String]) {
        
        self.messageNames = messageNames
        self.messageListener = messageListener
        
        super.init(viewModel: viewModel, spread: spread, scripts: scripts, animatedLoad: animatedLoad)
    }
    
    required init(viewModel: EPUBNavigatorViewModel, spread: EPUBSpread, scripts: [WKUserScript], animatedLoad: Bool) {
        fatalError("init(viewModel:spread:scripts:animatedLoad:) has not been implemented")
    }
    
    override func registerJSMessages() {
        super.registerJSMessages()
        
        for messageName in messageNames {
            registerJSMessage(named: messageName, handler:  { [weak self] in self?.messageListener?.didReceive(message: $0)})
        }
    }
}
