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

![Test Image 4](https://github.com/DangelTheMangel/RacerbilsEvolutionsProgram/blob/main/Pictures/Graphs/HowItWorks.JPG)

Her har vi prøvet at vise det visuelt

## Gennemgang af programmet visuelt
#### screenshot fra progreammet
Programmet når man starter det:
![Test Image 5](https://github.com/DangelTheMangel/RacerbilsEvolutionsProgram/blob/main/Pictures/ScreenShots/start.JPG)

Programmet når man har nok data til at lave en graf og til at vise generation på punkterne:
![Test Image 5](https://github.com/DangelTheMangel/RacerbilsEvolutionsProgram/blob/main/Pictures/ScreenShots/aftersomtime1.JPG)

Programmet når man har nok data til at lave en graf og ikke plads til at vise generation:
![Test Image 5](https://github.com/DangelTheMangel/RacerbilsEvolutionsProgram/blob/main/Pictures/ScreenShots/aftersometime2.JPG)

Programmet når man har for meget data at vise på grafen:
![Test Image 5](https://github.com/DangelTheMangel/RacerbilsEvolutionsProgram/blob/main/Pictures/ScreenShots/tid.JPG)


#### i bunden er der 4 knapper 
- **Retry generation**
Denne knap starter generation forfra som du er på

- **Change track ...**
Denne knap kan du  ændre banen ved at skrifte billede. vis du har windows som styresystem åbner stifinder og du kan vælge dit billede
![Test Image 6](https://github.com/DangelTheMangel/RacerbilsEvolutionsProgram/blob/main/Pictures/ScreenShots/selectPng.JPG)

- **Save CSV File**
Denne knap gøre at du kan gemme din processes i træningen og så kan du lave grafer om tingene i excel ellers kan du forsætte en anden gang (csv filen gemmes i data)

- **Continue training ...**
Denne knap gøre at du kan åbne en af dine gemte csv filer og forsæt derfra du nådet sidst. når du klikker på den så vis du har styresytem windows åbner stifinder og du kan vælge din csv fil

#### farve valg




