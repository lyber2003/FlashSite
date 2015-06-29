package rabitui.controls.list
{
    import rabitui.uicore.*;

    public class RectangleShape extends UIObject
    {
        private var fillColor:uint;
        private var fillAlpha:Number;
        private var borderThickness:Number;
        private var borderColor:uint;
        private var borderAlpha:Number;

        public function RectangleShape(param1:Number = 32, param2:Number = 32, param3:uint = 16777215, param4:Number = 1, param5:Number = 0, param6:uint = 0, param7:Number = 1)
        {
            this.fillColor = param3;
            this.fillAlpha = param4;
            this.borderThickness = param5;
            this.borderColor = param6;
            this.borderAlpha = param7;
            this._preferWidth = param1;
            this._preferHeight = param2;
            cacheAsBitmap = true;
            this.updateDisplay();
            return;
        }// end function

        override protected function updateDisplay() : void
        {
            graphics.clear();
            if (this.borderThickness > 0)
            {
                graphics.lineStyle(this.borderThickness, this.borderColor, this.borderAlpha, true);
            }
            graphics.beginFill(this.fillColor, this.fillAlpha);
            graphics.drawRect(0, 0, preferWidth, preferHeight);
            graphics.endFill();
            return;
        }// end function

        override protected function _update(param1:Boolean = true) : void
        {
            this.updateDisplay();
            return;
        }// end function

        override public function get width() : Number
        {
            return _preferWidth;
        }// end function

        override public function set width(param1:Number) : void
        {
            preferWidth = param1;
            return;
        }// end function

        override public function get height() : Number
        {
            return _preferHeight;
        }// end function

        override public function set height(param1:Number) : void
        {
            preferHeight = param1;
            return;
        }// end function

    }
}
