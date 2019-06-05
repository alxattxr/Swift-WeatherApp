//
//  MainView.swift
//  WeatherApp
//
//  Created by Alexandre Attar on 2019-06-05.
//  Copyright © 2019 AADevelopment. All rights reserved.
//

import UIKit
import AVFoundation

class MainView: UIView {
    var background:UIColor = UIColor.blue
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        let captureSession = AVCaptureSession()
        var previewLayer: AVCaptureVideoPreviewLayer!
        captureSession.sessionPreset = .high
        
        //If we don't get access to the camera take baby blue or dark blue background color
        guard let captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else {
            fatalError("Unable to access back camera!")
        }
        
        guard let input = try? AVCaptureDeviceInput(device: captureDevice) else {
            fatalError("Unbale to acces Device OR Invalid Device")
        }
        
        captureSession.addInput(input)
        captureSession.startRunning()
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        layer.addSublayer(previewLayer)
        previewLayer.frame = frame
    }

}
