import QtQuick
import QtQuick.Layouts

Canvas {
    id: canvas
    // Define a custom property for the delimiter's color.
    property color foregroundColor: "#333333"
    onForegroundColorChanged: requestPaint()

    property color backgroundColor: "transparent"
    onBackgroundColorChanged: requestPaint()

    property color borderColor: "black"

    property real similarityThreshold: 1000000.0

    implicitWidth: 15
    Layout.preferredHeight: parent.height

    onPaint: {
        var ctx = getContext("2d");
        ctx.reset();

        if (canvas.foregroundColor == "#00000000") {
            ctx.fillStyle = canvas.backgroundColor;
            ctx.beginPath();
            ctx.moveTo(0, 0);
            ctx.lineTo(canvas.width, canvas.height / 2);
            ctx.lineTo(0, canvas.height);
            ctx.lineTo(canvas.width, canvas.height);
            ctx.lineTo(canvas.width, 0);
            ctx.closePath();
            ctx.fill();

            return;
        }

        ctx.fillStyle = canvas.backgroundColor;
        ctx.fillRect(0, 0, canvas.width, canvas.height);

        ctx.fillStyle = canvas.foregroundColor;

        // Draw triangle path
        ctx.beginPath();
        ctx.moveTo(0, 0);                       // Top-left corner
        ctx.lineTo(canvas.width, canvas.height / 2); // Middle-right point
        ctx.lineTo(0, canvas.height);           // Bottom-left corner
        ctx.closePath();
        ctx.fill();

        // if (areColorsSimilar(canvas.foregroundColor, canvas.backgroundColor)) {
        if (canvas.foregroundColor == canvas.backgroundColor) {
            // Draw only line
            ctx.strokeStyle = canvas.borderColor;
            ctx.lineWidth = 1;

            ctx.beginPath();
            ctx.moveTo(0, 0);
            ctx.lineTo(canvas.width, canvas.height / 2);
            ctx.lineTo(0, canvas.height);

            ctx.stroke();
        }
    }

    function areColorsSimilar(qmlColor1, qmlColor2) {
        // QML color components are 0.0-1.0, so we scale them to 0-255.
        var rgb1 = [qmlColor1.r * 255, qmlColor1.g * 255, qmlColor1.b * 255];
        var rgb2 = [qmlColor2.r * 255, qmlColor2.g * 255, qmlColor2.b * 255];

        var lab1 = rgb2lab(rgb1);
        var lab2 = rgb2lab(rgb2);

        var delta = deltaE(lab1, lab2);

        return delta < similarityThreshold;
    }

    function deltaE(labA, labB) {
        var deltaL = labA - labB;
        var deltaA = labA[1] - labB[1];
        var deltaB = labA[2] - labB[2];
        var c1 = Math.sqrt(labA[1] * labA[1] + labA[2] * labA[2]);
        var c2 = Math.sqrt(labB[1] * labB[1] + labB[2] * labB[2]);
        var deltaC = c1 - c2;
        var deltaH = deltaA * deltaA + deltaB * deltaB - deltaC * deltaC;
        deltaH = deltaH < 0 ? 0 : Math.sqrt(deltaH);
        var sc = 1.0 + 0.045 * c1;
        var sh = 1.0 + 0.015 * c1;
        var deltaLKlsl = deltaL / (1.0);
        var deltaCkcsc = deltaC / (sc);
        var deltaHkhsh = deltaH / (sh);
        var i = deltaLKlsl * deltaLKlsl + deltaCkcsc * deltaCkcsc + deltaHkhsh * deltaHkhsh;
        return i < 0 ? 0 : Math.sqrt(i);
    }

    function rgb2lab(rgb) {
        var r = rgb[0] / 255, g = rgb[1] / 255, b = rgb[2] / 255, x, y, z;
        r = (r > 0.04045) ? Math.pow((r + 0.055) / 1.055, 2.4) : r / 12.92;
        g = (g > 0.04045) ? Math.pow((g + 0.055) / 1.055, 2.4) : g / 12.92;
        b = (b > 0.04045) ? Math.pow((b + 0.055) / 1.055, 2.4) : b / 12.92;
        x = (r * 0.4124 + g * 0.3576 + b * 0.1805) / 0.95047;
        y = (r * 0.2126 + g * 0.7152 + b * 0.0722) / 1.00000;
        z = (r * 0.0193 + g * 0.1192 + b * 0.9505) / 1.08883;
        x = (x > 0.008856) ? Math.pow(x, 1 / 3) : (7.787 * x) + 16 / 116;
        y = (y > 0.008856) ? Math.pow(y, 1 / 3) : (7.787 * y) + 16 / 116;
        z = (z > 0.008856) ? Math.pow(z, 1 / 3) : (7.787 * z) + 16 / 116;
        return [(116 * y) - 16, 500 * (x - y), 200 * (y - z)];
    }
}
