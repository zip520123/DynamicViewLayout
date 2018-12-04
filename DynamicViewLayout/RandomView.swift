//
//  RandomView.swift
//  DynamicViewLayout
//
//  Created by Woody on 2018/12/4.
//  Copyright © 2018年 Woody. All rights reserved.
//

import UIKit

class RandomView: UIView {
	let label = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
