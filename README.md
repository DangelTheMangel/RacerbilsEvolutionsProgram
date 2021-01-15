# RacerbilsEvolutionsProgram
Byg et program til træning af en autonom virtuel racerbil, så den kan køre en omgang på kortest mulig tid.
OPGAVE
Opgaven kan laves i grupper på maksimalt 2 personer. Vælg en af disse to varianter: 
●	Ekspert: Byg alt selv, med inspiration fra udleveret kode (se nedenstående).
●	Normal: Brug udleveret kode og byg selv den genetiske algoritme (anvend alt kode eller kun dele).
TEORI
Racerbilen skal styres af et neuralt netværk, og netværket skal optimeres af en genetisk algoritme.
Metoden kaldes Neuro Evolution. 
●	Kernestof: Opbygning af simple Neurale Netværk & Anvendelse af Neuro Evolution
●	Materiale: Bogen “Nature of Code”, kapitel 9 og kapitel 10.
●	Videoer: “Om  Racerbil Evolution” og  “Gennemgang af udleveret kode”
UDLEVERET PROGRAM
Link til repo: https://github.com/digitaltdesignlyngby/RacerbilsEvolution
Programmet laver 100 autonome racerbiler med “tilfældige” hjerner, der kører rundt på en sort racerbane tegnet i Paint. 
De autonome racerbils-objekter, består af en bil, et sensorsystem og en hjerne.
Bilen har en konstant hastighed på 5 pixels/frame og ændrer retning ved at rotere om sin egen akse. 
Hjernen er et neuralt netværk, der via tre input signaler bestemmer rotationsvinklen. De tre input stammer fra tre farvesensorer, der kan detektere farven hvid, som kun ses uden for banen.  
Sensorsystemet indsamler også anden data, end den, der bruges til at styre bilen nemlig:  
- Hvor mange frames bilen befinder sig i den hvide rabat,
- hvor mange frames bilen kører i den forkerte retning og 
- hvor hurtigt den kører en omgang. 
Disse data kan anvendes til at bygge den ønskede genetiske algoritme!
Vigtigt:  Man må ændre både bevægelse, typen af sensorer, banen og selve hjernen. Men det kræver godkendelse! 
AFLEVERING OG VURDERING
Link til gitHub repo.
Readme, der forklarer vigtigste valg vedrørende jeres specifikke løsning.
Brugerfladen skal være informativ - således applikationens formål kan forstås uden forklaring.


# Den del af readme der forklarer "vigtigste valg vedrørende jeres specifikke løsning."

I processen af den her opgave var vi meget besluttede på at vi ikke ville lege med source code for meget, da den allerede fungerede fint på de punkter vi ville have, og hvis der var noget der skulle ændres, var det kun få variabler eller metoder vi tilføjede. Så måtte vi heller ikke.
Ud fra dette, har det resulteret i at vi har en meget ren kode, der ikke er for fragmenteret. Hver del af koden har sin mening, som den bliver brugt til, og der opstår sjældent genbrug. Med dette menes der teknikker som blandt andet polymorfi. Det skal siges at vi taler om vores egen del af koden i dette tilfælde.

- Rent tekniskt, foregår det ved at vi har en række biler der kører igennem banen, hvoraf de 10 hurtigste bliver valgt.
- De bliver alle sat i et børnebassin, som vi kalder det, og de parrer sig med hinanden til at lave den næste generation.
- Den nye generation bliver muteret før de kommer ud på banen  for så at køre igennem igen.
- I den første generation, hvis der ikke er nogen der kommer over målstregen, vælger vi dem der kom længst.
