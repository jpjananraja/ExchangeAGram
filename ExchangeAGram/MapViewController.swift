//
//  MapViewController.swift
//  ExchangeAGram
//
//  Created by Janan Rajaratnam on 6/3/15.
//  Copyright (c) 2015 Janan Rajaratnam. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class MapViewController: UIViewController {

   
    
    @IBOutlet weak var mapView: MKMapView!
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//        
//        //Coordinates for Paris
//        let location = CLLocationCoordinate2D(latitude: 48.868639224587, longitude: 2.37119161036255)
//       
//        
//        
////        "MKCoordinateSpan" determines the amount of area spanned by the map. You can think of it as the scale we are going to use for that particular map window or the amount of area we will show.
//        
////        
////        "MKCoordinateRegion" determines the center of the map.
////        
////        "MKPointAnnotation" is the actual pin we will use.
//        
//        let span = MKCoordinateSpanMake(0.05, 0.05)
//        
//        let region = MKCoordinateRegionMake(location, span)
//        
//        self.mapView.setRegion(region, animated: true)
//        
//        
//        let annotation = MKPointAnnotation()
//        
//        annotation.setCoordinate(location)
//        annotation.title = "Canal-Saint Martin"
//        annotation.subtitle = "Paris"
//        
//        self.mapView.addAnnotation(annotation)
//        
//        
//    }
    
    
    
    
    override func viewDidLoad()
    {
        
        super.viewDidLoad()
        
        let request = NSFetchRequest(entityName: "FeedItem")
        
        let context:NSManagedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext!
        
        var error:NSError?
        
        
        let itemArray = context.executeFetchRequest(request, error: &error)
        
        if itemArray!.count > 0
        {
            
            for item in itemArray!
            {
                let location = CLLocationCoordinate2D(latitude: Double(item.latitude), longitude: Double(item.longitude))
                
                
                let span = MKCoordinateSpanMake(0.05, 0.05)
                
                let region = MKCoordinateRegionMake(location, span)
                
                self.mapView.setRegion(region, animated: true)
                
                
                let annotation = MKPointAnnotation()
                
                annotation.setCoordinate(location)
                annotation.title = item.caption
                self.mapView.addAnnotation(annotation)
            }
            
        }
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
