//
//  StructSettings.swift
//  NotesMobileApp
//
//  Created by Mac User on 17/12/23.
//

import Foundation

enum Types {
    case none
    case configure
    case show
}

struct Settings {
    let images: String
    let  title: String
    let  type: Types
}


