import QtQuick 2.0
import QtQuick.Layouts 1.1
import org.kde.plasma.core 2.0 as PlasmaCore

ColumnLayout {
    id: root

    property var messageData: undefined
    property bool showSeparator: false

    spacing: units.smallSpacing

    MessageItem {
        Layout.fillWidth: true
        iconSource: root.messageData.iconSource || ""
        text: root.messageData.text
    }

    RowLayout {
        Layout.fillWidth: true
        spacing: units.smallSpacing
        visible: repeater.count > 0

        Item {
            Layout.fillHeight: true
            width: units.iconSizes.small

            PlasmaCore.SvgItem {
                anchors.fill: parent
                elementId: "vertical-line"
                svg: lineSvg
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: units.smallSpacing

            Repeater {
                id: repeater

                model: root.messageData.children

                MessageItem {
                    Layout.fillWidth: true
                    iconSource: modelData.iconSource || ""
                    text: modelData.text
                }
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
