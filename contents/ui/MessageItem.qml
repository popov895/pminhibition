import QtQuick 2.15
import QtQuick.Layouts 1.1
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 3.0 as PlasmaComponents3

RowLayout {
    property alias iconSource: iconItem.source
    property alias text: label.text

    spacing: 2 * PlasmaCore.Units.smallSpacing

    PlasmaCore.IconItem {
        id: iconItem

        Layout.preferredWidth: PlasmaCore.Units.iconSizes.smallMedium
        Layout.preferredHeight: Layout.preferredWidth
        Layout.alignment: label.lineCount > 1 ? Qt.AlignTop : Qt.AlignVCenter
        Layout.topMargin: label.lineCount > 1 ? Math.max(0, (labelTextMetrics.height - Layout.preferredHeight) / 2) : 0
        visible: valid
    }

    PlasmaComponents3.Label {
        id: label

        Layout.fillWidth: true
        Layout.topMargin: lineCount > 1 ? Math.max(0, (iconItem.Layout.preferredHeight - labelTextMetrics.height) / 2) : 0
        wrapMode: Text.WordWrap
        elide: Text.ElideRight
        maximumLineCount: 4

        TextMetrics {
            id: labelTextMetrics
            font: label.font
            text: label.text
        }
    }
}
