import QtQuick
import org.kde.plasma.plasmoid
import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.plasma5support as P5Support
import org.kde.kirigami as Kirigami

PlasmoidItem {
    id: root

    property var inhibitingAppList: []
    property var messageList: {
        let messages = [];
        // laptop lid warning
        if (pmSource.data["PowerDevil"] && pmSource.data["PowerDevil"]["Is Lid Present"] && !pmSource.data["PowerDevil"]["Triggers Lid Action"]) {
            messages.push({
                iconSource: "computer-laptop",
                text: i18n("Your notebook is configured not to sleep when closing the lid while an external monitor is connected.")
            });
        }
        // inhibiting applications
        if (inhibitingAppList.length > 0) {
            messages.push({
                text: i18np(
                    "An application is preventing sleep and screen locking:",
                    "%1 applications are preventing sleep and screen locking:",
                    inhibitingAppList.length
                ),
                children: inhibitingAppList.map((inhibitingApp) => {
                    return {
                        iconSource: inhibitingApp.Icon || "application-x-executable",
                        text: i18nc(
                            "Application name: reason for preventing sleep and screen locking",
                            "%1: %2",
                            inhibitingApp.Name,
                            inhibitingApp.Reason ?? i18n("unknown reason")
                        ),
                    };
                })
            });
        }
        return messages;
    }

    switchWidth: Kirigami.Units.gridUnit * 10
    switchHeight: Kirigami.Units.gridUnit * 10
    toolTipMainText: i18n("Power Management Inhibition")
    fullRepresentation: FullRepresentation {}
    toolTipSubText: {
        if (messageList.length > 0) {
            return i18np("%1 message", "%1 messages", messageList.length);
        }
        return i18n("No messages");
    }

    Plasmoid.title:i18n("Power Management Inhibition")
    Plasmoid.icon: "exception"
    Plasmoid.status: {
        if (messageList.length > 0) {
            return PlasmaCore.Types.ActiveStatus;
        }
        return PlasmaCore.Types.PassiveStatus;
    }

    P5Support.DataSource {
        id: pmSource

        engine: "powermanagement"
        connectedSources: sources

        onSourceAdded: source => {
            disconnectSource(source);
            connectSource(source);
        }

        onSourceRemoved: source => {
            disconnectSource(source);
        }

        onDataChanged: {
            root.updateInhibitingAppList();
        }
    }

    Component.onCompleted: {
        root.updateInhibitingAppList();
    }

    function updateInhibitingAppList() {
        let inhibitingApps = [];
        if (pmSource.data["Inhibitions"]) {
            for (let key in pmSource.data["Inhibitions"]) {
                inhibitingApps.push(pmSource.data["Inhibitions"][key]);
            }
        }
        root.inhibitingAppList = inhibitingApps;
    }
}
