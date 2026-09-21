#!/bin/bash

# Verificar se o openrgb já possui um processo ativo
if ! pgrep -x "openrgb" > /dev/null; then
  openrgb --startminimized --profile Perfil1
fi
