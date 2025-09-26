pragma Singleton

import Quickshell
import QtQuick
import Quickshell.Services.UPower

Singleton {
    id: root
    property string profile: PowerProfiles.profile

    property color profileColor: Colors.sapphire

    property bool switchProfile: false

    onSwitchProfileChanged: {
        if (!switchProfile) {
            return;
        }
        if (profile == 1) {
            PowerProfiles.profile = 2;
            profileColor = Colors.rosewater;
        } else if (profile == 2) {
            PowerProfiles.profile = 0;
            profileColor = Colors.green;
        } else {
            PowerProfiles.profile = 1;
            profileColor = Colors.sapphire;
        }
        switchProfile = false;
    }
}
