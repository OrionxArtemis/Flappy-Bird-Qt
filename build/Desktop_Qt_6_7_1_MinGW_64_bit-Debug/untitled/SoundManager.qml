import QtQuick
import QtMultimedia

Item {
    id: soundManager

    property bool isMuted: false
    property MediaPlayer swooshingSound: swooshingSound
    property MediaPlayer dieSound: dieSound
    property MediaPlayer hitSound: hitSound

    MediaPlayer {
        id: swooshingSound

        source: "sound/sfx_swooshing.wav"
        audioOutput: AudioOutput {muted: soundManager.isMuted}
    }

    MediaPlayer {
        id: dieSound

        source: "sound/sfx_die.wav"
        audioOutput: AudioOutput {muted: soundManager.isMuted}
    }

    MediaPlayer {
        id: hitSound

        source: "sound/sfx_hit.wav"
        audioOutput: AudioOutput {muted: soundManager.isMuted}
    }
}
