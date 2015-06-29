package ExtEffect
{
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.utils.*;
    import rabitui.uicore.*;

    public class EffectLoder extends UIObject
    {
        private var loader:Loader;
        private var _bSetSize:Boolean = true;

        public function EffectLoder()
        {
            return;
        }// end function

        override protected function createChildren() : void
        {
            this.loader = new Loader();
            this.loader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onLoadComplete);
            this.loader.contentLoaderInfo.addEventListener(Event.INIT, this.onLoadInit);
            this.loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.onError);
            this.loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onError);
            addChild(this.loader);
            return;
        }// end function

        public function loadExtEffect(param1:String) : void
        {
            this.loader.unloadAndStop();
            if (param1 == null || param1 == "")
            {
                return;
            }
            var _loc_2:* = ApplicationDomain.currentDomain;
            var _loc_3:* = new LoaderContext(false, _loc_2);
            this.loader.load(new URLRequest(param1), _loc_3);
            return;
        }// end function

        public function loadByteArray(param1:ByteArray) : void
        {
            this.loader.unloadAndStop();
            var _loc_2:* = ApplicationDomain.currentDomain;
            var _loc_3:* = new LoaderContext(false, _loc_2);
            this.loader.loadBytes(param1, _loc_3);
            return;
        }// end function

        protected function onLoadComplete(event:Event) : void
        {
            dispatchEvent(new Event(Event.COMPLETE));
            this.updateDisplay();
            return;
        }// end function

        private function onLoadInit(event:Event) : void
        {
            return;
        }// end function

        private function onError(param1) : void
        {
            return;
        }// end function

        override protected function updateDisplay() : void
        {
            var _loc_1:* = null;
            if (this.loader.content && this._bSetSize)
            {
                _loc_1 = this.loader.content;
                if (_loc_1.hasOwnProperty("setSize"))
                {
                    _loc_1.setSize(preferWidth, preferHeight, true);
                }
                else
                {
                    width = preferWidth;
                    height = preferHeight;
                }
            }
            return;
        }// end function

        protected function onEffectRemove(event:ExtEffectEvent) : void
        {
            this.unloadEffect();
            return;
        }// end function

        public function unloadEffect() : void
        {
            this.loader.unloadAndStop();
            return;
        }// end function

        public function get bSetSize() : Boolean
        {
            return this._bSetSize;
        }// end function

        public function set bSetSize(param1:Boolean) : void
        {
            this._bSetSize = param1;
            return;
        }// end function

        public function getLoader()
        {
            if (this.loader.content)
            {
                return this.loader.content;
            }
            return null;
        }// end function

    }
}
