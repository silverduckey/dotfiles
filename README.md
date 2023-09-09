## Note:

For people who use Arch or any Arch based distrobution then you will have to compile
vim from source with the following command:

    git clone https://github.com/vim/vim.git
    cd vim/src
    make
    sudo make install

to get all the features working.

If you have already installed fzf from the official fzf github repo then to enable keybindings and completion use the following command:

    [[ -d $HOME/.fzf ]] && rm -rf $HOME/.fzf
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install --all
