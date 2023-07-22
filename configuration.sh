#!/bin/bash
                    
# Download necesary dependenies
sudo apt update

# Write file
echo "Hello Terraform" > prueba.txt

# Install Node
cd ~
curl -sL https://deb.nodesource.com/setup_16.x -o nodesource_setup.sh
sudo bash nodesource_setup.sh
sudo apt install nodejs
# Install  Nestjs
sudo npm i -g @nestjs/cli
# Clone Repository and install dependencies
export FEATURE="Hola" ## Create a environtment variable, $1 is dynamic
cd /home/ubuntu
git clone https://github.com/rodriguecj/nest-pokedex.git
cd nest-pokedex/
git config --global --add safe.directory /home/ubuntu/nest-pokedex
git checkout -b feature/x origin/feature/x
sudo npm i
sudo npm run build
npm run start:prod