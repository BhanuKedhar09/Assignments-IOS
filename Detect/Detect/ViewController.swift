//
//  ViewController.swift
//  Detect
//
//  Created by Sunku Bhanu Kedhar Nath on 4/19/23.
//


import UIKit
import AVKit
import Vision


class ViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    let identifierLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let captureSession = AVCaptureSession()
    let captureQueue = DispatchQueue(label: "com.example.captureQueue")
    
    lazy var model: VNCoreMLModel = {
        guard let model = try? VNCoreMLModel(for: Resnet50().model) else {
            fatalError("Failed to load Core ML model")
        }
        return model
    }()
    
    var lastRequestDate = Date()
    let requestThrottleInterval: TimeInterval = 0.5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        captureSession.sessionPreset = .photo
        
        guard let captureDevice = AVCaptureDevice.default(for: .video) else { return }
        guard let input = try? AVCaptureDeviceInput(device: captureDevice) else { return }
        captureSession.addInput(input)
        captureSession.startRunning()
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        view.layer.addSublayer(previewLayer)
        previewLayer.frame = view.frame
        
        let dataOutput = AVCaptureVideoDataOutput()
        dataOutput.setSampleBufferDelegate(self, queue: captureQueue)
        captureSession.addOutput(dataOutput)
        
        setupIdentifierConfidenceLabel()
    }
    
    fileprivate func setupIdentifierConfidenceLabel() {
        view.addSubview(identifierLabel)
        identifierLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32).isActive = true
        identifierLabel.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        identifierLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        identifierLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        identifierLabel.textColor = .red
    }
    
    func captureOutput(_ output : AVCaptureOutput, didOutput sampleBuffer : CMSampleBuffer, from connection : AVCaptureConnection) {
        guard let pixelBuffer: CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        
        let currentDate = Date()
        let timeElapsedSinceLastRequest = currentDate.timeIntervalSince(lastRequestDate)
        if timeElapsedSinceLastRequest < requestThrottleInterval {
            return
        }
        lastRequestDate = currentDate
        
        let request = VNCoreMLRequest(model: model) { [weak self] finishedReq, error in
            guard let results = finishedReq.results as? [VNClassificationObservation], let firstObservation = results.first else { return }
            
            DispatchQueue.main.async {
                self?.identifierLabel.text = "\(firstObservation.identifier) \(firstObservation.confidence * 100)"
                print(firstObservation.identifier)
            }
        }
        try? VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:]).perform([request])
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        URLCache.shared.removeAllCachedResponses()
    }
}

