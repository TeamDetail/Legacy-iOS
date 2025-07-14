import AVFoundation

public class SoundPlayer {
    public static let shared = SoundPlayer()
    private var player: AVAudioPlayer?
    
    private init() {}
    
    public func play(sound name: String) {
        guard let url = Bundle.module.url(forResource: name, withExtension: "mp3") else {
            print("❌ \(name).mp3 not found!")
            return
        }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.prepareToPlay()
            player?.numberOfLoops = -1
            player?.play()
        } catch {
            print("❌ Error: \(error)")
        }
    }
    
    public func mainSound() {
        play(sound: "mainbgm")
    }
    
    public func marketSound() {
        play(sound: "marketbgm")
    }
    
    public func loginSound() {
        play(sound: "loginbgm")
    }
}

