# ShareApp
### A ShareAPP Platform Based On Ethereum

The shareapp is a application that built on Ethereum. You can share anything if you want, and then you can query,rent and return the shared Object. Now we can see our function including create, display, query by id, rent and return the Object. More functions will be following.

In our testing program, we need two accounts. one for creator, the other is the renter. And we used geth and truffle.

The interface of Query by name and by id:
![image](https://github.com/asurily/ShareApp/blob/master/pngs/query.png)

The interface of Display:
![image](https://github.com/asurily/ShareApp/blob/master/pngs/list.png)

The interface of Creation:
![image](https://github.com/asurily/ShareApp/blob/master/pngs/create.png)

The interface of Rent:
![image](https://github.com/asurily/ShareApp/blob/master/pngs/rent.png)

The interface of Return:
![image](https://github.com/asurily/ShareApp/blob/master/pngs/return.png)

## Installation
We use geth client, so we need install some tools.
Go, Geth, Nodejs and Truffle

## Genesis block file
The first block in blockchain is called "genesis block", our example's genesis.json is:
```json
{
    "nonce": "0x0000000000000042",     "timestamp": "0x0",
    "parentHash": "0x0000000000000000000000000000000000000000000000000000000000000000",
    "extraData": "0x0",     "gasLimit": "0x8000000",     "difficulty": "0x400",
    "mixhash": "0x0000000000000000000000000000000000000000000000000000000000000000",
    "coinbase": "0x3333333333333333333333333333333333333333",     "alloc":
{
        "0x3177bf1a6ccf86ff6b945a9964fd7d88534b0fa9":
        { "balance": "20000000000000000000" }
}
}
```

## Private network
We run our program in our private network.
First, we need to generate genesis block:
```sh
> geth --datadir <your datadir> init <path/genesis.json>
```
your datadir is the path you want store your data, and path/genesis.json is the way to the file genesis.json.
Then, launch the Javascript Console:
```sh
> geth --identity "asurily" --rpc --rpccorsdomain "*" --datadir ~/etherTest --port "30303" --nodiscover --rpcapi "db,eth,net,web3" --networkid 1999 console 2>> ~/etherTest/geth.log
```
A nodeInfo of mine
```
enode: "enode://f9f52442f0bb637d1d6a6d72e3801aadfa38baf1bfb2f45c60348f8b2daddaaca10727c4944a5dd0ff2b6bcdd0528b906fe48a4b92a4476ea0872f1fce541ff8@[::]:30303?discport=0"
```

## Create your accounts
In our test program, we need two accounts. One for create the sharing Object, the other is the renter.
```sh
> personal.newAccount("123")
["0x3177bf1a6ccf86ff6b945a9964fd7d88534b0fa9"]
> personal.newAccount("123")
["0xa65bf431f4f07a22296dc93a7e6f4fe57642bee6"]
```
Now, we had created two accounts, the password were 123, just for example. By default, the first account is the coinbase, so now we can mine to get balances.
```sh
> miner.start()
```
## Run our application
We used truffle, so you first need to install truffle.
```sh
$ npm install -g truffle
```
Because we need some node_modules, so we first need to install these according to the package.json file, using this command:
```sh
$ npm install
```

Now, change directory into the application, open a terminal. Then depoly our contract into our private network(need mine):
```sh
$ truffle migrate --reset
```
And then, run our app.
```sh
$ npm run dev

> truffle-init-webpack@0.0.1 dev /home/hepu/Desktop/ethereum/ShareApp
> webpack-dev-server

Project is running at http://localhost:8080/
webpack output is served from /
Hash: 1ca9001233ce17a54582
Version: webpack 2.6.1
Time: 4061ms
     Asset     Size  Chunks                    Chunk Names
    app.js  1.37 MB       0  [emitted]  [big]  main
index.html  6.57 kB          [emitted]         
chunk    {0} app.js (main) 1.34 MB [entry] [rendered]
   [19] ./~/bignumber.js/bignumber.js 95.1 kB {0} [built]
   [82] ./~/web3/index.js 193 bytes {0} [built]
   [86] ./app/javascripts/app.js 10.9 kB {0} [built]
   [87] (webpack)-dev-server/client?http://localhost:8080 5.68 kB {0} [built]
   [88] ./build/contracts/ShareApp.json 13.4 kB {0} [built]
  [129] ./~/punycode/punycode.js 14.7 kB {0} [built]
  [132] ./~/querystring-es3/index.js 127 bytes {0} [built]
  [160] ./~/strip-ansi/index.js 161 bytes {0} [built]
  [163] ./app/stylesheets/app.css 905 bytes {0} [built]
  [170] ./~/truffle-contract/index.js 2.64 kB {0} [built]
  [205] ./~/url/url.js 23.3 kB {0} [built]
  [240] (webpack)-dev-server/client/overlay.js 3.73 kB {0} [built]
  [241] (webpack)-dev-server/client/socket.js 897 bytes {0} [built]
  [243] (webpack)/hot/emitter.js 77 bytes {0} [built]
  [245] multi (webpack)-dev-server/client?http://localhost:8080 ./app/javascripts/app.js 40 bytes {0} [built]
     + 231 hidden modules
webpack: Compiled successfully.
```
Finally, run localhost:8080 in our browser, we can use our app.
