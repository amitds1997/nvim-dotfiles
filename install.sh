#!/usr/bin/env bash

os=$(uname -s) 
platform="Linux"

case $os in
	Linux)
		platform="Linux"
		;;
	Darwin)
		platform="macOS"
		;;
esac

# Make sure LSP path exists
nvim_data_path="${HOME}/.local/share/nvim/lsp"
mkdir -p $nvim_data_path

# Setup gopls server
#GOPATH=$(pwd) GOBIN=$(pwd) GO111MODULE=on go get -v golang.org/x/tools/gopls
#GOPATH=$(pwd) GO111MODULE=on go clean -modcache
#echo "🌟 Gopls server setup done!"
#
## Setup bash-language-server, dockerfile-language-server and pyright
#npm install dockerfile-language-server-nodejs@latest
#echo "🌟 Dockerfile server setup done!"
#npm install bash-language-server@latest
#echo "🌟 Bash language server setup done!"
#npm install pyright@latest
#echo "🌟 Pyright server setup done!"

# Setup lua server
lua_package_name=$(openssl rand -hex 12)
lua_release_name="${lua_package_name}.zip"

curl -L --silent -o $lua_release_name $(curl --silent -H "Accept: application/vnd.github.v3+json" https://api.github.com/repos/sumneko/vscode-lua/releases/latest | grep 'browser_' | cut -d\" -f4)
unzip -q $lua_release_name -d $lua_package_name

chmod +x "${lua_package_name}/extension/server/bin/${platform}/lua-language-server"

# Move folder to correct location
rm -rf $nvim_data_path/lua-language-server
mv $lua_package_name/extension/server $nvim_data_path/lua-language-server
rm -rf $lua_package_name $lua_release_name
echo "🌟 Lua server setup done!"
