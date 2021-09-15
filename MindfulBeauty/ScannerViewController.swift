//
//  ScannerViewController.swift
//  MindfulBeauty
//
//  Created by Ritu K on 4/18/19.
//  Copyright © 2019 Ritu K. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit

class ScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    override func viewDidLoad() {
        setUpScanner()
    }
    
    func setUpScanner() {
        view.backgroundColor = UIColor.black
        
        captureSession = AVCaptureSession()
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        guard let videoInput = getVideoInput(captureDevice: videoCaptureDevice) else { return }
        
        addInputToCaptureSession(captureSession: captureSession, input: videoInput)
        
        let metadataOutput = AVCaptureMetadataOutput()
        addMetadataOutputToCaptureSession(captureSession: captureSession, metadataOutput: metadataOutput)
        
        setUpPreviewLayer()
    }
    
    func getVideoInput(captureDevice:AVCaptureDevice) -> AVCaptureDeviceInput? {
        let videoInput: AVCaptureDeviceInput
        do {
            videoInput = try AVCaptureDeviceInput(device: captureDevice)
            return videoInput
        } catch {
            return nil
        }
    }
    
    func setUpPreviewLayer() {
        self.previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        self.previewLayer.frame = view.layer.bounds
        self.previewLayer.videoGravity = .resizeAspectFill
        self.view.layer.addSublayer(previewLayer)
    }
    
    
    func addInputToCaptureSession(captureSession:AVCaptureSession, input:AVCaptureDeviceInput) {
        if captureSession.canAddInput(input) {
            captureSession.addInput(input)
        } else {
            failed()
            return
        }
    }
    
    func addMetadataOutputToCaptureSession(captureSession:AVCaptureSession, metadataOutput:AVCaptureMetadataOutput) {
        if captureSession.canAddOutput(metadataOutput) {
            captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.ean8, .ean13, .pdf417, .upce]
        } else {
            failed()
            return
        }
    }
    
    func failed()  {
        captureSession = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        runCaptureSession()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        endCaptureSession()
    }
    
    func runCaptureSession() {
        if let captureSession = captureSession {
            if !(captureSession.isRunning) {
                captureSession.startRunning()
            }
        }
    }
    
    func endCaptureSession() {
        if let captureSession = captureSession {
            if captureSession.isRunning {
                captureSession.stopRunning()
            }
        }
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession.stopRunning()
        
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else {return}
            guard let stringValue = readableObject.stringValue else {return}
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            codeFound(code: stringValue)
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func codeFound(code: String) {
        ProductData.defaults.set(code, forKey: "barcodeNumber")
        performSegue(withIdentifier: "productInfoSegue", sender: nil)
    }
    
    @objc func dismissScanner()  {
        self.dismiss(animated: true, completion: nil)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
}
