import QtQuick 2.0
import QtQuick.Layouts 1.1
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 3.0 as PlasmaComponents3

RowLayout {
    property alias iconSource: iconItem.source
    property alias text: label.text

    spacing: 2 * units.smallSpacing

    PlasmaCore.IconItem {
        id: iconItem

        Layout.preferredWidth: units.iconSizes.smallMedium
        Layout.preferredHeight: Layout.preferredWidth
        visible: valid
    }

    PlasmaComponents3.Label {
        id: label

        Layout.fillWidth: true
        wrapMode: Text.WordWrap
        elide: Text.ElideRight
        maximumLineCount: 4
    }
}
