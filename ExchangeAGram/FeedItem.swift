//
//  FeedItem.swift
//  ExchangeAGram
//
//  Created by Janan Rajaratnam on 6/4/15.
//  Copyright (c) 2015 Janan Rajaratnam. All rights reserved.
//

import Foundation
import CoreData

@objc (FeedItem)
class FeedItem: NSManagedObject {

    @NSManaged var caption: String
    @NSManaged var filtered: NSNumber
    @NSManaged var image: NSData
    @NSManaged var latitude: NSNumber
    @NSManaged var longitude: NSNumber
    @NSManaged var thumbNail: NSData
    @NSManaged var uniqueID: String

}
