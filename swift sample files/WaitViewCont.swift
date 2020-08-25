//
//  WaitViewCont.swift
//  
//
//  Created by Ahmed Mustafa on 5/21/20.
//

import UIKit
import GoogleMobileAds

protocol WaitViewContDelegate: class {
    func WaitViewContDidSubmit()
}

class WaitViewCont: UIViewController{
    
    weak var delegate: WaitViewContDelegate!
    var count = 0
    var bannerView: GADBannerView!
    
    override func viewDidLoad() {
        //self.view.backgroundColor = UIColor(patternImage: UIImage(named: "roll_backRED")!)
        //getPic()
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
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // a function to get a pic on load so that permission can be asked for as soon as possible
    func getPic(){
        if (count == 0){
            _ = getRandomPhoto(myBool: true)
            count+=1
        }
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
