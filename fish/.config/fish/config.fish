# initialize rbenv
if test -d ~/.rbenv/shims
  if test -d ~/.rbenv/bin
    set PATH ~/.rbenv/bin $PATH
  end

  status --is-interactive; and source (rbenv init - --no-rehash|psub)
end

# initialize nodenv
if test -d ~/.nodenv/shims
  if test -d ~/.nodenv/bin
    set PATH ~/.nodenv/bin $PATH
  end

  status --is-interactive; and source (nodenv init - --no-rehash|psub)
end

# add camp binaries to path
if test -d /home/camp/bin
  set PATH /home/camp/bin $PATH
end

# add locally-installed binaries to path
if test -d ~/bin
  set PATH ~/bin $PATH
end

# configure fzf to use ripgrep if available
if type -q rg
  set FZF_DEFAULT_COMMAND 'rg -g ""'
end

# define function for fixing ssh issues in tmux sessions
function fixssh
  tmux setenv SSH_AUTH_SOCK $SSH_AUTH_SOCK
end
