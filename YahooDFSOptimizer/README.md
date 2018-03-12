README
================
Jake Johnson
March 12, 2018

Package Description / Intent
----------------------------

-This is not the original readme for OPER782 deliverable 1, just an add-on to clarify the purpose & meaning of the package

This package works by scraping data off of the website: <https://www.rotowire.com/daily/NBA/optimizer.php?site=Yahoo&sport=NBA> This website is one of few, if not the only, free Daily Fantasy Sports (DFS) site that publishes free fantasy scoring predictions. The focus of this package is to take these predictions (for Yahoo NBA DFS contests) and generate the ten best (optimal) line-ups for the given day's contests. While it can be seen that this website provides its own easy Optimal Lineup feature, this package offers more to the user because it is able to generate more than one optimal, or top lineup. This is a highly useful feature for DFS players as the ability to see the top lineups provides insights into which players are common in the best lineups. For example, it is possible that a certain player is not featured in the optimal lineup, but he may be present in the second best to tenth best lineups. Hence, a DFS user would have missed this insight by relying solely on the free Rotowire website optimizer and may have missed out on a winning component of building the best lineup for the day. Thus, this package aims to provide a free way for DFS players to gain insights into the best NBA players to enter into Yahoos Daily Fantasy contests. While other sites provide similar info, i.e. k-best line-ups, they often charge 20-50 dollars a month. Consequently, this package is a great tool for the casual DFS player who wants to take free NBA fantasy predictions and generate the top ten lineups (via a Binary IP solved in R) to help him/her create winning lineups in Yahoo contests. In addition, this package was a practice for the developer in using R to scrape data and perform (binary integer) linear program optimization.

INFO ON YAHOO DFS NBA GUIDELINES
--------------------------------

Yahoo NBA contests are sometimes free or cost up to $10,500 per entry. Players are required to pick one Point Guard (PG), one Shooting Guard (SG), one additional Guard (PG or SG), one Small Forward (SF), one Power Forward (PF), one additional forward (SF or PF), one Center (C), and finally one Utility player (Util) which is a player from any position. Each player can only be picked once and all 8 positions must be filled. There is a salary cap of always $200 to pick the 8 players. Each player costs between 10 and usually 60 dollars. Each contest runs daily and allows players to pick players from all NBA game slates on that given day. Prize money is awarded out to the top finishers according to the total fantasy points achieved with that line-up. Fantasy points are awarded according to the following values:

-   Points: 1
-   Rebounds: 1.2
-   Assists: 1.5
-   Steals: 3
-   Blocks: 3
-   Turnovers: -1

Prize money is paid out differently according to the different type of DFS contests (tournament,50-50,etc.) with Yahoo usually taking 10% of the winnings as a commission.
