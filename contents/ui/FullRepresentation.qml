import QtQuick 2.0
import QtQuick.Layouts 1.1
import org.kde.plasma.components 3.0 as PlasmaComponents3
import org.kde.plasma.extras 2.0 as PlasmaExtras

PlasmaComponents3.Page {
    Layout.minimumHeight: units.gridUnit * 14
    Layout.minimumWidth: units.gridUnit * 14
    Layout.preferredHeight: Layout.minimumHeight * 1.5
    Layout.preferredWidth: Layout.minimumWidth * 1.5

    PlasmaExtras.PlaceholderMessage {
        anchors.centerIn: parent
        width: parent.width - 4 * units.largeSpacing
        text: i18n("No messages")
        visible: !contentView.visible
    }

    PlasmaExtras.ScrollArea {
        id: contentView

        anchors.fill: parent
        visible: repeater.count > 0

        ColumnLayout {
            spacing: units.smallSpacing
            width: contentView.viewport.width

            Repeater {
                id: repeater

                model: messageList

                MessageDelegate {
                    Layout.fillWidth: true
                    Layout.leftMargin: units.smallSpacing
                    Layout.rightMargin: Layout.leftMargin
                    messageData: modelData
                    showSeparator: index < repeater.count - 1
                }
            }
        }
    }
}
