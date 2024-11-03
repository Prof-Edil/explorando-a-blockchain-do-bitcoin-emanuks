# Which tx in block 257,343 spends the coinbase output of block 256,128?
BLOCK_256128_HASH=$(bitcoin-cli -rpcconnect=84.247.182.145:8332 -rpcuser=user_219 -rpcpassword=cDhUmFaszHEI getblockhash 256128)
COINBASE_TX_ID=$(bitcoin-cli -rpcconnect=84.247.182.145:8332 -rpcuser=user_219 -rpcpassword=cDhUmFaszHEI getblock $BLOCK_256128_HASH | jq -r '.tx[0]')

BLOCK_257343_HASH=$(bitcoin-cli -rpcconnect=84.247.182.145:8332 -rpcuser=user_219 -rpcpassword=cDhUmFaszHEI getblockhash 257343)
BLOCK_257343=$(bitcoin-cli -rpcconnect=84.247.182.145:8332 -rpcuser=user_219 -rpcpassword=cDhUmFaszHEI getblock $BLOCK_257343_HASH 2)
N_TXS=$(echo $BLOCK_257343 | jq -r '.nTx')

TX_ID="TX NOT FOUND"

for (( i=1; i<$N_TXS; i++))
do
  TX_INS=$(echo $BLOCK_257343 | jq -r ".tx[$i].vin")
  TX_INS_LENGTH=$(echo $TX_INS | jq '. | length')

  for (( y=0; y<$TX_INS_LENGTH; y++))
  do
    TX_IN=$(echo $TX_INS | jq -r ".[$y].txid")
    
    if [ "$TX_IN" == "$COINBASE_TX_ID" ]; then
      TX_ID=$(echo $BLOCK_257343 | jq -r ".tx[$i].txid")
      break
    fi
  done

  if [ "$TX_ID" != "TX NOT FOUND" ]; then
    break
  fi
done

echo $TX_ID