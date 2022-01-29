//
//  DetailViewController.swift
//  week-2-task
//
//  Created by Mohammed Al-Quraini on 1/28/22.
//

import UIKit

class DetailViewController: UIViewController {
    
    var photo : Photo!
    let userDefaults = UserDefaults.standard
    
    private let favouriteLabel : UILabel = {
       let label = UILabel()
        
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = false
        label.font = label.font.withSize(20)
        label.text = "Favourite"
        
        return label
    }()
    
    private let switchButton : UISwitch = {
        let uiswitch = UISwitch()
        return uiswitch
    }()
    
    private let imageView : UIImageView = {
        let image = UIImageView()
//        image.image = UIImage(systemName: "info")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        
        return image
    }()
    
    // view will appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        switchButton.isOn = userDefaults.bool(forKey: photo.id.description)
        
    }
    
    
    // view did appear
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // title
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Detail Page"
        
        // add subviews
        view.addSubview(favouriteLabel)
        view.addSubview(switchButton)
        view.addSubview(imageView)
        
        // configure image
        configureImage()
        
        // switch button target
        switchButton.addTarget(self, action: #selector(switchValueDidChange), for: .valueChanged)

        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // favourite label constraints
        favouriteLabel.translatesAutoresizingMaskIntoConstraints = false
        favouriteLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        favouriteLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        
        // switch button constraints
        switchButton.translatesAutoresizingMaskIntoConstraints = false
        switchButton.centerYAnchor.constraint(equalTo: favouriteLabel.centerYAnchor).isActive = true
        switchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        
        // image view constraints
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: favouriteLabel.bottomAnchor, constant: 30).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 3/4).isActive = true
        
    }
    
    private func configureImage(){
        imageView.cacheImage(from: photo.img_src)
    }
    
    // switch button target
    @objc private func switchValueDidChange(_ sender : UISwitch){
        userDefaults.set(sender.isOn, forKey: photo.id.description)
        let name = Notification.Name(rawValue: "tableView")
        NotificationCenter.default.post(name: name, object: nil)
        
    }


}
