//
//  FilterManager.swift
//  Fotoroid
//
//  Created by Henrique Alves Batochi on 22/02/22.
//

import UIKit

enum FilterType: Int{
    case comic
    case sepia
    case halftone
    case crystallize
    case vignette
    case noir
}

class FilterManager {
    
    let originalImage: UIImage
    let context = CIContext(options: nil)
    let filterNames = [
        "CIComicEffect",
        "CISepiaTone",
        "CICMYKHalfTone",
        "CICrystallize",
        "CIVignette",
        "CIPhotoEffectNoir"
    ]
    
    init(image: UIImage) {
        self.originalImage = image
    }
    
    func applyFilter(type: FilterType) -> UIImage {
        let ciImage = CIImage(image: originalImage)!
        let filter = CIFilter(name: filterNames[type.rawValue])!
        filter.setValue(ciImage, forKey: kCIInputImageKey)
        switch type {
            case .comic:
                break
            case .sepia:
                filter.setValue(1.0, forKeyPath: kCIInputIntensityKey)
            case .halftone:
                filter.setValue(25, forKeyPath: kCIInputWidthKey)
            case .crystallize:
                filter.setValue(25, forKeyPath: kCIInputRadiusKey)
            case .vignette:
                filter.setValue(3, forKeyPath: kCIInputIntensityKey)
                filter.setValue(30, forKey: kCIInputRadiusKey)
            case .noir:
                break
        }
        let filteredImage = filter.value(forKey: kCIOutputImageKey) as! CIImage
        let cgImage = context.createCGImage(filteredImage, from: filteredImage.extent)
        return UIImage(cgImage: cgImage!)
    }
}
