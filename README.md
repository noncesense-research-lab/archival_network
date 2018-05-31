# Monero_AltBlock_Research
*Investigating the frequency of alternative blocks, reorganizations, and attempted or successful double-spend attacks.*

![Logo](/misc/mabr_logo.png)

## Goals
### Objective set 1: Data collection and archiving
There are currently no known resources that archive the content of orphaned blocks. Furthermore, the frequency of alternative blocks and reorganization is logged by some nodes, but not compiled or analyzed.

**If you run a Monero node, please consider contributing your logs pertaining to alternative blocks and reorgs.** Different nodes will receive different alternative blocks, and may undergo different reorganizations. Consequently, differences between your logs and others may provide important clues about network latency and topology.

If you run a node, you can extract the pertinent information from your records by running the single command:

`grep -B2 Hydrogen\|Wolfram\|Helium\|Lithium\|ALTERNATIVE\|REORG\|stopped\ successfully -E bitmonero.log* > output_log_to_share.txt`

*Note: grep is a command that searches for text in files, {Hydrogen, Wolfram, Helium, and Lithium} are Monero release names, and {"ALTERNATIVE" and "REORG"} search strings are used to extract the relevant events. The "> output_log_to_share.txt" stores the extracted log events in a file with that name. Feel free to change the output filename.*

Please upload the results here, anonymously if you so please, to strengthen analyses and expand our sample size. You can also email the file (<= 25 MB) to IsthmusCrypto@protonmail.com

### Objective set 2: Frequency analyses
Logs such as those produced by the above command contain the heights when alternative blocks are heard, and sometimes reorganized as the longest chain with consensus. Using this data, we can ask questions such as:
1. How frequent are multiple versions of the same block mined? (lower bound)
2. What fraction of these alternative blocks result in reorganization? (is this ratio constant for most nodes?)
3. Given logs from multiple nodes with overlapping times, how often do the records reflect alternative blocks heard by only some of the miners? (Do 99% of the miners receive 99% of the alternative blocks? 50%/50%?)
4. What does the homogeneity or heterogeneity of alternative block records suggest about the representativeness of the data set?
5. Are the observed intervals between alternative blocks explained by any particular function? A Poisson distribution has been suggested as the theoretical expectation. How well does the model match observations? What are the parameters of, and deviations from, the distribution function model?

### Objective set 3: Double-spend analysis
Logs that record the content of orphaned blocks can be used to ascertain whether a given alternative block was benign (e.g. arising from network latency) or maliciously presented (e.g. attempting a double-spend attack).

When two contradictory blocks naturally arise, transaction duplication is expected since both miners draw from the same memory pool. In the case that two miners independently mine the same transaction, the {ring members, key image, receiving stealth address} will be mirrored in the two blocks.

If two versions of a transaction are generated, they will have the same key image, but different one-time recipient stealth address, and different cryptographic signatures. This could occur benignly, if a user regenerates the transaction to the same address (creating a new one-time address in the process). It could also represent a transaction that is being revised to spend to a different recipient. If a double-spend attack is attempted (with or without majority, with or without success), the minier will necessarily have to include a transaction with the same key image, but a different receiving stealth address and signature. While this might happen occasionally due to wallets or users refreshing transactions, an alternative block with several redirected transactions strongly suggests an intentional attempted double-spend attack.

## Provocative Hypotheses
As the Devil’s advocate, I put forth two hypotheses:

H1) At least one solved block has been broadcast to the Monero network (whether accepted or rejected) that attempts to reassign previously-spent Moneroj to a new recipient stealth address.

H2) A block described as above has been broadcast and attained consensus, becoming the main chain.

## Speculation
*Notes from MPKT (extracted from casual correspondence):*

Both hypotheses could be proven by finding an example. Neither hypothesis is theoretically falsifiable; however, if we can attain the historical records of orphaned block transaction composition and prove that no H1 blocks were widely received, then both hypotheses can be reasonably rejected for practical intents and purposes. It would be good to prove OR confirm absence of evidence in the dataset.

While I doubt H2 is true, I think that H1 is not an outlandish proposition, especially considering the previous large unknown hashrate. By March & April, I’m sure that the multiple ASIC manufacturers were enforcing decentralization on each other; however, the *first* company with working ASICs may have had a window with some pretty decent power (do we know who was running ASICs in December & January before the February hashrate explosion?).

Honestly, if I was an ASIC manufacturer with enough in-house hash rate to noodle around and conduct mining research, I’d totally try solving a contradictory block or two to see what happens. The nature of selling cryptocurrency equipment would strongly disincentivize me from double-spending to rip of an external entity; however I might quietly try it with test transactions between my own wallets if I thought nobody was paying attention. Of course, H2 is unlikely to be true unless one entity had >51% hash. But H1 could be true even due to a minority player conducting some experiments.

Now that we tweaked PoW algo to kick the ASICS, this is a much less existential question. But I think it would still be good to archive this data moving forward, so that we are prepared for upcoming threats (rapid growth of a vast bontet? FPGA or some kind of ASICs 2.0? A 3-letter agency with a mining farm and an agenda? I suppose we’ll find out …)
