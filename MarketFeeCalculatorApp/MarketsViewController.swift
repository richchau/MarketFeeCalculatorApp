//
//  MarketsViewController.swift
//  MarketFeeCalculatorApp
//
//  Created by Rich Chau on 4/1/20.
//  Copyright © 2020 Rich Chau. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class MarketsViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout{
    
    var items = [[String:String]]()
    
    func loadPlist() -> [[String:String]]{
        
        let path = Bundle.main.path(forResource: "Markets", ofType: "plist")
        return NSArray.init(contentsOf: URL.init(fileURLWithPath: path!)) as! [[String:String]]
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Do any additional setup after loading the view.
        self.items = loadPlist()
        self.navigationItem.title = "Markets"
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.items.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MarketCell", for: indexPath) as! MarketCell
    
        // Configure the cell
        
        let item = self.items[indexPath.row]
        cell.cellImageView.image = UIImage(named: item["Image"]!)
        cell.layer.cornerRadius = 7
        cell.backgroundColor = UIColor.white
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let screenSize : CGRect = UIScreen.main.bounds
        
        var widthCell = 0
        var heightCell = 0
        
        //Iphone 11 Pro Max, Xs Max, 11, Xr, 6+. 6s+, 7+, 8+
        if screenSize.width == 414 {
            widthCell = 187
            heightCell = widthCell
        }
        
        //Iphone 11 Pro, X, Xs, 6
        if screenSize.width == 375 {
            widthCell = 167
            heightCell = widthCell
        }
        
        //Iphone 11 Pro, X, Xs, 6
        if screenSize.width == 320 {
            widthCell = 140
            heightCell = widthCell
        }
        
        
        return CGSize(width: widthCell, height: heightCell)
    }
    
    
    
}
