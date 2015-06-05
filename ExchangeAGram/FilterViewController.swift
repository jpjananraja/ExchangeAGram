//
//  FilterViewController.swift
//  ExchangeAGram
//
//  Created by Janan Rajaratnam on 5/30/15.
//  Copyright (c) 2015 Janan Rajaratnam. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource
{
    
    var collectionView:UICollectionView!
    
    var thisFeedItem:FeedItem!
    
    let kIntensity = 0.7

    var context:CIContext = CIContext(options: nil)
    
    var filters:[CIFilter] = []
    
    let placeHolderImage = UIImage(named: "Placeholder")
    
    let tmp = NSTemporaryDirectory()
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //Create a flow layout to work on how the cells are laid out
        
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        //Setting the section inset and other layout attributes. Configures the layout of the Grid
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        //The size of the cell
        layout.itemSize = CGSize(width: 150.0, height: 150.0)
        
        
        
        self.collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        
        
        self.collectionView.backgroundColor = UIColor.whiteColor()
        
        
        //To add the cell and the reuse identifier for the cell without using storyboard
        self.collectionView.registerClass(FilterCell.self, forCellWithReuseIdentifier: "MyCell")
        //Filter.self is == [Filter class] in Obj-c to get the class of a class
        
        
        self.view.addSubview(self.collectionView)
        
        self.filters = self.photoFilters()
        
        
//        println(self.tmp)
        
       
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
     //MARK: - UICollectionViewDataSource methods

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        
        return self.filters.count
        
    }
    
    
//    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
//    {
//        
//        let cell:FilterCell = self.collectionView.dequeueReusableCellWithReuseIdentifier("MyCell", forIndexPath: indexPath) as FilterCell
//        
//        
//        //Put into an if statement so the images do not keep on reloading when you scroll up and down the grid  
//        
//        if cell.imageView.image == nil
//        {
////            cell.imageView.image = UIImage(named: "Placeholder")
//            cell.imageView.image = self.placeHolderImage
//            
//            //dive into GCD. Create a new queue
//            let filterQueue:dispatch_queue_t = dispatch_queue_create("filter queue", nil)
//            
//            dispatch_async(filterQueue, { () -> Void in
//                
//                //            let filterImage = self.filteredImageFromImage(self.thisFeedItem.image, filter: self.filters[indexPath.row])
//                
//                //Use the ThumbNail instead of the actual image as commented above
//                let filterImage = self.filteredImageFromImage(self.thisFeedItem.thumbNail, filter: self.filters[indexPath.row])
//                
//                
////                //Get the image from the cache rather than the code above
////                let filterImage = self.getCachedImage(indexPath.row)
////               
//                
//               
//                
//                
//                //do the UI changes/updates always on the main queue
//                dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                    cell.imageView.image = filterImage
//                })
//                
//            })
//            
//            
//            
//            
//            //        cell.imageView.image = self.filteredImageFromImage(self.thisFeedItem.image, filter: self.filters[indexPath.row])
//            
//        }
//        
//        
////
//        
//        return cell
//    }
    
    
    
    
    
    //Using the cache setup rather than the usual if statement from above , and reload images from scracth
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        
        let cell:FilterCell = self.collectionView.dequeueReusableCellWithReuseIdentifier("MyCell", forIndexPath: indexPath) as FilterCell
        
        
        
        
            //            cell.imageView.image = UIImage(named: "Placeholder")
            cell.imageView.image = self.placeHolderImage
            
            //dive into GCD. Create a new queue
            let filterQueue:dispatch_queue_t = dispatch_queue_create("filter queue", nil)
            
            dispatch_async(filterQueue, { () -> Void in
                
                //            let filterImage = self.filteredImageFromImage(self.thisFeedItem.image, filter: self.filters[indexPath.row])
                
                //Use the ThumbNail instead of the actual image as commented above
//                let filterImage = self.filteredImageFromImage(self.thisFeedItem.thumbNail, filter: self.filters[indexPath.row])
                
                
                
                let filterImage = self.getCachedImage(indexPath.row)
                
                
                
                
                
                
                
                //do the UI changes/updates always on the main queue
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    cell.imageView.image = filterImage
                })
                
            })
            
            
            
            
            //        cell.imageView.image = self.filteredImageFromImage(self.thisFeedItem.image, filter: self.filters[indexPath.row])
            
        
        
        
        //
        
        return cell
    }
    
    
    
    
    
    
    
    //MARK: - UICollectionViewDelegate methods
    
//    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
//    {
//        let filterImage = self.filteredImageFromImage(self.thisFeedItem.image, filter: self.filters[indexPath.row])
//        
//        
//        let imageData = UIImageJPEGRepresentation(filterImage, 1.0)
//        
//        self.thisFeedItem.image = imageData
//        
//        let thumbNailData = UIImageJPEGRepresentation(filterImage, 0.1)
//        self.thisFeedItem.thumbNail = thumbNailData
//        
//        //Save or persist to the core data filesystem for the changes made above
//        (UIApplication.sharedApplication().delegate as AppDelegate).saveContext()
//        
//        //pop the view controller once its done
//        self.navigationController?.popViewControllerAnimated(true)
//        
//        
//        
//    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        self.createUIAlertController(indexPath)
    }
    
    
    
    // MARK: - Helper Methods
    
    func photoFilters() ->[CIFilter]
    {
        
        let blur = CIFilter(name: "CIGaussianBlur")
        let instant = CIFilter(name: "CIPhotoEffectInstant")
        let noir = CIFilter(name: "CIPhotoEffectNoir")
        let transfer = CIFilter(name: "CIPhotoEffectTransfer")
        let unsharpen = CIFilter(name: "CIUnsharpMask")
        let monochrome = CIFilter(name: "CIColorMonochrome")
        
        
        let colorControls = CIFilter(name: "CIColorControls")
        colorControls.setValue(0.5, forKey: kCIInputSaturationKey)
        
        
        let sepia = CIFilter(name: "CISepiaTone")
        sepia.setValue(kIntensity, forKey: kCIInputIntensityKey)
        
        
        let colorClamp = CIFilter(name: "CIColorClamp")
        colorClamp.setValue(CIVector(x: 0.9, y: 0.9, z: 0.9, w: 0.9), forKey: "inputMaxComponents")
        colorClamp.setValue(CIVector(x: 0.2, y: 0.2, z: 0.2, w: 0.2), forKey: "inputMinComponents")
        
        
        
        let composite = CIFilter(name: "CIHardLightBlendMode")
        composite.setValue(sepia.outputImage, forKey: kCIInputImageKey)
        
        
        let vignette = CIFilter(name: "CIVignette")
        vignette.setValue(composite.outputImage, forKey: kCIInputImageKey)
        vignette.setValue(kIntensity * 2, forKey: kCIInputIntensityKey)
        vignette.setValue(kIntensity * 30, forKey: kCIInputRadiusKey)
        
        
        
        
        return [blur, instant, noir, transfer, unsharpen, monochrome, colorControls, sepia, colorClamp, composite, vignette]
    }
    
    
    func filteredImageFromImage(imageData: NSData , filter: CIFilter) -> UIImage
    {
        
        let unfilteredImage = CIImage(data: imageData)
        
        filter.setValue(unfilteredImage, forKey: kCIInputImageKey)
        
        let filteredImage:CIImage = filter.outputImage
        
        
//        extent in this case represents our image boundaries if you will. We declare a constant simply so it's easier to pass it to the createCGImage function which needs to know what we want to create an image from, it needs a rectangle information and that is exactly what extent is giving us here.
        let extent = filteredImage.extent()
        
        let cgImage:CGImageRef = context.createCGImage(filteredImage, fromRect: extent)
        
        let finalImage = UIImage(CGImage: cgImage)
        
        //comment above code using context object and uncomment below code to see lags in operation
        
//        let finalImage = UIImage(CIImage: filteredImage)
        
        return finalImage!
        
    }

    
    //MARK: - UIAlertController Helper Functions
    
    func createUIAlertController(indexPath: NSIndexPath)
    {
        let alert = UIAlertController(title: "Photo Options", message: "Please choose an option", preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addTextFieldWithConfigurationHandler { (textField) -> Void in
            
            textField.placeholder = "Add Caption"
            textField.secureTextEntry = false
            
        }
        
//        var text:String
        
        
        //Access the first textfield from the array

        let textField = alert.textFields![0] as UITextField
        
        
//        if textField.text != nil
//        {
//            text = textField.text
//        }
        
        
        let photoAction = UIAlertAction(title: "Post Photo to Facebook with Caption", style: UIAlertActionStyle.Destructive) { (UIAlertAction) -> Void in
            
            //Code to do photo posting to Facebook
            
            self.shareToFacebook(indexPath)
            
            var text = textField.text
            
            self.saveFilterToCoredData(indexPath, caption: text)
        }
        
        
        
        alert.addAction(photoAction)
        
        
        let saveFilterAction = UIAlertAction(title: "Save filter without posting on Facebook", style: UIAlertActionStyle.Default) { (UIAlertAction) -> Void in
            
            var text = textField.text
            
            
            //Save the filter and pop the view controller
            self.saveFilterToCoredData(indexPath, caption: text)

        }
        
        alert.addAction(saveFilterAction)
        
        
        
        let cancelAction = UIAlertAction(title: "Select another Filter", style: UIAlertActionStyle.Cancel) { (UIAlertAction) -> Void in
            
            
        }
        
        
        alert.addAction(cancelAction)
        
        
        
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    
    
    
    func saveFilterToCoredData(indexPath: NSIndexPath, caption: String)
    {
        
        let filterImage = self.filteredImageFromImage(self.thisFeedItem.image, filter: self.filters[indexPath.row])
        
        
                let imageData = UIImageJPEGRepresentation(filterImage, 1.0)
        
                self.thisFeedItem.image = imageData
        
                let thumbNailData = UIImageJPEGRepresentation(filterImage, 0.1)
                self.thisFeedItem.thumbNail = thumbNailData
        
        
                self.thisFeedItem.caption = caption
        
                self.thisFeedItem.filtered = true
        
                //Save or persist to the core data filesystem for the changes made above
                (UIApplication.sharedApplication().delegate as AppDelegate).saveContext()
        
                //pop the view controller once its done
                self.navigationController?.popViewControllerAnimated(true)
                
                
    }
    
    
    
    
    func shareToFacebook(indexPath: NSIndexPath)
    {
        
        let filterImage = self.filteredImageFromImage(self.thisFeedItem.image, filter: self.filters[indexPath.row])
        
        
        
        let photos:NSArray = [filterImage]
        
        var params = FBPhotoParams()
        params.photos = photos
        
        FBDialogs.presentShareDialogWithPhotoParams(params, clientState: nil) { (call, result, error) -> Void in
            
            if (result? != nil)
            {
                println(result)
            }
            else
            {
                println(error)
            }
        }
        
        
        
        
    }
    
    
    //MARK: - Caching methods
    
    func cacheImage (imageNumber: Int)
    {
//        let fileName = "\(imageNumber)"
        //        only using the above code as setting a filename will cause unexpected bugs in the filters selected
        
        
        //Create the filename and the file path for the file to be written into
        let fileName = "\(self.thisFeedItem.uniqueID)\(imageNumber)"
        
        let uniquePath = tmp.stringByAppendingPathComponent(fileName)
        
       
        //If a file doesn't exist at the filepath then generate a filter
        if !NSFileManager.defaultManager().fileExistsAtPath(fileName)
        {
            //Set the thumbnail and filter info
            let data = self.thisFeedItem.thumbNail
            let filter = self.filters[imageNumber]
            
            let image = self.filteredImageFromImage(data, filter: filter)
            
            
            //Write the image into the uinquepath specified above
            UIImageJPEGRepresentation(image, 1.0).writeToFile(uniquePath, atomically: true)
        }
        
        
        println("The cache file from cacheImage function is : \(fileName)")
    }
    
    
    
    
    func getCachedImage(imageNumber:Int) -> UIImage
    {
        //        let fileName = "\(imageNumber)"
        //        only using the above code as setting a filename will cause unexpected bugs in the filters selected
        
        
        
        //Create the filename and the file path for the file to be written into
        let fileName = "\(self.thisFeedItem.uniqueID)\(imageNumber)"
        
        let uniquePath = tmp.stringByAppendingPathComponent(fileName)
        
        var image:UIImage
        
        
        
        //if file does exist at the specified unique-path then do the following
        if NSFileManager.defaultManager().fileExistsAtPath(uniquePath)
        {
             image = UIImage(contentsOfFile: uniquePath)!
            
            
        }
        else //if file doesn't exist at the specified unique-path create a new file
        {
             self.cacheImage(imageNumber)
            
             image = UIImage(contentsOfFile: uniquePath)!
            
            
        }
        
        
        println("The cache file from getCachedImage() function is : \(fileName)")
        
        
        
        return image
        
    }

    
    
//MARK: -  IMAGE ORIENTATION CODE WHEN USING AN APPLE MOBILE DEVICE use this instead of the above "getCachedImage" function
    
//    func getCachedImage(imageNumber:Int) -> UIImage
//    {
////        let fileName = "\(imageNumber)"
////        only using the above code as setting a filename will cause unexpected bugs in the filters selected
//        
//        
//        
//        //Create the filename and the file path for the file to be written into
//        let fileName = "\(self.thisFeedItem.uniqueID)\(imageNumber)"
//        
//        let uniquePath = tmp.stringByAppendingPathComponent(fileName)
//        
//        var image:UIImage
//        
//        
//        
//        //if file does exist at the specified unique-path then do the following
//       if NSFileManager.defaultManager().fileExistsAtPath(uniquePath)
//            {
//                var returnedImage = UIImage(contentsOfFile: uniquePath)!
//                
//                //To change the image orientation of the returned image
//                image = UIImage(CGImage: returnedImage.CGImage, scale: 1.0, orientation: UIImageOrientation.Right)!
//                
//                
//                
//            }
//        else //if file doesn't exist at the specified unique-path create a new file
//       {
//            self.cacheImage(imageNumber)
//        
//        var returnedImage = UIImage(contentsOfFile: uniquePath)!
//        
//            //To change the image orientation of the returned image
//            image = UIImage(CGImage: returnedImage.CGImage, scale: 1.0, orientation: UIImageOrientation.Right)!
//        }
//        
//        
//        println("The cache file from getCachedImage() function is : \(fileName)")
//
//        
//        
//        return image
//        
//    }
    
    
    
}
