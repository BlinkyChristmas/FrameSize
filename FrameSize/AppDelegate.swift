// 

import Cocoa
import UniformTypeIdentifiers
@main
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet var window: NSWindow!

    @objc dynamic var items = [FrameInfo]()
    @IBOutlet var arrayController:NSArrayController!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
    }
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }

    @IBAction func createItem( _ sender: Any?) {
        let panel = NSOpenPanel()
        panel.prompt = "Wav/Light file(s)"
        panel.allowsMultipleSelection = true
        panel.allowedContentTypes = [UTType.wav,UTType(filenameExtension: "light")!]
        panel.beginSheetModal(for: self.window) { response in
            guard response == .OK , !panel.urls.isEmpty else { return }
            for url in panel.urls {
                self.arrayController.addObject(FrameInfo(url: url))
            }
        }
    }

    @IBAction func clearItem( _ sender: Any?) {
        items = [FrameInfo]()
    }
}

