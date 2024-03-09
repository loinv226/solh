## Getting started

- Script helper to settup solana history rpc node

- To run node

```
./faithful-cli rpc -gsfa-only-signatures=true epoch-500.yml
./faithful-cli rpc --listen ":7999" epoch-500.yml
```

faithful-cli rpc --listen ":7998"

- To test rpc:
  epoch 558

```
curl http://localhost:7999/ \
 -X POST \
 -H "Content-Type: application/json" \
 --data '{"method": "getBlock","params": [241100100,{"encoding": "base64","maxSupportedTransactionVersion":0}]}'

 curl http://localhost:7999/ \
 -X POST \
 -H "Content-Type: application/json" \
 --data '{"method": "getSignaturesForAddress","params": ["675kPX9MHTjS2zt1qfr1NYHuzeLXfQM9H24wFSUt1Mp8",{"limit": 1, "before": "PbYRrMA5Q2b4Ng8UBoDyQWUyisHGVH1GZzikW4ZZi45ZZENBwy6cHjMmKUDngYVSVFG8nnKohLKzzQiMQHUjoRf", "encoding": "base64","maxSupportedTransactionVersion":0}]}'

 curl http://localhost:7999/ \
 -X POST \
 -H "Content-Type: application/json" \
 --data '{"method": "getTransaction","params": ["2o5xznMBeVYwosUCg4TfDn9Y74CN5uRxaDG3cSnqogJNHuL8X72MeJiDFSrY2HkdpjkmpxL6v92aWLZAdMKqZimK",{"encoding": "base64","maxSupportedTransactionVersion":0}]}'
```

curl http://localhost:8001/ \
 -X POST \
 -H "Content-Type: application/json" \
 --data '{"jsonrpc":"2.0","id":1, "method":"getFirstAvailableBlock"}'

curl http://localhost:7999/ \
 -X POST \
 -H "Content-Type: application/json" \
 --data '{"jsonrpc": "2.0","id": 1,"method": "getTransaction","params": ["vrEgKumCanxudULNQUjqkFiSwF37eT7T6Zmicu1F2HUrXM7bCCRDYZSzRY4toALSiNP3bSfsrtctsJ4JS8U3r5N",{"encoding": "base64","maxSupportedTransactionVersion":0}]}'
