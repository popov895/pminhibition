import QtQuick
import QtQuick.Layouts
import org.kde.kirigami as Kirigami
import org.kde.ksvg as KSvg

ColumnLayout {
    id: root

    property var messageData: undefined
    property bool showSeparator: false

    spacing: Kirigami.Units.smallSpacing

    MessageItem {
        Layout.fillWidth: true
        iconSource: root.messageData.iconSource || ""
        text: root.messageData.text
    }

    ColumnLayout {
        Layout.fillWidth: true
        spacing: Kirigami.Units.smallSpacing

        Repeater {
            model: root.messageData.children

            MessageItem {
                Layout.fillWidth: true
                iconSource: modelData.iconSource || ""
                text: modelData.text
            }
        }
    }

    KSvg.SvgItem {
        Layout.fillWidth: true
        elementId: "horizontal-line"
        svg: lineSvg
        visible: root.showSeparator
    }

    KSvg.Svg {
        id: lineSvg
        imagePath: "widgets/line"
    }
}
