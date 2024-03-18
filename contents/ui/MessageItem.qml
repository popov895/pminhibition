import QtQuick
import QtQuick.Layouts
import org.kde.plasma.components as PlasmaComponents3
import org.kde.kirigami as Kirigami

RowLayout {
    property alias iconSource: iconItem.source
    property alias text: label.text

    spacing: 2 * Kirigami.Units.smallSpacing

    Kirigami.Icon {
        id: iconItem

        Layout.preferredWidth: Kirigami.Units.iconSizes.smallMedium
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
