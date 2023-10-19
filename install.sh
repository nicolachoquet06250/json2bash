#!/bin/bash

echo "    /\$\$\$\$\$                                /\$\$\$\$\$\$  /\$\$\$\$\$\$\$                      /\$\$      "
echo "   |__  \$\$                               /\$\$__  \$\$| \$\$__  \$\$                    | \$\$      "
echo "      | \$\$  /\$\$\$\$\$\$\$  /\$\$\$\$\$\$  /\$\$\$\$\$\$\$ |__/  \ \$\$| \$\$  \ \$\$  /\$\$\$\$\$\$   /\$\$\$\$\$\$\$| \$\$\$\$\$\$\$ "
echo "      | \$\$ /\$\$_____/ /\$\$__  \$\$| \$\$__  \$\$  /\$\$\$\$\$\$/| \$\$\$\$\$\$\$  |____  \$\$ /\$\$_____/| \$\$__  \$\$"
echo " /\$\$  | \$\$|  \$\$\$\$\$\$ | \$\$  \ \$\$| \$\$  \ \$\$ /\$\$____/ | \$\$__  \$\$  /\$\$\$\$\$\$\$|  \$\$\$\$\$\$ | \$\$  \ \$\$"
echo "| \$\$  | \$\$ \____  \$\$| \$\$  | \$\$| \$\$  | \$\$| \$\$      | \$\$  \ \$\$ /\$\$__  \$\$ \____  \$\$| \$\$  | \$\$"
echo "|  \$\$\$\$\$\$/ /\$\$\$\$\$\$\$/|  \$\$\$\$\$\$/| \$\$  | \$\$| \$\$\$\$\$\$\$\$| \$\$\$\$\$\$\$/|  \$\$\$\$\$\$\$ /\$\$\$\$\$\$\$/| \$\$  | \$\$"
echo " \______/ |_______/  \______/ |__/  |__/|________/|_______/  \_______/|_______/ |__/  |__/"
echo "                                                                                    "
echo "        ___         _        _ _      _   _          "
echo "       |_ _|_ _  __| |_ __ _| | |__ _| |_(_)___ _ _  "
echo "        | || ' \(_-<  _/ _' | | / _' |  _| / _ \ ' \ "
echo "       |___|_||_/__/\__\__,_|_|_\__,_|\__|_\___/_||_|"
echo "                                                     "

if [[ "$SUDO_PASSWD" == "" ]];then
  echo "❌ Saisissez votre mot de passe sudo dans la variable d'environnement 'SUDO_PASSWD'"
  return ;
fi

if [[ -f /bin/json2bash ]];then
  echo "❌ Json2Bash à déjà été installé."
  return
fi

path="$(pwd)/json2bash"
if [[ -d "${path}" ]] && [[ -f "${path}/json2bash" ]];then
  path="${path}/json2bash"
fi

potential_errors="$(echo "$SUDO_PASSWD" | sudo -S ln -s "${path}" /bin/json2bash 2>&1)"

if [[ "${potential_errors}" == "" ]];then
  echo "✅ Json2Bash à été installé dans le répertoire /bin"
  echo "➡️ Vous pouvez utiliser le le logiciel comme ceci :"
  echo "  • json2bash -json=\"content json\""
  echo "  • json2bash -json \"content json\""
  echo "  • json2bash -json=\"url du fichier json\""
  echo "  • json2bash -json \"url du fichier json\""
  echo "  • json2bash -json=\"chemin local du fichier json via le protocol file://\""
  echo "  • json2bash -json \"chemin local du fichier json via le protocol file://\""
else
  echo "❌ Json2Bash à déjà été installé."
fi

