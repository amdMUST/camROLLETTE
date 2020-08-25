//
//  FullViewCont.swift
//  meh MessagesExtension
//
//  Created by Ahmed Mustafa on 5/8/20.
//  Copyright © 2020 med. All rights reserved.
//

import UIKit
import Messages
import GoogleMobileAds

protocol FullViewContDelegate: class {
    func FullViewContDidSubmit( image: UIImage, caption: String, GameIsStarted: Bool )
}

var beAbleToGetNewPhoto = true
var name: String?

class FullViewCont: UIViewController {
    
    weak var delegate: FullViewContDelegate!
    
    // decides if hidden album is used or not
    var myBool: Bool = true
    
    var lastImage = UIImage(named: "roll_win")
    @IBOutlet var theImage: UIImageView?
    @IBOutlet weak var BlurImaged: UIImageView!
    
    var bannerView: GADBannerView!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLoad() {
        
        //self.view.backgroundColor = UIColor(patternImage: UIImage(named: "roll_back")!)
        super.viewDidLoad()
        
        // all the stuff for the ads
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        addBannerViewToView(bannerView)
        
        // my ad: ca-app-pub-6742015663554270/9101238168
        bannerView.adUnitID = "ca-app-pub-6742015663554270/9101238168"
        
        // test ad : ca-app-pub-3940256099942544/2934735716
        //bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        
        // this checks if you are able to get a new photo, if yes then it will use the function, if not then use the last photo
        if ( (beAbleToGetNewPhoto == true) ){
            let tempImg = getRandomPhoto(myBool: myBool)
            theImage?.image = tempImg
            lastImage = tempImg
        }
        else{
            theImage?.image = lastImage
        }
    }
    
    // when the x button is sent, this is activated. saying do not send the photo,
    // ends the game and the message of you lose with the pre-generated pic
    @IBAction func dontSend(_ sender: UIButton) {
        
        let img = UIImage(named: "roll_win")
        let captionLose = ("They wont send their pic, You Win!")
        
        // open the view that is the end of the game
        
        self.delegate.FullViewContDidSubmit( image: img!, caption: captionLose, GameIsStarted: false )
        // getNewPhoto()
    }
    
    // when the check button is sent, this is activated. saying send the photo,
    // sends the message with random pic included
    @IBAction func yesSend(_ sender: UIImage) {
        
        guard var img = theImage?.image else{ return }
        var captionSend: String?
        
        if ( beAbleToGetNewPhoto == false ){
            img = lastImage!
            captionSend = "I tried cheating!"
        }
        else{
            captionSend = "I sent my photo. Now it's your turn!"
        }
        
        self.delegate.FullViewContDidSubmit( image: img , caption: captionSend!, GameIsStarted: true )
    }
    
    // changes the value for the bool, beAbleToGetNewPhoto
    func ChangeFullViewCount( newAssignment: Bool){
        
        beAbleToGetNewPhoto = newAssignment
        print("--> assigned to",beAbleToGetNewPhoto)
    }
    
    // returns the value for the bool, beAbleToGetNewPhoto
    func getPhotoStatus() -> Bool{
        return beAbleToGetNewPhoto
    }
    
    // gets a new photo again, was originally used to cycle through all the photos
    func getNewPhoto(){
        
        theImage?.image = getRandomPhoto(myBool: myBool)
    }
    
    //MARK: ad function
    func addBannerViewToView(_ bannerView: GADBannerView) {
     bannerView.translatesAutoresizingMaskIntoConstraints = false
     view.addSubview(bannerView)
     view.addConstraints(
       [NSLayoutConstraint(item: bannerView,
                           attribute: .bottom,
                           relatedBy: .equal,
                           toItem: bottomLayoutGuide,
                           attribute: .top,
                           multiplier: 1,
                           constant: 0),
        NSLayoutConstraint(item: bannerView,
                           attribute: .centerX,
                           relatedBy: .equal,
                           toItem: view,
                           attribute: .centerX,
                           multiplier: 1,
                           constant: 0)
       ])
    }
    
}
