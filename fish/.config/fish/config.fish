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

function fixssh
  tmux setenv SSH_AUTH_SOCK $SSH_AUTH_SOCK
end
