//
//  ULQRScannerViewController.swift
//  ulearning_app_ios
//
//  Created by Gonzalo López on 25/07/23.
//

import UIKit
import AVFoundation


class ULQRScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupQRScanner()
    }

    func setupQRScanner() {
        let captureDevice = AVCaptureDevice.default(for: .video)

        do {
            let input = try AVCaptureDeviceInput(device: captureDevice!)

            captureSession = AVCaptureSession()
            captureSession.addInput(input)

            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession.addOutput(captureMetadataOutput)

            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = [.qr]
            
            
            DispatchQueue.global(qos: .userInitiated).async { // Use a background queue for setup
                       self.captureSession.startRunning()
                   }

            previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            previewLayer.frame = view.layer.bounds
            view.layer.addSublayer(previewLayer)

        } catch {
            print("Error setting up QR scanner: \(error)")
        }
    }

    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if let metadataObj = metadataObjects.first as? AVMetadataMachineReadableCodeObject {
            if metadataObj.type == .qr, let stringValue = metadataObj.stringValue {
                // Process the scanned QR code value (stringValue) here.
                print("Scanned QR Code: \(stringValue)")
                if let url = URL(string: stringValue ) {
                    UIApplication.shared.open(url, options: [:])
                }
            }
        }
    }
}
