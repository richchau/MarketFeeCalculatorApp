//
//  GoatView.swift
//  MarketFeeCalculatorApp
//
//  Created by Rich Chau on 4/3/20.
//  Copyright © 2020 Rich Chau. All rights reserved.
//

import UIKit

@IBDesignable
class GoatView: UIView{
    
    
    @IBOutlet weak var soldPriceTextField: UITextField!
    @IBOutlet weak var itemCostTextField: UITextField!
    @IBOutlet weak var taxTextField: UITextField!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    func commonInit() {
        let bundle = Bundle.init(for: GoatView.self)
        if let viewsToAdd = bundle.loadNibNamed("GoatView", owner: self, options: nil), let contentView = viewsToAdd.first as? UIView {
            addSubview(contentView)
            contentView.frame = self.bounds
            contentView.autoresizingMask = [.flexibleHeight,
                                            .flexibleWidth]
        }
    }
}


