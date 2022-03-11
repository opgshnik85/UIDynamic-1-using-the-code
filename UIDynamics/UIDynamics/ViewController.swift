//
//  ViewController.swift
//  UIDynamics
//
//  Created by MacBook on 14.02.2022.
//

import UIKit

class ViewController: UIViewController {
    
    //UIAttachmentBehavior - Привязка
    //UISnapBehavior - Снимок
    
    var squareView = UIView()
    var squareViewAnchorView = UIView()
    var anchorView = UIView()
    var animator = UIDynamicAnimator()
    var attachmentBehavior: UIAttachmentBehavior?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        createGestureRecognizer()
        createSmallSquareView()
        createAnchorView()
        createAnimationAndBehaviors()
    }
    
    //Создаем квадрат и в нем еще один
    func createSmallSquareView() {
        squareView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        squareView.backgroundColor = UIColor.systemGreen
        squareView.center = view.center
        squareViewAnchorView = UIView(frame: CGRect(x: 60, y: 0, width: 20, height: 20))
        squareViewAnchorView.backgroundColor = UIColor.brown
        squareView.addSubview(squareViewAnchorView)
        view.addSubview(squareView)
    }
    
    //Создаем View с точкой привязки
    func createAnchorView() {
        anchorView = UIView(frame: CGRect(x: 120, y: 120, width: 20, height: 20))
        anchorView.backgroundColor = UIColor.systemRed
        view.addSubview(anchorView)
    }
    
    //Создаем регистратор жеста панорамирования
    func createGestureRecognizer() {
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handletPan(paramPan:)))
        view.addGestureRecognizer(panGestureRecognizer)
    }
    
    //Создаем столкновение и прикрепление
    func createAnimationAndBehaviors() {
        animator = UIDynamicAnimator(referenceView: view)
        //Столкновения
        let collision = UICollisionBehavior(items: [squareView])
        collision.translatesReferenceBoundsIntoBoundary = true
        attachmentBehavior = UIAttachmentBehavior(item: squareView, attachedToAnchor: anchorView.center)
        animator.addBehavior(collision)
        animator.addBehavior(attachmentBehavior!)
    }
    
    /* Определяет где находится наш палец, туда передает красный квадрат,
     а потом привязка к большому квадрату */
    @objc func handletPan(paramPan: UIPanGestureRecognizer) {
        let tapPoint = paramPan.location(in: view)
        print(tapPoint)
        attachmentBehavior?.anchorPoint = tapPoint
        anchorView.center = tapPoint
    }

}

