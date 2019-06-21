# card-of-the-day
Command-line interface which prints a randomly queried Magic: The Gathering card to the console.
Used as an exercise for learning Ruby as well as developing a package for the AUR.

┌───────────────────────────────────┐
│ Tundra                            │
├───────────────────────────────────┤
│ Land — Plains Island              │
├───────────────────────────────────┤
│ ({T}: Add {W} or {U}.)            │
└───────────────────────────────────┘

┌───────────────────────────────────┐
│ Keldon Warlord          {2}{R}{R} │
├───────────────────────────────────┤
│ Creature — Human Barbarian        │
├───────────────────────────────────┤
│ Keldon Warlord's power and        │
│ toughness are each equal to the   │
│ number of non-Wall creatures      │
│ you control.                      │
│                           ┌───────┤
│                           │ * / * │
└───────────────────────────────────┘

## To Use
Make sure that Ruby is installed on your system.
- ```git clone https://github.com/JakeChvatal/card-of-the-day.git```
- ```cd card-of-the-day```
- ```bundle install```
- ```chmod +x card-of-the-day```
- ```./card-of-the-day```
#### Optional Arguments:
- ```-n {x}```: the number of cards to display
