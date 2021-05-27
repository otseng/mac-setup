#!/usr/bin/env bash
# Install command-line tools using Homebrew.
#
# Based on:
# https://github.com/mikeprivette/yanmss
# https://gist.github.com/bradp/bea76b16d3325f5c47d4

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do
    sudo -n true
    sleep 60
    kill -0 "$$" || exit
done 2>/dev/null &

config() {
    # Setup Finder Commands
    # Show Library Folder in Finder
    chflags nohidden ~/Library

    # Show Hidden Files in Finder
    defaults write com.apple.finder AppleShowAllFiles YES

    # Show Path Bar in Finder
    defaults write com.apple.finder ShowPathbar -bool true

    # Show Status Bar in Finder
    defaults write com.apple.finder ShowStatusBar -bool true

    # Check for Homebrew, and then install it
    if test ! "$(which brew)"; then
        echo "Installing homebrew..."
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        echo "Homebrew installed successfully"
    else
        echo "Homebrew already installed!"
    fi

    # Install XCode Command Line Tools
    echo 'Checking to see if XCode Command Line Tools are installed...'
    brew config

    # Updating Homebrew.
    echo "Updating Homebrew..."
    brew update

    # Upgrade any already-installed formulae.
    echo "Upgrading Homebrew..."
    brew upgrade

    # Install oh-my-zsh
    echo "Installing oh-my-zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    echo "Need to logout now to start the new SHELL..."
    logout
}

install-packages() {
    PACKAGES=(
      docker
      ffmpeg
      git
      httpd
      mysql
      php
      python3
      telnet
    )

    echo "Installing packages:"
    brew install ${PACKAGES[@]}
}

install-apps() {
    brew install homebrew/cask/brew-cask
    
    brew install cask --appdir="/Applications" 1password
    brew install cask --appdir="/Applications" android-studio
    brew install cask --appdir="/Applications" audacity
    brew install cask --appdir="/Applications" cyberduck
    brew install cask --appdir="/Applications" db-browser-for-sqlite
    brew install cask --appdir="/Applications" dropbox
    brew install cask --appdir="/Applications" firefox
    brew install cask --appdir="/Applications" gimp
    brew install cask --appdir="/Applications" github
    brew install cask --appdir="/Applications" google-chrome
    brew install cask --appdir="/Applications" iterm2
    brew install cask --appdir="/Applications" kindle
    brew install cask --appdir="/Applications" macs-fan-control
    brew install cask --appdir="/Applications" postman
    brew install cask --appdir="/Applications" pycharm-ce
    brew install cask --appdir="/Applications" shotcut
    brew install cask --appdir="/Applications" slack
    brew install cask --appdir="/Applications" steam
    brew install cask --appdir="/Applications" skype
    brew install cask --appdir="/Applications" sequel-pro
    brew install cask --appdir="/Applications" visual-studio-code
    brew install cask --appdir="/Applications" webex
    brew install cask --appdir="/Applications" zoom
}

install-python-packages() {
    PYTHON_PACKAGES=(
        virtualenv
        virtualenvwrapper
    )
    sudo pip install ${PYTHON_PACKAGES[@]}
}

install-config
install-packages
install-apps
install-python-packages

brew cleanup
echo "Done!"
