import QtQuick 2.0
import QtQuick.Layouts 1.1
import org.kde.plasma.core 2.0 as PlasmaCore

ColumnLayout {
    id: root

    property var messageData: undefined
    property bool showSeparator: false

    spacing: PlasmaCore.Units.smallSpacing

    MessageItem {
        Layout.fillWidth: true
        iconSource: root.messageData.iconSource || ""
        text: root.messageData.text
    }

    ColumnLayout {
        Layout.fillWidth: true
        spacing: PlasmaCore.Units.smallSpacing

        Repeater {
            model: root.messageData.children

            MessageItem {
                Layout.fillWidth: true
                iconSource: modelData.iconSource || ""
                text: modelData.text
            }
        }
    }

    PlasmaCore.SvgItem {
        Layout.fillWidth: true
        elementId: "horizontal-line"
        svg: lineSvg
        visible: root.showSeparator
    }

    PlasmaCore.Svg {
        id: lineSvg
        imagePath: "widgets/line"
    }
}
