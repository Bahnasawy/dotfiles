// Hides the top panel while a Zen window is focused, and shows it again for
// any other app. Zen draws its own tabs and toolbar at the top edge, so the
// auto-hiding top bar would cover them on hover.
//
// The panel is hidden through Panel Colorizer's "visible" setting on the top
// panel's colorizer widget; Plasma itself has no per-app panel visibility.

var hidden = null; // last state sent, so the shell is only called on a change

function shellScript(visible) {
    return 'panels().forEach(function(p){ if(p.location!="top") return;' +
        ' p.widgets().forEach(function(w){' +
        ' if(w.type!="luisbocanegra.panel.colorizer") return;' +
        ' w.currentConfigGroup=["General"];' +
        ' var g=JSON.parse(w.readConfig("globalSettings"));' +
        ' g.stockPanelSettings.visible={enabled:true,value:' + visible + '};' +
        ' w.writeConfig("globalSettings",JSON.stringify(g)); w.reloadConfig(); }); });';
}

function update(window) {
    // Panels, popups and the desktop take focus briefly; keep the last state.
    if (!window || !window.normalWindow) return;
    var hide = String(window.resourceClass).indexOf("zen") === 0;
    if (hide === hidden) return;
    hidden = hide;
    callDBus("org.kde.plasmashell", "/PlasmaShell", "org.kde.PlasmaShell",
        "evaluateScript", shellScript(!hide));
}

workspace.windowActivated.connect(update);
update(workspace.activeWindow);
