# Game Controller

1. [O que é?](#introduction)
2. [Quais os controles suportados?](#controls)
4. [Tutorial Rápido](#tutorial)
5. [Exemplo](#exemplo)
6. [Fontes](#fontes)

Repositório desenvolvido por:
* Afonso Lucas
* Eduardo Torres
* Felipe Rodrigues
* Gabriel Messias
* João Vitor
* Matheus Bispo

Sobre a tutoria de Marcos Morais, na Apple Developer Academy UCB.

## O que é?<a name="introduction"></a>

É uma framework, desenvolvida pela Apple, cujo o objetivo é facilitar a implatação de controles (Joystick, Gamepad, etc) em aplicações(incluindo Games) feitos em swift ou objective-c.

## Controles Suportados <a name="controls"></a>

- **MicroGamepad**: 

<img src="http://christophersharpe.com/wp-content/uploads/2015/11/remote-and-interaction-remote-diagram_2x.png" width="400" height="200">

- **Gamepad**:

<img src="https://docs-assets.developer.apple.com/published/0ad54e429b/featuresHIDGameControllerStandardFormFittingSample_2x_8be6fc5b-c612-44c8-bfaa-5d90c27f3865.png" width="400" height="200">

- **ExtendedGamepad**:

<img src="https://docs-assets.developer.apple.com/published/f73ea162f0/featuresHIDGameControllerExtendedNonFormFittingSample_2x_d94fb0b8-6cfc-4095-bfdd-3403b15445bb.png" width="300" height="300">

## Tutorial Rápido <a name="tutorial"></a>

#### ⚠️ Importante!

Para o funcionamento da framework não se esqueça de importar:
```swift
import GameController
```

#### Configure os observers
É importante saber se os controles estão conectados no device, para conseguir essa informação em tempo de execução precisamos configurar observers.

```swift

        SUA_VARIAVEL_OBSERVER = NotificationCenter.default.addObserver(forName: NSNotification.Name.GCControllerDidConnect, object: nil, queue: .main) { (notification) in
            if GCController.controllers().count > 0 {
                CODIGO DE CONFIGURAÇÃO DO CONTROLE
            }
        }
        
        OUTRA_VARIAVEL_OBSERVER = NotificationCenter.default.addObserver(forName: NSNotification.Name.GCControllerDidDisconnect, object: nil, queue: .main) { (notification) in
            CODIGO DE SEGURANÇA CASO PERCA A CONEXÃO COM O CONTROLE
        }

```

#### Pegue os controles conectados

```swift
var controles = GCController.controllers()
```

#### Verificando tipo do controle

```swift
if let extendedGamepad = connectedController.extendedGamepad {..}
if let gamepad = connectedController.gamepad {..}
if let microGamepad = connectedController.microGamepad {..}
```

#### Configurando os Inputs

Para cada botão do controle é preciso configurar uma ação, para isso usamos um handler.

```swift
      gamepad.buttonA.pressedChangedHandler = {(button, value, pressed) in
          AÇÃO DO BOTÃO
      }
```

⚠️ IMPORTANTE: Os botões estão classificados de acordo com o tipo de controle, como mostrado nas imagens da seção de [controles suportados](#controls).

#### Não se esqueça de retirar os observers

É importante sempre remover os observers no fim de uma aplicação.
```swift
        NotificationCenter.default.removeObserver(SUA_VARIAVEL_OBSERVER)
        NotificationCenter.default.removeObserver(OUTRA_VARIAVEL_OBSERVER)
```

## Exemplo <a name="exemplo"></a>

Segue no repositório um exemplo de implatação de controles micro, standart e extended Gamepad, tanto no iOS quanto no tvOS.

## Fontes <a name="fontes"></a>


1. [Apple Game Controller Framework Reference](https://developer.apple.com/documentation/gamecontroller) — @ Apple Doc
2. [Sobre Game Controllers](https://developer.apple.com/library/content/documentation/ServicesDiscovery/Conceptual/GameControllerPG/Introduction/Introduction.html#//apple_ref/doc/uid/TP40013276) — @ Apple Doc
3. [Usando o GameController na AppleTV](https://www.bignerdranch.com/blog/tvos-games-part-1-using-the-game-controller-framework/)
4. [Controlling Game Input For AppleTV, WWDC 2016](https://developer.apple.com/videos/play/wwdc2016/607/)
5. [How to Support External Game Controllers with Swift 2 and Sprite Kit for the New Apple TV](https://cartoonsmart.com/how-to-support-external-game-controllers-with-swift-2-and-sprite-kit-for-the-new-apple-tv/)
6. [Designing for Game Controllers WWDC 2014](https://developer.apple.com/videos/play/wwdc2014/611/)
7. [iOS 7 Game Controller Tutorial, em Objective-C, Rey](https://www.raywenderlich.com/66532/ios-7-game-controller-tutorial)
8. [Integrating with Game Controllers, WWDC 2013](https://developer.apple.com/videos/play/wwdc2013/501/)
9. [GCMotion](https://developer.apple.com/documentation/gamecontroller/gcmotion)
