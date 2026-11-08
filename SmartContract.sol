// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/*
    ContentDNA (mini version)
    MG3012 - Assignment 2
    Zonaira, 24I-5552

    The idea (same as my Assignment 1, just much smaller):
    a creator takes a file (art, a reel, a crochet pattern pdf, whatever),
    the website turns it into a SHA-256 fingerprint, and this contract stores
    that fingerprint with the creator's wallet and the time. So later, if
    someone copies the work, there's a public record of who registered it first.

    Only the fingerprint goes on-chain, never the file itself.
*/

contract ContentDNA {

    struct Entry {
        address creator;      // whoever owns this fingerprint right now
        string title;         // a human-readable name, e.g. "Sunset crochet bag"
        uint256 registeredAt; // block timestamp
    }

    // fingerprint -> entry. private because people should use getContent() below
    mapping(bytes32 => Entry) private entries;

    // public, so Solidity makes a free read function for it automatically
    uint256 public totalRegistered;

    event ContentRegistered(bytes32 indexed fingerprint, address indexed creator, string title);
    event OwnershipTransferred(bytes32 indexed fingerprint, address indexed from, address indexed to);

    // ---------- WRITE: register a new fingerprint ----------
    function registerContent(bytes32 fingerprint, string memory title) public {
        require(entries[fingerprint].creator == address(0), "Someone already registered this file");
        require(bytes(title).length > 0, "Please give it a title");

        entries[fingerprint] = Entry(msg.sender, title, block.timestamp);
        totalRegistered++;

        emit ContentRegistered(fingerprint, msg.sender, title);
    }

    // ---------- READ: get the details of a registered fingerprint ----------
    function getContent(bytes32 fingerprint)
        public
        view
        returns (address creator, string memory title, uint256 registeredAt)
    {
        Entry memory e = entries[fingerprint];
        require(e.creator != address(0), "This file is not registered");
        return (e.creator, e.title, e.registeredAt);
    }

    // ---------- READ: quick yes/no check ----------
    function isRegistered(bytes32 fingerprint) public view returns (bool) {
        return entries[fingerprint].creator != address(0);
    }

    // ---------- WRITE: hand the ownership to another wallet ----------
    function transferOwnership(bytes32 fingerprint, address newOwner) public {
        require(entries[fingerprint].creator == msg.sender, "Only the current owner can transfer this");
        require(newOwner != address(0), "New owner can't be the zero address");

        entries[fingerprint].creator = newOwner;

        emit OwnershipTransferred(fingerprint, msg.sender, newOwner);
    }
}
