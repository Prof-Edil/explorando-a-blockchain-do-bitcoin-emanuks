# Which public key signed input 0 in this tx:
#   `e5969add849689854ac7f28e45628b89f7454b83e9699e551ce14b6f90c86163`
RAW_TX=$(bitcoin-cli -rpcconnect=84.247.182.145:8332 -rpcuser=user_219 -rpcpassword=cDhUmFaszHEI getrawtransaction e5969add849689854ac7f28e45628b89f7454b83e9699e551ce14b6f90c86163)
TX_IN=$(bitcoin-cli -rpcconnect=84.247.182.145:8332 -rpcuser=user_219 -rpcpassword=cDhUmFaszHEI decoderawtransaction $RAW_TX | jq '.vin[0].txinwitness[2]')
echo "${TX_IN:5:66}"