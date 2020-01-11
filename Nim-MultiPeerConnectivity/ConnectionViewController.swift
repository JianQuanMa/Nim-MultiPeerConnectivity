//
//  ConnectionViewController.swift
//  Nim-MultiPeerConnectivity
//
//  Created by Jian Ma on 1/9/20.
//  Copyright © 2020 Jian Ma. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class ConnectionViewController: UIViewController, MCBrowserViewControllerDelegate, MCSessionDelegate {
    

    var peerID = MCPeerID(displayName: UIDevice.current.name)
    var mcSession: MCSession!
    var mcAdvertiserAssistant: MCAdvertiserAssistant!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpAddValueStackView()
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showConnectionPrompt))
        
        mcSession = MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .optional)
        mcSession.delegate = self
        
    }
    
    //MARK: helper funcs
    func setUpAddValueStackView(){

    }
    
    @objc func showConnectionPrompt() {
        let ac = UIAlertController(title: "Connect to others", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Host a session", style: .default, handler: startHosting))
        ac.addAction(UIAlertAction(title: "Join a session", style: .default, handler: joinSession))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
    
    func startHosting(action: UIAlertAction) {
        mcAdvertiserAssistant = MCAdvertiserAssistant(serviceType: "nim-game", discoveryInfo: nil, session: mcSession)
        
        mcAdvertiserAssistant.start()
        
    }
    
    func joinSession(action: UIAlertAction) {
        
        let mcBrowser = MCBrowserViewController(serviceType: "nim-game", session: mcSession)
        mcBrowser.delegate = self
        present(mcBrowser, animated: true)
    }
    
    //MARK: extension implementation
    //MCBrowserViewControllerDelegate
    func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
        dismiss(animated: true)
    }
    
    func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
        dismiss(animated: true)
    }
    //MCSessionDelegate
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        
        if mcSession.connectedPeers.count == 2 {
            mcAdvertiserAssistant.stop()
        }else{
            mcAdvertiserAssistant.start()
        }
        
        switch state {
        case .connected:
            print("connected to \(peerID.displayName)")
        case .connecting:
            print("connecting to \(peerID.displayName)")
        case .notConnected:
            print("not connected to \(peerID.displayName)")
        @unknown default:
            print("unkowned state received: \(peerID.displayName)")
        }
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        print("hello")
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        
    }
    
    
    
    
}
