import QtQuick 2.0
import QtQuick.Layouts 1.1
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 3.0 as PlasmaComponents3
import org.kde.plasma.extras 2.0 as PlasmaExtras

PlasmaComponents3.Page {
    Layout.minimumHeight: PlasmaCore.Units.gridUnit * 14
    Layout.minimumWidth: PlasmaCore.Units.gridUnit * 14
    Layout.preferredHeight: Layout.minimumHeight * 1.5
    Layout.preferredWidth: Layout.minimumWidth * 1.5

    PlasmaExtras.PlaceholderMessage {
        anchors.centerIn: parent
        width: parent.width - 4 * PlasmaCore.Units.largeSpacing
        iconName: "checkmark"
        text: i18n("No messages")
        visible: !contentView.visible
    }

    PlasmaComponents3.ScrollView {
        id: contentView

        anchors.fill: parent
        visible: messageList.length > 0

        contentItem: ListView {
            spacing: PlasmaCore.Units.smallSpacing
            model: messageList

            delegate: MessageDelegate {
                x: PlasmaCore.Units.smallSpacing
                width: ListView.view.width - 2 * x
                messageData: modelData
                showSeparator: index < messageList.length - 1
            }
        }
    }
}
