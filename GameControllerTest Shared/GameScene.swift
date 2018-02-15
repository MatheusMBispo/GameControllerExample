//
//  GameScene.swift
//  GameControllerTest Shared
//
//  Created by Apple Developer Academy UCB on 08/02/18.
//  Copyright © 2018 Apple Developer Academy UCB. All rights reserved.
//

import SpriteKit
import GameController

class GameScene: SKScene {
    
    //MARK: - Properties
    
    private var controller: GCController?
    private var buttonLabel = SKLabelNode(text: "Bem-Vindo")
    
    //MARK: - Observers
    
    private var didConnectObserver: NSObjectProtocol!
    private var didDisconnectObserver: NSObjectProtocol!
    
    //MARK: - Initialiazers
    
    override init(size: CGSize) {
        super.init(size: size)
        
        didConnectObserver = NotificationCenter.default.addObserver(forName: NSNotification.Name.GCControllerDidConnect, object: nil, queue: .main) { (notification) in
            if GCController.controllers().count == 1 {
                self.configureController(true)
            }
        }
        
        didDisconnectObserver = NotificationCenter.default.addObserver(forName: NSNotification.Name.GCControllerDidDisconnect, object: nil, queue: .main) { (notification) in
            self.configureController(false)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Deinit
    
    deinit {
        
        NotificationCenter.default.removeObserver(self.didConnectObserver)
        NotificationCenter.default.removeObserver(self.didDisconnectObserver)
        
    }
    
    //MARK: - Scene Methods
    
    class func newGameScene() -> GameScene {
        
        let scene = GameScene(size: UIScreen.main.bounds.size)
        
        // Set the scale mode to scale to fit the window
        scene.scaleMode = .aspectFill
        
        return scene
    }

    override func didMove(to view: SKView) {
        
        self.backgroundColor = UIColor.blue
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        self.buttonLabel.fontColor = .black
        self.buttonLabel.position = .zero
        self.addChild(buttonLabel)
        
    }
    
    //MARK: - Controller Methods
    
    /**
     Método para configurar o(s) controle(s).
        - Parameters:
            - useController: Booleano para saber se o controle deve ser usado ou não.
    */
    public func configureController(_ useController: Bool) {
        
        if useController {
        
            guard let connectedController = GCController.controllers().first else { return }
            
            self.controller = connectedController
            
            configureInput()
            
            buttonLabel.text = "Controle conectado"
            
            self.backgroundColor = .green
            
        } else {
            
            buttonLabel.text = "Controle não conectado"
            
            self.backgroundColor = .red
            
        }
        
    }
    
    /// Método para configurar os inputs para cada tipo de controle suportado.
    private func configureInput() {
        
        guard let connectedController = GCController.controllers().last else { return }
        
        if let extendedGamepad = connectedController.extendedGamepad {
            configureDPadButtons(extendedGamepad)
            configureDiamondButtons(extendedGamepad)
            configureShoulderButtons(extendedGamepad)
            configureTriggers(extendedGamepad)
            return
        }
        
        if let gamepad = connectedController.gamepad {
            configureDPadButtons(gamepad)
            configureDiamondButtons(gamepad)
            configureShoulderButtons(gamepad)
            return
        }
        
        if let microGamepad = connectedController.microGamepad {
            configureDPadButtons(microGamepad)
            configureDiamondButtons(microGamepad)
            return
        }
        
    }
    
    //MARK: - GCGamepad
    
    /**
     Método para configurar os botões A,B,X e Y do(s) controle(s) do tipo GCGamepad.
        - Parameters:
            - gamepad: Gamepad para configuração dos botões.
     */
    private func configureDiamondButtons(_ gamepad: GCGamepad) {
        
        //Configuração do botão A
        gamepad.buttonA.pressedChangedHandler = {(button, value, pressed) in
            self.buttonLabel.text = "Gamepad - A"
        }
        
        //Configuração do botão B
        gamepad.buttonB.pressedChangedHandler = {(button, value, pressed) in
            self.buttonLabel.text = "Gamepad - B"
        }
        
        //Configuração do botão X
        gamepad.buttonX.pressedChangedHandler = {(button, value, pressed) in
            self.buttonLabel.text = "Gamepad - X"
        }
        
        //Configuração do botão Y
        gamepad.buttonY.pressedChangedHandler = {(button, value, pressed) in
            self.buttonLabel.text = "Gamepad - Y"
        }
        
    }
    
    /**
     Método para configurar os botões direcionais do(s) controle(s) do tipo GCGamepad.
        - Parameters:
            - gamepad: Gamepad para configuração dos botões.
     */
    private func configureDPadButtons(_ gamepad: GCGamepad) {
        
        //Configuracão do direcional para cima
        gamepad.dpad.up.pressedChangedHandler = {(button, value, pressed) in
            self.buttonLabel.text = "Gamepad - Up"
        }
        
        //Configuracão do direcional para baixo
        gamepad.dpad.down.pressedChangedHandler = {(button, value, pressed) in
            self.buttonLabel.text = "Gamepad - Down"
        }
        
        //Configuracão do direcional para a esquerda
        gamepad.dpad.left.pressedChangedHandler = {(button, value, pressed) in
            self.buttonLabel.text = "Gamepad - Left"
        }
        
        //Configuracão do direcional para a direita
        gamepad.dpad.right.pressedChangedHandler = {(button, value, pressed) in
            self.buttonLabel.text = "Gamepad - Right"
        }
        
    }
    
    /**
     Método para configurar os botões de shoulder(L1 e R1) do(s) controle(s) do tipo GCGamepad.
        - Parameters:
            - gamepad: Gamepad para configuração dos botões.
     */
    private func configureShoulderButtons(_ gamepad: GCGamepad) {
        
        //Configuracão do L1
        gamepad.leftShoulder.pressedChangedHandler = {(button, value, pressed) in
            self.buttonLabel.text = "Gamepad - Left Shoulder"
        }
        
        //Configuracão do R1
        gamepad.rightShoulder.pressedChangedHandler = {(button, value, pressed) in
            self.buttonLabel.text = "Gamepad - Right Shoulder"
        }
        
    }
    
    //MARK: - GCExtendedGamepad
    
    /**
     Método para configurar os botões A,B,X e Y do(s) controle(s) do tipo GCExtendedGamepad.
        - Parameters:
            - gamepad: Gamepad para configuração dos botões.
     */
    private func configureDiamondButtons(_ gamepad: GCExtendedGamepad) {
        
        //Configuração do botão A
        gamepad.buttonA.pressedChangedHandler = {(button, value, pressed) in
            self.buttonLabel.text = "ExtendedGamepad - A"
        }
        
        //Configuração do botão B
        gamepad.buttonB.pressedChangedHandler = {(button, value, pressed) in
            self.buttonLabel.text = "ExtendedGamepad - B"
        }
        
        //Configuração do botão X
        gamepad.buttonX.pressedChangedHandler = {(button, value, pressed) in
            self.buttonLabel.text = "ExtendedGamepad - X"
        }
        
        //Configuração do botão Y
        gamepad.buttonY.pressedChangedHandler = {(button, value, pressed) in
            self.buttonLabel.text = "ExtendedGamepad - Y"
        }
        
    }
    
    /**
     Método para configurar os botões direcionais controle(s) do tipo GCExtendedGamepad.
        - Parameters:
            - gamepad: Gamepad para configuração dos botões.
     */
    private func configureDPadButtons(_ gamepad: GCExtendedGamepad) {
        
        //Configuracão do direcional para cima
        gamepad.dpad.up.pressedChangedHandler = {(button, value, pressed) in
            self.buttonLabel.text = "ExtendedGamepad - Up"
        }
        
        //Configuracão do direcional para baixo
        gamepad.dpad.down.pressedChangedHandler = {(button, value, pressed) in
            self.buttonLabel.text = "ExtendedGamepad - Down"
        }
        
        //Configuracão do direcional para a esquerda
        gamepad.dpad.left.pressedChangedHandler = {(button, value, pressed) in
            self.buttonLabel.text = "ExtendedGamepad - Left"
        }
        
        //Configuracão do direcional para a direita
        gamepad.dpad.right.pressedChangedHandler = {(button, value, pressed) in
            self.buttonLabel.text = "ExtendedGamepad - Right"
        }
        
    }
    
    /**
     Método para configurar os botões de shoulder(L1 e R1) do(s) controle(s) do tipo GCExtendedGamepad.
        - Parameters:
            - gamepad: Gamepad para configuração dos botões.
     */
    private func configureShoulderButtons(_ gamepad: GCExtendedGamepad) {
        
        //Configuracão do L1
        gamepad.leftShoulder.pressedChangedHandler = {(button, value, pressed) in
            self.buttonLabel.text = "ExtendedGamepad - Left Shoulder"
        }
        
        //Configuracão do R1
        gamepad.rightShoulder.pressedChangedHandler = {(button, value, pressed) in
            self.buttonLabel.text = "ExtendedGamepad - Right Shoulder"
        }
        
    }
    
    /**
     Método para configurar os botões de trigger(L2 e R2) do(s) controle(s) do tipo GCExtendedGamepad.
        - Parameters:
            - gamepad: Gamepad para configuração dos botões.
     */
    private func configureTriggers(_ gamepad: GCExtendedGamepad) {
        
        //Configuracão do L2
        gamepad.leftTrigger.pressedChangedHandler = {(button, value, pressed) in
            self.buttonLabel.text = "ExtendedGamepad - Left Trigger"
        }
        
        //Configuracão do R2
        gamepad.rightTrigger.pressedChangedHandler = {(button, value, pressed) in
            self.buttonLabel.text = "ExtendedGamepad - Right Trigger"
        }
        
    }
    
    //MARK: - GCMicroGamepad
    
    /**
     Método para configurar os botões A e Y do(s) controle(s) do tipo GCMicroGamepad.
        - Parameters:
            - gamepad: Gamepad para configuração dos botões.
     */
    private func configureDiamondButtons(_ gamepad: GCMicroGamepad) {
        
        //Configuração do botão A
        gamepad.buttonA.pressedChangedHandler = {(button, value, pressed) in
            self.buttonLabel.text = "MicroGamepad - A"
        }

        //Configuração do botão X
        gamepad.buttonX.pressedChangedHandler = {(button, value, pressed) in
            self.buttonLabel.text = "MicroGamepad - X"
        }

        
    }
    
    /**
     Método para configurar os botões direcionais do(s) controle(s) do tipo GCMicroGamepad.
        - Parameters:
            - gamepad: Gamepad para configuração dos botões.
     */
    private func configureDPadButtons(_ gamepad: GCMicroGamepad) {
        
        //Configuracão do direcional para cima
        gamepad.dpad.up.pressedChangedHandler = {(button, value, pressed) in
            self.buttonLabel.text = "MicroGamepad - Up"
        }
        
        //Configuracão do direcional para baixo
        gamepad.dpad.down.pressedChangedHandler = {(button, value, pressed) in
            self.buttonLabel.text = "MicroGamepad - Down"
        }
        
        //Configuracão do direcional para a esquerda
        gamepad.dpad.left.pressedChangedHandler = {(button, value, pressed) in
            self.buttonLabel.text = "MicroGamepad - Left"
        }
        
        //Configuracão do direcional para a direita
        gamepad.dpad.right.pressedChangedHandler = {(button, value, pressed) in
            self.buttonLabel.text = "MicroGamepad - Right"
        }
        
    }
    
    //MARK: -
    
}


#if os(iOS) || os(tvOS)
// Touch-based event handling
extension GameScene {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if GCController.controllers().count != 0 {
            self.configureController(true)
        } else {
            self.configureController(false)
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {

    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {

    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {

    }
    
   
}
#endif


