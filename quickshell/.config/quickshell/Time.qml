pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
  property string time

  Process {
    id: dateProc
    command: ["date", "+%b %e   %l:%M"]
    running: true

    stdout: SplitParser {
      onRead: data => time = data
    }
  }

  Timer {
    interval: 1000
    running: true
    repeat: true
    onTriggered: dateProc.running = true
  }
}
