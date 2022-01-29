//
//  ViewController.swift
//  week-2-task
//
//  Created by Mohammed Al-Quraini on 1/28/22.
//

import UIKit

class ViewController: UIViewController {
    
    // network manager instance
    private let networkManager = NetworkManager()
    
    // photos array
    private var photos : [Photo]?
    private var selectedPhoto : Photo?
    
    // table view property
    private let tableView : UITableView = {
        let table = UITableView()
        table.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        table.rowHeight = 100

        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // add subviews
        view.addSubview(tableView)
        
        // table view delegates
        tableView.dataSource = self
        tableView.delegate = self
        
        // add observer
        addObserver()
        
        // perform request
        getPhotos()
        
        
        
        
        
    }
    
    // layout subviews
    override func viewDidLayoutSubviews() {
        
        // table view constraints
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
    }
    
    // get photos
    func getPhotos(){
        networkManager.performRequest(Mars.self){ result in
            switch result {
                        case .success(let response):
                self.photos = response.photos
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                        case .failure(let error):
                            print(error.localizedDescription)
                    }
        }
    }
    
    // add observer
    func addObserver(){
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableView), name: NSNotification.Name(rawValue: "tableView"), object: nil)
    }
    
    // reload table view
    @objc func reloadTableView(){
        tableView.reloadData()
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            let destinationVC = segue.destination as! DetailViewController
            if let photo = selectedPhoto {
                destinationVC.photo = photo
            }
            
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}


//MARK: - Table view delegate, Table view data source
extension ViewController : UITableViewDataSource , UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as! TableViewCell
        
        cell.accessoryType = .disclosureIndicator
        cell.configureCell(with: photos?[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        selectedPhoto = photos?[indexPath.row]
        
        
        performSegue(withIdentifier: "showDetail", sender: self)

    }

    
    
}


//MARK: - Network Protocol
extension ViewController : NetworkProtocol {
    typealias Model = Photo
    
    
    func performRequest(from url: String, completion: @escaping (Result<Model, NetworkError>) -> Void) {
        
    }
    
    
}
