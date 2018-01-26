//
//  UIImageView+Download.swift
//  HelloAdvanceImageView
//
//  Created by 胡靜諭 on 2018/1/26.
//  Copyright © 2018年 胡靜諭. All rights reserved.
//

import UIKit


extension UIImageView {
    
    func showImage(url: URL) {
        
        
//        check if this file exisr in Caches.
        
        guard let cachesUrl = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else{
            
            return
        }
        
        let hashFilename = String(format: "Cache_%1d", url.hashValue) // url.hashValue 就可以獨一無二
        let finalFullUrl = cachesUrl.appendingPathComponent(hashFilename) // 路徑加檔名
        if let image = UIImage (contentsOfFile: finalFullUrl.path){
            self.image = image
            return
        }
        
         //   Mark: - loadingView
        let loadingIndicatorView = prepareLoadingIndicatorView()
        
        
        let confing = URLSessionConfiguration.default
        let session = URLSession(configuration: confing)
        let task = session.dataTask(with: url) { (data, response, error) in
            defer{//defer refers to delay 他可以等到上一層closure 結束 再執行defer裡面的程式
                DispatchQueue.main.async {
                    loadingIndicatorView.stopAnimating()
                    loadingIndicatorView.removeFromSuperview()
                }
            }
            if let error = error {
                NSLog("Dowload Image Fail: \(error)")
                return
            }
            //Show image.
            guard let data = data else {
                NSLog("Invalid nil data")
                return
            }
            let image = UIImage(data: data)
            DispatchQueue.main.async {
                self.image = image
            }
        }
        loadingIndicatorView.startAnimating()
        task.resume() //Importnt!!!
    }
    
    private func prepareLoadingIndicatorView() -> UIActivityIndicatorView {
        
        //Remove loadingIndicatorView if exist.
        for view in self.subviews {
            //subView 就是附加在imageView上
            if view is UIActivityIndicatorView {
                view.removeFromSuperview()
            }
        }
        
        let frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        //self->imageView 轉轉轉的長寬就佔滿 imageView
        let result = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        result.frame = frame
        result.color = UIColor.blue
        result.hidesWhenStopped = true
        self.addSubview(result)
        return result
        
        
    }
    
}
