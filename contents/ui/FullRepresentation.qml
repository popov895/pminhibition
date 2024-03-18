import QtQuick
import QtQuick.Layouts
import org.kde.plasma.components as PlasmaComponents3
import org.kde.plasma.extras as PlasmaExtras
import org.kde.kirigami as Kirigami

PlasmaComponents3.Page {
    Layout.minimumHeight: Kirigami.Units.gridUnit * 14
    Layout.minimumWidth: Kirigami.Units.gridUnit * 14
    Layout.preferredHeight: Layout.minimumHeight * 1.5
    Layout.preferredWidth: Layout.minimumWidth * 1.5

    PlasmaExtras.PlaceholderMessage {
        anchors.centerIn: parent
        width: parent.width - 4 * Kirigami.Units.largeSpacing
        iconName: "checkmark"
        text: i18n("No messages")
        visible: !contentView.visible
    }

    PlasmaComponents3.ScrollView {
        id: contentView

        anchors.fill: parent
        visible: messageList.length > 0

        contentItem: ListView {
            spacing: Kirigami.Units.smallSpacing
            model: messageList

            delegate: MessageDelegate {
                x: Kirigami.Units.smallSpacing
                width: ListView.view.width - 2 * x
                messageData: modelData
                showSeparator: index < messageList.length - 1
            }
        }
    }
}
