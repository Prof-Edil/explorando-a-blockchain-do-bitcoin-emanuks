# Create a 1-of-4 P2SH multisig address from the public keys in the four inputs of this tx:
#   `37d966a263350fe747f1c606b159987545844a493dd38d84b070027a895c4517`
RAW_TX=$(bitcoin-cli -rpcconnect=84.247.182.145 -rpcuser=user_219 -rpcpassword=cDhUmFaszHEI getrawtransaction 37d966a263350fe747f1c606b159987545844a493dd38d84b070027a895c4517)
TX_INS=$(bitcoin-cli -rpcconnect=84.247.182.145 -rpcuser=user_219 -rpcpassword=cDhUmFaszHEI decoderawtransaction $RAW_TX)

PUBKEY_0=$(echo $TX_INS | jq -r '.vin[0].txinwitness[1]')
PUBKEY_1=$(echo $TX_INS | jq -r '.vin[1].txinwitness[1]')
PUBKEY_2=$(echo $TX_INS | jq -r '.vin[2].txinwitness[1]')
PUBKEY_3=$(echo $TX_INS | jq -r '.vin[3].txinwitness[1]')

bitcoin-cli -rpcconnect=84.247.182.145 -rpcuser=user_219 -rpcpassword=cDhUmFaszHEI createmultisig 1 "[\"$PUBKEY_0\",\"$PUBKEY_1\",\"$PUBKEY_2\",\"$PUBKEY_3\"]" "p2sh-segwit" | jq -r .address