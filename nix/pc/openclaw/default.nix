{
  programs.openclaw = {
    enable = true;

    # Declarative runtime plugin: @openclaw/parallel-plugin (keyless web_search).
    # Nix-managed installs can't use `openclaw plugins install`.
    runtimePlugins = [ "parallel" ];

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

        # Keyless web_search via Parallel's free Search MCP. Key-free providers
        # are never auto-selected; provider must be explicit.
        web.search = {
          enabled = true;
          provider = "parallel-free";
        };
      };

      channels.telegram = {
        # Telegram polling is handled by Timmy on the VPS.
        enabled = false;
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
              {
                id = "gpt-6-luna";
                name = "GPT 6 Luna";
                input = [
                  "text"
                  "image"
                ]; # vision-capable — required for the computer tool
              }
            ];
          };
        };
      };

      mcp.servers = {
        # Linear MCP — first-party remote server (streamable HTTP + OAuth).
        # Authorize with: openclaw mcp login linear
        linear = {
          url = "https://mcp.linear.app/mcp";
          transport = "streamable-http";
          auth = "oauth";
        };

        # Neon MCP (hosted) — DB branch/project management, pinned to the GoCast-360
        # project. Authorized 2026-10-06 (gateway restart required after login for
        # the daemon runtime to pick up the token). Scope params: ?readonly=true /
        # ?category=querying for lower-trust use.
        neon = {
          url = "https://mcp.neon.tech/mcp?projectId=shy-smoke-13265855";
          transport = "streamable-http";
          auth = "oauth";
        };

        # Doppler MCP (read-only) — stdio wrapper injects DOPPLER_TOKEN at runtime
        # from the local CLI auth; the token is never stored in config.
        doppler = {
          command = "/home/bahnasawy/.local/bin/doppler-mcp";
          transport = "stdio";
          enabled = true;
        };
      };

      # Vision-capable primary — the gateway only exposes the `computer` tool to
      # sessions whose model can process screenshots (computer-use requirement).
      agents.defaults.model.primary = "custom/gpt-6-luna";
    };
  };

  # Module ships the unit without [Install]; make it start at login.
  systemd.user.services.openclaw-gateway.Install.WantedBy = [ "default.target" ];
}
