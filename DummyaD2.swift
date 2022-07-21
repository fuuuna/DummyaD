//
//  Trickphoto2.swift
//  dummy
//
//  Created by f m on 2022/06/08.
//

import Foundation
import ARKit
import AVFoundation

class TrickPhoto2 {
    var player2: AVPlayer!
    
    
    init(movieName: String, node: SCNNode, for anchor: ARAnchor) {
        guard let imageAnchor = anchor as? ARImageAnchor,
            let fileUrlString = Bundle.main.path(forResource: "poster_2", ofType: "mp4") else {
                return
        }
        let videoItem = AVPlayerItem(url: URL(fileURLWithPath: fileUrlString))
        player2 = AVPlayer(playerItem: videoItem)
        
//        //ループ再生
//        player.actionAtItemEnd = AVPlayer.ActionAtItemEnd.none;
//        NotificationCenter.default.addObserver(self,selector:#selector(didPlayToEnd),
//            name:NSNotification.Name("AVPlayerItemDidPlayToEndTimeNotification"),
//                                                            object: player.currentItem)

        let size = CGSize(width: 1080, height: 1350)
        let videoScene = SKScene(size: size)

        let videoNode = SKVideoNode(avPlayer: player2)
        videoNode.position = CGPoint(x: size.width / 2, y: size.height / 2)
        videoNode.yScale = -1.0

        videoScene.addChild(videoNode)

        let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width,
                                height: imageAnchor.referenceImage.physicalSize.height)
        plane.firstMaterial?.diffuse.contents = videoScene
        let planeNode = SCNNode(geometry: plane)
        planeNode.eulerAngles.x = -Float.pi / 2
        node.addChildNode(planeNode)
    }
    
//    //ループ再生
//    @objc func didPlayToEnd(notification: NSNotification) {
//        let item: AVPlayerItem = notification.object as! AVPlayerItem
//        item.seek(to: CMTime.zero, completionHandler: nil)
//    }
//
    func start() {
        player2.play()
    }
    
    func stop() {
        player2.pause()
    }
}
