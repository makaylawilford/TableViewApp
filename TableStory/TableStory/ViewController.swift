//
//  ViewController.swift
//  TableStory
//
//  Created by Wilford, Makayla M on 3/17/25.
//

import UIKit
import MapKit
//array objects of our data.
let data = [
    Item(name: "Tacos Los Jambados", neighborhood: "San Marcos", desc: "A local taco truck known for its authentic Mexican street tacos, flavorful meats, and casual atmosphere.", lat: 29.8725, long: -97.9406, imageName: "tacos"),
    Item(name: "Garcia's", neighborhood: "San Marcos", desc: "A well-loved Tex-Mex restaurant serving classic dishes like enchiladas, fajitas, and breakfast tacos in a cozy setting.", lat: 29.8776, long: -97.9409, imageName: "enchiladas"),
    Item(name: "Gus's World Famous Fried Chicken", neighborhood: "San Marcos", desc: "A popular chain specializing in crispy, spicy fried chicken with Southern-style sides like mac and cheese and baked beans.", lat: 29.8796, long: -97.9427, imageName: "chicken"),
    Item(name: "Toro Ramen and Poke Barn", neighborhood: "San Marcos", desc: "A modern eatery offering Japanese ramen bowls, poke bowls, and fusion dishes with fresh ingredients.", lat: 29.8890, long: -97.9418, imageName: "poke"),
    Item(name: "Xian Sushi and Noodle", neighborhood: "San Marcos", desc: "A restaurant featuring hand-pulled noodles, fresh suhsi, and a mix of Chinese and Japanese-inspired dishes in a casual dining setting.", lat: 29.8924, long: -97.9225, imageName: "noodles")
   
]

struct Item {
    var name: String
    var neighborhood: String
    var desc: String
    var lat: Double
    var long: Double
    var imageName: String
}




class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var theTable: UITableView!
    
    
    @IBOutlet weak var mapView: MKMapView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return data.count
   }


   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell")
       let item = data[indexPath.row]
       cell?.textLabel?.text = item.name
       
       //Add image references
                    let image = UIImage(named: item.imageName)
                    cell?.imageView?.image = image
                    cell?.imageView?.layer.cornerRadius = 10
                    cell?.imageView?.layer.borderWidth = 5
                    cell?.imageView?.layer.borderColor = UIColor.white.cgColor
                    
                    
       return cell!
   }
       
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let item = data[indexPath.row]
       performSegue(withIdentifier: "ShowDetailSegue", sender: item)
     
   }
       
    // add this function to original ViewController
           override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
             if segue.identifier == "ShowDetailSegue" {
                 if let selectedItem = sender as? Item, let detailViewController = segue.destination as? DetailViewController {
                     // Pass the selected item to the detail view controller
                     detailViewController.item = selectedItem
                 }
             }
         }
         
             
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        theTable.delegate = self
        theTable.dataSource = self
        //add this code in viewDidLoad function in the original ViewController, below the self statements

         //set center, zoom level and region of the map
        let coordinate = CLLocationCoordinate2D(latitude: 29.8822, longitude: -97.9377)
             let region = MKCoordinateRegion(center: coordinate,span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
             mapView.setRegion(region, animated: true)
             
          // loop through the items in the dataset and place them on the map
              for item in data {
                 let annotation = MKPointAnnotation()
                 let eachCoordinate = CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)
                 annotation.coordinate = eachCoordinate
                     annotation.title = item.name
                     mapView.addAnnotation(annotation)
                     }

           
    }


}

