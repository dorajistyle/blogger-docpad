#!/bin/bash
shopt -s extglob

cd 'src'
rm -f updated_at.*
cd 'documents'
rm -rf !(images|styles|scripts|index.html.md)
cd '../..'
