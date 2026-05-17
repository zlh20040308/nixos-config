# home-manager 的 tmux 模块配置
{ config, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    
    # 基础设置
    baseIndex = 1;           # 窗口编号从 1 开始
    escapeTime = 0;          # 更快的退出时间
    mouse = true;            # 启用鼠标支持
    prefix = "C-a";          # 修改前缀键为 Ctrl+a（默认是 C-b）
    
    # 快捷键模式
    keyMode = "vi";          # 使用 vi 风格的快捷键
    
    # 自定义额外配置
    extraConfig = ''
      # 重新加载配置文件
      bind r source-file ~/.tmux.conf \; display "配置已重新加载！"
      
      # 使用 | 和 - 分割面板
      bind | split-window -h
      bind - split-window -v
      
      # Vim 风格的面板导航
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R
      
      # 类似 vim 的面板大小调整
      bind -r H resize-pane -L 5
      bind -r J resize-pane -D 5
      bind -r K resize-pane -U 5
      bind -r L resize-pane -R 5
      
      # 智能面板切换（识别 vim 分割）
      is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
          | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|l?n?vim?x?|diff)(-wrapped)?$'"
      bind -n C-h if-shell "$is_vim" "send-keys C-h" "select-pane -L"
      bind -n C-j if-shell "$is_vim" "send-keys C-j" "select-pane -D"
      bind -n C-k if-shell "$is_vim" "send-keys C-k" "select-pane -U"
      bind -n C-l if-shell "$is_vim" "send-keys C-l" "select-pane -R"
      
      # 复制模式（vi 风格）
      bind -T copy-mode-vi v send-keys -X begin-selection
      bind -T copy-mode-vi y send-keys -X copy-selection
      
      # 更好的滚动
      bind -T copy-mode-vi C-u send-keys -X halfpage-up
      bind -T copy-mode-vi C-d send-keys -X halfpage-down
      
      # 剪贴板集成（Linux 使用 xclip）
      bind C-c run "tmux save-buffer - | xclip -selection clipboard"
      bind C-v run "xclip -selection clipboard -o | tmux load-buffer - && tmux paste-buffer"
      
      # 状态栏自定义
      set -g status-left-length 100
      set -g status-right-length 100
      set -g status-left "#[fg=green]#S #[fg=white]|"
      set -g status-right "#[fg=yellow]%H:%M #[fg=cyan]%d/%m/%y"
      
      # 窗口样式
      set -g window-status-current-format "#[fg=green,bold]#I:#W"
      set -g window-status-format "#[fg=white]#I:#W"
      
      # 活动监控
      setw -g monitor-activity on
      set -g visual-activity on
      
      # 激进式大小调整
      setw -g aggressive-resize on
      
      # 增加历史记录限制
      set -g history-limit 50000
      
      # 窗口和面板从 1 开始编号
      set -g base-index 1
      setw -g pane-base-index 1
    '';
    
    # 插件
    plugins = with pkgs; [
      tmuxPlugins.sensible      # 合理的默认设置
      tmuxPlugins.yank          # 系统剪贴板集成
      tmuxPlugins.resurrect     # 持久化 tmux 会话
      tmuxPlugins.continuum     # 自动保存和恢复会话
      tmuxPlugins.prefix-highlight  # 按下前缀键时高亮显示
    ];
  };
  
  # 可选：安装 xclip 以支持剪贴板（Linux）
  home.packages = with pkgs; [ xclip ];
}
