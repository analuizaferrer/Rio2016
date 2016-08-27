//
//  AppDelegate.swift
//  Rio2016
//
//  Created by Ana Luiza Ferrer on 8/4/16.
//  Copyright © 2016 Ana Luiza Ferrer. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    // Praia de Copacabana, Arcos da Lapa, Bonde de Santa Teresa, Parque das Ruínas, Escadaria Selaron, Theatro Municipal, Paço Imperial, Quinta da Boa Vista, Lagoa, Jardim Botânico, Pão de Açúcar, Cristo Redentor, Floresta da Tijuca, Arpoador, Museu do Amanhã.
    
    let christTheRedeemer = Sticker(name: NSLocalizedString("CHRIST_THE_REDEEMER",comment:"Christ the Redeemer"), description: NSLocalizedString("CHRIST_THE_REDEEMER_DESCRIPTION", comment:"It’s located at Parque Nacional da Tijuca, 710 meter above the sea level, where anybody can appreciate one of the most beautiful views of the city. Over all 220 steps that lead to the famous statue feet, it was elected one of the Seven Wonders of the World made by formal voting in 2007 by the Swiss Institution New 7 Wonders Foundation. The monument is accessible by train, van or car. To get into the monument, there’s a nice ride by train that, during 20 minutes, it crosses Mata Atlântica until Corcovado’s top. Making an easy access to the visitants, three panoramic elevators and four escalators were built. The visual is amazing; it makes an unmissable programme for those that visit the city."), latitude: -22.9519, longitude: -43.2105, cover: "christTheRedeemer", photo: "no photo", date: "")

    let sugarLoaf = Sticker(name: NSLocalizedString("SUGAR_LOAF",comment:"Sugar Loaf"), description: NSLocalizedString("SUGAR_LOAF_DESCRIPTION",comment:"Inaugurated in 1912, the little tram of the Sugar loaf was the first Brazilian cable car and the third in the world, linking the Urca hill to the Sugar loaf mountain. Since then, more than 40 million of people have already used that cable cars. From the high of the two mountains revels a gorgeous landscapes of the city, including the Botafogo cave, Copacabana edge and the entrance of Guanabara bay. In the summer, the amphitheater, located in the top of Urca hill is a stage for shows and night events, joining fun and a wonderful visual of lights of the city."), latitude: 0, longitude: 0, cover: "sugarLoaf", photo: "no photo", date: "")
    
    let copacabanaBeach = Sticker(name: NSLocalizedString("COPACABANA_BEACH",comment:"Copacabana Beach"), description: NSLocalizedString("COPACABANA_BEACH_DESCRIPTION",comment:"Affectionately known by the population of Princess of the Sea, a popular song of the Brazilian João de Barro – Braguinha – and Alberto Ribeiro, Copacabana beach is located in a district of the same name in the South of Rio. Copacabana has bike racks, bike path, kiosks, hotels, bars and restaurants frequented both day and night. It also has two military forts, one at each end of the beach, with panoramic views, open to visitation. Stage of the largest New Year’s Eve party on the planet with their fires known worldwide, Copacabana has more than three million people every passing year."), latitude: 0, longitude: 0, cover: "copacabanaBeach", photo: "no photo", date: "")
    
    let pucRio = Sticker(name: "PUC-Rio", description: "", latitude: -22.9793, longitude: -43.2331, cover: "", photo: "", date: "")
    
    let lapaArches = Sticker(name: NSLocalizedString("LAPA_ARCHES",comment:"Lapa Arches"), description: NSLocalizedString("LAPA_ARCHES_DESCRIPTION",comment:"Rio’s old Carioca Aqueduct, known Lapa Arches, is one of the best known sites in the city, as well as one of the most representative symbols of old Rio, fully preserved to this day at the bohemian neighborhood of Lapa. The limestone structure in a Romantic style features 42 large double arcs and seeing glasses in the superior area. The Lapa Arches are considered the architectural piece in Brazil built during the colonial period. Around it are two of the most important houses of the city: Fundição Progresso e Circo Voador."), latitude: 0, longitude: 0, cover: "lapaArches", photo: "no photo", date: "")
    
    let saintTeresaTram = Sticker(name: NSLocalizedString("SAINT_TERESA_TRAM",comment:"Saint Teresa Tram"), description: NSLocalizedString("SAINT_TERESA_TRAM_DESCRIPTION",comment:"The original characteristics of the Santa Teresa Tram were preserved and its external features were listed as a national heritage by the State Government in 1983. The trip begins in the downtown area, passing through Lapa Arches and the district’s slopes, and landmarks such as Ruins Park – an observatory with an amazing view of Rio de Janeiro."), latitude: 0, longitude: 0, cover: "saintTeresaTram", photo: "no photo", date: "")
    
    let ruinsPark = Sticker(name: NSLocalizedString("RUINS_PARK",comment:"Ruins Park"), description: NSLocalizedString("RUINS_PARK_DESCRIPTION",comment:"The program is perfect to relax, date or talk overlooking the beautiful scenery of downtown and Guanabara bay. For those who wants to have fun with the family, the place is also perfect, because the Cultural Centre of the park is for free and intense like exposition, theater for kids, performances by circuses and music. Saturdays and Sundays, there are special programming for kids and a great breakfast served by the local coffee shop. The Cultural Centre Parque das Ruínas was the house of a big Maecenas of Belle Époque carioca, Laurinda Santos Lobo. Known as the “marechala da elegância”, Laurinda used to meet intellectuals and artists on the magnificent premises of the palace, that today uis one of the most beautiful winning projects of the architect Ernani Freire and house experimental works of art. Unmissable!"), latitude: 0, longitude: 0, cover: "ruinsPark", photo: "no photo", date: "")
    
    let selaronsSteps = Sticker(name: NSLocalizedString("SELARONS_STEPS",comment:"Selarón's Steps"), description: NSLocalizedString("SELARONS_STEPS_DESCRIPTION",comment:"Selarón's Steps is located 5 minutes away from Lapa Arches, connecting Santa Teresa to the Lapa district, decorated with colored tiles from various different corners of the world. The steps were envisioned by Chilean artist Jorge Selarón."), latitude: 0, longitude: 0, cover: "selaronsSteps", photo: "no photo", date: "")
    
    let municipalTheatre = Sticker(name: NSLocalizedString("MUNICIPAL_THEATRE", comment: "Municipal Theatre"), description: NSLocalizedString("MUNICIPAL_THEATRE_DESCRIPTION", comment: "Inaugurated in 1909, the Municipal theatre is one of the main show houses of Brazil and Latin America. Over less than a century of the history, the Municipal Theatre earned big international artists and important names of the Brazilian culture, including dancing representatives, music, opera and performing arts. The project that started the beginning of the construction of Municipal theatre was made from the fusion of architectural projects of Francisco de Oliveira Passos and the French Albert Guilbert, tied the contest for creation of the new theatre design. This design was inspired on the Paris Opera. Since the 30 decade, the Municipal theatre of Rio de Janeiro has the worry to keep an own artistic body. Today is the unique Brazilian cultural institution to keep simultaneously a choir, a symphony orchestra and a ballet company."), latitude: 0, longitude: 0, cover: "municipalTheatre", photo: "no photo", date: "")
    
    let imperialPalace = Sticker(name: NSLocalizedString("IMPERIAL_PALACE", comment: "Imperial Palace"), description: NSLocalizedString("IMPERIAL_PALACE_DESCRIPTION", comment: "With the Court D. João VI arrival in Rio de Janeiro, the Paço has transformed in a headquarters for the government of the Kingdom and Empire. After the Republic proclamation, on it was installed the Post offices. In 1938, it was tumbled by the National Historical and Artistic Heritage and today is one of the marks of the cultural history of the city. Since 1985, the Paço Imperial is one of the cultural center bound to the Institute of Historical and Artistic Heritage, from the Ministry culture, and offers incredible exposition during the whole year with free entrance."), latitude: 0, longitude: 0, cover: "imperialPalace", photo: "no photo", date: "")
    
    let quintaDaBoaVista = Sticker(name: NSLocalizedString("QUINTA_DA_BOA_VISTA", comment: "Quinta da Boa Vista"), description: NSLocalizedString("QUINTA_DA_BOA_VISTA_DESCRIPTION", comment: "Located in São Cristóvão, Quinta da Boa Vista is one the biggest urban parks of the city, over 155 thousand square meters. It preserves the gardens and lakes created by the French landscaper Auguste Glaziou; the old real family palace, where the National museum is located; buildings and original bronze statues; like the Apolo Temple; the Monumental Gate, marriage gift of Northumberland Duke to the young couple D. Pedro I and the Empress, D. Leopoldina, that today welcomes the Zoo visitants. Goers of every ages enjoy that big green area to the sport practicing during every day of the week. The paddle boat in the main lake, the multisport court and stroll through artificial caves also attract many youths and kids. The kind gardens are also a space for picnic."), latitude: 0, longitude: 0, cover: "quintaDaBoaVista", photo: "no photo", date: "")
    
    let lagoaRodrigoDeFreitas = Sticker(name: NSLocalizedString("LAGOA_RODRIGO_DE_FREITAS", comment: "Lagoa Rodrigo de Freitas"), description: NSLocalizedString("LAGOA_RODRIGO_DE_FREITAS_DESCRIPTION", comment: "Over the quiet waters of Rodrigo de Freitas Lagoon, cariocas and visitants practice sports, make picnic and relax. The scenery is perfect to the nautical sports, like Rowing and Canoeing. For those who prefer solid ground can opt to walk or cycle over the place, of 8 km, always bustling, mainly in the end of the afternoon. After a lof of effort, nothing better than than a great coconut water, in one of the many kiosks, to complete de programme."), latitude: 0, longitude: 0, cover: "lagoaRodrigoDeFreitas", photo: "no photo", date: "")
    
    let botanicalGarden = Sticker(name: NSLocalizedString("BOTANICAL_GARDEN", comment: "Botanical Garden"), description: NSLocalizedString("BOTANICAL_GARDEN_DESCRIPTION", comment: "Founded in 1808 by D. João VI, the Botanical Garden is an important touristic side of the city and so much visited by researchers who study the hundreds species that are there. With total area of 137 hectares, being 54 of acreage, the Botanical Garden houses rare collections of bromeliads and orchids, as well as old trees and exotic plants. The Garden also has constructions in the beginning of the century XVI, saving a rich historical and cultural heritage. The Park also is an excellent place to observe the birds, because there are more than hundred different species in the crowns and trunks of their trees"), latitude: 0, longitude: 0, cover: "botanicalGarden", photo: "no photo", date: "")
    
    let tijucaForest = Sticker(name: NSLocalizedString("TIJUCA_FOREST", comment: "Tijuca Forest"), description: NSLocalizedString("TIJUCA_FOREST_DESCRIPTION", comment: "The Rio’s green heart. One of the largest urban forests in the world, was established in 1861 by Emperor Pedro II to reforest the area affected by deforestation caused by sugarcane and coffee cultivation. This sector of Tijuca National Park gather many attractives, such as the Pico da Tijuca, Pico do Papagaio and Cascatinha Taunay. This preserved area of Atlantic Forest is visited by Cariocas and tourists for the practice of sports, strolls and walking. Birds, native plants and fruitful trees compose the flora and the fauna of the Forest of the Tijuca."), latitude: 0, longitude: 0, cover: "tijucaForest", photo: "no photo", date: "")
    
    let arpoador = Sticker(name: NSLocalizedString("ARPOADOR", comment: "Arpoador"), description: NSLocalizedString("ARPOADOR_DESCRIPTION", comment: "One of the favorite beaches for residents and tourists for the beauty and the nice landscape and the practice of surfing, both in summer and winter. It has 800m of extension from the Copacabana Fort and Francisco Otavianostreet with Vieira Souto Avenue. The place name comes from the fact that it is possible, in the past, to whale stops near the cost. Do not forget to visit the Arpoador stones, the most beautiful place to enjoy the sea and the sunset!"), latitude: 0, longitude: 0, cover: "arpoador", photo: "no photo", date: "")
    
    let museumOfTomorrow = Sticker(name: NSLocalizedString("MUSEUM_OF_TOMORROW", comment: "Museum of Tomorrow"), description: NSLocalizedString("MUSEUM_OF_TOMORROW", comment: "Questions like “where did we come from?” and “where are we going?” pervade the thoughts of the world’s population and are common among all peoples. Reflecting on these questions, as well as others, the visionary project of the Museu do Amanhã(Museum of Tomorrow) took shape and became an ample space for debating and studying the impact of our actions and how we can alter the decaying scenario that draws close."), latitude: 0, longitude: 0, cover: "museumOfTomorrow", photo: "no photo", date: "")
    
    var stickerList: [Sticker] = []

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        let hasLaunchedKey = "HasLaunched"
        let defaults = NSUserDefaults.standardUserDefaults()
        let hasLaunched = defaults.boolForKey(hasLaunchedKey)
        
        if !hasLaunched {
            
            //Executed only on first run
            
            defaults.setBool(true, forKey: hasLaunchedKey)
            
            stickerList += [christTheRedeemer, sugarLoaf, copacabanaBeach, pucRio, lapaArches, saintTeresaTram, ruinsPark, selaronsSteps, municipalTheatre, imperialPalace, quintaDaBoaVista, lagoaRodrigoDeFreitas, botanicalGarden, tijucaForest]
            
            for sticker in stickerList {
                saveRioStickersInCoreData(sticker.name!, description: sticker.description!, latitude: sticker.latitude!, longitude: sticker.longitude, cover: sticker.cover!)
            }
            
        }
        
        return true
    }
    
    func saveRioStickersInCoreData(name: String, description: String, latitude: Double, longitude: Double, cover: String) {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let stickerEntity =  NSEntityDescription.entityForName("Sticker", inManagedObjectContext: managedContext)
        let newSticker = NSManagedObject(entity: stickerEntity!, insertIntoManagedObjectContext: managedContext)
        
        newSticker.setValue(name, forKey: "name")
        newSticker.setValue(description, forKey: "stickerDescription")
        newSticker.setValue(latitude, forKey: "latitude")
        newSticker.setValue(longitude, forKey: "longitude")
        newSticker.setValue(cover, forKey: "cover")
        
        do {
            try managedContext.save()
        }
            
        catch let error as NSError  {
            
            print("Could not save \(error), \(error.userInfo)")
            
        }
    }


    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        
        self.saveContext()
    }
    
    
    // MARK: - Core Data stack
    
    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "uk.co.plymouthsoftware.core_data" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1]
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("Rio2016", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("SingleViewCoreData.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }


}

