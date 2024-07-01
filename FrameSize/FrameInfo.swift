// 

import Foundation
import AVFoundation

class FrameInfo : NSObject {
    @objc dynamic var frameCount = 0
    @objc dynamic var frameLength = 0
    @objc dynamic var url:URL?
    @objc dynamic var hasFrameLength = false
    
    convenience init(url:URL) {
        self.init()
        self.url = url
        do {
            if url.pathExtension == "light" {
                try processLight(url: url)
            }
            else {
                processWav(url: url)
            }
        }
        catch {
            
        }
    }
    
    func processLight(url:URL) throws {
            let file = try LightFile(url: url)
            self.frameCount = file.frameCount
            self.frameLength = file.frameLength
            hasFrameLength = true
     }
    func processWav(url:URL) {
        _ = Task{
                let asset = AVAsset(url: url)
                var duration = 0.0
                
                let timeduration = try? await asset.load(.duration)
                if timeduration != nil {
                    duration = CMTimeGetSeconds(timeduration!)
                }
            
                frameCount = Int( (duration / ( Double(37) / 1000.0)).rounded())
            }
    }
}
