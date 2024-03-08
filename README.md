## Getting started

- Script helper to settup solana history rpc node

- To run node

```
./faithful-cli rpc -gsfa-only-signatures=true epoch-500.yml
./faithful-cli rpc --listen ":7999" epoch-500.yml
```

- To test rpc:

```
curl http://localhost:7999/ \
 -X POST \
 -H "Content-Type: application/json" \
 --data '{"method": "getBlock","params": [216000100,{"encoding": "base64","maxSupportedTransactionVersion":0}]}'
```
