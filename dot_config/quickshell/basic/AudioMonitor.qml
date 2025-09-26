pragma Singleton

import Quickshell
import Quickshell.Services.Pipewire
import QtQuick

Singleton {

    readonly property PwNode sink: Pipewire.defaultAudioSink

    readonly property PwNode source: Pipewire.defaultAudioSource

    readonly property bool sinkMuted: sink?.audio?.muted ?? true
    readonly property bool sourceMuted: source?.audio?.muted ?? true

    readonly property int sinkVolume: Math.round(internalSinkVolume * 100)
    readonly property int sourceVolume: Math.round(internalSourceVolume * 100)

    readonly property real internalSinkVolume: sink?.audio?.volume ?? 0
    readonly property real internalSourceVolume: source?.audio?.volume ?? 0

    readonly property bool ready: sink?.ready ?? false

    property color audioColor: (sinkMuted && sourceMuted) ? Colors.red : (sinkMuted || sourceMuted) ? Colors.yellow : Colors.green

    function setSinkVolume(volume: real): void {
        if (sink?.ready && sink?.audio) {
            sink.audio.muted = false;
            sink.audio.volume = volume;
        }
    }

    function setSourceVolume(volume: real): void {
        if (source?.ready && source?.audio) {
            source.audio.muted = false;
            source.audio.volume = volume;
        }
    }

    function switchSinkMute(): void {
        if (sink?.ready && sink?.audio) {
            sink.audio.muted = !sinkMuted;
            if (sink?.audio?.volume == undefined) {
                sink.audio.volume = 0;
            }
        }
    }

    function switchSourceMute(): void {
        if (source?.ready && source?.audio) {
            source.audio.muted = !sourceMuted;
            if (source?.audio?.volume == undefined) {
                source.audio.volume = 0;
            }
        }
    }

    PwObjectTracker {
        objects: [Pipewire.defaultAudioSink, Pipewire.defaultAudioSource]
    }
}
