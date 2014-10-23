# If we don't find an rbenv command, add $HOME/.rbenv/bin to PATH
# Because, obviously rbenv should be installed, it just might not
# be in our path.
if (( ! $+commands[rbenv] ))
then
  export PATH=$HOME/.rbenv/bin:$PATH
fi
