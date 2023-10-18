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
echo "        ___         _         _        _ _      _   _           "
echo "       |   \ ___ __(_)_ _  __| |_ __ _| | |__ _| |_(_)___ _ _   "
echo "        | |) / -_|_-< | ' \(_-<  _/ _' | | / _' |  _| / _ \ ' \ "
echo "       |___/\___/__/_|_||_/__/\__\__,_|_|_\__,_|\__|_\___/_||_| "
echo "                                                                "

if [[ "$SUDO_PASSWD" == "" ]];then
  echo "❌ Saisissez votre mot de passe sudo dans la variable d'environnement 'SUDO_PASSWD'"
  exit 1;
fi

if [[ ! -f /bin/json2bash ]];then
  echo "❌ Json2Bash n'est pas installé."
  exit 0
fi

echo "$SUDO_PASSWD" | sudo -S rm -rf /bin/json2bash

echo "✅ Json2Bash à été desinstallé."
