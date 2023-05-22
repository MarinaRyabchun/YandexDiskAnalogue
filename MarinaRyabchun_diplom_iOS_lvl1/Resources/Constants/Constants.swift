//
//  Constants.swift
//  MarinaRyabchun_diplom_iOS_lvl1
//
//  Created by Марина Рябчун on 30.12.2022.
//

import UIKit

enum Constants{
    enum Colors{
        static var white: UIColor?{
            UIColor(named: "White")
        }
        static var black: UIColor?{
            UIColor(named: "Black")
        }
        static var iconsAndOtherDetails: UIColor?{
            UIColor(named: "Icons&otherDetails")
        }
        static var accent1: UIColor?{
            UIColor(named: "Accent1")
        }
        static var accent2: UIColor?{
            UIColor(named: "Accent2")
        }
        static var red: UIColor?{
            UIColor(named: "Red")
        }
    }
    enum Fonts{
        static var header1: UIFont?{
            UIFont(name: "Graphik-Semibold", size: 26)
        }
        static var header2: UIFont?{
            UIFont(name: "Graphik-Medium", size: 17)
        }
        static var mainBody: UIFont?{
            UIFont(name: "Graphik-Regular", size: 15)
        }
        static var smallText: UIFont?{
            UIFont(name: "Graphik-Regular", size: 13)
        }
        static var buttonText: UIFont?{
            UIFont(name: "Graphik-Regular", size: 16)
        }
    }
    enum Image {
        static let startImage = "Vector"
        static let onboardingImage1 = "Group7"
        static let onboardingImage2 = "Group9"
        static let onboardingImage3 = "Group11"
        static let group21168 = "Group21168"
        static let image2 = "Изображение2"
        static let image1 = "Изображение"
        static let ellipse10 = "Ellipse10"
        static let ellipse10_2 = "Ellipse10-2"
        static let foalder = "Vector2"
        static let tabBarIconFile = "file"
        static var tabBarIconArchive = "archive"
        static var tabBarIconPerson = "person"
    }
    enum Text {
//        login
        static let loginButton = Bundle.main.localizedString(forKey: "LoginScene.Button.Login", value: "", table: "Localizable")
//        onboarding
        static let nextButton = Bundle.main.localizedString(forKey: "Onboarding.Button.Next", value: "", table: "Localizable")
        static let onboardingTitle1 = Bundle.main.localizedString(forKey: "Onboarding.Page1.Label", value: "", table: "Localizable")
        static let onboardingTitle2 = Bundle.main.localizedString(forKey: "Onboarding.Page2.Label", value: "", table: "Localizable")
        static let onboardingTitle3 = Bundle.main.localizedString(forKey: "Onboarding.Page3.Label", value: "", table: "Localizable")
//        errorAllert
        static let errorAllertTitle = Bundle.main.localizedString(forKey: "Error.Allert.Title", value: "", table: "Localizable")
        static let errorAllertSubtitle = Bundle.main.localizedString(forKey: "Error.Allert.Subtitle", value: "", table: "Localizable")
        static let errorAllertButton = Bundle.main.localizedString(forKey: "Error.Allert.Button", value: "", table: "Localizable")
    }
    
    enum TextLastFiles {
        static let navTitleLastFiles = Bundle.main.localizedString(forKey: "TabBar.LastFiles.NavigationItem.Title", value: "", table: "Localizable")
    }
    
    enum TextPreviewFile {
        static let previewAlertShareTitle = Bundle.main.localizedString(forKey: "Preview.Button.Alert.ShareImageTitle", value: "", table: "Localizable")
        static let previewAlertShareButtonFile = Bundle.main.localizedString(forKey: "Preview.Button.Alert.ButtonTextFile", value: "", table: "Localizable")
        static let previewAlertShareButtonLink = Bundle.main.localizedString(forKey: "Preview.Button.Alert.ButtonTextLink", value: "", table: "Localizable")
        static let previewAlertShareButtonCancel = Bundle.main.localizedString(forKey: "Preview.Button.Alert.ButtonTextCancel", value: "", table: "Localizable")
        
        static let previewFileNotBeOpened = Bundle.main.localizedString(forKey: "Preview.Label.TextLabel", value: "", table: "Localizable")

        static let previewAlertDeleteTitle = Bundle.main.localizedString(forKey: "Preview.Button2.Alert.DeleteImageTitle", value: "", table: "Localizable")
        static let previewAlertDeleteButtonOK = Bundle.main.localizedString(forKey: "Preview.Button2.Alert.ButtonTextDelete", value: "", table: "Localizable")
        static let previewAlertDeleteButtonNo = Bundle.main.localizedString(forKey: "Preview.Button2.Alert.ButtonTextCancel", value: "", table: "Localizable")

        static let previewEditTitle = Bundle.main.localizedString(forKey: "Preview.Edit.Title", value: "", table: "Localizable")
        static let previewEditButton = Bundle.main.localizedString(forKey: "Preview.Edit.Button", value: "", table: "Localizable")
        static let previewEditTextFieldPlaceholder = Bundle.main.localizedString(forKey: "Preview.Edit.TextField.Placeholder", value: "", table: "Localizable")

    }
    
    enum TextAllFiles {
        static let navTitleAllFiles = Bundle.main.localizedString(forKey: "TabBar.AllFiles.NavigationItem.Title", value: "", table: "Localizable")


        static let allFilesDirisEmpty = Bundle.main.localizedString(forKey: "TabBar.AllFiles.Dir.isEmpty", value: "Директория не содержит файлов", table: "Localizable")

    }
    
    enum TextProfile {
        static let navTitleProfile = Bundle.main.localizedString(forKey: "TabBar.Profile.NavigationItem.Title", value: "", table: "Localizable")
        static let profileLabelBusy = Bundle.main.localizedString(forKey: "TabBar.Profile.Label.Busy", value: "", table: "Localizable")
        static let profileLabelFree = Bundle.main.localizedString(forKey: "TabBar.Profile.Label.Free", value: "", table: "Localizable")
        static let profileLabelBt = Bundle.main.localizedString(forKey: "TabBar.Profile.Label.Bt", value: "", table: "Localizable")
        static let profileLabelKb = Bundle.main.localizedString(forKey: "TabBar.Profile.Label.Kb", value: "", table: "Localizable")
        static let profileLabelMb = Bundle.main.localizedString(forKey: "TabBar.Profile.Label.Mb", value: "", table: "Localizable")
        static let profileLabelGb = Bundle.main.localizedString(forKey: "TabBar.Profile.Label.Gb", value: "", table: "Localizable")
        static let profileButtonPublishedFiles = Bundle.main.localizedString(forKey: "TabBar.Profile.Button.PublishedFiles", value: "", table: "Localizable")
        static let profileAllert1Title = Bundle.main.localizedString(forKey: "TabBar.Profile.Allert1.Title", value: "", table: "Localizable")
        static let profileAllert1Button1 = Bundle.main.localizedString(forKey: "TabBar.Profile.Allert1.Button1", value: "", table: "Localizable")
        static let profileAllert1Button2 = Bundle.main.localizedString(forKey: "TabBar.Profile.Allert1.Button2", value: "", table: "Localizable")
        static let profileAllert2Title = Bundle.main.localizedString(forKey: "TabBar.Profile.Allert2.Title", value: "", table: "Localizable")
        static let profileAllert2Subtitle = Bundle.main.localizedString(forKey: "TabBar.Profile.Allert2.Subtitle", value: "", table: "Localizable")
        static let profileAllert2ButtonOk = Bundle.main.localizedString(forKey: "TabBar.Profile.Allert2.Button.Ok", value: "", table: "Localizable")
        static let profileAllert2ButtonNo = Bundle.main.localizedString(forKey: "TabBar.Profile.Allert2.Button.No", value: "", table: "Localizable")
    }
    
    enum TextPublishedFiles {
        static let navTitlePublishedFiles = Bundle.main.localizedString(forKey: "PublishedFiles.NavigationItem.Title", value: "", table: "Localizable")
        static let publishedFilesLabel = Bundle.main.localizedString(forKey: "PublishedFiles.Label", value: "", table: "Localizable")
        static let publishedFilesButton = Bundle.main.localizedString(forKey: "PublishedFiles.Button", value: "", table: "Localizable")
        static let publishedFilesAllertTitle = Bundle.main.localizedString(forKey: "PublishedFiles.Allert.Title", value: "", table: "Localizable")
        static let publishedFilesAllertCancel = Bundle.main.localizedString(forKey: "PublishedFiles.Allert.Cancel", value: "", table: "Localizable")
    }
    

    
}

