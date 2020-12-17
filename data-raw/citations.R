library(tidyverse)

tribble(
  ~data_function, ~citation,
  '{peacesciencer}', 'Miller, Steven V. 2020. "peacesciencer: Tools and Data for Quantitative Peace Science". R package version 0.1',
  'alliances (CoW)', 'Gibler, Douglas M. 2009. International Military Alliances, 1648-2008. Congressional Quarterly Press.',
  'capabilities', 'Singer, J. David, Stuart Bremer, and John Stuckey. (1972). "Capability Distribution, Uncertainty, and Major Power War, 1820-1965." in Bruce Russett (ed) Peace, War, and Numbers, Beverly Hills: Sage, 19-48.',
  'capabilities','Singer, J. David. 1987. "Reconstructing the Correlates of War Dataset on Material Capabilities of States, 1816-1985" International Interactions, 14: 115-32.',
  'capitals', 'Miller, Steven V. 2020. "peacesciencer: Tools and Data for Quantitative Peace Science". R package version 0.1',
  'contiguity', 'Stinnett, Douglas M., Jaroslav Tir, Philip Schafer, Paul F. Diehl, and Charles Gochman (2002). "The Correlates of War Project Direct Contiguity Data, Version 3." Conflict Management and Peace Science 19 (2):58-66.',
  'democracy (V-dem)', 'Coppedge, Michael, John Gerring, Carl Henrik Knutsen, Staffan I. Lindberg, Jan Teorell, David Altman, Michael Bernhard, M. Steven Fish, Adam Glynn, Allen Hicken, Anna Luhrmann, Kyle L. Marquardt, Kelly McMann, Pamela Paxton, Daniel Pemstein, Brigitte Seim, Rachel Sigman, Svend-Erik Skaaning, Jeffrey Staton, Agnes Cornell, Lisa Gastaldi, Haakon Gjerløw, Valeriya Mechkova, Johannes von Römer, Aksel Sundtröm, Eitan Tzelgov, Luca Uberti, Yi-ting Wang, Tore Wig, and Daniel Ziblatt. 2020. ”V-Dem Codebook v10” Varieties of Democracy (V-Dem) Project.',
  'democracy (Polity)', 'Marshall, Monty G., Ted Robert Gurr, and Keith Jaggers. 2017. "Polity IV Project: Political Regime Characteristics and Transitions, 1800-2017." Center for Systemic Peace.',
  'democracy (Marquez-QuickUDS)', 'Marquez, Xavier, "A Quick Method for Extending the Unified Democracy Scores" (March 23, 2016). http://dx.doi.org/10.2139/ssrn.2753830',
  'democracy (Marquez-QuickUDS)', 'Pemstein, Daniel, Stephen Meserve, and James Melton. 2010. Democratic Compromise: A Latent Variable Analysis of Ten Measures of Regime Type. Political Analysis 18 (4): 426-449.',
  'disputes (GML-MIDs)', 'Gibler, Douglas M., Steven V. Miller, and Erin K. Little. 2016. "An Analysis of the Militarized Interstate Dispute (MID) Dataset, 1816-2001." International Studies Quarterly 60(4): 719-730.',
  "IGOs (CoW)", 'Pevehouse, Jon C.W., Timothy Nordstron, Roseanne W McManus, Anne Spencer Jamison, “Tracking Organizations in the World: The Correlates of War IGO Version 3.0 datasets”, Journal of Peace Research 57(3): 492-503.',
  "IGOs (CoW)", 'Wallace, Michael, and J. David Singer. 1970. "International Governmental Organization in the Global System, 1815-1964." International Organization 24: 239-87.',
  "Maoz' Regional/Global Power Data", 'Maoz, Zeev. 2010. Network of Nations: The Evolution, Structure, and Impact of International Networks, 1816-2001. Cambridge University Press.',
  'politically relevant dyads', 'Weede, Erich. 1976. "Overwhelming preponderance as a pacifying condition among contiguous Asian dyads." Journal of Conflict Resolution 20: 395-411.',
  'politically relevant dyads', 'Lemke, Douglas and William Reed. 2001. "The Relevance of Politically Relevant Dyads." Journal of Conflict Resolution 45(1): 126-144.',
  'states (CoW)','Correlates of War Project. 2017. "State System Membership List, v2016." Online, https://correlatesofwar.org/data-sets/state-system-membership',
  'states (GW)', 'Gleditsch, Kristian S. and Michael D. Ward. 1999. "A Revised List of Independent States since the Congress of Vienna" 25(4): 393--413'
) -> citations


save(citations, file="data/citations.rda")
