//@ pragma UseQApplication
import Quickshell

ShellRoot {
    id: shellRoot
    // Use to enable / disable modules
    property bool enableBar: true
    property bool enableCheatSheet: true
    property bool enableMediaControl: true
    property bool enableNotificationPopup: true
    property bool enableOnScreenDisplayBrightness: true
    property bool enableOnScreenDisplayVolume: true
    property bool enableOnScreenKeyboard: true
    property bool enableOverview: true
    property bool enableReloadPopup: true
    property bool enableScreenCorners: true
    property bool enableSession: true
    property bool enableSidebarLeft: true
    property bool enableSidebarRight: true
    property bool enableBottomPopup: true

    LazyLoader {
        active: shellRoot.enableBar
        component: Bar {}
    }

    LazyLoader {
        active: shellRoot.enableBottomPopup
        component: BottomPopup {}
    }
}
