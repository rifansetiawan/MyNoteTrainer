//
//  ContentView.swift
//  Music Player
//
//  Created by Kavsoft on 08/02/20.
//  Copyright © 2020 Kavsoft. All rights reserved.
//

import SwiftUI
import AVKit



struct MusicalNoteLearnView : View {
    
    @State var data : Data = .init(count: 0)
    @State var title = ""
    @State var player : AVAudioPlayer!
    @State var playing = false
    @State var width : CGFloat = 0
    @State var songs = ["half-not"]
    @State var current = 0
    @State var finish = false
    @State var del = AVdelegate()
    @State var signifierchangeimage = false
    @State var currentColor1 = Color.black.opacity(0.08)
    var colorCircle1: [Color] = [Color("blue-1")]
    @State var currentColor2 = Color.black.opacity(0.08)
    var colorCircle2: [Color] = [Color("blue-1")]
    @State var currentColor3 = Color.black.opacity(0.08)
    var colorCircle3: [Color] = [Color("yellow-1")]
    @State var currentColor4 = Color.black.opacity(0.08)
    var colorCircle4: [Color] = [Color("yellow-1")]
    @State var currentColor5 = Color.black.opacity(0.08)
    var colorCircle5: [Color] = [Color("blue-1")]
    @State var currentColor6 = Color.black.opacity(0.08)
    var colorCircle6: [Color] = [Color("blue-1")]
    @State var currentColor7 = Color.black.opacity(0.08)
    var colorCircle7: [Color] = [Color("yellow-1")]
    @State var currentColor8 = Color.black.opacity(0.08)
    var colorCircle8: [Color] = [Color("yellow-1")]

    
    var body : some View{
        
       
        
        ZStack{
            Text("Half Note")
            .font(.system(size: 20, weight: .semibold))
        }.padding(.bottom, 10)
        VStack(spacing: 20){
            
            Image(uiImage: self.data.count == 0 ? UIImage(named: self.signifierchangeimage == true ? "half-note-2" : "half-note-1")! : UIImage(data: self.data)!)
            .resizable()
            .frame(width: self.data.count == 0 ? 250 : nil, height: 250)
            .cornerRadius(15)
            
            HStack(spacing: 1){
                Rectangle().fill(currentColor1).frame(width: 45, height: 100)
                Rectangle().fill(currentColor2).frame(width: 45, height: 100)
                Rectangle().fill(currentColor3).frame(width: 45, height: 100)
                Rectangle().fill(currentColor4).frame(width: 45, height: 100)
                Rectangle().fill(currentColor5).frame(width: 45, height: 100)
                Rectangle().fill(currentColor6).frame(width: 45, height: 100)
                Rectangle().fill(currentColor7).frame(width: 45, height: 100)
                Rectangle().fill(currentColor8).frame(width: 45, height: 100)
            }
            

            
            ZStack(alignment: .leading) {
            
                Capsule().fill(Color.black.opacity(0.08)).frame(height: 8)
                
                Capsule().fill(Color.purple).frame(width: self.width, height: 8)
                .gesture(DragGesture()
                    .onChanged({ (value) in
                        
                        let x = value.location.x
                        
                        self.width = x
                        
                    }).onEnded({ (value) in
                        
                        let x = value.location.x
                        
                        let screen = UIScreen.main.bounds.width - 30
                        
                        let percent = x / screen
                        
                        self.player.currentTime = Double(percent) * self.player.duration
                    }))
            }
            .padding(.top)
            
            HStack(spacing: UIScreen.main.bounds.width / 5 - 30){
                
                Button(action: {
                    
                    if self.current > 0{
                        
                        self.current -= 1
                        
                        self.ChangeSongs()
                    }
                    
                }) {
            
                    Image("back").font(.title)
                    
                }
                

                
                    Button(action: {
                        
                        if self.player.isPlaying{
                            
                            self.player.pause()
                            self.playing = false

                        }
                        else{
                            
                            if self.finish{
                                
                                self.player.currentTime = 0
                                self.width = 0
                                self.finish = false
                                
                            }
                            
                            self.player.play()
                            self.playing = true
                            
                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()) {
                                self.currentColor1 = self.colorCircle1.randomElement()!
                            }
                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                                self.currentColor2 = self.colorCircle2.randomElement()!
                            }
                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                                self.currentColor3 = self.colorCircle3.randomElement()!
                                self.signifierchangeimage = true
                            }
                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2.9) {
                                self.currentColor4 = self.colorCircle4.randomElement()!
                            }
                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3.8) {
                                self.currentColor5 = self.colorCircle5.randomElement()!
                                self.signifierchangeimage = false
                            }
                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 4.75) {
                                self.currentColor6 = self.colorCircle6.randomElement()!
                            }
                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5.72) {
                                self.currentColor7 = self.colorCircle7.randomElement()!
                                self.signifierchangeimage = true
                            }
                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 6.7) {
                                self.currentColor8 = self.colorCircle8.randomElement()!
                            }
                        }
                        
                    }) {
                
                        Image(self.playing && !self.finish ? "pause" : "play").font(.title)
                        
                    }
                
                    
                
                    Button(action: {
                        
                        if self.songs.count - 1 != self.current{
                            
                            self.current += 1
                            
                            self.ChangeSongs()
                            self.changeImages()
                        }
                        
                    }) {
                
                        Image("next").font(.title)
                        
                    }
                
            }.padding(.top,25)
            .foregroundColor(.black)
            
        }.padding()
        .onAppear {
            
            let url = Bundle.main.path(forResource: self.songs[self.current], ofType: "mp3")
            
            self.player = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: url!))
            
            self.player.delegate = self.del
            
            self.player.prepareToPlay()
            self.getData()
            
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (_) in
                
                if self.player.isPlaying{
                    
                    let screen = UIScreen.main.bounds.width - 30
                    
                    let value = self.player.currentTime / self.player.duration
                    
                    self.width = screen * CGFloat(value)
                    
                    
                }
                else {
                    self.currentColor1 = Color.black.opacity(0.08)
                    self.currentColor2 = Color.black.opacity(0.08)
                    self.currentColor3 = Color.black.opacity(0.08)
                    self.currentColor4 = Color.black.opacity(0.08)
                    self.currentColor5 = Color.black.opacity(0.08)
                    self.currentColor6 = Color.black.opacity(0.08)
                    self.currentColor7 = Color.black.opacity(0.08)
                    self.currentColor8 = Color.black.opacity(0.08)
                }
            }
            
            NotificationCenter.default.addObserver(forName: NSNotification.Name("Finish"), object: nil, queue: .main) { (_) in
                
                self.finish = true
            }
        }
    }
    
    func changeImages()-> String{
        var returrrn = "musical-note-1"
        if self.songs[self.current] == "half-not" {
            returrrn = "half-note-1"
        }
        return returrrn
    }
    
    
    func getData(){
        
        
        let asset = AVAsset(url: self.player.url!)
        
        for i in asset.commonMetadata{
            
            if i.commonKey?.rawValue == "artwork"{
                
                let data = i.value as! Data
                self.data = data
            }
            
            if i.commonKey?.rawValue == "title"{
                
                let title = i.value as! String
                self.title = title
            }
        }
    }
    
    func ChangeSongs(){
        
        let url = Bundle.main.path(forResource: self.songs[self.current], ofType: "mp3")
        
        self.player = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: url!))
        
        self.player.delegate = self.del
        
        self.data = .init(count: 0)
        
        self.title = ""
        
        self.player.prepareToPlay()
        self.getData()
        
        self.playing = true
        
        self.finish = false
        
        self.width = 0
        
        self.player.play()
        

    }
    
   
}

class AVdelegate : NSObject,AVAudioPlayerDelegate{
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        
        NotificationCenter.default.post(name: NSNotification.Name("Finish"), object: nil)
    }
}
