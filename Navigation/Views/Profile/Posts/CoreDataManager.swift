//
//  CoreDataManager.swift
//  Navigation
//
//  Created by Kiryl Rakk on 2/12/22.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    init() {
        reloadData()
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
      
        let container = NSPersistentContainer(name: "PostCoreData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
               let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    var posts = [PostData]()
    
    //reload folder
    func reloadData() {
        let request = PostData.fetchRequest()
        let posts = (try? persistentContainer.viewContext.fetch(request)) ?? []
        self.posts = posts
    }
    
    //like post
    
    func likePost(originalPost: Post) {
        persistentContainer.performBackgroundTask { backgroundContext in
            let post = PostData(context: backgroundContext)
            post.authorLabel = originalPost.authorLabel
            post.image = originalPost.image
            post.views = Int32(originalPost.views)
            post.descriptionLabel = originalPost.descriptionLabel
            post.likes = Int32(originalPost.likes)
            post.isLiked = true
            do {
                try backgroundContext.save()
            } catch {
                print(error)
            }
            self.reloadData()
            print("post was added at index")
            print("Numbers of posts in core data now : \(self.posts.count)")
        }
    }
    
    func unlike (post: PostData) {
        persistentContainer.viewContext.delete(post)
        saveContext()
        reloadData()
        print("post was deleted at index")
        print("Numbers of posts in core data now : \(self.posts.count)")
       
    }
    
    func getFilteredPostsData (authorLabel: String? = nil) -> [PostData]? {
           let fetchRequest = PostData.fetchRequest()
           if let authorLabel, authorLabel.count > 0 {
               fetchRequest.predicate = NSPredicate(format: "authorLabel contains[c] %@", authorLabel)
           }
           return (try? persistentContainer.viewContext.fetch(fetchRequest)) ?? []
       }
}
