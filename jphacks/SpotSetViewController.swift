//
//  LoacationSetViewController.swift
//  jphacks
//
//  Created by SakuragiYoshimasa on 2015/11/28.
//  Copyright © 2015年 at. All rights reserved.
//
import UIKit

class SpotSetViewController: BaseViewController {
    
    var spots: [Spot]!
    var searchedSpots: [Spot]! = nil
    var spot: Spot!
    var completion: (Spot) -> Void = {_ in }

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var seachedTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        searchBar.showsCancelButton = true
        seachedTableView.registerClass(SearchedTableViewCell.self, forCellReuseIdentifier: "CustomCell")
        seachedTableView.delegate = self
        seachedTableView.dataSource = self
        seachedTableView.allowsSelection = true
        seachedTableView.allowsMultipleSelection = false
        spot = Spot(name: "sample", address: "sample", detail: "", latitude: 1, longitude: 1)
        spots = SpotManager.sharedController.spots
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func dismissView(sender: AnyObject) {
        dismiss()
    }
    
    func dismiss(){
        completion(spot)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

extension SpotSetViewController : UISearchBarDelegate  {
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        self.filterContainsWithSearchText(searchText)
        self.seachedTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
    
    func filterContainsWithSearchText(searchText: String) {
        if searchText == "" {
            return searchedSpots = nil
        }
        searchedSpots = spots.filter { spot -> Bool in
            return spot.name.rangeOfString(searchText) != nil
        }
        
    }
}

extension SpotSetViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CustomCell", forIndexPath: indexPath) as! SearchedTableViewCell
        if searchedSpots != nil {
            cell.setup(searchedSpots[indexPath.row].name)
        } else {
            cell.setup(spots[indexPath.row].name)
        }
        return cell
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchedSpots != nil {
            return self.searchedSpots.count
        }
        return self.spots.count

    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        spot = Spot(name: "sample" + String(indexPath.row), address: "sample", detail: "", latitude: 1, longitude: 1)
        dismiss()
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}