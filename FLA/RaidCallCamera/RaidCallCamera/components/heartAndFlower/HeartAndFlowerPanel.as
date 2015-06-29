package components.heartAndFlower
{
    import com.greensock.*;
    import com.greensock.data.*;
    import components.flower.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;
    import particles.*;
    import rabitui.uicore.*;

    public class HeartAndFlowerPanel extends UIObject
    {
        private var asset:Asset_HeartAndFlowerPanel;
        public var heartBtn:Asset_heart_btn;
        public var heartLabel:TextField;
        public var flowerBtn:Asset_flower_btn;
        public var flowerLabel:TextField;
        public var nameText:TextField;
        private var pFlower:SFlowers;
        private var flowerTip:FlowerTip;
        private var pHeart:HeartEffect;

        public function HeartAndFlowerPanel()
        {
            return;
        }// end function

        override protected function createChildren() : void
        {
            this.asset = new Asset_HeartAndFlowerPanel();
            this.heartBtn = this.asset.heartBtn;
            this.heartLabel = this.asset.heartLabel;
            this.flowerLabel = this.asset.flowerLabel;
            this.flowerBtn = this.asset.flowerBtn;
            this.asset.y = 24;
            this.heartLabel.mouseEnabled = false;
            this.flowerLabel.mouseEnabled = false;
            addChild(this.asset);
            this.nameText = new TextField();
            this.nameText.defaultTextFormat = new TextFormat("tohoma", 14, 1256277);
            this.nameText.multiline = false;
            this.nameText.mouseEnabled = false;
            this.nameText.autoSize = TextFieldAutoSize.LEFT;
            addChild(this.nameText);
            this.heartLabel.mouseEnabled = false;
            this.flowerLabel.mouseEnabled = false;
            this.pHeart = new HeartEffect();
            addChild(this.pHeart);
            this.pFlower = new SFlowers();
            this.pFlower.x = this.flowerBtn.x + this.flowerBtn.width / 2;
            this.pFlower.y = this.flowerBtn.y + this.flowerBtn.height / 2;
            addChild(this.pFlower);
            return;
        }// end function

        override protected function init() : void
        {
            this.heartBtn.addEventListener(MouseEvent.ROLL_OVER, this.onHRollOver);
            this.heartBtn.addEventListener(MouseEvent.ROLL_OUT, this.onHRollOut);
            this.flowerBtn.addEventListener(MouseEvent.ROLL_OVER, this.onFRollOver);
            this.flowerBtn.addEventListener(MouseEvent.ROLL_OUT, this.onFRollOut);
            return;
        }// end function

        protected function onHRollOut(event:MouseEvent) : void
        {
            this.pHeart.stop();
            return;
        }// end function

        protected function onHRollOver(event:MouseEvent) : void
        {
            this.pHeart.start(new Point(this.heartBtn.width / 2, this.heartBtn.height / 2));
            return;
        }// end function

        protected function onFRollOver(event:MouseEvent) : void
        {
            this.pFlower.start();
            if (this.flowerTip == null)
            {
                this.flowerTip = new FlowerTip();
                this.flowerTip.mouseEnabled = false;
                this.flowerTip.mouseChildren = false;
                this.flowerTip.x = this.flowerBtn.x + this.flowerBtn.width / 2 - this.flowerTip.width / 2;
                this.flowerTip.y = this.flowerBtn.y + this.flowerBtn.height + 20;
                this.flowerTip.alpha = 0;
                addChild(this.flowerTip);
                TweenLite.to(this.flowerTip, 0.3, new TweenLiteVars({alpha:1}));
            }
            return;
        }// end function

        protected function onFRollOut(event:MouseEvent) : void
        {
            this.pFlower.stop();
            if (this.flowerTip != null)
            {
                TweenLite.killTweensOf(this.flowerTip);
                this.flowerTip.remove();
                removeChild(this.flowerTip);
                this.flowerTip = null;
            }
            return;
        }// end function

    }
}
