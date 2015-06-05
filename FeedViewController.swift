//
//  FeedViewController.swift
//  ExchangeAGram
//
//  Created by Janan Rajaratnam on 5/29/15.
//  Copyright (c) 2015 Janan Rajaratnam. All rights reserved.
//

import UIKit
import MobileCoreServices
import CoreData
import MapKit


class FeedViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate
{

    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var feedArray:[AnyObject] = []
    
    var locationManager:CLLocationManager!
    
    
    
    
    
//    override func viewDidLoad()
//    {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//        
//        
//        //create NSFetchedResults
//        
//        let request = NSFetchRequest(entityName: "FeedItem")
//        
//        
//        let appDelegate:AppDelegate = (UIApplication.sharedApplication().delegate) as AppDelegate
//        
//        let context:NSManagedObjectContext = appDelegate.managedObjectContext!
//        
//        feedArray = context.executeFetchRequest(request, error: nil)!
//        
//        
////        To check the objects inside of the array and identifying them through their size aka length
////        for obj:FeedItem in feedArray as [FeedItem]
////        {
////            println("\n \(obj.image.length) ")
////            
////        }
//        
//    }
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //Set the back ground color
        let backGroundImage = UIImage(named: "AutumnBackground")
        
        self.view.backgroundColor = UIColor(patternImage: backGroundImage!)
        
        
        
        self.locationManager = CLLocationManager()
        self.locationManager.delegate = self
        
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
       
        self.locationManager.requestWhenInUseAuthorization()
        
        self.locationManager.distanceFilter = 100.0
        
        self.locationManager.startUpdatingLocation()
        
        
        
    }
    
    
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        
        //create NSFetchedResults
        
        let request = NSFetchRequest(entityName: "FeedItem")
        
        
        let appDelegate:AppDelegate = (UIApplication.sharedApplication().delegate) as AppDelegate
        
        let context:NSManagedObjectContext = appDelegate.managedObjectContext!
        
        feedArray = context.executeFetchRequest(request, error: nil)!
        
        self.collectionView.reloadData()
        
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    
    // MARK: - IBAction Methods
    
    
    
    
    @IBAction func profileTapped(sender: UIBarButtonItem)
    {
        self.performSegueWithIdentifier("profileSegue", sender: nil)
    }
    
    
    
    
    @IBAction func snapBarButtonItemTapped(sender: UIBarButtonItem)
    {
        
        //Check if camera is available
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        {
            var cameraController = UIImagePickerController()
            
            //Set the UIImagePickerController delegate property to self
            cameraController.delegate = self
            
            //set the sourcetype to camera
            cameraController.sourceType = UIImagePickerControllerSourceType.Camera
            
            
            //The mediatypes the camera controller will be accessing - image data for this project
            let mediaTypes:[AnyObject] = [kUTTypeImage]
            cameraController.mediaTypes = mediaTypes
            cameraController.allowsEditing = false
          
            //Present the camera controller modally...UINavigationController inherits from UIViewController
           
           self.presentViewController(cameraController, animated: true, completion: nil)
            
        }
        //If camera isn't available use the photo library
        else if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary)
        {
            
            var photoLibraryController = UIImagePickerController()
            
            photoLibraryController.delegate = self
            
            photoLibraryController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            
            let mediaTypes:[AnyObject] = [kUTTypeImage]
            photoLibraryController.mediaTypes = mediaTypes
            photoLibraryController.allowsEditing = false
            
            
            self.presentViewController(photoLibraryController, animated: true, completion: nil)
            
            
            
        }
            //If camera and photolibrary not available present alert view
        else
        {
            var alertController = UIAlertController(title: "Alert", message: "your device doesn't support the Camera or Photo Library", preferredStyle: UIAlertControllerStyle.Alert)
            
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        
        
        
        
        
    }
    
   
    
    // MARK: - UICollectionViewDataSource methods
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
    {
        return 1
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return feedArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
       
        var cell:FeedCell = (self.collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath)) as FeedCell
            
        
        let thisItem = feedArray[indexPath.row] as FeedItem
        
        
        //MARK: -  IMAGE ORIENTATION CODE WHEN USING AN APPLE MOBILE DEVICE
        
//        //If image is filtered then do image orientation
//        if thisItem.filtered == true
//        {
//            let returnedImage = UIImage(data: thisItem.image)
//            let image = UIImage(CGImage: returnedImage?.CGImage, scale: 1.0, orientation: UIImageOrientation.Right)
//            
//            cell.imageView.image = image
//        }
//        else
//        {
//            cell.imageView.image = UIImage(data: thisItem.image) //change NSData to UIImage
//            
//        }
        
        //Comment the below two lines of code if going for apple device testing
        //set the cell properties
        cell.imageView.image = UIImage(data: thisItem.image) //change NSData to UIImage
        cell.captionLabel.text = thisItem.caption
        
        
        return cell
        
        
    }
    
    
    // MARK: - UIImagePickerControllerDelegate methods
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject])
    {
        //The "key" to obtain the required UIImage "value" is "UIImagePickerControllerOriginalImage"
        let image = info[UIImagePickerControllerOriginalImage] as UIImage
        
        //convert the image into jpeg and return NSData instance
        let imageData = UIImageJPEGRepresentation(image, 1.0)
        
        
        //Lower res image for thumbnail
        let thumbNailData = UIImageJPEGRepresentation(image, 0.1)
        
        
        
        //Core Data coding to create the entity
        
        let managedObjContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
        
        let entityDesc = NSEntityDescription.entityForName("FeedItem", inManagedObjectContext: managedObjContext!)
        
        
        let feedItm = FeedItem(entity: entityDesc!, insertIntoManagedObjectContext: managedObjContext!)
        
        
        feedItm.image = imageData
        feedItm.caption = "Test Caption"
        feedItm.thumbNail = thumbNailData
        
        
        
        
        feedItm.latitude = locationManager.location.coordinate.latitude
        feedItm.longitude = locationManager.location.coordinate.longitude
        
        
        
        //Create a UniqueID
        
        let UUID = NSUUID().UUIDString
        
        
        feedItm.uniqueID = UUID
        
        
        //Set the filtered property to false
        feedItm.filtered = false
        
        
        //Save the changes made
        (UIApplication.sharedApplication().delegate as AppDelegate).saveContext()
        
        
        //Add the feed item obj into the array
        self.feedArray.append(feedItm)
        
        
        
        self.dismissViewControllerAnimated(true, completion: nil)
       
        //Reload the collection view
        self.collectionView.reloadData()
        
    }
    
    
     // MARK: - UICollectionViewDelegate methods
    
    
    //since no explicit segue in the main storyboard, use the following code to do the transition to the FilterViewController
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        //The cell corresponding to the feedItem that is selected
        
        let thisItem = self.feedArray[indexPath.row] as FeedItem
        
        //Create a FilterViewController  View Controller instance
        var filterVC:FilterViewController = FilterViewController()
        
        //Pas the feedItem selected from this VC to filterVC
        filterVC.thisFeedItem = thisItem
        
        //Show the filterVC through the NAVController
        self.navigationController?.pushViewController(filterVC, animated: false)
        
        
    }
    
    
     // MARK: - CLLocationManagerDelegate Methods
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!)
    {
        println("Locations =  \(locations)")
    }
    
    

}
