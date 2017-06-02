//
//  UIImageView.swift
//  TlySina
//
//  Created by jack_tang on 17/5/4.
//  Copyright © 2017年 jack_tang. All rights reserved.
//

import SDWebImage

extension UIImageView{

    func cz_setImage(urlString : String? ,placeholderImage: UIImage){
    
        guard let urlString = urlString,
              let url = URL(string: urlString)  else {
              image = placeholderImage
            return
        }
        
        sd_setImage(with: url, placeholderImage: placeholderImage, options: []) { (image, _, _, _) in
            
        }
    
    }


}
