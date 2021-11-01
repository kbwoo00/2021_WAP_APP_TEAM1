# togetor

## TGTButton class

```dart
TGTButton(
    child: const Icon(
        Icons.add,
        color: Colors.white,
        size: 30.0,
    ),
    onPressed: () {
        print("button add");
    },
),
```

### **_Constructors_**

```dart
  const TGTButton(
      {Key? key,
      required this.child,
      required this.onPressed,
      this.width = 50.0,
      this.height = 50.0,
      this.borderRadius = 80.0})
      : super(key: key);
```

### **_Properties_**

**child** → Widget
The primary content of the TGTButton.
_`final`_

**onPressed** → voidCallback
The callback that is called when the button is tapped or otherwise activated.
_`final`_

**width** → Double?
_`final`_

**height** → Double?
_`final`_

**borderRadius** → Double?
_`final`_
