//
//  ViewController.swift
//  LoginDemo
//
//  Created by Abrahamas on 09/01/2020.
//  Copyright © 2020 Abraham Asmile. All rights reserved.
//

import UIKit
import AVKit

class ViewController: UIViewController {
    
    
    
    var videoPlayer:AVPlayer?
    var videoPlayerLayer:AVPlayerLayer?
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setUpElements()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        
//        set up the video in the background
         setUpVideo()
        
    }

    func setUpElements() {
        Utilities.styleFilledButton(signUpButton)
        Utilities.styleHollowButton(loginButton)
    }
    func setUpVideo()  {
        
//         get the path to the ressource in the bundle
       let bundlePath = Bundle.main.path(forResource: "loginbg", ofType: "mp4")
        guard bundlePath != nil  else {
            return
        }
//        create an url form it
        
        let url = URL(fileURLWithPath: bundlePath! )
        
//        create the video item
        let item = AVPlayerItem(url: url)
        
        
//        create the player
        videoPlayer = AVPlayer(playerItem: item )
        
//        create the layer
        
        videoPlayerLayer = AVPlayerLayer(player: videoPlayer)
        
//        adjust the size in frame
        videoPlayerLayer?.frame = CGRect(x: -self.view.frame.size.width*1.5, y: 0, width: self.view.frame.size.width*4, height: self.view.frame.size.height)
              
//        videoPlayerLayer?.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width*4, height: self.view.frame.size.height)
                            
               view.layer.insertSublayer(videoPlayerLayer!, at: 0)
        
        
//        add it to he view in play it
        videoPlayer?.playImmediately(atRate: 0.5)
        
    }
    

}

