## 1.1.0

Changed:
- All methods of **CarvableNode** and **CarvableElement** return themselves instead of **CarvableAnalyzer**,
	allowing for chaining.
- Narrow **CarvingNode** into **CarvingToken**, it accepts SyntacticEntity instead of AstNode
- Renamed `removeNode()` to `removeToken()`, in **CarvableAnalyzer** extensions

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
