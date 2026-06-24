{
  everforest.opencode.transparentBackground = true;
  programs.opencode = {
    enable = true;
    settings = {
      enabled_providers = [ "codexcn" ];
      lsp = true;
      model = "codexcn/gpt-5.5";
      provider.codexcn = {
        npm = "@ai-sdk/openai";
        name = "CodexCN";
        options = {
          baseURL = "{env:OPENAI_BASE_URL}";
          apiKey = "{env:OPENAI_API_KEY}";
        };
        models."gpt-5.5" = {
          name = "GPT-5.5";
        };
      };
    };
  };
}
