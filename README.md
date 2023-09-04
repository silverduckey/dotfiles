## Note:
For people who use Arch or any Arch based distrobution then you will have to compile
vim from source with the following command:
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
to get all the features working.
