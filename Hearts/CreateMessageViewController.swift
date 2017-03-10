
import UIKit

class CreateMessageViewController: UIViewController {

    
    @IBAction func sendMessage(_ sender: UITextField) {
        
        // get the value from the text field
        let message = sender.text
        // make a dictionary
        let dictionary = ["text": message]
        // convert to json data
        guard let data = try? JSONSerialization.data(withJSONObject: dictionary, options: [])
            else {return}
        // create a URLRequest
        let url = URL(string: "https://v.aswifter.guide/heart/")!
        var request = URLRequest(url: url)
        // set it to a post request
        request.httpMethod = "POST"
        // set the data to send
        request.httpBody = data
        // setup a URLSession using the request
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                _ = self.navigationController?.popViewController(animated: true)
            }
            }.resume()
    }

        
}
    
   
    






