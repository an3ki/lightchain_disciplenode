To Install a new disciple node on Ubuntu 18.04 please enter in the following as root

sudo wget https://raw.githubusercontent.com/an3ki/lightchain_disciplenode/master/lightchain.sh

chmod +x lightchain.sh

source lightchain.sh


Once Installed:

screen

./LightChaind --validate 5eb11dc9b3bd28f9487f18d8e8579d96 --enable-blockexplorer --enable-cors "*" --rpc-bind-ip 0.0.0.0


