//
//  StorageManager.swift
//  Instagram
//
//  Created by grace kim  on 2022/07/27.
//

import FirebaseStorage

public class StorageManager{
    
    static let shared = StorageManager()
    
    private let bucket = Storage.storage().reference()
    
    
    //lets the user upload and download
    public func uploadUserPhotoPost(model: UserPost, completion: @escaping ((Result<URL, Error>) -> Void)){
        
    }
    
    
    public enum IGStorageManager: Error {
        case failedToDownload
    }
    
    
    public func downloadImage(with reference: String, completion: @escaping (Result<URL, Error>) -> Void){
        bucket.child(reference).downloadURL(completion: { url, error in
            guard let url = url, error == nil else{
                completion(.failure(IGStorageManager.failedToDownload))
                return
            }
            completion(.success(url))
        })
    }
    
}


public enum UserPostType {
    case photo, video
}

public struct UserPost {
    let postType: UserPostType}

