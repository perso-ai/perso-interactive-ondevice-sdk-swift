<picture>
  <source media="(prefers-color-scheme: dark)" srcset=".github/banner_dark.png" />
  <source media="(prefers-color-scheme: light)" srcset=".github/banner_light.png" />
  <img style="width:100%;" alt="Perso AI Banner" src=".github/banner_light.png" />
</picture>

<div align="center">

# Perso Interactive On-Device SDK for Swift

[![Swift](https://img.shields.io/badge/Swift-6.0+-orange?style=flat-square)](https://img.shields.io/badge/Swift-6.0+-Orange?style=flat-square)
[![Platforms](https://img.shields.io/badge/Platforms-iOS_18+_|_macOS_15+_|_visionOS_2+-Green?style=flat-square)](https://img.shields.io/badge/Platforms-iOS_18+_|_macOS_15+_|_visionOS-Green?style=flat-square)

<p align="center"> 📕 <a href="https://perso-ai.github.io/perso-interactive-ondevice-sdk-swift/">API Reference</a> &nbsp | &nbsp 💻 <a href="https://github.com/perso-ai/perso-interactive-ondevice-sample-swift">Sample Project</a>
</div>

<br>

**Perso Interactive On-Device SDK** enables you to create interactive AI conversations with photorealistic human avatars, featuring seamless AI Lip Sync powered by the on-device model. The SDK provides a flexible conversational AI pipeline (STT, LLM, TTS) that allows you to integrate your own custom models. This on-device approach ensures a private, seamless conversational AI experience with minimal latency.


<br/>

## Key Features

- **Realistic AI Human Avatars**: Natural expressions with AI Lip Sync
- **Conversational AI Pipeline**: Speech-to-Text, Large Language Model, and Text-to-Speech
- **Customization**: Integrate your own STT, LLM, and TTS models into the Conversational AI Pipeline
- **On-Device Processing**: Private, low-latency ML inference powered by Apple Neural Engine

<br/>

## Prerequisites

- iOS 18.0+ / macOS 15.0+ / visionOS 2.0+
- Swift 6.0+
- Xcode 16.0+

<br/>

## Installation

### Swift Package Manager

1. Open your Xcode project
2. Navigate to `File` > `Add Package Dependencies...`
3. Enter the following URL of this repository :
    ```
    https://github.com/perso-ai/perso-interactive-ondevice-sdk-swift
    ```
4. Choose the version range or specific version
5. Click `Add Package` to add `PersoInteractiveOnDeviceSDK` to your project

<br/>

Once this setup is complete, you can `import PersoInteractiveOnDeviceSDK` and start using the SDK in your Swift code.

<br/>

## Quick Look

```swift
import PersoInteractiveOnDeviceSDK

// 1. Initialize SDK
PersoInteractive.apiKey = "YOUR_API_KEY"
PersoInteractive.computeUnits = .ane

// 2. Load on-device models
try await PersoInteractive.load()
try await PersoInteractive.warmup()

// 3. Fetch and prepare model-style
let modelStyles = try await PersoInteractive.fetchAvailableModelStyles()
guard let modelStyle = modelStyles.first(where: { $0.availability == .available }) else {
    return
}

// Download model-style resources if needed
if case .unavailable = modelStyle.availability {
    let stream = PersoInteractive.loadModelStyle(with: modelStyle)
    for try await progress in stream {
        if case .progressing(let value) = progress {
            print("Downloading: \(Int(value.fractionCompleted * 100))%")
        }
    }
}

// 4. Configure audio session (iOS/visionOS only)
#if os(iOS) || os(visionOS)
try PersoInteractive.setAudioSession(
    category: .playAndRecord,
    options: [.defaultToSpeaker, .allowBluetooth]
)
#endif

// 5. Fetch features
let sttModels = try await PersoInteractive.fetchAvailableSTTModels()
let llmModels = try await PersoInteractive.fetchAvailableLLMModels()
let ttsModels = try await PersoInteractive.fetchAvailableTTSModels()
let prompts = try await PersoInteractive.fetchAvailablePrompts()

// 6. Create a session
let session = try await PersoInteractive.createSession(
    for: [
        .speechToText(type: sttModels.first!),
        .largeLanguageModel(llmType: llmModels.first!, promptID: prompts.first!.id),
        .textToSpeech(type: ttsModels.first!)
    ],
    modelStyle: modelStyle,
    statusHandler: { status in
        print("Session status: \(status)")
    }
)

// 7. Display AI Human
let videoView = PersoInteractiveVideoView(session: session)
videoView.videoContentMode = .aspectFit
try videoView.start()

// 8. Start conversation
let userMessage = UserMessage(content: "Hello!")
let stream = session.completeChat(message: userMessage)

for try await message in stream {
    if case .assistant(let assistantMessage, _) = message,
       let chunk = assistantMessage.chunks.last {
        try? videoView.push(text: chunk)
    }
}
```

<br/>

## Documentation

Start with the **[Getting Started](https://perso-ai.github.io/perso-interactive-ondevice-sdk-swift/)** guide, and explore other articles in the documentation as needed. Check out the **[Sample Project](https://github.com/perso-ai/perso-interactive-ondevice-sample-swift)** to see the Perso Interactive SDK in action.


<br/>

## License
Perso Interactive SDK for Swift is commercial software. [Contact our sales team](https://perso.ai/contact).