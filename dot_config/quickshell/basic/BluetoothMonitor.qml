pragma Singleton

import Quickshell
import Quickshell.Bluetooth
import QtQuick

Singleton {
    readonly property BluetoothAdapter adapter: Bluetooth.defaultAdapter
    // readonly property BluetoothAdapterState state: adapter.state
    property color bluetoothColor: adapter.enabled ? Colors.lavender : Colors.rosewater

    function switchEnable(): void {
        adapter.enabled = !adapter.enabled;
    }
}
