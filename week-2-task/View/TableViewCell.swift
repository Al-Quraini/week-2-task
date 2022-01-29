//
//  TableViewCell.swift
//  week-2-task
//
//  Created by Mohammed Al-Quraini on 1/28/22.
//

import UIKit



class TableViewCell: UITableViewCell {
    
    static let identifier : String = "cell"
    
    let userDefaults = UserDefaults.standard

    
    // id label
    let idLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = false
        label.font = label.font.withSize(15)
        
        return label
    }()
    
    
    
    let statusLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = false
        label.font = label.font.withSize(15)
        
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // subviews
        addSubview(idLabel)
        addSubview(statusLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // id label constraints
        idLabel.translatesAutoresizingMaskIntoConstraints = false
        idLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        idLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        
        // description label constraints
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.topAnchor.constraint(equalTo: idLabel.bottomAnchor, constant: 20).isActive = true
        statusLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        idLabel.text = nil
        statusLabel.text = nil
    }
    
    func configureCell(with photo : Photo?){
        if photo == nil
        {return}
        
        let isFavourite =  userDefaults.bool(forKey: photo!.id.description)
        
        DispatchQueue.main.async {
            self.idLabel.text = "id : \(photo!.id)"
            self.statusLabel.text = "status : \(isFavourite)"
        }
//        statusLabel.text = "is favourite : \(photo.status.description)"
        
    }
    
}
