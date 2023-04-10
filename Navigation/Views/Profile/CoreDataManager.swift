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
    
    //Обновление данных
    func reloadData() {
        let request = PostData.fetchRequest()
        let posts = (try? persistentContainer.viewContext.fetch(request)) ?? []
        self.posts = posts
    }
    
    //В избранное пост
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
    
    // отмена в избранное
    func unlike (post: PostData) {
        print("post with name \(String(describing: post.authorLabel)) - \(post.likes) likes")
        persistentContainer.viewContext.delete(post)
        saveContext()
        reloadData()
        print("post was deleted")
        print("Numbers of posts in core data now : \(self.posts.count)")
       
    }
    
    // фильтр
    func getFilteredPostsData (description: String? = nil) -> [PostData]? {
           let fetchRequest = PostData.fetchRequest()
           if let description, description.count > 0 {
               fetchRequest.predicate = NSPredicate(format: "descriptionPost contains[c] %@", description)
           }
           return (try? persistentContainer.viewContext.fetch(fetchRequest)) ?? []
       }
    
    
    // сохрание постов перед поиском по предикату
    func savePosts(post: AccountPosts) {
        persistentContainer.performBackgroundTask { backgroundContext in
            let postCore = PostData(context: backgroundContext)
            postCore.isLiked = post.isLiked
            postCore.profileImage = post.authorImage?.pngData()
            postCore.authorLabel = post.authorLabel
            postCore.statusLabel = post.statusLabel
            postCore.comments = post.views
            postCore.likes = post.likes
            postCore.descriptionPost = post.descriptionLabel
            postCore.date = post.date
            postCore.id = post.id
        }
    }
}
