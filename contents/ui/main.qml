import QtQuick 2.0
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore

Item {
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
                text: (() => {
                    if (inhibitingAppList.length > 1)
                        return i18np("%1 application is preventing sleep and screen locking:",
                                     "%1 applications are preventing sleep and screen locking:",
                                     inhibitingAppList.length);
                        if (1 === inhibitingAppList.length)
                            return i18n("An application is preventing sleep and screen locking:");
                        return "";
                })(),
                children: inhibitingAppList.map((inhibitingApp) => {
                    return {
                        iconSource: inhibitingApp.Icon,
                        text: (() => {
                            if (inhibitingApp.Reason)
                                return i18nc("Application name: reason for preventing sleep and screen locking", "%1: %2", inhibitingApp.Name, inhibitingApp.Reason);
                            return i18nc("Application name: reason for preventing sleep and screen locking", "%1: unknown reason", inhibitingApp.Name);
                        })()
                    };
                })
            });
        }
        return messages;
    }

    Plasmoid.icon: "exception"
    Plasmoid.switchWidth: units.gridUnit * 10
    Plasmoid.switchHeight: units.gridUnit * 10
    Plasmoid.toolTipMainText: i18n("Power Management Inhibition")
    Plasmoid.compactRepresentation: CompactRepresentation {}
    Plasmoid.fullRepresentation: FullRepresentation {}
    Plasmoid.toolTipSubText: {
        if (messageList.length > 0)
            return i18np("%1 message", "%1 messages", messageList.length);
        return i18n("No messages");
    }
    Plasmoid.status: {
        if (messageList.length > 0)
            return PlasmaCore.Types.ActiveStatus;
        return PlasmaCore.Types.PassiveStatus;
    }

    PlasmaCore.DataSource {
        id: pmSource

        engine: "powermanagement"
        connectedSources: sources

        onSourceAdded: {
            disconnectSource(source);
            connectSource(source);
        }

        onSourceRemoved: {
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
            for (let key in pmSource.data["Inhibitions"])
                inhibitingApps.push(pmSource.data["Inhibitions"][key]);
        }
        root.inhibitingAppList = inhibitingApps;
    }
}
