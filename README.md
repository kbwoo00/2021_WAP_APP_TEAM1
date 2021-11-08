# Togetor

---

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

---

## TGTTopBar class

---
```dart 
        leading: IconButton(
            icon:Icon(Icons.arrow_left_rounded),
            onPressed: (){
              print('gotoback(navigation위젯');
            }
            ),
            
        endDrawer : Drawer(
          child : ListView(
            padding : EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child:Text('Drawer'),
                decoration: BoxDecoration(
                  color:Colors.blue,),
              ),
            ],
          )
      )
```

### **_Properties_**
**onPressed**→ voidCallBack

The callback that is called when the button is tapped or otherwise activated.

_`final`_

**child** → Widget  

The primary content of the TGTTopBar.

_`final`_

**padding**→ EdgeInsetsGeometry?

The internal padding for the button's child.

_`final`_


