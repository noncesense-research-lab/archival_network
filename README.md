# Monero_Archival_Project
*Investigating the frequency of alternative blocks, reorganizations, and attempted or successful double-spend attacks.*

![Logo](/misc/map_header.png)

## Goals
### Objective set 1: Data collection and archiving
There are currently no known resources that archive the content of orphaned blocks or side chains. The total absence of this data precludes analyses that are critical for monitoring the ecosystem and empirically studying mining and network phenomena. Since these types of records are not on the blockchain itself, they are lost to the sands of time unless intentionally preserved. MAP's central mission is to ensure that we are always collecting and analyzing this key information.

The Monero Archival Project employs a custom archival daemon (credit: [NeptuneResearch](https://github.com/neptuneresearch)) that collects data from orphaned blocks/chains along with notes from the node itself. Nodes are deloyed globally using virtual private servers (VPS) to capture a broader view of the network and enable representative analyses.

### Objective set 2: Side chain analyses
Analysis of MAP records allows us to answer several questions:
-  How frequently are multiple versions of the same block mined?
-  What fraction of these alternative blocks result in reorganization?
-  Are the observed intervals between alternative blocks explained by any particular function? A Poisson distribution has been suggested as the theoretical expectation. How well does the model match observations? What are the parameters of, and deviations from, the distribution function model?

Regarding the frequent long side chains (15-30 blocks, up to 70 blocks long):
-  Based on the timing of the blocks, how much hashrate is being used to mine them?
-  Does this hashrate come from external sources (e.g. R & D on FPGAs) or correspond with loss of hash power on the main chain?

### Objective set 3: Timing exploration
Miners can arbitrarily choose the timestamps that they include in the block, so MAP retains both the miner-reported timestamp (MRT) and the node-receipt timestamp (NRT).Comparison of the timestamps in the block against the timestamps when the block was received will reveal how often the miner-reported timestamps are spoofed.

Similarly, we can look for signs of [selfish mining](https://arxiv.org/pdf/1311.0243.pdf) based on the timing with which blocks are received. Ittay Eyal and Emin Gün Sirer [point out](http://hackingdistributed.com/2014/01/15/detecting-selfish-mining/) that "One could detect this [phenomenon] by looking at the timestamps on successive blocks in the blockchain. Since mining is essentially an independent random process, we'd expect the interblock time gap to be exponentially distributed. Any deviation from this expectation would be suggestive of selfish mining."

### Objective set 4: Network topology and study
Data from geographically-distributed MAP nodes can be used to study network connectivity and latency. With each new transaction or block broadcast, we can watch the the route(s) and speed with which it propogates across the globe.

### Objective set 5: Double-spend analyses
Logs that record the content of orphaned blocks can be used to ascertain whether a given alternative block was benign (e.g. arising from network latency) or maliciously presented (e.g. attempting a double-spend attack).

When two contradictory blocks naturally arise, transaction duplication is expected since both miners draw from the same memory pool. In the case that two miners independently mine the same transaction, the {ring members, key image, receiving stealth address} will be mirrored in the two blocks.

If two versions of a transaction are generated, they will have the same key image, but different one-time recipient stealth address, and different cryptographic signatures. This could occur benignly, if a user regenerates the transaction to the same address (creating a new one-time address in the process). It could also represent a transaction that is being revised to spend to a different recipient. If a double-spend attack is attempted (with or without majority, with or without success), the miner will necessarily have to include a transaction with the same key image, but a different receiving stealth address and signature. While this might happen occasionally due to wallets or users refreshing transactions, an alternative block with several redirected transactions strongly suggests an intentional attempted double-spend attack.

### Long-term goals:
We have several plans for making this type of data common and accessible.
-  Data presentation on a web dashboard that allows interactive exploration of MAP data products such as navigation of side chans, empirical analytics, and a global view of broadcast propogation.
-  Integration into main Monero code as an *opt-in* daemon setting for users that wish to collect archival data for R & D purposes.
-  While our archival daemon is coded for Monero, the analyses and framework are applicable to all similarly-structured blockchains. In the future, our network of archival node servers may also provide this service for other projects and cryptocurrencies.

## General notes:
The `documents` directory in this repository contains the roadmap, information for accessing our nodes, specifications, and miscellaneous notes.

The `analyses` directory includes some preliminary results.

The MAP project is a product of Noncesense Research Labs. Feel free to pop into NRL's front lobby on Freenode at #noncesense-research-lab. We look forward to your contributions and ideas.

## Request for data
**If you run a Monero node, please consider contributing your logs pertaining to alternative blocks and reorgs.** Different nodes will receive different alternative blocks, and may undergo different reorganizations. Consequently, differences between your logs and others may provide important clues about network latency and topology.

If you run a node, you can extract the pertinent information from your records by running the single command:

`grep -B2 Hydrogen\|Wolfram\|Helium\|Lithium\|ALTERNATIVE\|REORG\|stopped\ successfully -E bitmonero.log* > output_log_to_share.txt`

*Note: grep is a command that searches for text in files, {Hydrogen, Wolfram, Helium, and Lithium} are Monero release names, and {"ALTERNATIVE" and "REORG"} search strings are used to extract the relevant events. The "> output_log_to_share.txt" stores the extracted log events in a file with that name. Feel free to change the output filename.*

Additionally, the output of monerod's `--alt-chain-info` is quite informative, and very welcomed! Especially seeking this information from long-running nodes.

Please upload the results here, anonymously if you so please, to strengthen analyses and expand our sample size. You can also email the file (<= 25 MB) to IsthmusCrypto@protonmail.com

## Example data

There was a fork at height 1592780, and both sides have been archived

```
---alt-chain-info output

5 alternate chains found:
19 blocks long, from height 1578847 (13932 deep), diff 15046008135770616: 217bbfe0974a9ced9ff3b848f69f4bc871ac8323b6f67cf669b7ff011514d3e4
25 blocks long, from height 1565690 (27089 deep), diff 14333944572481961: 1ce9c7f554d0c9f4c709bb3c733803db6b9865a0b9237c2e60654751758de5c3
6 blocks long, from height 1587293 (5486 deep), diff 15469073606002084: b4bd6b85aed05b351b2a8f225910009711ffec35a8d944ea0a0901b12155514c
4 blocks long, from height 1589926 (2853 deep), diff 15593988238902517: 5294849d7c578227966a2fb5cb6a4155038464c57c5810d1820b27df826b2487
1 blocks long, from height 1591490 (1289 deep), diff 15668928217242122: 87c752cdeee4c9ba7aefc879ca1285e39563e1a5c752fc6d8d743a2be452812d
5 alternate chains found:
19 blocks long, from height 1578847 (13933 deep), diff 15046008135770616: 217bbfe0974a9ced9ff3b848f69f4bc871ac8323b6f67cf669b7ff011514d3e4
25 blocks long, from height 1565690 (27090 deep), diff 14333944572481961: 1ce9c7f554d0c9f4c709bb3c733803db6b9865a0b9237c2e60654751758de5c3
6 blocks long, from height 1587293 (5487 deep), diff 15469073606002084: b4bd6b85aed05b351b2a8f225910009711ffec35a8d944ea0a0901b12155514c
4 blocks long, from height 1589926 (2854 deep), diff 15593988238902517: 5294849d7c578227966a2fb5cb6a4155038464c57c5810d1820b27df826b2487
1 blocks long, from height 1591490 (1290 deep), diff 15668928217242122: 87c752cdeee4c9ba7aefc879ca1285e39563e1a5c752fc6d8d743a2be452812d
```
### First block at height 1592780
```
{
  "major_version": 7, 
  "minor_version": 7, 
  "timestamp": 1528736759, 
  "prev_id": "1d4db93917bc6bd16061bcfb638c7dccd8dfa5eb8972412aef421438798d15b3", 
  "nonce": 518482, 
  "miner_tx": {
    "version": 2, 
    "unlock_time": 1592840, 
    "vin": [ {
        "gen": {
          "height": 1592780
        }
      }
    ], 
    "vout": [ {
        "amount": 4534453164784, 
        "target": {
          "key": "4be69660f709234dad518051f5a6d56c01fe81e20afbadbfaa64f6059acfe23b"
        }
      }
    ], 
    "extra": [ 1, 201, 244, 41, 165, 3, 194, 90, 48, 85, 90, 71, 17, 186, 121, 100, 157, 19, 98, 96, 224, 50, 23, 102, 183, 113, 12, 19, 105, 36, 119, 25, 85, 2, 8, 0, 0, 3, 173, 20, 1, 0, 0
    ], 
    "rct_signatures": {
      "type": 0
    }
  }, 
  "tx_hashes": [ "dd6c105d72656e6f9b027a5d0cff9f571c4c8ed75e63509906eabb4dca76ce63", "83b49efb4f5c7938393821bd647c99e9895f20e5e49595ea8a7ed15eb6bc0898", "a37cbcf9fb9a548af32762830890766b4c3126b48a122edb780906a72ff8a03d", "e4bcb887cf6619de9572db3adc2b4fa2ad23b56b7ba11806c08fc3fc88e658dc", "84ef89e6bdb56e63588905142835b371623be4eb6845826ac21c423034dd026f", "fc9f8dfb619a90ea4c755028258315339452979ab056235d8bcfe626cf346084", "f26fd8b663e085040cc65c8c0e8f56238235243c631791b07d2986d0e50f3156", "1083ff3b9b67a193cc2c47b251c8b3facc47e77932d4e1d39c631d7f01fabfc5", "f2db3f41623110dfd17c2ff67c01dfcd2e040cae6269e6fcef11976b467f92d2", "689739ded0aef480c8b149e126aa84685a0eceaa624db9044d0382c07395a86b", "ed1b9d15303f84fc16e0e4b7454bed759390c47634faaae6e87387d2b2a04fa9", "888a91550442d06288c2778e6ce67ed1d392fc451d4c1783c5a2a27a89265d17", "0a37ac74ec6751441b3a364c443c1519f961e79d92f92cfd2588cf5a309bd6a1", "010855970bee8a4e24bb462bf5df62c8fe53c9a3aafa04c0dfdd7f36c6d647d7", "655b211fa826a0035637a6cb637abb3cc7d321c40ceaa21d6aff472745e5ea5c"
  ]
}
```
### Alternative block at height 1592780

```
{
  "major_version": 7, 
  "minor_version": 7, 
  "timestamp": 1528736759, 
  "prev_id": "1d4db93917bc6bd16061bcfb638c7dccd8dfa5eb8972412aef421438798d15b3", 
  "nonce": 699007682, 
  "miner_tx": {
    "version": 2, 
    "unlock_time": 1592840, 
    "vin": [ {
        "gen": {
          "height": 1592780
        }
      }
    ], 
    "vout": [ {
        "amount": 4534453164784, 
        "target": {
          "key": "85b4261a79211cb9c1f69cf16ee2832c2ae8ef4d626644a77918b3a1ff6359de"
        }
      }
    ], 
    "extra": [ 1, 121, 206, 76, 251, 36, 153, 28, 209, 147, 253, 221, 39, 132, 163, 152, 94, 212, 35, 113, 152, 0, 254, 192, 94, 139, 21, 75, 25, 141, 73, 34, 180, 2, 17, 0, 0, 1, 188, 101, 203, 84, 173, 0, 0, 0, 0, 0, 0, 0, 0, 0
    ], 
    "rct_signatures": {
      "type": 0
    }
  }, 
  "tx_hashes": [ "dd6c105d72656e6f9b027a5d0cff9f571c4c8ed75e63509906eabb4dca76ce63", "83b49efb4f5c7938393821bd647c99e9895f20e5e49595ea8a7ed15eb6bc0898", "a37cbcf9fb9a548af32762830890766b4c3126b48a122edb780906a72ff8a03d", "e4bcb887cf6619de9572db3adc2b4fa2ad23b56b7ba11806c08fc3fc88e658dc", "84ef89e6bdb56e63588905142835b371623be4eb6845826ac21c423034dd026f", "fc9f8dfb619a90ea4c755028258315339452979ab056235d8bcfe626cf346084", "f26fd8b663e085040cc65c8c0e8f56238235243c631791b07d2986d0e50f3156", "1083ff3b9b67a193cc2c47b251c8b3facc47e77932d4e1d39c631d7f01fabfc5", "f2db3f41623110dfd17c2ff67c01dfcd2e040cae6269e6fcef11976b467f92d2", "689739ded0aef480c8b149e126aa84685a0eceaa624db9044d0382c07395a86b", "ed1b9d15303f84fc16e0e4b7454bed759390c47634faaae6e87387d2b2a04fa9", "888a91550442d06288c2778e6ce67ed1d392fc451d4c1783c5a2a27a89265d17", "0a37ac74ec6751441b3a364c443c1519f961e79d92f92cfd2588cf5a309bd6a1", "010855970bee8a4e24bb462bf5df62c8fe53c9a3aafa04c0dfdd7f36c6d647d7", "655b211fa826a0035637a6cb637abb3cc7d321c40ceaa21d6aff472745e5ea5c"
  ]
}
```
Since the transaction hashes match between the two blocks, no transactions were re-routed. Thus we can infer that this was an accident, and not a double-spend attack. 
