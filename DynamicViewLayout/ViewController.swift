//
//  ViewController.swift
//  DynamicViewLayout
//
//  Created by Woody on 2018/12/4.
//  Copyright © 2018年 Woody. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
class ViewController: UIViewController {
	var disposeBag = DisposeBag()
    @IBOutlet weak var xTextField: UITextField!
    @IBOutlet weak var yTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    var x = 0
    var y = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        Observable.combineLatest(xTextField.rx.text.orEmpty, yTextField.rx.text.orEmpty) {[weak self] textValue1, textValue2 -> Bool in
            guard let num1 = Int(textValue1) , let num2 = Int(textValue2) , let `self` = self else {return false}
            	self.x = num1
            	self.y = num2
                return (num1 > 0) && (num2 > 0) ? true : false
            }
            .bind(to: submitButton.rx.isEnabled)
            .disposed(by: disposeBag)

        submitButton.rx.tap.subscribe(onNext: { [weak self] _ in
            self?.performSegue(withIdentifier: "showStackVC", sender: nil)
        }).disposed(by: disposeBag)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showStackVC" {
            let stackVC = segue.destination as! StackVC
            stackVC.x = x
            stackVC.y = y
            stackVC.title = "x:\(x), y:\(y)"
        }
    }
}

