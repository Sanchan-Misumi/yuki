//
//  File.swift
//  Yukitoru
//
//  Created by Maho Misumi on 2018/10/01.
//  Copyright © 2018年 Maho Misumi. All rights reserved.
//

import Foundation
import RealmSwift

final class RealmData: Object {
    
    @objc dynamic var wordListName = ""
    @objc dynamic var photoImageData = Data()
    @objc dynamic var title = ""
    
}
