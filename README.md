Vertical Detail Scroller
========================

### Version 1.0

#####Highlights

 - TableView with automatically sized cells.
 - Custom vertical transition between detail views.
 - Automatic and Interactive transition.
 - No UITableViewDataSource code in the ViewController.
 - Works in any orientation.
 
#####How to Use

The app will start by showing *ListVC*.<br>
The only view in this ViewController is a Table View whose data is loaded from a *.json* file included in the app bundle. Each cell has its own color and is sizing its height by using AutoLayout constraints.

Touching one of the cells will push to another ViewController, *DetailVC*.<br>
In this ViewController there's a Scroll View with fixed height. By scrolling beyond the top or bottom limits of the scroll content, it's possible to trigger a transition to a sibling *DetailVC*.<br>
This transition can be toggled between Automatic and Interactive. By default, it's automatic.

Automatic Transition: The transition will trigger at a certain point beyond the limits of the Scroll content size and animate all the way to the sibling *DetailVC* without stoping.

Interactive Transition: After the transition is triggered it will continuously follow the swipe gesture after starting and can be cancelled at any time.
 
#####Notes

 Requires Xcode 6 and iOS 8. No external library used.
 

### Future development

 - Custom transition from the ListVC to the DetailVC