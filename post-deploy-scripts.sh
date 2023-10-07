curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
      . ~/.bashrc 

      nvm install v18
      nvm use v18

      ### sometimes ip is stale. assign specific ip
      echo "104.16.26.34 registry.npmjs.org" | tee -a /etc/hosts
      npm install dalai
      npx -y dalai llama install 7B
      


### mod nginx with ws fix
location / {
    proxy_pass http://localhost:3000;
    proxy_http_version 1.1;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection "Upgrade";
    proxy_set_header Host $host;
}

### run server
`npx dalai serve`