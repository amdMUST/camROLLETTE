//
//  PhotoRandomizer.swift
//  randomPhotoTest
//
//  Created by Ahmed Mustafa on 5/4/20.
//  Copyright © 2020 med. All rights reserved.
//

import SwiftUI
import Photos


var allPhotos : PHFetchResult<PHAsset>? = nil
var lastImg: UIImage?
var location: CLLocation?
var creationDate: Date?

// function to get the random photo and convert it to correct format
func getRandomPhoto(myBool: Bool) -> UIImage{
    
    let temp = getPhotosAndVideos( myBool: myBool )
    let tempImage: UIImage = convertImageFromAsset( asset: temp )
    lastImg = tempImage
    return tempImage
}

// gets a random photo from the camera roll
private func getPhotosAndVideos(myBool: Bool) -> PHAsset{

    let fetchOptions = PHFetchOptions()
    fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate",ascending: false)]
    fetchOptions.predicate = NSPredicate(format: "mediaType = %d", PHAssetMediaType.image.rawValue )
    
    // sets if the hidden album should be included or not
    fetchOptions.includeHiddenAssets = myBool;
    
    let imagesN = PHAsset.fetchAssets(with: fetchOptions)
    print(imagesN.count, "total images - getPhotoPart")
    
    let temp = imagesN.object(at: Int.random(in: (0..<imagesN.count) ) )
    
    location = temp.location
    creationDate = temp.creationDate
    
    return temp
}

// converts from PHAsset to UIImage so we can actually use the image
func convertImageFromAsset(asset: PHAsset) -> UIImage {
    let manager = PHImageManager.default()
    let option = PHImageRequestOptions()
    var image = UIImage()
    option.isSynchronous = true
    manager.requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: .aspectFit, options: option, resultHandler: {(result, info)->Void in
        image = result!
    })
    return image
}

func getLocation() -> CLLocation{
    return location!
}
func getDate() -> Date{
    return creationDate!
}

// MARK: stuff i dont understand yet

struct PhotoRandomizer{
    
    @State private var myBool = true
    
    @Binding var isShown: Bool
    @Binding var image: Image?
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(isShown: $isShown, image: $image)
    }
    
}

extension PhotoRandomizer: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let cc = UIImagePickerController()
        cc.sourceType = .savedPhotosAlbum
        
        return cc
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<PhotoRandomizer>) {
        
    }
    
}
