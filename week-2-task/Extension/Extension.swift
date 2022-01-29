//
//  Extension.swift
//  week-2-task
//
//  Created by Mohammed Al-Quraini on 1/29/22.
//

import UIKit

extension UIImageView {
    
    func cacheImage(from url : String) {
        guard let url = URL(string: url) else {
            return
        }
        
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url){
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
        
        
        
        
    }
}
