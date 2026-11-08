# ContentDNA mini (MG3012 Assignment 2)

**Student:** Zonaira (24I-5552), BS FinTech, FAST-NUCES Islamabad
**Course:** MG3012 Blockchain Technology for Business, Dr. Usama Arshad
**Network:** Sepolia testnet

## What is this?

A small dApp where a creator can register the fingerprint of a file on the blockchain, so there's a public record of who registered it first. It's a tiny version of the ContentDNA idea from my Assignment 1.

The file itself is never uploaded. The browser makes a SHA-256 hash of it and only that hash (plus a title, my wallet and the time) goes on-chain.

## Contract details

* **Contract address:** `0xCC62c17d570ab8cbd85c1cFFf3D34001054E5Bb8`
* **Etherscan:** https://sepolia.etherscan.io/address/0xCC62c17d570ab8cbd85c1cFFf3D34001054E5Bb8
* **GitHub repo:** PASTE\_YOUR\_REPO\_LINK\_HERE

### Functions

|Function|Type|What it does|
|-|-|-|
|`registerContent(fingerprint, title)`|write|Saves a new fingerprint with the sender as owner|
|`getContent(fingerprint)`|read|Returns owner, title and registration time|
|`isRegistered(fingerprint)`|read|true/false check|
|`transferOwnership(fingerprint, newOwner)`|write|Current owner hands it to another wallet|
|`totalRegistered()`|read|How many files are registered so far|

## Files

```
SmartContract.sol   the Solidity contract
index.html          the page (HTML + JavaScript with ethers.js)
style.css           styling
logo.svg            the image used on the page
screenshots/        deployment and UI screenshots
```

## How to run it

1. Install the MetaMask browser extension and switch it to the **Sepolia** network.
2. Get some free Sepolia test ETH from a faucet.
3. Open [Remix](https://remix.ethereum.org), create a file, and paste in `SmartContract.sol`.
4. Compile it (Solidity compiler tab, version 0.8.20 or newer).
5. In "Deploy \& run transactions", pick **Injected Provider - MetaMask**, then click Deploy and confirm in MetaMask.
6. Copy the deployed contract address.
7. Open `index.html` and replace `0xCC62c17d570ab8cbd85c1cFFf3D34001054E5Bb8` with that address.
8. Serve the folder locally. Opening the file by double-clicking can stop MetaMask from showing up, so use one of these:

   * VS Code: right click `index.html` and choose "Open with Live Server", or
   * Terminal: run `python -m http.server 8000` inside the folder and go to `http://localhost:8000`.
9. Click **Connect MetaMask**, choose a file, give it a title and click **Register this file**.

## Screenshots

1. `screenshots/1-deployment.png`: contract deployed in Remix
2. `screenshots/2-connected.png`: wallet connected on the page
3. `screenshots/3-transaction.png`: a successful registration with the transaction hash

## Things I learned

* A transaction (write) costs gas and needs a MetaMask confirmation, but reading data is free.
* Hashing a file in the browser means the actual work never has to be shared.
* Reverts like "Someone already registered this file" are how the contract protects itself, and ethers.js shows them as error messages.

