// Builds the three rice panels from scratch. Source of truth for the layout.
// Run through panels.sh, which replaces __TIGHT_GLASS__ with the Panel
// Colorizer settings from panel-colorizer/tight-glass/settings.json.
// Running it again removes every panel and rebuilds the same three.

var RAIL = 46;      // rail width
var BAR = 30;       // top bar height
var GAP = 3;        // gap between a panel and the screen edge
// Invisible strip on each panel's inner side. The pointer still counts as on
// the panel there, so a panel does not hide the moment the pointer slips past
// its border. Plasma clips a panel's input area to its blur region, so this
// only works with no blur at all: tight-glass/settings.json turns off both
// Panel Colorizer's blur and the native panel background, which would
// otherwise blur the whole panel window including the slack strip.
var SLOP = 24;
var RAIL_PAD = 8;   // space above the first and below the last rail widget
var INNER = { left: "right", right: "left", top: "bottom" };
var COLORIZER = "luisbocanegra.panel.colorizer";
var TITLEBAR = "com.github.antroids.application-title-bar";
var GLASS = __TIGHT_GLASS__;

// System tray entries carried over from the previous layout.
var TRAY_EXTRA = "org.kde.plasma.manage-inputmethod,org.kde.plasma.keyboardlayout,org.kde.plasma.bluetooth,org.kde.kdeconnect,org.kde.plasma.devicenotifier,org.kde.plasma.mediacontroller,org.kde.plasma.networkmanagement,org.kde.plasma.keyboardindicator,org.kde.plasma.volume,org.kde.kscreen,org.kde.plasma.brightness,org.kde.plasma.battery,org.kde.plasma.clipboard,org.kde.plasma.notifications,org.kde.plasma.weather,org.kde.merkuro.contact.applet,org.kde.plasma.dwellclicker";
var TRAY_HIDDEN = "blueman,org.kde.plasma.brightness,org.kde.plasma.battery,org.kde.plasma.clipboard,org.kde.plasma.notifications,org.kde.plasma.weather";

function set(widget, group, values) {
    widget.currentConfigGroup = [group];
    for (var k in values) widget.writeConfig(k, values[k]);
}

function colorize(panel) {
    var w = panel.addWidget(COLORIZER);
    var glass = JSON.parse(JSON.stringify(GLASS));
    glass.panel.normal.margin.side[INNER[panel.location]] = GAP + SLOP;
    // Rails fit their content; without end padding the first and last widget
    // are clipped by the rounded background.
    if (panel.location !== "top") {
        glass.panel.normal.padding = {
            enabled: true,
            side: { left: 0, right: 0, top: RAIL_PAD, bottom: RAIL_PAD }
        };
    }
    set(w, "General", {
        globalSettings: JSON.stringify(glass),
        hideWidget: true,
        isEnabled: true
    });
}

function makePanel(location, thickness) {
    var p = new Panel;
    p.location = location;
    p.height = thickness + SLOP;
    p.hiding = "autohide";
    p.floating = false;
    return p;
}

panels().forEach(function (p) { p.remove(); });

// Left rail: launcher, tasks, pager. Centered and only as long as its
// content; a spacer would stretch it to full height again.
var left = makePanel("left", RAIL);
left.alignment = "center";
left.lengthMode = "fit";
left.addWidget("org.kde.plasma.kickoff");
set(left.addWidget("org.kde.plasma.icontasks"), "General", {
    minimizeActiveTaskOnClick: false,
    sortingStrategy: 2
});
left.addWidget("org.kde.plasma.pager");
colorize(left);

// Right rail: clock and date, tray, lock/logout. Centered, fits content.
var right = makePanel("right", RAIL);
right.alignment = "center";
right.lengthMode = "fit";
set(right.addWidget("org.kde.plasma.digitalclock"), "Appearance", {
    showDate: true,
    dateFormat: "custom",
    customDateFormat: "dd-MM",
    use24hFormat: 0,
    autoFontAndSize: true
});
var tray = right.addWidget("org.kde.plasma.systemtray");
var trayContainment = desktopById(tray.readConfig("SystrayContainmentId"));
if (trayContainment) {
    set(trayContainment, "General", { extraItems: TRAY_EXTRA, hiddenItems: TRAY_HIDDEN });
}
right.addWidget("org.kde.plasma.lock_logout");
colorize(right);

// Top bar: inset between the rails so the hover zones do not overlap.
var top = makePanel("top", BAR);
var inset = 2 * (RAIL + GAP + GAP);
var barLength = screenGeometry(top.screen).width - inset;
top.alignment = "center";
top.lengthMode = "custom";
top.minimumLength = barLength;
top.maximumLength = barLength;
set(top.addWidget(TITLEBAR), "Appearance", {
    widgetElements: "windowTitle",
    windowTitleSource: 0,
    windowTitleFontSize: 10,
    windowTitleFontBold: false
});
top.addWidget("org.kde.plasma.appmenu");
top.addWidget("org.kde.plasma.panelspacer");
set(top.addWidget(TITLEBAR), "Appearance", {
    widgetElements: "windowMinimizeButton,windowMaximizeButton,windowCloseButton",
    // 1 = Breeze. The default (Plasma theme) draws no buttons here.
    widgetButtonsIconsTheme: 1
});
colorize(top);
