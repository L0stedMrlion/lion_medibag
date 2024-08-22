# 🏥 Lion Medibag 

- Medibag script made for more better EMS RP, add healing for EMS, many featured.

## 🙆 FEATURES
- Very well optimized
- Many customizations
- Can be compatible with any notify script
- Supports all framework that ox_inventory is supporting
- Healing system for EMS included!
- On disabling the script it deletes all medibags
- Command to delete all medibags
- And more!

## 🫳 Dependecies

- [ox_target](https://github.com/overextended/ox_target)
- [ox_lib](https://github.com/overextended/ox_lib)
- [ox_inventory](https://github.com/overextended/ox_inventory)

## 🧑‍🏫 Installation

- Download and make sure you have all dependencies listed above
- Add lion_mechanic to your resource directory
- In you server cfg write `ensure lion_medibag`, and make you its starter after the dependencies
- And make sure you added the medibag item to the ox_inventory!

## 🐂 Installation to ox_inventory

- Just paste this to your `items.lua`

```lua
	['medibag'] = {
		label = 'Medibag',
		weight = 500,
		stack = true,
		close = true,
		client = {
			event = 'lion_medibag:place' -- Do not edit the event, the medibag wont work. Edit it only if you know what are you doing.
		}
	},

	['bandage'] = { -- Edit the bandage however you want, and bandage is not required, but can be used with the new healing system
		label = 'Bandage',
		weight = 200,
		client = {
			label = "Applying bandage",
			anim = { dict = 'missheistdockssetup1clipboard@idle_a', clip = 'idle_a', flag = 49 },
			prop = { model = `prop_rolled_sock_02`, pos = vec3(-0.14, -0.14, -0.08), rot = vec3(-50.0, -50.0, 0.0) },
			disable = { car = true, combat = true, move = true },
			usetime = 3500,
			cancel = true,
		}
	},
```

## 🦁 SUPPORT

- If you need any support just contact me on my Discord. I'm named there **lostedmrlion** or you click on [this](https://discord.com/users/710549603216261141).
