# 🏥 Lion Medibag 

- Medibag script made for more RP opportunities

## 🙆 FEATURES
- Very well optimized
- Many customizations
- Can be compatible with any notify script
- Supports all framework that ox_inventory is supporting
- On disabling the script it deletes all medibags
- And more!

## 🫳 Dependecies

- [ox_target](https://github.com/overextended/ox_target)
- [ox_lib](https://github.com/overextended/ox_lib)
- [ox_inventory](https://github.com/overextended/ox_inventory)

## 🐂 How add it to ox_inventory?

- Just paste this to your items.lua

```lua
	['medibag'] = {
		label = 'Medibag',
		weight = 500,
		stack = true,
		close = true,
		client = {
			event = 'lion_medibag:place' --DO NOT EDIT, IF YOU EDIT THE MEDIBAG WILL NOT WORK
		}
	},
```
## 📋 To-do list

- [ ] Add inventory to open on place

## 🦁 SUPPORT

- If you need any support just contact me on my Discord. Im named there **lostedmrlion** or you click on [this](https://discord.com/users/710549603216261141).
