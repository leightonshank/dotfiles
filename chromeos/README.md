# Development setup for an [Acer C720 Chromebook](https://github.com/leightonshank/leightonshank.github.io/blob/master/chromebook_setup_notes.md)

This is the process I went through to setup my Acer C720 Chromebook to be a legit development environment, without too much heartburn.  

## Creating chroots with `crouton`

Steps to bootstrap and create basic development chroots for Ubuntu *Precise*:

1. Download [crouton](https://goo.gl/fd3zc) to ~/Downloads
2. Copy `crouton` to `/usr/local/bin`

   ~~~ sh
   $ sudo cp ~/Downloads/crouton /usr/local/bin
   ~~~

3. Download the *precise* release bootstrap file

   ~~~ sh
   $ sudo crouton -d -f crouton_bootstrap.tar.bz2 -r precise -t core
   ~~~

4. Create a *precise* chroot

   ~~~ sh
   $ sudo crouton -f crouton_bootsrap.tar.bz2 -r precise -t core
   ~~~

5. Enter the new chroot and install basic packages

   ~~~ sh
   $ sudo enter-chroot
   (precise) $ sudo apt-get -y install git vim gcc make libssl-dev libsqlite3-dev libv8-dev build-essential curl uuid-runtime postgresql libpq-dev tmux
   (precise) $ git config --global user.name "YOUR NAME"
   (precise) $ git config --global user.email "YOUR EMAIL"
   ~~~
   
6. Install [rbenv](https://github.com/sstephenson/ruby-build.git) and [ruby-build](https://github.com/sstephenson/ruby-build)

   ~~~ sh
   (precise) $ git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
   (precise) $ echo "export PATH=$HOME/.rbenv/bin:$PATH" >> ~/.bashrc
   (precise) $ echo 'eval "$(rbenv init -)"' >> ~/.bashrc
   (precise) $ source ~/.bashrc
   (precise) $ git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
   ~~~
   
7. Setup PostgreSQL
   
   ~~~ sh
   (precise) $ sudo -u postgres createuser --superuser $USER
   ~~~

8. Bootstrapping a Rails project, assuming ruby version is in `.ruby-version` at root of project directory.  Also assuming you have the project cloned, and are *in* the project directory.

   ~~~ sh
   (precise) project/ $ rbenv install `cat .ruby-version`
   (precise) project/ $ gem install bundler
   (precise) project/ $ bundle install
   (precise) project/ $ bin/rake db:create db:migrate db:seed
   ~~~
