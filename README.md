<p align="center">
  <img src="petgotchi.gif" alt="petgotchi" style="width:120px;"/>
</p>

<br/>

[![](https://img.shields.io/badge/license-MIT-red.svg?style=for-the-badge&color=plum&logo=data:image/svg%2bxml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAxNiAxNCI+PHBhdGggZD0iTTE1IDEydi0xaC0xdi0xaDFWMWgtMVYwSDJ2MUgxdjloMXYxSDF2MUgwdjJoMTZ2LTJoLTF6Ii8+PHBhdGggZD0iTTE0IDEydi0xSDJ2MUgxdjFoMTR2LTFoLTF6IiBmaWxsPSIjNjQ2NDY0Ii8+PHBhdGggZD0iTTIgMXY5aDEyVjFIMnoiIGZpbGw9IiMzMjMyMzIiLz48ZyBmaWxsPSIjOTY5Njk2Ij48cGF0aCBkPSJNMiAxMWgxdjFIMnptMiAwaDF2MUg0em0yIDBoMXYxSDZ6bTIgMGgxdjFIOHoiLz48cGF0aCBkPSJNMTAgMTFoMXYxaC0xem0yIDBoMXYxaC0xek0xIDEyaDF2MUgxem0yIDBoMXYxSDN6Ii8+PHBhdGggZD0iTTUgMTJoMXYxSDV6bTIgMGgxdjFIN3ptMiAwaDF2MUg5em0yIDBoMXYxaC0xem0yIDBoMXYxaC0xeiIvPjwvZz48cGF0aCBkPSJNMyA0djRoMVYzSDN2MXptMi0xdjFoMXYxSDV2MWgxdjFINXYxaDJWM0g1em0zIDB2MWgxdjFIOHYxaDF2MUg4djFoMlYzSDh6bTMgMHYxaDF2NGgxVjNoLTJ6IiBmaWxsPSIjMGYwIi8+PC9zdmc+)](https://github.com/orden-gg/autopet/blob/main/LICENSE)

This contract act as a a proxy between user and the petting bot. Allowing for a trustless petting.

User should `setPetOperatorForAll({address of AavegotchiPetting}, true)` before using auto-petting so that it's possible to pet his aavegotchies.

### Methods and fields
- `subscribe` - subscribe user for auto-petting. Withdraws GHST fee from caller. Requires GHST of `fee` amount to be approved before calling it.
- `unsubscribe` - unsubscribes user for auto-petting and returns GHST back.
- `fee` - amount of GHST required to stake to use auto-petting.
- `claimTickets` - buy tickets for frens
- `withdrawTickets` - withdraw tickets from contract to owner
