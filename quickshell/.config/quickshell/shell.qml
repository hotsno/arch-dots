import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Wayland
import Quickshell.Hyprland

Scope {
  Variants {
    model: Quickshell.screens

    delegate: WlrLayershell {
      property var modelData
      screen: modelData
      color: "transparent"

      anchors {
        top: true
        left: true
        right: true
      }

      implicitHeight: 30

      // Bar "background"
      Rectangle {
        anchors.fill: parent

        Layout.fillWidth: true
        Layout.alignment: Qt.AlignTop

        color: "#111111"
        opacity: 0.5
      }

      // Bar components
      Row {
        anchors.fill: parent

        // Left
        Rectangle {
          width: parent.width / 3
          height: parent.height
          color: "transparent"

          Text {
            readonly property Toplevel activeWindow: ToplevelManager.activeToplevel
            property string actWinName: activeWindow?.activated ? activeWindow?.appId : "Desktop"

            text: {
              switch (actWinName) {
                case "com.mitchellh.ghostty": return "Ghostty";
                case "tv.plex.Plex": return "Plex";
                case "vesktop": return "Discord";
                default: return actWinName;
              }
            }
            color: "#dddddd"
            font.family: "SF Pro Rounded"
            font.weight: Font.ExtraBold
            font.pointSize: 10
            font.capitalization: Font.Capitalize

            anchors.margins: 24
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
          }
        }

        // Center
        Rectangle {
          width: parent.width / 3
          height: parent.height
          color: "transparent"

          Text {
            id: workspaceIdText
            anchors.centerIn: parent
            text: {
                const id = Hyprland.focusedWorkspace?.id;
                if (id === undefined || id === null) {
                    return "???";
                }

                switch (id) {
                    case 1: return "I";
                    case 2: return "II";
                    case 3: return "III";
                    case 4: return "IV";
                    case 5: return "Browser";
                    case 6: return "Notes";
                    case 7: return "Chat";
                    case 8: return "Music";
                    case 9: return "Terminal";
                    default: return id.toString();
                }
            }
            opacity: 1
            color: "#dddddd"
            font.family: "SF Pro Rounded"
            font.weight: Font.ExtraBold
            font.pointSize: 10
          }
        }
        // Right
        Rectangle {
          width: parent.width / 3
          height: parent.height
          color: "transparent"

          ClockWidget {
            anchors.margins: 24
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
          }
        }
      }
    }
  }
}
