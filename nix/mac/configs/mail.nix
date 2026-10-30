{ ... }:
{
  accounts.email.accounts.gmail = {
    primary = true;
    address = "yousef.elbahnasawy@gmail.com";
    userName = "yousef.elbahnasawy@gmail.com";
    realName = "Yousef Elbahnasawy";
    flavor = "gmail.com";
    folders = {
      inbox = "INBOX";
      sent = "[Gmail]/Sent Mail";
      drafts = "[Gmail]/Drafts";
      trash = "[Gmail]/Trash";
    };
    # Bitwarden item "Gmail app password (aerc)"; needs BW_SESSION (see the aerc wrapper in packages.nix)
    passwordCommand = "bw get password 16add1e7-f73b-41b4-a496-b4f300b93842";
    aerc.enable = true;
  };

  programs.aerc = {
    enable = true;
    extraConfig = {
      # accounts.conf is a read-only symlink into the store
      general.unsafe-accounts-conf = true;
      ui.styleset-name = "catppuccin";
      # Prefer the HTML part when a message has both
      viewer.alternatives = "text/html,text/plain";
      # aerc's stock filters, which it skips once aerc.conf exists. "html" is
      # the bundled sandboxed w3m wrapper. Keys are written sorted and aerc
      # uses the first match, so no wildcards.
      filters = {
        "text/plain" = "colorize";
        "text/calendar" = "calendar";
        "message/delivery-status" = "colorize";
        "message/rfc822" = "colorize";
        "text/html" = "! html";
        ".headers" = "colorize";
      };
    };
  };
}
