# Only one single output remains unspent from block 123,321. What address was it sent to?
BLOCK_123321_HASH=$(bitcoin-cli -rpcconnect=84.247.182.145:8332 -rpcuser=user_219 -rpcpassword=cDhUmFaszHEI getblockhash 123321)
BLOCK_123321=$(bitcoin-cli -rpcconnect=84.247.182.145:8332 -rpcuser=user_219 -rpcpassword=cDhUmFaszHEI getblock $BLOCK_123321_HASH 2)
N_TXS=$(echo $BLOCK_123321 | jq '.nTx')
TXS=$(echo $BLOCK_123321 | jq '.tx')

SENT_ADDRESS="ADDRESS NOT FOUND"

for (( i=0; i<$N_TXS; i++))
do
  TX_ID=$(echo $TXS | jq -r ".[$i].txid")
  TX_OUTS=$(echo $TXS | jq -r ".[$i].vout")
  TX_OUTS_LENGTH=$(echo $TX_OUTS | jq '. | length')

  for (( y=0; y<$TX_OUTS_LENGTH; y++ ))
  do
    UTXO=$(bitcoin-cli -rpcconnect=84.247.182.145:8332 -rpcuser=user_219 -rpcpassword=cDhUmFaszHEI gettxout $TX_ID $y | jq -r ".scriptPubKey.address")

    if [ -n "$UTXO" ]; then
      SENT_ADDRESS=$(echo $UTXO)
      break
    fi
  done

  if [ "$SENT_ADDRESS" != "ADDRESS NOT FOUND" ]; then
    break
  fi
done

echo $SENT_ADDRESS