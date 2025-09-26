pragma Singleton

import Quickshell
import QtQuick
import Quickshell.Services.UPower

Singleton {
    id: root

    readonly property real percentage: Math.round(UPower.displayDevice.percentage * 100)

    // This is 0 if charging
    readonly property real timeToEmpty: UPower.displayDevice.timeToEmpty

    // This will be 0 if discharging
    readonly property real timeToFull: UPower.displayDevice.timeToFull

    readonly property real changeRate: UPower.displayDevice.changeRate

    readonly property color batteryColor: getBatColor()

    function getBatColor() {
        if (changeRate == 0) {
            return Colors.green;
        } else if (percentage >= 50) {
            return Colors.blue;
        } else if (percentage >= 20) {
            return Colors.yellow;
        } else {
            return Colors.red;
            var profile = PowerProfiles.profile;
            if (profile != 0) {
                PowerProfiles.profile = 0;
                console.log(PowerProfiles.profile);
                console.log("Profile: " + PowerprofileMonitor.profile);
            }
        }
    }
}
