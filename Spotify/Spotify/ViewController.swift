//
//  ViewController.swift
//  Spotify
//
//  Created by Faraz on 7/11/19.
//  Copyright © 2019 mydigipay. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var tracks: Tracks? = nil
    var items = [Items]()
    let spotify = Spotify.sharedInstance
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var spotifyLogo: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.spotifyLogo.image = UIImage(named: "Spotify")
    }
    
    fileprivate func configSearchBar(){
        self.searchBar.returnKeyType = .done
        self.searchBar.showsScopeBar = false
        self.searchBar.delegate = self
    }
    
    fileprivate func configTableView(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.isHidden = true
        self.tableView.tableFooterView = UIView()
        self.tableView.register(UINib(nibName: "TrackRowTableViewCell", bundle: nil), forCellReuseIdentifier: "TrackRowCell")
        self.tableView.register(UINib(nibName: "LoadingTableViewCell", bundle: nil), forCellReuseIdentifier: "LoadingCell")
    }
    
}

extension ViewController:UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
    
}

extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 83
    }
    
}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrackRowCell", for: indexPath) as! TrackRowTableViewCell
        return cell
    }
    
    
}
