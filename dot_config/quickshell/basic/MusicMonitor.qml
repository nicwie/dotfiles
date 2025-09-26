pragma Singleton

import Quickshell
import Quickshell.Services.Mpris

Singleton {
    id: root
    readonly property list<MprisPlayer> list: Mpris.players.values
    readonly property MprisPlayer active: manualActive ?? list.find(p => p.identity === "Spotify") ?? list[0] ?? null
    property MprisPlayer manualActive

    readonly property string title: active ? active.trackTitle || "Unknown Title" : "Unknown Title"

    readonly property string artist: active ? active.trackArtist || "Unknown Artist" : "Unknown Artist"

    readonly property real trackProgress: (active && (active.position != 0)) ? active.position / active.length : 0

    // FrameAnimation {
    //     // only emit the signal when the position is actually changing.
    //     running: player.playbackState == MprisPlaybackState.Playing
    //     // emit the positionChanged signal every frame.
    //     onTriggered: player.positionChanged()
    // }

    // function getActive(prop: string): string {
    //     const active = root.active;
    //     return active ? active[prop] ?? "Invalid property" : "No active player";
    // }

    // function list(): string {
    //     return root.list.map(p => p.identity).join("\n");
    // }

    function play(): void {
        const active = root.active;
        if (active?.canPlay)
            active.play();
    }

    function pause(): void {
        const active = root.active;
        if (active?.canPause)
            active.pause();
    }

    function playPause(): void {
        const active = root.active;
        if (active?.canTogglePlaying)
            active.togglePlaying();
    }

    function previous(): void {
        const active = root.active;
        if (active?.canGoPrevious)
            active.previous();
    }

    function next(): void {
        const active = root.active;
        if (active?.canGoNext)
            active.next();
    }

    function stop(): void {
        root.active?.stop();
    }
}
