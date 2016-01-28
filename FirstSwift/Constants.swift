//
//  Constants.swift
//  ERESTemplate
//
//  Created by Rathish on 13/12/15.
//  Copyright © 2015 DubaiLandDept. All rights reserved.
//


import Foundation

// MARK: - URL's

let kBaseURL = NSURL(string: "http://www.example.com/")

// MARK: - Font Sizes

let DefaultFontSize: CGFloat = 12.0
let DefaultiPhoneFontSize: CGFloat = 12.0
let DefaultiPadFontSize: CGFloat = 16.0


// MARK: - Segue Identifiers

let SegueToMasterViewController = "SecondVC"
let SegueToDetailViewController = "DetailsVC"


// MARK: - Bool

enum isArabicEnum {
    case isTrue, isFalse
}

var isArabic = true

// MARK: - Enums

enum Emojis: Character {
    case Happy = "😄"
    case Sad = "😢"
}

/*
let happyEmoji = Constants.Emojis.Happy
println("Swift is fun! \(happyEmoji)") // Swift is fun! 😄
*/

// MARK: - ImageNames

let kHomeIconImage  = "home-icon"
let kSideMenuImage  = "menu-icon"
let kBackBtnAr      = "back-btn-ar"
let kBackBtnEn      = "back-btn-en"


// MARK: - Colors

//Theme Color

let kBaseColor      = "#00AFF0"
let kNavBarColor    = "#006393"
let kTextColor      = "#006393"
let kBorderColor    = "#00AFF0"

//NavigationBar

let kWhiteColor      = "#ffffff"
let kCellColor       = "#102592"
let kCountLabelColor = "#101A7D"
let kCountTextBlue   = "142B90"

//BackGround

let kBGColor        = "#FD752E"
let kBGColor1       = "#FD8D40"
let kBGColor2       = "#FD7C34"
let kBGColor3       = "#FD6926"


