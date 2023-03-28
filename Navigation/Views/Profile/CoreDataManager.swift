//
//  CoreDataManager.swift
//  Navigation
//
//  Created by Kiryl Rakk on 2/12/22.
//

import Foundation
import CoreData
import UIKit

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
        container.viewContext.automaticallyMergesChangesFromParent = true 
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
    
    func likePost(originalPost: AccountPosts) {
        persistentContainer.performBackgroundTask { backgroundContext in
            let post = PostData(context: backgroundContext)
            // сохраниение фото автра итж итп.
            post.authorLabel = originalPost.authorLabel
            post.profileImage = originalPost.authorImage?.pngData()
            post.statusLabel = originalPost.statusLabel
            post.date = originalPost.date
            post.postImage =  originalPost.image?.pngData()
            post.descriptionPost = originalPost.descriptionLabel
            post.likes = Int32(originalPost.likes)
            post.id = originalPost.id
            post.isLiked = true
            post.comments = Int32(originalPost.comments.count)
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
        print("post with name \(String(describing: post.authorLabel)) - \(post.likes) likes")
        persistentContainer.viewContext.delete(post)
        saveContext()
        reloadData()
        print("post was deleted")
        print("Numbers of posts in core data now : \(self.posts.count)")
       
    }
    
    func getFilteredPostsData (authorLabel: String? = nil) -> [PostData]? {
           let fetchRequest = PostData.fetchRequest()
           if let authorLabel, authorLabel.count > 0 {
               fetchRequest.predicate = NSPredicate(format: "descriptionPost contains[c] %@", authorLabel)
           }
           return (try? persistentContainer.viewContext.fetch(fetchRequest)) ?? []
       }
}
