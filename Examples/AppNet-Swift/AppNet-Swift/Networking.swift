import UIKit

class Networking: NSObject {
    let SYNCAppNetURL = "https://api.app.net/posts/stream/global"

    var dataStack: DATAStack!

    required init(dataStack: DATAStack) {
        self.dataStack = dataStack
    }

    func fetchNewContent() {
        var urlAppNet = NSURL(string: SYNCAppNetURL)
        var request = NSURLRequest(URL:urlAppNet!)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (var response: NSURLResponse!, var data: NSData!, var error: NSError!) -> Void in
            if ((error) != nil) {
                var alertController = UIAlertController(title: "Ooops!", message: "There was a connection error. \(error)", preferredStyle: UIAlertControllerStyle.Alert)
                var alertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (UIAlertAction) -> Void in
                    alertController.dismissViewControllerAnimated(true, completion: nil)
                })

                alertController.addAction(alertAction)
            } else {
                var serializationJSON = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSJSONSerialization

                Sync.changes(serializationJSON.valueForKey("data") as NSArray, inEntityNamed: "Data", dataStack: self.dataStack, completion: nil)

            }
        }
    }
   
}
