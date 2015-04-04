
#!/bin/sh
#
# Node Version Manager (NVM)
#
# version manager for Node.JS 

# Check for NVM
if test ! $(which nvm)
then
  echo "  Installing NVM for you."
   curl https://raw.githubusercontent.com/creationix/nvm/v0.24.0/install.sh | bash > /tmp/homebrew-install.log
fi

exit 0
