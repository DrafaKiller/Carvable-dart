## 1.2.1

Fixed:
- Not sorting **CarvingAppend** when tailing, start position was always at the beginning

Changed:
- Renamed `at` to `start`, in **CarvingAppend**, to conform with **PositionalCarving**

## 1.2.0

Added:
- **CarvingRange**, has a `start` and `end`, it's the same as the previous **PositionalCarving**

Changed:
- Simplified **PositionalCarving** to only have a position, moved the rest to **CarvingRange**,
	now only having `start`
- Extended **CarvingAppend** from **PositionalCarving**
- Renamed `at` to `start`, in **CarvingAppend**, to conform with **PositionalCarving**

Fixed:
- No offset in **CarvingAppend**

## 1.1.0

Added:
- **CarvableString**'s `append()` method, `at` argument, set the index where to append the string.
	If not set, the string will be appended at the end.

Changed:
- All methods of **CarvableNode** and **CarvableElement** return themselves instead of **CarvableAnalyzer**,
	allowing for chaining.
- Narrow **CarvingNode** into **CarvingToken**, it accepts SyntacticEntity instead of AstNode
- Renamed `removeNode()` to `removeToken()`, in **CarvableAnalyzer** extensions

Fixed:
- No offset in **CarvingNode**
- Method `compareTo()` in **Carving** was always merging carvings

## 1.0.0

**BREAKING CHANGES:**
- The API has been refactored, in a way that carvings apply themselves to the carvable object.
	Thus, handling all the different possible carvings in `apply()` is no longer needed, instead,
	all it's needed is to call the carving and pass it in.
	This allows for more complexity while being organized.

Added:
- **Carving** interface, to determine what can be passed into a **Carvable** object.
	Carvings may only be applied to their respective in and out data types.
- Method `apply()` to **Carving**, to apply the modifications to the carvable object.

## 0.0.2

Added:
- Methods to add multiple for **CarvableAnalyzer**
- More documentation

## 0.0.1

Initial version
