{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    claude-code
  ];
  
  # 使用环境变量方式（推荐，更灵活）
  home.sessionVariables = {
    ANTHROPIC_BASE_URL = "https://api.deepseek.com/anthropic";
    ANTHROPIC_AUTH_TOKEN = "$DEEPSEEK_API_KEY";  # 从 shell 环境变量读取
    ANTHROPIC_MODEL = "deepseek-v4-pro";
    ANTHROPIC_DEFAULT_OPUS_MODEL = "deepseek-v4-pro";
    ANTHROPIC_DEFAULT_SONNET_MODEL = "deepseek-v4-pro";
    ANTHROPIC_DEFAULT_HAIKU_MODEL = "deepseek-v4-flash";
    CLAUDE_CODE_SUBAGENT_MODEL = "deepseek-v4-flash";
    CLAUDE_CODE_EFFORT_LEVEL = "max";
  };
  
  programs.claude-code = {
    enable = true;
  };
}
