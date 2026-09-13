#!/bin/bash

# Define a pasta de origem (onde estão os dotfiles)
DOTFILES_DIR="$HOME/.dotfiles/"

# Lista de arquivos/pastas para linkar
# Formato: "nome_no_dotfiles:caminho_no_home"
FILES=(
	"bashrc:.bashrc"
	"hyprland.lua:.config/hypr/hyprland.lua"
	"autostart.lua:.config/hypr/autostart.lua"
	"bindings.lua:.config/hypr/bindings.lua"
	"input.lua:.config/hypr/input.lua"
	"looknfeel.lua:.config/hypr/looknfeel.lua"
	"monitors.lua:.config/hypr/monitors.lua"
  "scripts/start_openrgb.sh:.config/hypr/scripts/start_openrgb.sh"
)

echo "?? Iniciando a instalação dos dotfiles..."

for item in "${FILES[@]}"; do
	# Separa o nome da origem e do destino
	SRC="${item%%:*}"
	DST="${item#*:}"

	FULL_SRC="$DOTFILES_DIR/$SRC"
	FULL_DST="$HOME/$DST"

	# Verifica se o arquivo na origem realmente existe
	if [ ! -e $FULL_SRC ]; then
		echo "AVISO: Fonte não encontrada, pulando: $SRC"
		continue
	fi

	# cria a pasta de destino caso ela não exista
	mkdir -p "$(dirname "$FULL_DST")"

	# Se já existir um arquivo ou link no destino
	if [ -e "$FULL_DST" ] || [ -L "$FULL_DST" ]; then
		# Se for apenas um link simbólico antigo, remove
		if [ -L "$FULL_DST" ]; then
			rm "$FULL_DST"
		else
			echo " Arquivo real já existe em $FULL_DST. Fazendo backup..."
			mv "$FULL_DST" "$FULL_DST.bak"

		fi
	fi

	# Cria link simbólico
	ln -s "$FULL_SRC" "$FULL_DST"
	echo "Link criado: $FULL_DST -> $FULL_SRC"
done

echo "Atualizando bashrc..."
source ~/.bashrc

echo "Atualizando Hyprland..."
hyprctl reload

echo "Instalação concluída!"
