{
  programs.openclaw = {
    enable = true;

    workspace.bootstrapFiles = {
      agents = ./workspace/AGENTS.md;
      soul = ./workspace/SOUL.md;
      tools = ./workspace/TOOLS.md;
      identity = ./workspace/IDENTITY.md;
      user = ./workspace/USER.md;
    };

    environment = {
      ANTHROPIC_API_KEY = "/home/bahnasawy/.secrets/openclaw/anthropic-api-key";
      CUSTOM_API_KEY = "/home/bahnasawy/.secrets/openclaw/custom-api-key";
    };

    config = {
      gateway = {
        mode = "local";
        auth.token = "z68Lx6gc68Y9leqI0SOkXsGW8JEJkMzfmfkMDebI2OIiJg7S";
        tailscale.mode = "serve"; # publish gateway at https://pc.tailffec45.ts.net (tailnet-only)
      };

      tools = {
        alsoAllow = [ "computer" ]; # computer use: control paired node desktops (MacBook) via Peekaboo
      };

      channels.telegram = {
        tokenFile = "/home/bahnasawy/.secrets/openclaw/telegram-bot-token";
        allowFrom = [ 8713324248 ];
        groups = {
          "*" = {
            requireMention = true;
          };
        };
      };

      models = {
        mode = "merge";
        providers = {
          custom = {
            baseUrl = "https://api.cheaperinference.com/v1";
            apiKey = "\${CUSTOM_API_KEY}";
            api = "openai-completions";
            models = [
              {
                id = "glm-5.3-flash";
                name = "GLM 5.3 Flash";
                input = [
                  "text"
                  "image"
                ]; # vision-capable — required for the computer tool
              }
              {
                id = "gemini-3.7-flash";
                name = "Gemini 3.7 Flash";
                input = [
                  "text"
                  "image"
                ]; # vision-capable — required for the computer tool
              }
            ];
          };
        };
      };

      # Linear MCP — first-party remote server (streamable HTTP + OAuth).
      # Authorize with: openclaw mcp login linear
      mcp.servers.linear = {
        url = "https://mcp.linear.app/mcp";
        transport = "streamable-http";
        auth = "oauth";
      };

      # Vision-capable primary — the gateway only exposes the `computer` tool to
      # sessions whose model can process screenshots (computer-use requirement).
      agents.defaults.model.primary = "custom/glm-5.3-flash";
    };
  };

  # Module ships the unit without [Install]; make it start at login.
  systemd.user.services.openclaw-gateway.Install.WantedBy = [ "default.target" ];
}
