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

##################
## LSP Setup
##################

# Make sure LSP path exists
nvim_data_path="${HOME}/.local/share/nvim/lsp"
mkdir -p $nvim_data_path

# Golang
#GOPATH=$(pwd) GOBIN=$(pwd) GO111MODULE=on go get -v golang.org/x/tools/gopls
#GOPATH=$(pwd) GO111MODULE=on go clean -modcache
#echo "🌟 Gopls server setup done!"

# Dockerfile
npm install -g dockerfile-language-server-nodejs@latest && echo "🌟 Dockerfile server setup done!"

# Bash
npm install -g bash-language-server@latest && echo "🌟 Bash language server setup done!"

# Pyright
npm install -g pyright@latest && echo "🌟 Pyright server setup done!"

# Lua
lua_setup() {
	lua_release=$(openssl rand -hex 12)
	lua_release_archive="${lua_release}.zip"
	lua_server_install_location="${nvim_data_path}/lua-language-server"

	# Download, extract and move archive to correct location
	curl -L --silent -o $lua_release_archive $(curl --silent -H "Accept: application/vnd.github.v3+json" https://api.github.com/repos/sumneko/vscode-lua/releases/latest | grep 'browser_' | cut -d\" -f4)
	unzip -q $lua_release_archive -d $lua_release
	rm -rf $lua_server_install_location
	mv $lua_release/extension/server $lua_server_install_location
	rm -rf $lua_release $lua_release_archive

	chmod +x "${lua_server_install_location}/bin/${platform}/lua-language-server"
}
lua_setup && echo "🌟 Lua server setup done!"
