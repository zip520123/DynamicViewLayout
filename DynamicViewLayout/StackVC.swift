//
//  StackVC.swift
//  DynamicViewLayout
//
//  Created by Woody on 2018/12/4.
//  Copyright © 2018年 Woody. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
let viewDefaultColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
let viewHightlightColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
let buttonDefaultColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
let buttonHightlightColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
let buttonTextColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
class StackVC: UIViewController {
    
	var x = 0 //column
    var y = 0 //row
    var disposeBag = DisposeBag()
    var currentView : RandomView?
    var currentButton : UIButton?

    var currentStackList : [UIStackView] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        let mainStackView = UIStackView()
        view.addSubview(mainStackView)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        mainStackView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        mainStackView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        mainStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        mainStackView.axis = .horizontal
        mainStackView.spacing = 1
        mainStackView.distribution = .fillEqually
        for i in 0..<x {
            let columnStack = UIStackView()
            currentStackList.append(columnStack)
            columnStack.axis = .vertical
            columnStack.spacing = 1
            columnStack.distribution = .fillEqually
            mainStackView.addArrangedSubview(columnStack)
            for j in 0..<y{
                let rowView = RandomView()
                
                rowView.tag = j
                rowView.backgroundColor = viewDefaultColor
                columnStack.addArrangedSubview(rowView)
            }
            let button = UIButton(type: .system)
            button.backgroundColor = buttonDefaultColor
            button.setTitle("確定", for: .normal)
            button.setTitleColor(buttonTextColor, for: .normal)
            button.rx.tap.subscribe(onNext:{[weak self] _ in
                guard let `self` = self else{return}
                print("^^ : \(i)")
                for view in self.currentStackList[i].arrangedSubviews{
                    if view == self.currentView {
                        self.resetView()
                    }
                }
                
            }).disposed(by: disposeBag)
            columnStack.addArrangedSubview(button)
        }
        
        let interval = Observable<Int>.interval(5, scheduler: MainScheduler.instance)
    	interval.map({ (i) -> Int in
            return i * 10
        }).subscribe(onNext:{[weak self] in
            guard let `self` = self else {return}
            self.resetView()
            self.resetButton()
            let randomX = Int(arc4random_uniform(UInt32(self.x)))
            let randomY = Int(arc4random_uniform(UInt32(self.y)))
            print("\($0) rx:\(randomX) , ry:\(randomY)")
            for view in self.currentStackList[randomX].arrangedSubviews {
                if view.tag == randomY && view.isKind(of: RandomView.self) {
                    self.toggleView(view: view as! RandomView)
                }
                if view.isKind(of: UIButton.self){
                    self.toggleButton(button: view as! UIButton)
                }
            }
        }).disposed(by:disposeBag )
        
    }
    func toggleView(view : RandomView){
        view.backgroundColor = viewHightlightColor
        view.label.text = "Random"
        currentView = view
    }
    func resetView(){
        currentView?.label.text = ""
        currentView?.backgroundColor = viewDefaultColor
    }
    func toggleButton(button: UIButton){
        button.backgroundColor = buttonHightlightColor
        currentButton = button
    }
    func resetButton(){
        currentButton?.backgroundColor = buttonDefaultColor

    }
    

}
