# Using descriptors, compute the taproot address at index 100 derived from this extended public key:
#   `xpub6Cx5tvq6nACSLJdra1A6WjqTo1SgeUZRFqsX5ysEtVBMwhCCRa4kfgFqaT2o1kwL3esB1PsYr3CUdfRZYfLHJunNWUABKftK2NjHUtzDms2`
XPUB="xpub6Cx5tvq6nACSLJdra1A6WjqTo1SgeUZRFqsX5ysEtVBMwhCCRa4kfgFqaT2o1kwL3esB1PsYr3CUdfRZYfLHJunNWUABKftK2NjHUtzDms2"
DESCRIPTOR=$(bitcoin-cli -rpcconnect=84.247.182.145:8332 -rpcuser=user_219 -rpcpassword=cDhUmFaszHEI getdescriptorinfo "tr($XPUB/100)" | jq -r ".descriptor")

TAPROOT_ADDRESS=$(bitcoin-cli -rpcconnect=84.247.182.145:8332 -rpcuser=user_219 -rpcpassword=cDhUmFaszHEI deriveaddresses "$DESCRIPTOR" | jq -r ".[0]")
echo $TAPROOT_ADDRESS