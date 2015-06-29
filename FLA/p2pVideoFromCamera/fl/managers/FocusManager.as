package fl.managers
{
    import fl.controls.*;
    import fl.core.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import flash.ui.*;
    import flash.utils.*;

    public class FocusManager extends Object implements IFocusManager
    {
        private var _form:DisplayObjectContainer;
        private var focusableObjects:Dictionary;
        private var focusableCandidates:Array;
        private var activated:Boolean = false;
        private var calculateCandidates:Boolean = true;
        private var lastFocus:InteractiveObject;
        private var _showFocusIndicator:Boolean = true;
        private var lastAction:String;
        private var defButton:Button;
        private var _defaultButton:Button;
        private var _defaultButtonEnabled:Boolean = true;

        public function FocusManager(param1:DisplayObjectContainer)
        {
            focusableObjects = new Dictionary(true);
            if (param1 != null)
            {
                _form = param1;
                activate();
            }
            return;
        }// end function

        private function addedHandler(event:Event) : void
        {
            var _loc_2:* = DisplayObject(event.target);
            if (_loc_2.stage)
            {
                addFocusables(DisplayObject(event.target));
            }
            return;
        }// end function

        private function removedHandler(event:Event) : void
        {
            var _loc_2:* = 0;
            var _loc_4:* = null;
            var _loc_3:* = DisplayObject(event.target);
            if (_loc_3 is IFocusManagerComponent)
            {
            }
            if (focusableObjects[_loc_3] == true)
            {
                if (_loc_3 == lastFocus)
                {
                    IFocusManagerComponent(lastFocus).drawFocus(false);
                    lastFocus = null;
                }
                _loc_3.removeEventListener(Event.TAB_ENABLED_CHANGE, tabEnabledChangeHandler, false);
                delete focusableObjects[_loc_3];
                calculateCandidates = true;
            }
            else
            {
                if (_loc_3 is InteractiveObject)
                {
                }
                if (focusableObjects[_loc_3] == true)
                {
                    _loc_4 = _loc_3 as InteractiveObject;
                    if (_loc_4)
                    {
                        if (_loc_4 == lastFocus)
                        {
                            lastFocus = null;
                        }
                        delete focusableObjects[_loc_4];
                        calculateCandidates = true;
                    }
                    _loc_3.addEventListener(Event.TAB_ENABLED_CHANGE, tabEnabledChangeHandler, false, 0, true);
                }
            }
            removeFocusables(_loc_3);
            return;
        }// end function

        private function addFocusables(param1:DisplayObject, param2:Boolean = false) : void
        {
            var focusable:IFocusManagerComponent;
            var io:InteractiveObject;
            var doc:DisplayObjectContainer;
            var docParent:DisplayObjectContainer;
            var i:int;
            var child:DisplayObject;
            var o:* = param1;
            var skipTopLevel:* = param2;
            if (!skipTopLevel)
            {
                if (o is IFocusManagerComponent)
                {
                    focusable = IFocusManagerComponent(o);
                    if (focusable.focusEnabled)
                    {
                        if (focusable.tabEnabled)
                        {
                        }
                        if (isTabVisible(o))
                        {
                            focusableObjects[o] = true;
                            calculateCandidates = true;
                        }
                        o.addEventListener(Event.TAB_ENABLED_CHANGE, tabEnabledChangeHandler, false, 0, true);
                        o.addEventListener(Event.TAB_INDEX_CHANGE, tabIndexChangeHandler, false, 0, true);
                    }
                }
                else if (o is InteractiveObject)
                {
                    io = o as InteractiveObject;
                    if (io)
                    {
                    }
                    if (io.tabEnabled)
                    {
                    }
                    if (findFocusManagerComponent(io) == io)
                    {
                        focusableObjects[io] = true;
                        calculateCandidates = true;
                    }
                    io.addEventListener(Event.TAB_ENABLED_CHANGE, tabEnabledChangeHandler, false, 0, true);
                    io.addEventListener(Event.TAB_INDEX_CHANGE, tabIndexChangeHandler, false, 0, true);
                }
            }
            if (o is DisplayObjectContainer)
            {
                doc = DisplayObjectContainer(o);
                o.addEventListener(Event.TAB_CHILDREN_CHANGE, tabChildrenChangeHandler, false, 0, true);
                docParent;
                try
                {
                    docParent = doc.parent;
                }
                catch (se:SecurityError)
                {
                    docParent;
                }
                if (!(doc is Stage))
                {
                }
                if (!(docParent is Stage))
                {
                }
                if (doc.tabChildren)
                {
                    i;
                    while (i < doc.numChildren)
                    {
                        
                        try
                        {
                            child = doc.getChildAt(i);
                            if (child != null)
                            {
                                addFocusables(doc.getChildAt(i));
                            }
                        }
                        catch (error:SecurityError)
                        {
                        }
                        i = (i + 1);
                    }
                }
            }
            return;
        }// end function

        private function removeFocusables(param1:DisplayObject) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (param1 is DisplayObjectContainer)
            {
                param1.removeEventListener(Event.TAB_CHILDREN_CHANGE, tabChildrenChangeHandler, false);
                param1.removeEventListener(Event.TAB_INDEX_CHANGE, tabIndexChangeHandler, false);
                for (_loc_2 in focusableObjects)
                {
                    
                    _loc_3 = DisplayObject(_loc_2);
                    if (DisplayObjectContainer(param1).contains(_loc_3))
                    {
                        if (_loc_3 == lastFocus)
                        {
                            lastFocus = null;
                        }
                        _loc_3.removeEventListener(Event.TAB_ENABLED_CHANGE, tabEnabledChangeHandler, false);
                        delete _loc_5[_loc_2];
                        calculateCandidates = true;
                    }
                }
            }
            return;
        }// end function

        private function isTabVisible(param1:DisplayObject) : Boolean
        {
            var p:DisplayObjectContainer;
            var o:* = param1;
            try
            {
                p = o.parent;
                do
                {
                    
                    if (!p.tabChildren)
                    {
                        return false;
                    }
                    p = p.parent;
                    if (p)
                    {
                    }
                    if (!(p is Stage))
                    {
                        if (p.parent)
                        {
                        }
                    }
                }while (!(p.parent is Stage))
            }
            catch (se:SecurityError)
            {
            }
            return true;
        }// end function

        private function isValidFocusCandidate(param1:DisplayObject, param2:String) : Boolean
        {
            var _loc_3:* = null;
            if (!isEnabledAndVisible(param1))
            {
                return false;
            }
            if (param1 is IFocusManagerGroup)
            {
                _loc_3 = IFocusManagerGroup(param1);
                if (param2 == _loc_3.groupName)
                {
                    return false;
                }
            }
            return true;
        }// end function

        private function isEnabledAndVisible(param1:DisplayObject) : Boolean
        {
            var formParent:DisplayObjectContainer;
            var tf:TextField;
            var sb:SimpleButton;
            var o:* = param1;
            try
            {
                formParent = DisplayObject(form).parent;
                while (o != formParent)
                {
                    
                    if (o is UIComponent)
                    {
                        if (!UIComponent(o).enabled)
                        {
                            return false;
                        }
                    }
                    else if (o is TextField)
                    {
                        tf = TextField(o);
                        if (tf.type != TextFieldType.DYNAMIC)
                        {
                        }
                        if (!tf.selectable)
                        {
                            return false;
                        }
                    }
                    else if (o is SimpleButton)
                    {
                        sb = SimpleButton(o);
                        if (!sb.enabled)
                        {
                            return false;
                        }
                    }
                    if (!o.visible)
                    {
                        return false;
                    }
                    o = o.parent;
                }
            }
            catch (se:SecurityError)
            {
            }
            return true;
        }// end function

        private function tabEnabledChangeHandler(event:Event) : void
        {
            calculateCandidates = true;
            var _loc_2:* = InteractiveObject(event.target);
            var _loc_3:* = focusableObjects[_loc_2] == true;
            if (_loc_2.tabEnabled)
            {
                if (!_loc_3)
                {
                }
                if (isTabVisible(_loc_2))
                {
                    if (!(_loc_2 is IFocusManagerComponent))
                    {
                        _loc_2.focusRect = false;
                    }
                    focusableObjects[_loc_2] = true;
                }
            }
            else if (_loc_3)
            {
                delete focusableObjects[_loc_2];
            }
            return;
        }// end function

        private function tabIndexChangeHandler(event:Event) : void
        {
            calculateCandidates = true;
            return;
        }// end function

        private function tabChildrenChangeHandler(event:Event) : void
        {
            if (event.target != event.currentTarget)
            {
                return;
            }
            calculateCandidates = true;
            var _loc_2:* = DisplayObjectContainer(event.target);
            if (_loc_2.tabChildren)
            {
                addFocusables(_loc_2, true);
            }
            else
            {
                removeFocusables(_loc_2);
            }
            return;
        }// end function

        public function activate() : void
        {
            if (activated)
            {
                return;
            }
            addFocusables(form);
            form.addEventListener(Event.ADDED, addedHandler, false, 0, true);
            form.addEventListener(Event.REMOVED, removedHandler, false, 0, true);
            try
            {
                form.stage.addEventListener(FocusEvent.MOUSE_FOCUS_CHANGE, mouseFocusChangeHandler, false, 0, true);
                form.stage.addEventListener(FocusEvent.KEY_FOCUS_CHANGE, keyFocusChangeHandler, false, 0, true);
                form.stage.addEventListener(Event.ACTIVATE, activateHandler, false, 0, true);
                form.stage.addEventListener(Event.DEACTIVATE, deactivateHandler, false, 0, true);
            }
            catch (se:SecurityError)
            {
                form.addEventListener(FocusEvent.MOUSE_FOCUS_CHANGE, mouseFocusChangeHandler, false, 0, true);
                form.addEventListener(FocusEvent.KEY_FOCUS_CHANGE, keyFocusChangeHandler, false, 0, true);
                form.addEventListener(Event.ACTIVATE, activateHandler, false, 0, true);
                form.addEventListener(Event.DEACTIVATE, deactivateHandler, false, 0, true);
            }
            form.addEventListener(FocusEvent.FOCUS_IN, focusInHandler, true, 0, true);
            form.addEventListener(FocusEvent.FOCUS_OUT, focusOutHandler, true, 0, true);
            form.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler, false, 0, true);
            form.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler, true, 0, true);
            activated = true;
            if (lastFocus)
            {
                setFocus(lastFocus);
            }
            return;
        }// end function

        public function deactivate() : void
        {
            if (!activated)
            {
                return;
            }
            focusableObjects = new Dictionary(true);
            focusableCandidates = null;
            lastFocus = null;
            defButton = null;
            form.removeEventListener(Event.ADDED, addedHandler, false);
            form.removeEventListener(Event.REMOVED, removedHandler, false);
            try
            {
                form.stage.removeEventListener(FocusEvent.MOUSE_FOCUS_CHANGE, mouseFocusChangeHandler, false);
                form.stage.removeEventListener(FocusEvent.KEY_FOCUS_CHANGE, keyFocusChangeHandler, false);
                form.stage.removeEventListener(Event.ACTIVATE, activateHandler, false);
                form.stage.removeEventListener(Event.DEACTIVATE, deactivateHandler, false);
            }
            catch (se:SecurityError)
            {
            }
            form.removeEventListener(FocusEvent.MOUSE_FOCUS_CHANGE, mouseFocusChangeHandler, false);
            form.removeEventListener(FocusEvent.KEY_FOCUS_CHANGE, keyFocusChangeHandler, false);
            form.removeEventListener(Event.ACTIVATE, activateHandler, false);
            form.removeEventListener(Event.DEACTIVATE, deactivateHandler, false);
            form.removeEventListener(FocusEvent.FOCUS_IN, focusInHandler, true);
            form.removeEventListener(FocusEvent.FOCUS_OUT, focusOutHandler, true);
            form.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler, false);
            form.removeEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler, true);
            activated = false;
            return;
        }// end function

        private function focusInHandler(event:FocusEvent) : void
        {
            var _loc_3:* = null;
            if (!activated)
            {
                return;
            }
            var _loc_2:* = InteractiveObject(event.target);
            if (form.contains(_loc_2))
            {
                lastFocus = findFocusManagerComponent(InteractiveObject(_loc_2));
                if (lastFocus is Button)
                {
                    _loc_3 = Button(lastFocus);
                    if (defButton)
                    {
                        defButton.emphasized = false;
                        defButton = _loc_3;
                        _loc_3.emphasized = true;
                    }
                }
                else
                {
                    if (defButton)
                    {
                    }
                    if (defButton != _defaultButton)
                    {
                        defButton.emphasized = false;
                        defButton = _defaultButton;
                        _defaultButton.emphasized = true;
                    }
                }
            }
            return;
        }// end function

        private function focusOutHandler(event:FocusEvent) : void
        {
            if (!activated)
            {
                return;
            }
            var _loc_2:* = event.target as InteractiveObject;
            return;
        }// end function

        private function activateHandler(event:Event) : void
        {
            if (!activated)
            {
                return;
            }
            var _loc_2:* = InteractiveObject(event.target);
            if (lastFocus)
            {
                if (lastFocus is IFocusManagerComponent)
                {
                    IFocusManagerComponent(lastFocus).setFocus();
                }
                else
                {
                    form.stage.focus = lastFocus;
                }
            }
            lastAction = "ACTIVATE";
            return;
        }// end function

        private function deactivateHandler(event:Event) : void
        {
            if (!activated)
            {
                return;
            }
            var _loc_2:* = InteractiveObject(event.target);
            return;
        }// end function

        private function mouseFocusChangeHandler(event:FocusEvent) : void
        {
            if (!activated)
            {
                return;
            }
            if (event.relatedObject is TextField)
            {
                return;
            }
            event.preventDefault();
            return;
        }// end function

        private function keyFocusChangeHandler(event:FocusEvent) : void
        {
            if (!activated)
            {
                return;
            }
            showFocusIndicator = true;
            if (event.keyCode != Keyboard.TAB)
            {
            }
            if (event.keyCode == 0)
            {
            }
            if (!event.isDefaultPrevented())
            {
                setFocusToNextObject(event);
                event.preventDefault();
            }
            return;
        }// end function

        private function keyDownHandler(event:KeyboardEvent) : void
        {
            if (!activated)
            {
                return;
            }
            if (event.keyCode == Keyboard.TAB)
            {
                lastAction = "KEY";
                if (calculateCandidates)
                {
                    sortFocusableObjects();
                    calculateCandidates = false;
                }
            }
            if (defaultButtonEnabled)
            {
            }
            if (event.keyCode == Keyboard.ENTER)
            {
            }
            if (defaultButton)
            {
            }
            if (defButton.enabled)
            {
                sendDefaultButtonEvent();
            }
            return;
        }// end function

        private function mouseDownHandler(event:MouseEvent) : void
        {
            if (!activated)
            {
                return;
            }
            if (event.isDefaultPrevented())
            {
                return;
            }
            var _loc_2:* = getTopLevelFocusTarget(InteractiveObject(event.target));
            if (!_loc_2)
            {
                return;
            }
            showFocusIndicator = false;
            if (_loc_2 == lastFocus)
            {
            }
            if (lastAction == "ACTIVATE")
            {
            }
            if (!(_loc_2 is TextField))
            {
                setFocus(_loc_2);
            }
            lastAction = "MOUSEDOWN";
            return;
        }// end function

        public function get defaultButton() : Button
        {
            return _defaultButton;
        }// end function

        public function set defaultButton(param1:Button) : void
        {
            var _loc_2:* = param1 ? (Button(param1)) : (null);
            if (_loc_2 != _defaultButton)
            {
                if (_defaultButton)
                {
                    _defaultButton.emphasized = false;
                }
                if (defButton)
                {
                    defButton.emphasized = false;
                }
                _defaultButton = _loc_2;
                defButton = _loc_2;
                if (_loc_2)
                {
                    _loc_2.emphasized = true;
                }
            }
            return;
        }// end function

        public function sendDefaultButtonEvent() : void
        {
            defButton.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
            return;
        }// end function

        private function setFocusToNextObject(event:FocusEvent) : void
        {
            if (!hasFocusableObjects())
            {
                return;
            }
            var _loc_2:* = getNextFocusManagerComponent(event.shiftKey);
            if (_loc_2)
            {
                setFocus(_loc_2);
            }
            return;
        }// end function

        private function hasFocusableObjects() : Boolean
        {
            var _loc_1:* = null;
            for (_loc_1 in focusableObjects)
            {
                
                return true;
            }
            return false;
        }// end function

        public function getNextFocusManagerComponent(param1:Boolean = false) : InteractiveObject
        {
            var _loc_8:* = null;
            if (!hasFocusableObjects())
            {
                return null;
            }
            if (calculateCandidates)
            {
                sortFocusableObjects();
                calculateCandidates = false;
            }
            var _loc_2:* = form.stage.focus;
            _loc_2 = DisplayObject(findFocusManagerComponent(InteractiveObject(_loc_2)));
            var _loc_3:* = "";
            if (_loc_2 is IFocusManagerGroup)
            {
                _loc_8 = IFocusManagerGroup(_loc_2);
                _loc_3 = _loc_8.groupName;
            }
            var _loc_4:* = getIndexOfFocusedObject(_loc_2);
            var _loc_5:* = false;
            var _loc_6:* = _loc_4;
            if (_loc_4 == -1)
            {
                if (param1)
                {
                    _loc_4 = focusableCandidates.length;
                }
                _loc_5 = true;
            }
            var _loc_7:* = getIndexOfNextObject(_loc_4, param1, _loc_5, _loc_3);
            return findFocusManagerComponent(focusableCandidates[_loc_7]);
        }// end function

        private function getIndexOfFocusedObject(param1:DisplayObject) : int
        {
            var _loc_2:* = focusableCandidates.length;
            var _loc_3:* = 0;
            _loc_3 = 0;
            while (_loc_3 < _loc_2)
            {
                
                if (focusableCandidates[_loc_3] == param1)
                {
                    return _loc_3;
                }
                _loc_3 = _loc_3 + 1;
            }
            return -1;
        }// end function

        private function getIndexOfNextObject(param1:int, param2:Boolean, param3:Boolean, param4:String) : int
        {
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = 0;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_5:* = focusableCandidates.length;
            var _loc_6:* = param1;
            while (true)
            {
                
                if (param2)
                {
                    param1 = param1 - 1;
                }
                else
                {
                    param1 = param1 + 1;
                }
                if (param3)
                {
                    if (param2)
                    {
                    }
                    if (param1 < 0)
                    {
                        break;
                    }
                    if (!param2)
                    {
                    }
                    if (param1 == _loc_5)
                    {
                        break;
                    }
                }
                else
                {
                    param1 = (param1 + _loc_5) % _loc_5;
                    if (_loc_6 == param1)
                    {
                        break;
                    }
                }
                if (isValidFocusCandidate(focusableCandidates[param1], param4))
                {
                    _loc_7 = DisplayObject(findFocusManagerComponent(focusableCandidates[param1]));
                    if (_loc_7 is IFocusManagerGroup)
                    {
                        _loc_8 = IFocusManagerGroup(_loc_7);
                        _loc_9 = 0;
                        while (_loc_9 < focusableCandidates.length)
                        {
                            
                            _loc_10 = focusableCandidates[_loc_9];
                            if (_loc_10 is IFocusManagerGroup)
                            {
                                _loc_11 = IFocusManagerGroup(_loc_10);
                                if (_loc_11.groupName == _loc_8.groupName)
                                {
                                }
                                if (_loc_11.selected)
                                {
                                    param1 = _loc_9;
                                    break;
                                }
                            }
                            _loc_9 = _loc_9 + 1;
                        }
                    }
                    return param1;
                }
            }
            return param1;
        }// end function

        private function sortFocusableObjects() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            focusableCandidates = [];
            for (_loc_1 in focusableObjects)
            {
                
                _loc_2 = InteractiveObject(_loc_1);
                if (_loc_2.tabIndex)
                {
                }
                if (!isNaN(Number(_loc_2.tabIndex)))
                {
                }
                if (_loc_2.tabIndex > 0)
                {
                    sortFocusableObjectsTabIndex();
                    return;
                }
                focusableCandidates.push(_loc_2);
            }
            focusableCandidates.sort(sortByDepth);
            return;
        }// end function

        private function sortFocusableObjectsTabIndex() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            focusableCandidates = [];
            for (_loc_1 in focusableObjects)
            {
                
                _loc_2 = InteractiveObject(_loc_1);
                if (_loc_2.tabIndex)
                {
                }
                if (!isNaN(Number(_loc_2.tabIndex)))
                {
                    focusableCandidates.push(_loc_2);
                }
            }
            focusableCandidates.sort(sortByTabIndex);
            return;
        }// end function

        private function sortByDepth(param1:InteractiveObject, param2:InteractiveObject) : Number
        {
            var index:int;
            var tmp:String;
            var tmp2:String;
            var aa:* = param1;
            var bb:* = param2;
            var val1:String;
            var val2:String;
            var zeros:String;
            var a:* = DisplayObject(aa);
            var b:* = DisplayObject(bb);
            try
            {
                do
                {
                    
                    index = getChildIndex(a.parent, a);
                    tmp = index.toString(16);
                    if (tmp.length < 4)
                    {
                        tmp2 = zeros.substring(0, 4 - tmp.length) + tmp;
                    }
                    val1 = tmp2 + val1;
                    a = a.parent;
                    if (a != DisplayObject(form))
                    {
                    }
                }while (a.parent)
            }
            catch (se1:SecurityError)
            {
            }
            try
            {
                do
                {
                    
                    index = getChildIndex(b.parent, b);
                    tmp = index.toString(16);
                    if (tmp.length < 4)
                    {
                        tmp2 = zeros.substring(0, 4 - tmp.length) + tmp;
                    }
                    val2 = tmp2 + val2;
                    b = b.parent;
                    if (b != DisplayObject(form))
                    {
                    }
                }while (b.parent)
            }
            catch (se2:SecurityError)
            {
            }
            return val1 > val2 ? (1) : (val1 < val2 ? (-1) : (0));
        }// end function

        private function getChildIndex(param1:DisplayObjectContainer, param2:DisplayObject) : int
        {
            return param1.getChildIndex(param2);
        }// end function

        private function sortByTabIndex(param1:InteractiveObject, param2:InteractiveObject) : int
        {
            return param1.tabIndex > param2.tabIndex ? (1) : (param1.tabIndex < param2.tabIndex ? (-1) : (sortByDepth(param1, param2)));
        }// end function

        public function get defaultButtonEnabled() : Boolean
        {
            return _defaultButtonEnabled;
        }// end function

        public function set defaultButtonEnabled(param1:Boolean) : void
        {
            _defaultButtonEnabled = param1;
            return;
        }// end function

        public function get nextTabIndex() : int
        {
            return 0;
        }// end function

        public function get showFocusIndicator() : Boolean
        {
            return _showFocusIndicator;
        }// end function

        public function set showFocusIndicator(param1:Boolean) : void
        {
            _showFocusIndicator = param1;
            return;
        }// end function

        public function get form() : DisplayObjectContainer
        {
            return _form;
        }// end function

        public function set form(param1:DisplayObjectContainer) : void
        {
            _form = param1;
            return;
        }// end function

        public function getFocus() : InteractiveObject
        {
            var _loc_1:* = form.stage.focus;
            return findFocusManagerComponent(_loc_1);
        }// end function

        public function setFocus(param1:InteractiveObject) : void
        {
            if (param1 is IFocusManagerComponent)
            {
                IFocusManagerComponent(param1).setFocus();
            }
            else
            {
                form.stage.focus = param1;
            }
            return;
        }// end function

        public function showFocus() : void
        {
            return;
        }// end function

        public function hideFocus() : void
        {
            return;
        }// end function

        public function findFocusManagerComponent(param1:InteractiveObject) : InteractiveObject
        {
            var component:* = param1;
            var p:* = component;
            try
            {
                while (component)
                {
                    
                    if (component is IFocusManagerComponent)
                    {
                    }
                    if (IFocusManagerComponent(component).focusEnabled)
                    {
                        return component;
                    }
                    component = component.parent;
                }
            }
            catch (se:SecurityError)
            {
            }
            return p;
        }// end function

        private function getTopLevelFocusTarget(param1:InteractiveObject) : InteractiveObject
        {
            var o:* = param1;
            try
            {
                while (o != InteractiveObject(form))
                {
                    
                    if (o is IFocusManagerComponent)
                    {
                    }
                    if (IFocusManagerComponent(o).focusEnabled)
                    {
                    }
                    if (IFocusManagerComponent(o).mouseFocusEnabled)
                    {
                    }
                    if (UIComponent(o).enabled)
                    {
                        return o;
                    }
                    o = o.parent;
                    if (o == null)
                    {
                        break;
                    }
                }
            }
            catch (se:SecurityError)
            {
            }
            return null;
        }// end function

    }
}
