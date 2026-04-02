# friend-li

A CLI pet tamagotchi that lives in your terminal. Deterministic species rolled from your username, persistent mood and hunger, ASCII sprites with idle animations, and a personality that grows over time.

## Install

```bash
bash install.sh
```

## Usage

```
fli              Show your pet's status
fli hatch        Hatch your companion (first time)
fli hatch --seed=X  Hatch with a custom seed
fli preview <s>  Preview a seed roll without hatching
fli status       Show detailed stats and mood
fli feed         Feed your pet
fli pet          Pet your companion
fli play         Play with your pet (animated)
fli train <stat> Train a specific stat (DEBUGGING, PATIENCE, etc.)
fli advice       Get dev advice from your pet (stat-weighted)
fli rename <n>   Rename your companion
fli sprite       Show the full ASCII sprite
fli animate      Watch idle animation loop (Ctrl+C to stop)
fli card         Show the companion card (rarity, stats, species)
fli reroll       Reroll your companion (resets everything)
fli version      Show version
fli help         Show help
```

## Custom Seeds

By default, your companion is rolled from your OS username. To try different rolls:

- `fli preview coolseed` - see what a seed produces without committing
- `fli hatch --seed=coolseed` - hatch with that seed

Use `fli preview` to shop around for the rarity and species you want, then hatch when you find one you like.

## Advice System

Your pet dispenses dev advice via `fli advice`. The 500 advice lines are organized into 5 pools of 100, one per stat:

- WISDOM - architecture, design, and practical engineering advice
- DEBUGGING - debugging, testing, and error handling tips
- PATIENCE - process, craft, and long-term thinking advice
- CHAOS - creative, unhinged, and wildcard takes
- SNARK - sarcastic wrappers and delivery modifiers

Your pet's stats influence which pool is drawn from:
- 60% chance the advice comes from your pet's highest stat pool
- 25% chance it comes from the second highest
- 15% chance it's random

If your pet's SNARK stat is high enough, there's a chance any advice gets wrapped with a snarky prefix. Each pool ranges from silly/obvious advice to genuinely insightful tips.

## License

MIT - see [LICENSE](LICENSE)

## Architecture

- `fli` - main script (bash)
- `sprites.sh` - ASCII sprite definitions and rendering
- `advice.sh` - 500 dev advice lines across 5 stat pools
- `install.sh` - installer
- `friend-completion.bash` - bash/zsh tab completion

State is stored in `~/.friend-li/state.json` as key=value pairs.

## PRNG Design

The companion roll uses a seeded mulberry32-style PRNG to deterministically generate species, rarity, stats, and cosmetics from the username. All PRNG functions (`prng_next`, `prng_range`, `prng_pick`) communicate results via global variables (`PRNG_RESULT`, `PRNG_PICK_RESULT`) instead of subshell capture (`$(...)`) to ensure `PRNG_STATE` advances correctly between calls.

## Known Fix History

- Fixed infinite loop in `roll_stats` caused by PRNG state not advancing. The root cause was bash subshell isolation - calling `$(prng_next)` or `$(prng_range N)` ran the function in a child process, so `PRNG_STATE` updates were lost when the subshell exited. Replaced all subshell-captured PRNG calls with direct invocation plus global result variables.
- Renamed CLI command from `friend` to `fli`.
- Aligned progress bars in status output using fixed-width printf formatting for stat names.
- Rewrote `fli animate` with mood-aware behavior system: thought bubbles, actions, sleep cycles, environment particles, shiny sparkle effects, variable animation speed, and a compact status bar. The pet cycles through idle, thought, action, sleep, and environment phases based on current mood and hunger.
- Added `fli advice` command with 500 dev advice lines (100 per stat pool: WISDOM, DEBUGGING, PATIENCE, CHAOS, SNARK). Advice selection is weighted by the pet's stats - highest stat pool is drawn from 60% of the time. High SNARK stat adds sarcastic prefixes to advice from other pools.
