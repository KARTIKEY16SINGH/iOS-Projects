//
//  Manager.swift
//  ImageSearch
//
//  Created by Iron Man on 18/05/21.
//

import Foundation

class Manager {
    var curString = ""
    var flickerCache = Cache<String, FlickerPage>()
    var imageCache = Cache<Photo, Data>()
    var completionHandler : (() -> ())
    var curPage = 0
    
    init(handler : @escaping () -> ()) {
        completionHandler = handler
    }
    
    func searchedTextChanged(_ text : String) {
        guard text != "" else {
            executeCompletionHandler()
            return
        }
        if let data = flickerCache.get(text) {
            executeCompletionHandler()
        } else {
            NetworkUtility.getData(fromUrl: getPageURL(text), decodeType: FlickerPage.self) { [weak self] (response) in
                self?.flickerCache.add(text, value: response)
                self?.executeCompletionHandler()
            }
        }
        curString = text
        curPage = 1
    }
    
    private func executeCompletionHandler() {
        DispatchQueue.main.async {
            self.completionHandler()
        }
    }
    
    func getCount() -> Int {
        print("IN \(#function)")
        guard let data = flickerCache.get(curString), data.count > 0 else {
            return 0
        }
        var count = 0
        for pInd in 1...curPage {
            count += data[pInd-1].photos.photo.count
        }
        return count
    }
    
    func getImage(index : Int, completionHandler: @escaping (Data) -> ()) {
        print("IN GetImage")
        guard let data = flickerCache.get(curString), data.count > 0 else {return}
        var offsetPage = 0
        
        for page in data {
            if offsetPage + page.photos.photo.count <= index {
                offsetPage = offsetPage + page.photos.photo.count
            } else {
                if let img = imageCache.get(page.photos.photo[index - offsetPage]) {
                    DispatchQueue.main.async {
                        completionHandler(img.first!)
                    }
                } else {
                    print("[Network] Getting image for row = \(index)")
                    NetworkUtility.getImageData(fromURL: createImageURL(page.photos.photo[index - offsetPage])) { [weak self, offsetPage, index] (data) in
                        guard let _ = self else {return}
                        DispatchQueue.main.async {
                            completionHandler(data)
                        }
                        self!.imageCache.add(page.photos.photo[index - offsetPage], value: data)
                    }
                }
            }
        }
    }
    
    func fetchNextPage() {
        guard let data = flickerCache.get(curString) else {return}
        if data.count >= curPage + 1 {
            curPage += 1
            executeCompletionHandler()
        } else {
            NetworkUtility.getData(fromUrl: getPageURL(curString, page: curPage + 1), decodeType: FlickerPage.self) { [weak self, curString] (response) in
                guard let wSelf = self else {return}
                wSelf.flickerCache.add(curString, value: response)
                if wSelf.curString == curString {
                    wSelf.curPage = response.photos.page
                }
                wSelf.executeCompletionHandler()
            }
        }
    }
    
    private func createImageURL(_ photo : Photo) -> URL {
        let httpUrl = "https://farm\(photo.farm).static.flickr.com/\(photo.server)/\(photo.id)_\(photo.secret).jpg"
        return URL(string: httpUrl)!
    }
    
    private func getPageURL(_ text : String, page : Int = 1) -> URL {
        let httpUrl = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=3e7cc266ae2b0e0d78e279ce8e361736&%20format=json&nojsoncallback=1&safe_search=1&text=\(text)&page=\(page)"
        return URL(string: httpUrl)!
    }
}
