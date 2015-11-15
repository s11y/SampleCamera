//
//  ViewController.swift
//  SampleCamera
//
//  Created by ShinokiRyosei on 2015/11/16.
//  Copyright © 2015年 ShinokiRyosei. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    //カメラセッション
    let captureSession = AVCaptureSession()
    //デバイス
    var cameraDevices = AVCaptureDevice()
    //画像のアウトプット
    let imageOutput = AVCaptureStillImageOutput()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let devices = AVCaptureDevice.devices()
        
        for device in devices {
            if device.position == AVCaptureDevicePosition.Back {
                cameraDevices = device as! AVCaptureDevice
            }
        }
        
        let videoInput = AVCaptureDeviceInput.dev
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

