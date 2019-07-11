//
//  ViewController.swift
//  Spotify
//
//  Created by Faraz on 7/11/19.
//  Copyright © 2019 mydigipay. All rights reserved.
//

import UIKit
import Kingfisher
import Reachability

class ViewController: UIViewController {
    
    var tracks: Tracks? = nil
    var items = [Items]()
    let spotify = Spotify.sharedInstance
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var spotifyLogo: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configTableView()
        self.configSearchBar()
        self.initialViews()
        self.initialValues()
    }
    
    fileprivate func initialValues(){
        KingfisherManager.shared.cache.memoryStorage.config.totalCostLimit = 10000
        NotificationCenter.default.addObserver(self, selector: #selector(self.requestAuthorizationBearerToken(_:)), name: NSNotification.Name(rawValue: Constants.afterLoginNotificationKey), object: nil)
        _ = spotify.getTokenIfNeeded()
        
        let reachability = Reachability(hostname: "Spotify.com")!
        
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
        do{
            try reachability.startNotifier()
        }catch{
            print("could not start reachability notifier")
        }
    }
    
    fileprivate func initialViews(){
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
    
    @objc fileprivate func requestAuthorizationBearerToken(_ notification: NSNotification){
        if let url = (notification.userInfo?["url"] as? URL){
            spotify.getCodeFromUrlParams(url: url)
        }
    }
    
    @objc func reachabilityChanged(note: Notification) {
        
        let reachability = note.object as! Reachability
        
        reachability.whenReachable = { [weak self] _ in
            
        }
        reachability.whenUnreachable = { [weak self] _ in
        }
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
