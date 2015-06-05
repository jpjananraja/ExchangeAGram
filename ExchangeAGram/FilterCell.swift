//
//  FilterCell.swift
//  ExchangeAGram
//
//  Created by Janan Rajaratnam on 5/30/15.
//  Copyright (c) 2015 Janan Rajaratnam. All rights reserved.
//

import UIKit

class FilterCell: UICollectionViewCell
{

    var imageView:UIImageView!
    
    
    override init(frame: CGRect)
    {
        
        super.init(frame: frame)
        
        self.imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        
        //add the imageview to the main view of the cell
        self.contentView.addSubview(self.imageView)
        
        
        println("\nSize of width of cell is: \(frame.size.width)")
        println("\nSize of height of cell is: \(frame.size.height)")

    }

    
    //To make it NSCoding compliant
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
