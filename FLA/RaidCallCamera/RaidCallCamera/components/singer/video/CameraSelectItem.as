package components.singer.video
{
    import com.greensock.*;
    import com.greensock.data.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import rabitui.uicore.*;

    public class CameraSelectItem extends UIObject
    {
        private var asset:Asset_cam_selectitem;
        private var label:TextField;
        private var back:MovieClip;
        private var _data:Object;

        public function CameraSelectItem()
        {
            return;
        }// end function

        public function get data() : Object
        {
            return this._data;
        }// end function

        public function set data(param1:Object) : void
        {
            this._data = param1;
            return;
        }// end function

        override protected function init() : void
        {
            return;
        }// end function

        public function setLabel(param1:String) : void
        {
            this.label.text = param1;
            return;
        }// end function

        public function getLabel() : String
        {
            return this.label.text;
        }// end function

        override protected function createChildren() : void
        {
            this.asset = new Asset_cam_selectitem();
            addChild(this.asset);
            this.label = this.asset.label;
            this.label.textColor = 7766679;
            this.label.text = "";
            this.back = this.asset.back;
            this.back.alpha = 0;
            this.addEventListener(MouseEvent.ROLL_OVER, this.onRollOver);
            this.addEventListener(MouseEvent.ROLL_OUT, this.onRollOut);
            return;
        }// end function

        private function onRollOver(event:MouseEvent) : void
        {
            TweenLite.to(this.back, 0.3, new TweenLiteVars().autoAlpha(1));
            return;
        }// end function

        private function onRollOut(event:MouseEvent) : void
        {
            TweenLite.to(this.back, 0.3, new TweenLiteVars().autoAlpha(0));
            return;
        }// end function

        override protected function updateDisplay() : void
        {
            if (preferWidth)
            {
                this.back.width = preferWidth;
                this.label.width = preferWidth - 4;
            }
            return;
        }// end function

    }
}
