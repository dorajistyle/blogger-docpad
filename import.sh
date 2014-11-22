#!/bin/bash
shopt -s extglob

if [ -d "out" ]; then
  cd 'out'
  rm -f sitemap.old
  mv sitemap.xml sitemap.old
  cd '..'
fi

cd 'src'
if [ ! -f updated_at.txt ]; then
   echo "1900-11-12T00:00:00" > updated_at.txt 
fi

cd 'documents'
find . -type f -print0 | xargs -0 sed -i 's/ignored: false/ignored: true/g'
cd '..'
grunt import
grunt generate --force

cd '..'
docpad generate --env static

if [ -d "out" ]; then
  cd 'out'

  if [ -f "sitemap.old" ]; then
    cp sitemap.xml sitemap.xml.tmp
    sed '$ d' sitemap.xml.tmp > sitemap.xml
    rm -f sitemap.xml.tmp
    sed -n '3,$p' sitemap.old >> sitemap.xml
  fi

  if [ ! -d ".git" ]; then
    git init
    git remote add origin "git@github.com:dorajistyle/dorajistyle.github.io.git"
  fi
  if [ ! -f "CNAME" ]; then  
  echo "dorajistyle.net" > CNAME 
  fi
  git add .
  git commit -m "posts are updated."
  git push origin master --force
fi
