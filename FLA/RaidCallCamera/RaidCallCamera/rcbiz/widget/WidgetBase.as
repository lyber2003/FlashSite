package rcbiz.widget
{
    import flash.events.*;
    import rcbiz.interfaces.*;

    public class WidgetBase extends Object
    {
        public var rc:IClientWidget;
        protected var dispatcher:EventDispatcher;

        public function WidgetBase(param1:IClientWidget)
        {
            this.dispatcher = new EventDispatcher();
            this.rc = param1;
            return;
        }// end function

        public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
        {
            this.dispatcher.addEventListener(param1, param2, param3, param4, param5);
            return;
        }// end function

        public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
        {
            this.dispatcher.removeEventListener(param1, param2, param3);
            return;
        }// end function

        public function dispatchEvent(event:Event) : Boolean
        {
            return this.dispatcher.dispatchEvent(event);
        }// end function

    }
}
