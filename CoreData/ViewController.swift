//
//  ViewController.swift
//  CoreData
//
//  Created by Damodar Patel on 6/15/15.
//  Copyright (c) 2015 sakha. All rights reserved.
//

import UIKit
import CoreData
import MediaPlayer
import MobileCoreServices
import  AVFoundation


class ViewController: UIViewController,AVAudioPlayerDelegate {
    var cdPersistance : SwiftPersistance?
    var context : NSManagedObjectContext?
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtCell: UITextField!
    @IBOutlet weak var txtAddress: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        cdPersistance = SwiftPersistance();
        context  = cdPersistance!.managedObjectContext!

        playAudio();

        //deleteAll();

    }
    func playAudio(){

        let path = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).first as! String


        var  urlString : NSString = path + "/ChalChal.mp3"
        var player = AVPlayer()


            let url = "http://stream.your.url.com"
            let playerItem = AVPlayerItem( URL:NSURL( string:urlString as String ) )
            player = AVPlayer(playerItem:playerItem)
            player.rate = 1.0;
            player.play()
            

    }
    func deleteAll(){

        let request = NSFetchRequest(entityName: "Person")

        var results = context!.executeFetchRequest(request, error: nil)


        if let tv = results {

            var bas: NSManagedObject!

            for bas: AnyObject in tv
            {
                context!.deleteObject(bas as! NSManagedObject)
            }

            results?.removeAll(keepCapacity: false)
            context!.save(nil)
        }


    }
    @IBAction func saveData(sender: AnyObject) {

        var newPerson = NSEntityDescription.insertNewObjectForEntityForName("Person", inManagedObjectContext: context!) as! NSManagedObject
        newPerson.setValue(txtName.text, forKey: "name")
        newPerson.setValue(txtAddress.text, forKey: "address")
        newPerson.setValue(txtCell.text, forKey: "cell")

        var error: NSError?
        context!.save(nil);


        self.fetchValues();



    }

    func fetchValues (){

        var arrayDetails : NSMutableArray = NSMutableArray()


        var request = NSFetchRequest(entityName: "Person")

        request.returnsObjectsAsFaults = false

        var results = context!.executeFetchRequest(request, error: nil)

        for result in results! as! [NSManagedObject] {

            var name: NSString = result.valueForKey("name")! as! NSString;
            var address: NSString = result.valueForKey("address")! as! NSString;
            var cell: NSString = result.valueForKey("cell")! as! NSString;

            var description: NSString = "Name = \(name), Address:\(address) , Cell: \(cell)"
            //print("Descript : \(description)");
            var dict : NSMutableDictionary  = NSMutableDictionary()
            dict.setObject(name, forKey: "name");
            dict.setObject(address, forKey: "address");
            dict.setObject(cell, forKey: "cell");
            arrayDetails.addObject(dict);


        }


        print("Details : \(arrayDetails)");



    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

