//
//  ContentView.swift
//  Study Buddy
//
//  Created by Journey Galore on 6/20/23.
//  Copyright © 2023 NexThings. All rights reserved.
//

import SwiftUI
import Combine

class UserSettings: ObservableObject {
    @Published var loggedIn : Bool = false
    @Published var navigateNowToLogIn: Bool = false
    @Published var navigateNowToSignup: Bool = false
}

struct StartView: View {
    @EnvironmentObject var settings: UserSettings
    
    var body: some View {
        if settings.loggedIn {
            return AnyView(TabbarView())
        }else {
            return AnyView(ContentView())
        }
    }
}

struct OnboardingModel {
    var id: Int
    var image: String
    var titleText: String
    var descriptionText: String
    var showButton: Bool?
}

struct ContentView: View {
    @EnvironmentObject var settings: UserSettings
    
    var onboardingDataArray: [OnboardingModel] = [
        OnboardingModel(id: 1, image: "sparkles.rectangle.stack", titleText: "Practice", descriptionText: "Explore study-enhancing tools powered by ChatGPT, including personalized tips, scheduling aids, peer reviews, bespoke study guides, real-world applications, and interactive flashcards."),
        OnboardingModel(id: 2, image: "message.circle", titleText: "Chat", descriptionText: "Engage with ChatGPT in the chat section to receive instant study assistance and clarify doubts on-the-go."),
        OnboardingModel(id: 3, image:"graduationcap", titleText: "Improve", descriptionText: "Leveraging ChatGPT, the app provides immediate topic clarifications, personalized study tools, and fosters consistent engagement, thereby enhancing test scores and cultivating effective study habits in students."),
        OnboardingModel(id: 4, image: "arrow.up.heart", titleText: "Thank You", descriptionText: "From the heart of its creator, thank you for choosing our app to guide your academic Journey. Wishing you unparalleled success in all your educational endeavors!", showButton: true)
    ]
    
    var body: some View {
    GeometryReader { geometry in
        NavigationView {
                ZStack {
                    
                    SwiftyUIScrollView(axis: .horizontal, numberOfPages: self.onboardingDataArray.count, pagingEnabled: true, pageControlEnabled: true, hideScrollIndicators: true, currentPageIndicator: .black, pageIndicatorTintColor: .gray) {
                                HStack(spacing: 0) {
                                    ForEach(self.onboardingDataArray, id: \.id) { item in
                                          OnboardingView(onboardingData: item)
                                                .frame(width: geometry.size.width, height: geometry.size.height)
                                       }
                                }
                            }.frame(width: geometry.size.width, height: geometry.size.height)
                }
            }
        }
    }
}

struct OnboardingView: View {
    var onboardingData: OnboardingModel
    @EnvironmentObject var settings: UserSettings
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 10) {
                Spacer()
                Image("\(self.onboardingData.image)")
                    .resizable()
                    .frame(width: 300, height: 300)
                    .aspectRatio(contentMode: ContentMode.fill)
                    .clipShape(Circle())
                    .padding(20)
                
                Text("\(self.onboardingData.titleText)")
                    .frame(width: geometry.size.width, height: 20, alignment: .center)
                    .font(.title)
                
                Text("\(self.onboardingData.descriptionText)")
                    .lineLimit(nil)
                    .padding(.leading, 15)
                    .padding(.trailing, 15)
                    .font(.system(size: 16))
                    .frame(width: geometry.size.width, height: 50, alignment: .center)
                    .multilineTextAlignment(.center)
                
//                Spacer(minLength: 20)
                Spacer()
                if self.onboardingData.showButton ?? false {
                    VStack {
                        Button(action: {
                           self.settings.navigateNowToLogIn = true
                        }) {
                               HStack {
                                   Text("Log In")
                               }.frame(width: geometry.size.width - 200, height: 40)
                               .foregroundColor(Color(.white))
                               .background(Color(UIColor.gray))
                               .cornerRadius(10)
                               .padding(.bottom, 5)
                           }
                        
                        Button(action: {
                                self.settings.navigateNowToSignup = true
                                }) {
                                HStack {
                                       Text("Sign Up")
                                }.frame(width: geometry.size.width - 200, height: 40)
                                  .foregroundColor(Color(.white))
                                  .background(Color(UIColor.gray))
                                  .cornerRadius(10)
                           }
                        
                    }.padding(.bottom, 30)
                }
                
                Spacer()
            }
        }
    }
}


#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
#endif
