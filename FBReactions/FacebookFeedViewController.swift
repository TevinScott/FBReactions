//
//  ViewController.swift
//  FBReactions
//
//  Created by Tevin Scott on 9/10/18.
//  Copyright © 2018 Tevin Scott. All rights reserved.
//

import UIKit

class FacebookFeedViewController: UIViewController {

    //MARK: - IBOutlets
    
    @IBOutlet weak var reactionView: UIView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var likeImage: UIImageView!
    @IBOutlet weak var loveImage: UIImageView!
    @IBOutlet weak var hahaImage: UIImageView!
    @IBOutlet weak var woahImage: UIImageView!
    @IBOutlet weak var sadImage: UIImageView!
    @IBOutlet weak var angryImage: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    
    //MARK: - Properties
    private var shadowLayer: CAShapeLayer!
    private var baseImageHeight: CGFloat?
    
    //MARK: - Actions
    
    @IBAction func likeButtonHeld(_ sender: UILongPressGestureRecognizer) {

        if sender.state == UIGestureRecognizerState.began {
            reactionView.isHidden = false
            fadeInContainerView()
            
        }
        if sender.state == UIGestureRecognizerState.changed {
            
            let heldLocation = sender.location(in: self.reactionView)
            print(heldLocation)
            
            let hitTestView = reactionView.hitTest(heldLocation, with: nil)

            if hitTestView is UIImageView {
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    
                    self.stackView.subviews.forEach { (imageView) in
                        imageView.transform = .identity
                    }
                    var imageTransformation = CGAffineTransform.identity
                    
                    imageTransformation = imageTransformation.translatedBy(x: 0, y: -50)
                    imageTransformation = imageTransformation.scaledBy(x: 1.5, y: 1.5)
                    
                    hitTestView?.transform = imageTransformation
                })
            }
        } else if sender.state == UIGestureRecognizerState.ended {
            
            fadeOutContainerView()
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
//                self.reactionView.isHidden = true
                self.stackView.subviews.forEach { (imageView) in
                    imageView.transform = .identity
                }
            })
            
        }
    }
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reactionView.isHidden = true
        baseImageHeight = likeImage.bounds.height
        loadGifs()
        styleReactionView()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //MARK: - Helper Functions
    
    private func loadGifs(){
        likeImage.loadGif(name: "like")
        loveImage.loadGif(name: "love")
        hahaImage.loadGif(name: "haha")
        woahImage.loadGif(name: "wow")
        sadImage.loadGif(name: "sad")
        angryImage.loadGif(name: "angry")
    }
    
    private func fadeInContainerView(){
        reactionView.alpha = 0
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.reactionView.alpha = 1
        })
    }
    
    private func fadeOutContainerView(){
        reactionView.alpha = 1
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.reactionView.alpha = 0
        })
    }
    
    private func styleReactionView(){
        reactionView.layer.cornerRadius = reactionView.bounds.height/2
        shadowLayer = CAShapeLayer()
        shadowLayer.path = UIBezierPath(roundedRect: reactionView.bounds, cornerRadius: reactionView.layer.cornerRadius).cgPath
        shadowLayer.fillColor = UIColor.white.cgColor
        shadowLayer.shadowColor = UIColor.black.cgColor
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        shadowLayer.shadowOpacity = 0.2
        shadowLayer.shadowRadius = 3
        reactionView.layer.insertSublayer(shadowLayer, at: 0)
        print("reaction View info", reactionView)
        print("shadow view info", shadowLayer)
    }
    
}


