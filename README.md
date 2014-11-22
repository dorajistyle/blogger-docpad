# [Goolge Blogger](https://www.blogger.com/) to [DocPad](https://github.com/bevry/docpad).

Import Google Blooger articles by label and generate Docpad static blog.


### Installation

1. [Install nvm](https://github.com/creationix/nvm)

```bash
git clone git://github.com/creationix/nvm.git ~/.nvm
printf "\n\n# NVM\nif [ -s ~/.nvm/nvm.sh ]; then\n\tNVM_DIR=~/.nvm\n\tsource ~/.nvm/nvm.sh\nfi" >> ~/.bashrc
NVM_DIR=~/.nvm
source ~/.nvm/nvm.sh
```

1. [Install Node.js](http://nodejs.org/)

```bash 
nvm install v0.10.25
nvm alias default 0.10
nvm use 0.10
```
1. [Install jekyll-import](https://github.com/jekyll/jekyll-import)

```bash
gem install jekyll-import
```

1. [Install DocPad](https://github.com/bevry/docpad)
                
```bash
sudo npm install docpad -g
npm install --save cheerio
```

1. [Install Blogger-Docpad](https://github.com/dorajistyle/blogger-docpad)

```bash
git clone https://github.com/dorajistyle/blogger-docpad 
cd blogger-docpad
docpad install sitemap
docpad install cleancss 
docpad install uglify
docpad install ghpages
docpad install moment
docpad install sitemap
cd src
npm install -g grunt
npm install --save-dev grunt-contrib-watch 
npm install --save-dev grunt-shell
npm install --save-dev time-grunt
```

1. Edit config files to fit your blog

  Make sure that a category name should be unique.

    * import.sh
        line 37 : git repository.
        line 40 : domain name.

    * docpad.coffee
        * categories
        * docpadConfig/templateData/site
        * docpadConfig/templateData/collections

    * src/Gruntfile
      * categories
      * intros
      * titles
      * descriptions

    * src/partials
    * src/layouts
    * src/documents/scripts
    * src/documents/styles
    * src/documents/images

1. Run init.sh to init blogger-docpad
                
```bash
./init.sh
```

1. Run import.sh

```bash
./import.sh
```

### Generated static blog.

  [dorajistyle.net](http://dorajistyle.net)

________________________

## Attributions

Blogger-Docpad is under the [MIT license](http://opensource.org/licenses/MIT).
