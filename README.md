# [Goolge Blogger](https://www.blogger.com/) to [DocPad](https://github.com/bevry/docpad).

Import Google Blooger articles by label and generate Docpad static blog.


### Installation

* [Install nvm](https://github.com/creationix/nvm)

```bash
git clone git://github.com/creationix/nvm.git ~/.nvm
printf "\n\n# NVM\nif [ -s ~/.nvm/nvm.sh ]; then\n\tNVM_DIR=~/.nvm\n\tsource ~/.nvm/nvm.sh\nfi" >> ~/.bashrc
NVM_DIR=~/.nvm
source ~/.nvm/nvm.sh
```

* [Install Node.js](http://nodejs.org/)

```bash 
nvm install v0.10.25
nvm alias default 0.10
nvm use 0.10
```
* [Install jekyll-import](https://github.com/jekyll/jekyll-import)

```bash
gem install jekyll-import
```

* [Download blogger-docpad.rb](https://gist.github.com/dorajistyle/b39f2284dafd03741eb0)
* copy blogger-docpad.rb into .gem/ruby/x.x.x/gems/jekyll-import-x.x.x/lib/jekyll-import/importers/

* [Install DocPad](https://github.com/bevry/docpad)
                
```bash
sudo npm install docpad -g
npm install --save cheerio
```

* [Install Blogger-Docpad](https://github.com/dorajistyle/blogger-docpad)

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

### Edit config files to fit your blog

  Make sure that a category name should be unique.

  * import.sh
    * line 37 : git repository.
    * line 40 : domain name.

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

### Execute

* Run init.sh to init blogger-docpad
                
```bash
./init.sh
```

* Run import.sh

```bash
./import.sh
```

### How to handle large number of files with docpad?

It's very tough. The sample blog [dorajistyle.pe.kr](http://dorajistyle.pe.kr) has more than 1000 articles. But docpad can't handle large number of files. However we have a trick. That's adding 'ignored' flag into your article's header. Before generating an article, set 'ignored' flag as false. When the article generated well, change 'ignored' flag to true. Docpad will ignore articles that already generated. Unfortunately [cleanurls](https://github.com/docpad/docpad-plugin-cleanurls) plugin not working with this trick. If you use the plugin, docpad generate ignored articles without layouts.


### Sample

* Original blog.

  [dorajistyle.pe.kr](http://dorajistyle.pe.kr)

* Generated docpad static blog.

  [dorajistyle.net](http://dorajistyle.net)

________________________

## Attributions

Blogger-Docpad is under the [MIT license](http://opensource.org/licenses/MIT).
