//
//  Helpers.swift
//  MemoryManagementHomework
//
//  Created by Dmytro Kolesnyk2 on 14.05.2020.
//  Copyright © 2020 Dmytro Kolesnyk. All rights reserved.
//

import UIKit

extension UIImage {
    func getImageRatio() -> CGFloat {
        return CGFloat(self.size.width / self.size.height)
    }
}

extension UIImage {
    convenience init?(url: URL?) {
        guard let url = url else { return nil }

        do {
            let data = try Data(contentsOf: url)
            self.init(data: data)
            
        } catch {
            print("Cannot load image from url: \(url) with error: \(error)")
            return nil
        }
    }
}
