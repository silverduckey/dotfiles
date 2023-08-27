## Note:
For people who use Arch or any Arch based distrobution then you will have to compile vim from source with the following command:
```
git clone https://github.com/vim/vim.git
cd vim
./configure --with-features=huge \
            --enable-multibyte \
            --enable-cscope \
            --prefix=/usr/local
make
sudo make install
```
so that Vim can actually talk to the system clipboard.
For people who use Arch or any Arch based distrobution then you will have to compile lf from source using the following command:
```
go install github.com/gokcehan/lf@latest
```
so that all the options are are available in lf
