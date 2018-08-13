#!/usr/bin/env bash

sudo rm -Rf db
sudo rm -Rf _build

cd assets && npm run deploy && cd ..

rsync -ravz ./* maexBox:~/projects/flip.maex.me
ssh maexBox 'cd ~/projects/flip.maex.me && docker-compose --file docker-compose-production.yml restart'
