# How many new outputs were created by block 123,456?
bitcoin-cli -rpcconnect=84.247.182.145:8332 -rpcuser=user_219 -rpcpassword=cDhUmFaszHEI getblockstats 123456 | jq '.outs'