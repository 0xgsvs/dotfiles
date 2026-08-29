function fish_greeting
    echo "Dont push to Production on Friday!"
end

if status is-interactive
end

# auto starting zellij have some drawabacks
# if status is-interactive; and not set -q ZELLIJ
#     zellij
# end

mise activate fish | source
atuin init fish | source

complete -c j -w jj
abbr -a jc 'jj git clone'
abbr -a js 'jj st'
abbr -a jd 'jj desc'
abbr -a jf 'jj git fetch'
abbr -a jp 'jj git push'
abbr -a ji 'jj git init'
abbr -a jr 'jj git remote'
abbr -a jn 'jj new'

abbr -a z zellij
abbr -a zl 'zellij ls'
abbr -a za 'zellij a'
abbr -a zs 'zellij -s'
abbr -a zk 'zellij k'
abbr -a zd 'zellij d'
abbr -a zka 'zellij ka'
abbr -a zda 'zellij da'

abbr -a lj jjui
abbr -a c clear
abbr -a e exit
abbr -a n nvim
abbr -a h hx
abbr -a cn 'clear && nvim'
abbr -a rmf 'rm -rf'
abbr -a cdd 'cd ..'
abbr -a sos 'source ~/.config/fish/config.fish'
# abbr -a dev 'nom develop --command fish'

set -Ux NH_HOME_FLAKE /home/greed/.config/nix_system/

set -gx RUSTUP_HOME "$HOME/.config/rustup"
set -gx CARGO_HOME "$HOME/.config/cargo"
set -gx XDG_RUNTIME_DIR /tmp

fish_add_path "$HOME/.local/share/mise/shims"
fish_add_path "$HOME/projects/maintain/nixpkgs/result/bin"
fish_add_path "$HOME/.bun/bin"
fish_add_path "$HOME/.config/cargo/bin"
fish_add_path "$HOME/.local/bin"

set -gx CORE_RETROARCH /home/greed/.local/share/Steam/steamapps/common/RetroArch/cores/
set -gx EDITOR nvim
set -gx VISUAL nvim

set -gx FIRECRAWL_API_URL http://localhost:3002

# Zoxide
set -gx _ZO_CD zi
zoxide init --cmd cd fish | source

alias l='eza -l --icons --group-directories-first '
alias la='eza -la --icons --group-directories-first '
alias ls='eza --icons --group-directories-first --tree --level=2'
alias please='sudo'

function toggle_vi_mode
    if test "$fish_bind_mode" = default
        set fish_bind_mode insert
        commandline -f repaint-mode
    else
        set fish_bind_mode default
        commandline -f repaint-mode
    end
end

set -g fish_key_bindings fish_vi_key_bindings

bind -M insert jk "if commandline -P; commandline -f cancel; else; set fish_bind_mode default; commandline -f backward-char force-repaint; end"
bind -M insert alt-l forward-char

# Custom binds: alt+e to toggle vi mode, alt+o to edit command
bind -M insert alt-e toggle_vi_mode
bind -M default alt-e toggle_vi_mode
bind -M insert alt-o edit_command_buffer
bind -M default alt-o edit_command_buffer

set -g fish_sequence_key_delay_ms 200

fish_ssh_agent
