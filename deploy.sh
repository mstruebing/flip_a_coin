#!/usr/bin/env bash

sudo rm -Rf db
sudo rm -Rf _build

cd assets && npm run deploy && cd ..

rsync -ravz ./* maexBox:~/projects/flip.maex.me
ssh maexBox 'cd ~/projects/flip.maex.me && cp /home/maex/certbot/{fullchain,privkey,cert}.pem /home/maex/projects/flip.maex.me/ && docker-compose restart'
