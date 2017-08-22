#!/bin/bash

usage () {
  echo "Usage : ${0} <options>"
  echo "Options:"
  echo "    -h  --help         Exibe este menu de ajuda"
  echo "    -c  --css          Adiciona arquivo de CSS personalizado"
  echo "    -f  --favicon      Adiciona favicon (ícone na barra de título do navegador)"
  echo "    -j  --js           Adiciona arquivo de JavaScript personalizado"
  echo "    -b  --bootstrap    Adiciona folha de estilo do bootstrap"
  echo "    -a  --fontawesome  Adiciona folha de estilo do font-awesome"
  echo "    -s  --semantic     Adiciona todas tags semânticas estilizada com bootstrap"
  echo "    -n  --nav          Adiciona tag semântica nav estilizada com bootstrap"
  echo "    -m  --main         Adiciona tag semântica main estilizada com bootstrap"
  echo "    -t  --footer       Adiciona tag semântica footer estilizada com bootstrap"
  echo "    -q  --jquery       Adiciona script do jQuery"
  exit
}

# Parsing de argumentos

OPTIONS=$(getopt -o hcfjbasnmtq --long help,css,favicon,js,bootstrap,fontawesome,semantic,nav,main,footer,jquery -- "$@")
eval set -- "${OPTIONS}"

while [ $# -gt 0 ]
do
   case "${1}" in
      -h | --help ) usage; shift ;;
      -c | --css ) BOOL_CSS=true; shift ;;
      -f | --favicon ) BOOL_FAVICON=true; shift ;;
      -j | --js ) BOOL_JAVASCRIPT=true; shift ;;
      -b | --bootstrap ) BOOL_BOOTSTRAP=true; shift ;;
      -a | --fontawesome ) BOOL_FONTAWESOME=true; shift ;;
      -s | --semantic ) BOOL_BOOTSTRAP_SEMANTIC=true; shift ;;
      -n | --nav ) BOOL_BOOTSTRAP_NAV=true; shift ;;
      -m | --main ) BOOL_BOOTSTRAP_MAIN=true; shift ;;
      -t | --footer ) BOOL_BOOTSTRAP_FOOTER=true; shift ;;
      -q | --jquery ) BOOL_JQUERY=true; shift ;;
      -- ) shift; break ;;
      * ) break ;;
   esac
done

# Variáveis com conteúdo do HTML

DOCTYPE_HTML5='<!DOCTYPE html>'
HTML_BEGIN='<html lang="en">'
HEAD_BEGIN='<head>\n    <meta charset="UTF-8" />'
BOOTSTRAP='    <link rel="stylesheet" type="text/css" media="screen" href="css/bootstrap.min.css" />'
FONTAWESOME='    <link rel="stylesheet" type="text/css" media="screen" href="css/font-awesome.min.css" />'
CSS='    <link rel="stylesheet" type="text/css" media="screen" href="css/main.css" />'
FAVICON='    <link rel="shortcut icon" type="image/png" href="images/favicon.png" />'
HEAD_END='    <title>Title</title>\n</head>'
BODY_BEGIN='<body>'
BOOTSTRAP_NAV='
    <nav class="navbar navbar-default navbar-static-top text-center">
        <a href="/">
            <img src="images/logotype.png" />
        </a>
    </nav>'
BOOTSTRAP_MAIN='
    <main class="container">
        <!-- Content here... -->
    </main>'
BOOTSTRAP_FOOTER='
    <footer class="footer container text-center">
        <img src="glyph.png" />
        © Title 2017
        <img src="images/glyph.png" />
    </footer>'
BOOTSTRAP_SEMANTIC="${BOOTSTRAP_NAV}${BOOTSTRAP_MAIN}${BOOTSTRAP_FOOTER}"
JQUERY='    <script src="js/jquery.min.js"></script>'
JAVASCRIPT='    <script src="js/main.js"></script>'
BODY_END='</body>'
HTML_END='</html>'

# Criação do arquivo

TEMPLATE="${DOCTYPE_HTML5}\n${HTML_BEGIN}\n${HEAD_BEGIN}"
[ "$BOOL_BOOTSTRAP" == "true" ] && TEMPLATE="${TEMPLATE}\n${BOOTSTRAP}"
[ "$BOOL_FONTAWESOME" == "true" ] && TEMPLATE="${TEMPLATE}\n${FONTAWESOME}"
[ "$BOOL_CSS" == "true" ] && TEMPLATE="${TEMPLATE}\n${CSS}"
[ "$BOOL_FAVICON" == "true" ] && TEMPLATE="${TEMPLATE}\n${FAVICON}"
TEMPLATE="${TEMPLATE}\n${HEAD_END}\n${BODY_BEGIN}"
[ "$BOOL_BOOTSTRAP_SEMANTIC" == "true" ] && {
    TEMPLATE="${TEMPLATE}${BOOTSTRAP_SEMANTIC}"
} || {
    [ "$BOOL_BOOTSTRAP_NAV" == "true" ] && TEMPLATE="${TEMPLATE}${BOOTSTRAP_NAV}"
    [ "$BOOL_BOOTSTRAP_MAIN" == "true" ] && TEMPLATE="${TEMPLATE}${BOOTSTRAP_MAIN}"
    [ "$BOOL_BOOTSTRAP_FOOTER" == "true" ] && TEMPLATE="${TEMPLATE}${BOOTSTRAP_FOOTER}"
}
[ "$BOOL_JQUERY" == "true" ] && TEMPLATE="${TEMPLATE}\n${JQUERY}"
[ "$BOOL_JAVASCRIPT" == "true" ] && TEMPLATE="${TEMPLATE}\n${JAVASCRIPT}"
TEMPLATE="${TEMPLATE}\n${BODY_END}\n${HTML_END}"

echo -e "${TEMPLATE}"
