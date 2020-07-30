//
//  ViewController.swift
//  Filtery
//
//  Created by Eric Golovin on 30.07.2020.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    enum StoryboardID: String {
        case photoVC = "PhotoViewController"
    }
    
    @IBOutlet var rgbLabels: [UILabel]!
    var colorsData: [Int] {
        get {
            return []
        }
        set {
            self.updateRGBLabels(with: newValue)
        }
    }
    
    let captureSession = AVCaptureSession()
    var previewLayer: CALayer!
    
    var captureDevice: AVCaptureDevice!
    
    var takePhoto = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        AVCaptureDevice.requestAccess(for: .video, completionHandler: { granted in
        })
        self.prepareCamera()
    }
    
    @IBAction func takePhoto(_ sender: UIButton) {
        takePhoto = true
    }
    
    func prepareCamera() {
        captureSession.sessionPreset = AVCaptureSession.Preset.photo
        
        print(AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .back).devices)
        if let ultraWideCamera = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .back).devices.first {
            captureDevice = ultraWideCamera
            beginSession()
        }
        
    }
    
    func beginSession() {
        do {
            let captureDeviceInput = try AVCaptureDeviceInput(device: captureDevice)
            
            captureSession.addInput(captureDeviceInput)
            
        } catch {
            print("Error: \(error): \(error.localizedDescription)")
        }
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        self.previewLayer = previewLayer
        view.layer.addSublayer(self.previewLayer)
        previewLayer.frame = view.layer.frame
        captureSession.startRunning()
        
        let dataOutput = AVCaptureVideoDataOutput()
        
        dataOutput.videoSettings = [(kCVPixelBufferPixelFormatTypeKey as String): kCVPixelFormatType_32BGRA]
        
        dataOutput.alwaysDiscardsLateVideoFrames = true
        
        if captureSession.canAddOutput(dataOutput) {
            captureSession.addOutput(dataOutput)
        }
        
        captureSession.commitConfiguration()
        
        
        let queue = DispatchQueue(label: "com.ericgolovin.captureQueue")
        dataOutput.setSampleBufferDelegate(self, queue: queue)
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let sampleBufferColorData = getImageColorsFromSumpleBuffer(sampleBuffer) else {
            return
        }
        
        DispatchQueue.main.async {
            self.updateRGBLabels(with: sampleBufferColorData)
        }
        
        if takePhoto {
            takePhoto.toggle()
            
            if let image = getImageFromSampleBuffer(buffer: sampleBuffer) {
                DispatchQueue.main.async {
                    let photoViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: StoryboardID.photoVC.rawValue) as! PhotoViewController
                    
                    photoViewController.image = image
                    photoViewController.completion = { self.beginSession() }
                    
                    self.present(photoViewController, animated: true, completion: {
                        self.stopCaptureSession()
                    })
                }
                
            }
            
        }
    }
    
    func getImageFromSampleBuffer(buffer: CMSampleBuffer) -> UIImage? {
        if let pixelBuffer = CMSampleBufferGetImageBuffer(buffer) {
            
            let ciImage = CIImage(cvPixelBuffer: pixelBuffer)
            
            let context = CIContext()
            
            let imageRect = CGRect(x: 0, y: 0, width: CVPixelBufferGetWidth(pixelBuffer), height: CVPixelBufferGetHeight(pixelBuffer))
            
            if let image = context.createCGImage(ciImage, from: imageRect) {
                return (UIImage(cgImage: image, scale: UIScreen.main.scale, orientation: .right))
            }
            
        }
        return nil
    }
    
    func getImageColorsFromSumpleBuffer(_ buffer: CMSampleBuffer) -> [Int]? {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(buffer) else {
            return nil
        }
        
        let ciImage = CIImage(cvPixelBuffer: pixelBuffer)
        
        let extentVector = CIVector(x: ciImage.extent.origin.x, y: ciImage.extent.origin.y, z: ciImage.extent.size.width, w: ciImage.extent.size.height)
        
        guard let filter = CIFilter(name: "CIAreaAverage", parameters: [kCIInputImageKey: ciImage, kCIInputExtentKey: extentVector]) else { return nil }
        guard let outputImage = filter.outputImage else { return nil }
        
        var bitmap = [UInt8](repeating: 0, count: 3)
        let filterContext = CIContext(options: [.workingColorSpace: kCFNull!])
        filterContext.render(outputImage, toBitmap: &bitmap, rowBytes: 4, bounds: CGRect(x: 0, y: 0, width: 1, height: 1), format: .RGBA8, colorSpace: nil)
        
        return bitmap.map { Int($0) }
    }
    
    func updateRGBLabels(with colorsData: [Int]) {
        for (index, color) in colorsData.enumerated() {
            rgbLabels[index].text = "\(color)"
        }
    }
    
    func stopCaptureSession() {
        self.captureSession.stopRunning()
        
        if let inputs = captureSession.inputs as? [AVCaptureDeviceInput] {
            for input in inputs {
                self.captureSession.removeInput(input)
            }
        }
        
    }
    
}

