// appcycle <bundle-identifier>
//
// A tiny native helper for Karabiner app-launch keys:
//   - app not running        -> launch it
//   - running, not frontmost -> bring it to the front
//   - already frontmost      -> raise the backmost window, cycling through
//                               every window on repeated presses
//
// Replaces the slower `osascript`/AppleScript approach. Raising a specific
// window requires the Accessibility API (AX), so the compiled binary must be
// granted Accessibility permission once in
//   System Settings > Privacy & Security > Accessibility.

import Cocoa
import ApplicationServices

guard CommandLine.arguments.count > 1 else {
    FileHandle.standardError.write(Data("usage: appcycle <bundle-identifier>\n".utf8))
    exit(2)
}
let bundleID = CommandLine.arguments[1]

let running = NSWorkspace.shared.runningApplications.first { $0.bundleIdentifier == bundleID }

guard let app = running else {
    // Not running: launch it.
    if let url = NSWorkspace.shared.urlForApplication(withBundleIdentifier: bundleID) {
        NSWorkspace.shared.open(url)
    }
    exit(0)
}

if !app.isActive {
    // Running but in the background: bring it forward.
    app.activate()
    exit(0)
}

// Already frontmost: rotate to the next window by raising the backmost one.
// AX returns windows front-to-back, so raising the last entry cycles through
// all of them across successive presses. Raising windows requires Accessibility
// permission; prompt for it once if this binary hasn't been granted yet.
let trusted = AXIsProcessTrustedWithOptions(
    [kAXTrustedCheckOptionPrompt.takeUnretainedValue() as String: true] as CFDictionary)
guard trusted else { exit(0) }

let axApp = AXUIElementCreateApplication(app.processIdentifier)
var value: CFTypeRef?
guard AXUIElementCopyAttributeValue(axApp, kAXWindowsAttribute as CFString, &value) == .success,
      let windows = value as? [AXUIElement], windows.count > 1 else {
    exit(0)
}
AXUIElementPerformAction(windows[windows.count - 1], kAXRaiseAction as CFString)
