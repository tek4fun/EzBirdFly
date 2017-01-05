//
//  ViewController.swift
//  EzBirdFly
//
//  Created by iOS Student on 1/4/17.
//  Copyright © 2017 tek4fun. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    var bird = UIImageView()
    var audioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        drawJungle()
        addBird()
        flyUpAndDown()
        playSong()
    }
    
    
    func drawJungle(){
        let background = UIImageView(image:UIImage(named:"jungle.jpg"))
        background.frame = self.view.bounds
        background.contentMode = .scaleAspectFill
        self.view.addSubview(background)
    }
    
    func addBird()
    {
        bird = UIImageView(frame: CGRect(x: 0, y: 0, width: 110, height: 68))
        bird.animationImages = [UIImage(named:"bird0.png")!,
                                UIImage(named:"bird1.png")!,
                                UIImage(named:"bird2.png")!,
                                UIImage(named:"bird3.png")!,
                                UIImage(named:"bird4.png")!,
                                UIImage(named:"bird5.png")!]
        bird.animationRepeatCount = 0
        bird.animationDuration = 1
        bird.startAnimating()
        self.view.addSubview(bird)
    }
    
    func flyUpAndDown()
    {
        UIView.animate(withDuration: 4, animations: {
            self.bird.center = CGPoint(x: self.view.bounds.width, y: self.view.bounds.height)
            }, completion:  {(finished) in
                
                self.bird.transform = self.bird.transform.scaledBy(x: -1, y: 1).concatenating(CGAffineTransform(rotationAngle: 0))
                UIView.animate(withDuration: 4, animations: {
                    self.bird.center = CGPoint(x: 0, y: self.view.bounds.height - 50)
                    }, completion: {(finished)in
                        
                        self.bird.transform = self.bird.transform.scaledBy(x: -1, y: 1).concatenating(CGAffineTransform(rotationAngle: CGFloat(0 - M_PI_4)))
                        UIView.animate(withDuration: 4, animations: {
                            self.bird.center = CGPoint(x: self.view.bounds.width, y: 0 )
                            }, completion: {(finished)in
                                self.bird.transform = CGAffineTransform.identity
                                self.bird.transform = self.bird.transform.scaledBy(x: -1, y: 1).concatenating(CGAffineTransform(rotationAngle: CGFloat(0)))
                                UIView.animate(withDuration: 4, animations: {
                                    self.bird.center = CGPoint(x: 0, y: 0)
                                    }, completion: {(finished)in
                                        self.bird.transform = CGAffineTransform.identity
                                        self.flyUpAndDown()
                                })
                        })
                })
        })
    }
    
        
        func playSong()
        {
            let filePath = Bundle.main.path(forResource: "A+ – Chào Mào Mái Hót", ofType: ".mp3")
            let url = URL(fileURLWithPath: filePath!)
            audioPlayer = try! AVAudioPlayer(contentsOf: url)
            audioPlayer.prepareToPlay()
            audioPlayer.play()
        }
        override func viewWillDisappear(_ animated: Bool) {
            audioPlayer.stop()
        }
        
}

