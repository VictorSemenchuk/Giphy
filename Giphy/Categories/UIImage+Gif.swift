//
//  UIImage+Gif.swift
//  Giphy
//
//  Created by Victor Macintosh on 26/08/2018.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

import UIKit

extension UIImage {
    @objc public static func animatedImage(data: Data) -> UIImage? {
        guard let source: CGImageSource = CGImageSourceCreateWithData(data as CFData, nil), CGImageSourceGetCount(source) > 1 else {
            return UIImage(data: data)
        }
        
        var frames: [(image: CGImage, delay: TimeInterval)] = []
        for i: Int in 0 ..< CGImageSourceGetCount(source) {
            guard let image = CGImageSourceCreateImageAtIndex(source, i, nil),
                let frame = CGImageSourceCopyPropertiesAtIndex(source, i, nil) as? [String: Any],
                let gif = frame["{GIF}"] as? [String: Any] else {
                continue
            }
            
            if let delay = gif["UnclampedDelayTime"] as? TimeInterval, delay > 0.0 {
                frames.append((image, delay))
            } else if let delay = gif["DelayTime"] as? TimeInterval, delay > 0.0 {
                frames.append((image, delay))
            } else {
                frames.append((image, 0.1))
            }
        }
        
        var images: [UIImage] = []
        var duration: TimeInterval = 0.0
        for frame in frames {
            let image = UIImage(cgImage: frame.image)
            for _ in 0 ..< Int(frame.delay * 100.0) {
                images.append(image)
            }
            duration += frame.delay
        }
        return UIImage.animatedImage(with: images, duration: duration)
    }
}
