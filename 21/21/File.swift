//
//  File.swift
//  21
//
//  Created by Lika Nozadze on 11/10/23.
//


import UIKit

class DataManager {
    static let shared = DataManager()
    
    private var memoryCache = [String: Data]()
    private let diskCachePath = "/MyAppCache"
    
    private init() {
        setupCache()
    }
    
    private func setupCache() {
        if let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first {
            let diskCacheURL = cachesDirectory.appendingPathComponent(diskCachePath)
            do {
                try FileManager.default.createDirectory(at: diskCacheURL, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print("Error creating cache directory: \(error)")
            }
        }
    }
    
    func isDataCached(forURL url: URL) -> Bool {
        if memoryCache.keys.contains(url.absoluteString) {
            return true
        }
        
        if let diskCacheURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?.appendingPathComponent(diskCachePath),
           FileManager.default.fileExists(atPath: diskCacheURL.appendingPathComponent(url.lastPathComponent).path) {
            return true
        }
        
        return false
    }
    
    func fetchData(from url: URL, completion: @escaping (Data?) -> Void) {
        if let cachedData = memoryCache[url.absoluteString] {
            completion(cachedData)
            return
        }
        
        if let diskCacheURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?.appendingPathComponent(diskCachePath),
           let cachedData = try? Data(contentsOf: diskCacheURL.appendingPathComponent(url.lastPathComponent)) {
            memoryCache[url.absoluteString] = cachedData
            completion(cachedData)
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            self.memoryCache[url.absoluteString] = data
            
            if let diskCacheURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?.appendingPathComponent(self.diskCachePath) {
                do {
                    try data.write(to: diskCacheURL.appendingPathComponent(url.lastPathComponent))
                } catch {
                    print("Error caching data: \(error)")
                }
            }
            
            completion(data)
        }.resume()
    }
    
    func main() {
        let urlString = "https://api.themoviedb.org/3/movie/top_rated?language=en-US&page=1"
        
        if let url = URL(string: urlString) {
            if DataManager.shared.isDataCached(forURL: url) {
                print("Data is cached")
            } else {
                print("Data is not cached")
                
                }
            }
        }
        
    }

