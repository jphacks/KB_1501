//
//  LoacationSetViewController.swift
//  jphacks
//
//  Created by SakuragiYoshimasa on 2015/11/28.
//  Copyright © 2015年 at. All rights reserved.
//
import UIKit

class LocationSetViewController: UIViewController {
    
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

extension LocationSetViewController : UISearchBarDelegate  {
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
    }
    
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
}

extension LocationSetViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("CustomCell", forIndexPath: indexPath) as! SearchedTableViewCell
        cell.setup("sample" + String(indexPath))
        return cell
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return myItems.count
        return 4
    }
    
    // セクション高さ
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("Num: \(indexPath.row)")
        // print("Value: \(myItems[indexPath.row])")
    }
}