import QtQuick 2.0
import org.kde.plasma.core 2.0 as PlasmaCore

PlasmaCore.IconItem {
    source: "exception"

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton

        onClicked: {
            plasmoid.expanded = !plasmoid.expanded;
        }
    }
}
