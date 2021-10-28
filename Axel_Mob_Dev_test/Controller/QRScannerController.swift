//
//  QRScannerController.swift
//  Axel_Mob_Dev_test
//
//  Created by Meadown on 28/10/21.
//

import UIKit
import AVFoundation

class QRScannerController: UIViewController {
    
    //MARK: all necessaryview Outlates
    @IBOutlet weak var leftPadingView: UIView!
    @IBOutlet weak var rightPadingView: UIView!
    @IBOutlet weak var subview: UIView!
    
    @IBOutlet var designHelperView: [UIView]!
    
    @IBOutlet weak var lblScanStatus: UILabel!
    
    @IBOutlet weak var imgScanGroup: UIImageView!{
        didSet{
            let tapgGesture = UITapGestureRecognizer(target:self , action: #selector(startScan))
            imgScanGroup.addGestureRecognizer(tapgGesture)
            imgScanGroup.isUserInteractionEnabled = true
        }
    }
    @IBOutlet weak var imgBack: UIImageView!{
        didSet{
            let tapgGesture = UITapGestureRecognizer(target:self , action: #selector(backToHome))
            imgBack.addGestureRecognizer(tapgGesture)
            imgBack.isUserInteractionEnabled = true
        }
    }
    
    //MARK: all constraints layout
    @IBOutlet weak var leftPadingHeightConstant: NSLayoutConstraint!
    @IBOutlet weak var rightPadingHeightConstant: NSLayoutConstraint!
    
    var captureSession = AVCaptureSession()
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var qrCodeFrameView: UIView?
    
    private let supportedCodeTypes = [AVMetadataObject.ObjectType.upce,
                                      AVMetadataObject.ObjectType.code39,
                                      AVMetadataObject.ObjectType.code39Mod43,
                                      AVMetadataObject.ObjectType.code93,
                                      AVMetadataObject.ObjectType.code128,
                                      AVMetadataObject.ObjectType.ean8,
                                      AVMetadataObject.ObjectType.ean13,
                                      AVMetadataObject.ObjectType.aztec,
                                      AVMetadataObject.ObjectType.pdf417,
                                      AVMetadataObject.ObjectType.itf14,
                                      AVMetadataObject.ObjectType.dataMatrix,
                                      AVMetadataObject.ObjectType.interleaved2of5,
                                      AVMetadataObject.ObjectType.qr]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Get the back-facing camera for capturing videos
        guard let captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else {
            print("Failed to get the camera device")
            return
        }
        
        do {
            // Get an instance of the AVCaptureDeviceInput class using the previous device object
            let input = try AVCaptureDeviceInput(device: captureDevice)
            
            // Set the input device on the capture session
            captureSession.addInput(input)
            
            // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession.addOutput(captureMetadataOutput)
            
            // Set delegate and use the default dispatch queue to execute the call back
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
//            captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
            captureMetadataOutput.metadataObjectTypes = supportedCodeTypes
            
            // Initialize the video preview layer and add it as a sublayer to the viewPreview view's layer
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
            videoPreviewLayer?.frame = view.layer.bounds
            view.layer.addSublayer(videoPreviewLayer!)
            
            // Start video capture
          //  captureSession.startRunning()
            
            // Move the message label and top bar to the front and setup view
            
            
            
            
            // Initialize QR Code Frame to highlight the QR Code
            leftPadingHeightConstant.constant = UIScreen.main.bounds.height/3
            rightPadingHeightConstant.constant = UIScreen.main.bounds.height/3
            
            
            if let qrcodeFrameView = qrCodeFrameView {
                qrcodeFrameView.layer.borderColor = UIColor.yellow.cgColor
                qrcodeFrameView.layer.borderWidth = 2
                view.addSubview(qrcodeFrameView)
                view.bringSubviewToFront(qrcodeFrameView)
            }
            
        } catch {
            // If any error occurs, simply print it out and don't continue anymore
            print(error)
            return
        }
    }
    
    
    @objc func startScan(){
        // Start video capture
        self.view.bringSubviewToFront(subview)
        
        lblScanStatus.text = "Scanning..."
        captureSession.startRunning()
    }
    @objc func backToHome(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "home")
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true)
        captureSession.stopRunning()
    }

}

extension QRScannerController: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        // Check if the metadataObjects array is not nil and it contains at least one object
        if metadataObjects.count == 0 {
            qrCodeFrameView?.frame = CGRect.zero
           // messageLabel.text = "No QR code is detected"
            return
        }
        
        // Get the metadata object
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        if supportedCodeTypes.contains(metadataObj.type) {
            // If the found metadata is equal to the QR code metadata then update the status label's text and set the bounds
            let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
            qrCodeFrameView?.frame = barCodeObject!.bounds
            
            if metadataObj.stringValue != nil {
               // messageLabel.text = metadataObj.stringValue
                print("start data view\n",metadataObj,"\nend dataview")
                ManagetData.shared.qrDetails = metadataObj.stringValue! + "\n\nThis is a demo app. Any data can be shown here accoerding to the API structure and with gendeling the qr  Functionalities."
                
                performSegue(withIdentifier: "afterScan", sender: self)
                captureSession.stopRunning()
            }
        }
    }
}
