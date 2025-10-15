pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root

    // Public API
    readonly property int usagePercent: Math.round(usage * 100)
    property real usage: 0
    property string cpuDetail: ""
    property color cpuColor: (usagePercent > 70) ? Colors.peach : Colors.teal

    // This property is the main control for the detailed view.
    // The UI (e.g., a popup) should set this to true when visible.
    property bool detailedViewActive: false

    onDetailedViewActiveChanged: {
        if (detailedViewActive) {
            // Trigger an immediate read when the view becomes active,
            // the timer will handle subsequent updates.
            coreCpuProcess.running = true;
        } else
        // Clear details when the view is hidden
        // cpuDetail = "";
        // lastCoreStats = {};
        {}
    }

    // Internal State
    property real lastTotal: 0
    property real lastIdle: 0
    property var lastCoreStats: ({})

    Component.onCompleted: {
        // Initial run for the main widget display
        aggregateCpuProcess.running = true;
    }

    // Process for Aggregate CPU Usage (for the main widget)
    Process {
        id: aggregateCpuProcess
        command: ["sh", "-c", "head -n 1 /proc/stat"]

        stdout: StdioCollector {
            onStreamFinished: {
                var line = this.text;
                if (!line.startsWith("cpu "))
                    return;

                var fields = line.substring(5).trim().split(/\s+/);
                var total = 0;
                for (var i = 0; i < fields.length; i++) {
                    total += parseFloat(fields[i]) || 0;
                }
                var idle = parseFloat(fields[3]) || 0;

                if (root.lastTotal > 0) {
                    // Avoid usage spike on first run
                    var totalDiff = total - root.lastTotal;
                    var idleDiff = idle - root.lastIdle;

                    if (totalDiff > 0) {
                        // Correctly calculate usage, not idle percentage
                        root.usage = Math.max(0, 1.0 - (idleDiff / totalDiff));
                    }
                }

                root.lastTotal = total;
                root.lastIdle = idle;
            }
        }
    }

    // Timer for the aggregate process (slower, for the always-on widget)
    Timer {
        interval: 5000
        repeat: true
        running: true
        onTriggered: aggregateCpuProcess.running = true
    }

    // Process for Per-Core CPU Usage
    Process {
        id: coreCpuProcess
        command: ["sh", "-c", "bat /proc/stat"]

        stdout: StdioCollector {
            onStreamFinished: {
                var lines = this.text.split("\n");
                if (lines.length < 2)
                    return;

                var newCoreStats = {};
                var detailLines = [];

                for (var i = 1; i < lines.length; i++) {
                    var line = lines[i];
                    if (line.match(/^cpu\d+/)) {
                        var parts = line.trim().split(/\s+/);
                        var coreId = parts[0];
                        var fields = parts.slice(1);

                        var total = 0;
                        for (var j = 0; j < fields.length; j++) {
                            total += parseFloat(fields[j]) || 0;
                        }
                        var idle = parseFloat(fields[3]) || 0;

                        if (root.lastCoreStats[coreId]) {
                            var lastCoreStat = root.lastCoreStats[coreId];
                            var coreTotalDiff = total - lastCoreStat.total;
                            var coreIdleDiff = idle - lastCoreStat.idle;

                            if (coreTotalDiff > 0) {
                                var coreUsage = Math.max(0, 1.0 - (coreIdleDiff / coreTotalDiff));
                                var coreUsagePercent = Math.round(coreUsage * 100);
                                detailLines.push(coreId + ": " + coreUsagePercent + "%");
                            }
                        }
                        newCoreStats[coreId] = {
                            total: total,
                            idle: idle
                        };
                    }
                }

                root.lastCoreStats = newCoreStats;
                root.cpuDetail = detailLines.join("\n");
            }
        }
    }

    // Timer for the per-core process (faster, but only runs when popup is active)
    Timer {
        interval: 1000 // Faster update rate for detailed view
        repeat: true
        running: root.detailedViewActive
        onTriggered: {
            if (!coreCpuProcess.running) {
                coreCpuProcess.running = true;
                console.log("Started timer!");
            }
        }
    }
}
