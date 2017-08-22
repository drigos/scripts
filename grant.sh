#!/bin/bash

DIR=${1:-/var/www}
USER=${2:-www-data}
GROUP=${3:-${USER}}

# Altera o dono e grupo dos arquivos e diretório recursivamente
chown -R ${USER}:${GROUP} ${DIR}
# Altera a permissão dos arquivos para leitura/escrita para dono/grupo
find ${DIR} -type f -exec chmod 660 {} +
# Altera a permissão dos diretórios para leitura/escrita/execução para dono/grupo
# Arquivos e diretórios criados assumem o grupo do diretório pai em vez de grupo do usuário
find ${DIR} -type d -exec chmod 2770 {} +

# Arquivos e diretórios são criados com permissão máxima para o grupo em vez da mascára padrão
setfacl -R -d -m group:${GROUP}:rwx ${DIR}
