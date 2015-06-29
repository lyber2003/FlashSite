package rabitui.controls.image
{
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import rabitui.uicore.*;

    public class Image extends UIObject
    {
        private var _url:String;
        private var loader:Loader;
        private var loaded:Boolean = false;
        private var scale:Boolean = false;

        public function Image(param1:String = null, param2:Boolean = true)
        {
            if (param1 != null)
            {
                this._url = param1;
            }
            this.scale = param2;
            return;
        }// end function

        override protected function createChildren() : void
        {
            this.loader = new Loader();
            addChild(this.loader);
            this.loader.contentLoaderInfo.addEventListener(Event.INIT, this.onLoadInit);
            this.loader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onLoadComplete);
            this.loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.onError);
            this.loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onError);
            return;
        }// end function

        override protected function init() : void
        {
            if (this._url != null)
            {
                this.load(this.url);
            }
            return;
        }// end function

        public function load(param1:String) : void
        {
            if (this._url != param1)
            {
                this._url = param1;
                this.loaded = false;
                if (param1 == null || param1 == "")
                {
                    this.unload();
                }
                else
                {
                    this.loader.load(new URLRequest(param1));
                }
            }
            return;
        }// end function

        public function unload() : void
        {
            this.loaded = false;
            this.loader.unloadAndStop();
            return;
        }// end function

        private function onLoadInit(event:Event) : void
        {
            return;
        }// end function

        private function onLoadComplete(event:Event) : void
        {
            this.loaded = true;
            this.updateDisplay();
            dispatchEvent(new Event(Event.COMPLETE));
            return;
        }// end function

        private function onError(param1) : void
        {
            return;
        }// end function

        public function get url() : String
        {
            return this._url;
        }// end function

        public function set url(param1:String) : void
        {
            this.load(param1);
            return;
        }// end function

        override public function gc() : void
        {
            this.loader.unloadAndStop(true);
            return;
        }// end function

        override protected function updateDisplay() : void
        {
            if (this.loaded && this.scale)
            {
                this.loader.width = preferWidth;
                this.loader.height = preferHeight;
            }
            return;
        }// end function

    }
}
