# RacerbilsEvolutionsProgram

## Opgaven
Byg et program til træning af en autonom virtuel racerbil, så den kan køre en omgang på kortest mulig tid.

Der var to versioner af opgaven:
-	Ekspert: Byg alt selv, med inspiration fra udleveret kode (se nedenstående).
-	Normal: Brug udleveret kode og byg selv den genetiske algoritme (anvend alt kode eller kun dele).

vi valgte at lave Normal
programmet vi startet ud med var:
https://github.com/digitaltdesignlyngby/RacerbilsEvolution


## vigtigste valg vedrørende den specifikke løsning

### valgene
I processen af den her opgave var vi meget besluttede på at vi ikke ville lege med source code for meget, da den allerede fungerede fint på de punkter vi ville have, og hvis der var noget der skulle ændres, var det kun få variabler eller metoder vi tilføjede. Så måtte vi heller ikke.
Ud fra dette, har det resulteret i at vi har en meget ren kode, der ikke er for fragmenteret. Hver del af koden har sin mening, som den bliver brugt til, og der opstår sjældent genbrug. Med dette menes der teknikker som blandt andet polymorfi. Det skal siges at vi taler om vores egen del af koden i dette tilfælde.

### hvordan koden fungere
- Rent tekniskt, foregår det ved at vi har en række biler der kører igennem banen, hvoraf de 10 hurtigste bliver valgt.
- De bliver alle sat i et børnebassin, som vi kalder det, og de parrer sig med hinanden til at lave den næste generation.
- Den nye generation bliver muteret før de kommer ud på banen  for så at køre igennem igen.
- Den nye generation bliver så sat på banen igen og så forsætter loppede
- Vis ikke der er nogle af dem der kom over målstregen kan bruger slev vælge at starte den forfra ellers ville der komme "indvandre" som ligner alle tidligere vinder og prøve at gennemføre banen

## Gennemgang af programmet visuelt


