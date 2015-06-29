package components.singer
{
    import flash.display.*;
    import rabitui.uicore.*;

    public class SingerBackPanel extends UIObject
    {
        private var DefaultImageBmp:Class;
        private var defaultImage:Bitmap;
        private var sp:Sprite;

        public function SingerBackPanel()
        {
            this.DefaultImageBmp = SingerBackPanel_DefaultImageBmp;
            return;
        }// end function

        override protected function createChildren() : void
        {
            this.defaultImage = new this.DefaultImageBmp() as Bitmap;
            this.defaultImage.x = -3;
            this.defaultImage.y = -3;
            addChild(this.defaultImage);
            this.sp = new Sprite();
            addChild(this.sp);
            return;
        }// end function

        private function drawSp() : void
        {
            this.sp.graphics.clear();
            this.sp.graphics.beginFill(4344408);
            this.sp.graphics.drawRect(0, 0, preferWidth, preferHeight);
            this.sp.graphics.endFill();
            return;
        }// end function

        override protected function updateDisplay() : void
        {
            this.defaultImage.width = preferWidth + 6;
            this.defaultImage.height = preferHeight + 6;
            this.drawSp();
            return;
        }// end function

    }
}
