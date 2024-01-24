# SAMenuOverlay

SAMenuOverlay is a versatile Swift package that provides a customizable drop-down menu overlay for iOS applications. It allows you to easily attach a drop-down menu to any view, providing a seamless and user-friendly way to present a list of options.

## Features

- **Easy Integration:** Attach drop-down menus to any view with minimal setup.
- **Customizable:** Customize the appearance and behavior of the drop-down menu to suit your application's design.
- **Support for Any Data Type:** Use SAMenuOverlay with an array of any type to create dynamic and flexible drop-down menus.

## Installation

### Swift Package Manager

Installation through Swift Package Manager can be done by going to File > Add Packages. Then enter the following URL in the searchbar; github.com/ahmedsallamdd/SAMenuOverlay.

### CocoaPods

Coming soon!

## Usage Example

1. Import SAMenuOverlay.
3. Create a property of SAMenuOverlay with the data type of your dataSource.
4. initialize with your customized values (your sourceView, default selection, menuItemHeight, ..etc).
5. call .showList() whenever you want to show the menu.

```
import UIKit
import SAMenuOverlay

class ViewController: UIViewController {

    @IBOutlet weak var coloredButton: UIButton!
    var buttonColorsDropDownMenu: NormalMenuOverlay<SampleColor>!
    let rawData: [SampleColor] = [
        SampleColor(name: "black", color: UIColor.black),
        SampleColor(name: "red", color: UIColor.red),
        SampleColor(name: "green", color: UIColor.green),
        // ... add more data as needed
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaultSelection = SampleColor(name: self.coloredButton.title(for: .normal),
                                           color: self.coloredButton.backgroundColor)
        
        self.buttonColorsDropDownMenu = NormalMenuOverlay<SampleColor>(parentViewController: self,
                                                                       sourceView: self.coloredButton)
        
        self.buttonColorsDropDownMenu.dataSource = self.rawData
        self.buttonColorsDropDownMenu.displayableItemTitle = { $0.name ?? "" }
        self.buttonColorsDropDownMenu.defaultSelection = defaultSelection
        self.buttonColorsDropDownMenu.selectionBackgroundColor = UIColor.red.withAlphaComponent(0.5)
        
        self.buttonColorsDropDownMenu.didSelectOption = { [weak self] sampleColor in
            self?.coloredButton.backgroundColor = sampleColor?.color
            self?.coloredButton.setTitle(sampleColor?.name, for: .normal)
        }
    }

    @IBAction func coloredButtonTapped(_ sender: Any) {
        self.buttonColorsDropDownMenu.showList()
    }
}
```
