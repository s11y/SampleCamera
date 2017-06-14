//
//  ViewController.swift
//  SampleCamera
//
//  Created by ShinokiRyosei on 2015/11/16.
//  Copyright © 2015年 ShinokiRyosei. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVCapturePhotoCaptureDelegate {

    //カメラセッションの作成
    let captureSession: AVCaptureSession = AVCaptureSession()
    //画像のアウトプット
    //出力先を生成
    var imageOutput: AVCapturePhotoOutput = AVCapturePhotoOutput()

    override func viewDidLoad() {
        super.viewDidLoad()
        //デバイス一覧の取得
        let devices = AVCaptureDeviceDiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: nil, position: .back).devices
        //バックカメラからVideoInputを取得
        let videoInput = try? AVCaptureDeviceInput(device: devices?.first)


        //セッションに追加
        captureSession.addInput(videoInput)

        //セッションに追加
        captureSession.addOutput(imageOutput)

        //画像を表示するレイヤーを生成
        let captureVideoLayer: AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        captureVideoLayer.frame = self.view.bounds
        captureVideoLayer.videoGravity = AVLayerVideoGravityResizeAspectFill

        //Viewに追加
        self.view.layer.insertSublayer(captureVideoLayer, at: 0)
        

        //セッション開始
        captureSession.startRunning()

    }

    @IBAction func cameraStart(_ sender: UIButton) {

        let setting = AVCapturePhotoSettings()
        setting.flashMode = .auto
        setting.isAutoStillImageStabilizationEnabled = true
        setting.isHighResolutionPhotoEnabled = false
        imageOutput.capturePhoto(with: setting, delegate: self)
        captureSession.stopRunning()
    }

    func capture(_ captureOutput: AVCapturePhotoOutput, didFinishProcessingPhotoSampleBuffer photoSampleBuffer: CMSampleBuffer?, previewPhotoSampleBuffer: CMSampleBuffer?, resolvedSettings: AVCaptureResolvedPhotoSettings, bracketSettings: AVCaptureBracketedStillImageSettings?, error: Error?) {

        if let error = error {

            print("ERROR: capture(_ captureOutput: AVCapturePhotoOutput, didFinishProcessingPhotoSampleBuffer photoSampleBuffer: CMSampleBuffer?, previewPhotoSampleBuffer: CMSampleBuffer?, resolvedSettings: AVCaptureResolvedPhotoSettings, bracketSettings: AVCaptureBracketedStillImageSettings?, error: Error?)...\(error.localizedDescription)")
        }
        else {

            guard
                let photoSampleBuffer = photoSampleBuffer,
                let photoData = AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: photoSampleBuffer, previewPhotoSampleBuffer: previewPhotoSampleBuffer),
                let image = UIImage(data: photoData) else { return }

            UIImageWriteToSavedPhotosAlbum(image, self, #selector(imageWriteToSavedPhotosAlbum(_:didFinishSavingWithError:contextInfo:)), nil)
        }
    }

    private dynamic func imageWriteToSavedPhotosAlbum(_ image: UIImage!, didFinishSavingWithError error: Error?,  contextInfo: Any?) {

        if let error = error {

            print("ERROR: imageWriteToSavedPhotosAlbum(_:didFinishSavingWithError:contextInfo) ... \(error)")
        }
        else {


        }
    }
    
}

