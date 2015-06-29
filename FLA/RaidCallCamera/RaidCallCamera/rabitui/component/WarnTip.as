package rabitui.component
{
    import com.greensock.*;
    import com.greensock.data.*;
    import com.greensock.easing.*;
    import flash.display.*;
    import flash.text.*;
    import rabitui.uicore.*;

    public class WarnTip extends UIObject
    {
        private var asset:Asset_WarnTip;
        private var label:TextField;
        private var icon:Sprite;
        private var text:String;
        private var hideTime:Number;
        private var bShowIcon:Boolean;
        private const MIN_SIZE:int = 280;
        private const MAX_SIZE:int = 480;

        public function WarnTip(param1:String, param2:Number = 3, param3:Boolean = true)
        {
            this.text = param1;
            this.hideTime = param2;
            this.bShowIcon = param3;
            return;
        }// end function

        override protected function createChildren() : void
        {
            this.asset = new Asset_WarnTip();
            addChild(this.asset);
            this.label = this.asset.label;
            this.label.autoSize = TextFieldAutoSize.LEFT;
            this.label.wordWrap = true;
            this.label.multiline = true;
            this.label.htmlText = this.text;
            this.icon = this.asset.icon;
            this.icon.visible = this.bShowIcon;
            var _loc_1:* = 60;
            if (!this.bShowIcon)
            {
                this.label.x = 12;
                _loc_1 = 40;
            }
            if (this.label.textWidth + _loc_1 < this.MIN_SIZE)
            {
                this.asset.back.width = this.MIN_SIZE;
            }
            else if (this.label.textWidth + _loc_1 > this.MAX_SIZE)
            {
                this.asset.back.width = this.MAX_SIZE;
            }
            else
            {
                this.asset.back.width = this.label.textWidth + _loc_1;
            }
            this.label.width = this.asset.back.width - _loc_1;
            this.asset.back.height = this.label.textHeight + 40;
            this.label.y = (this.asset.back.height - this.label.textHeight) / 2 - 4;
            this.icon.y = (this.asset.back.height - this.icon.height) / 2 - 4;
            this.asset.cacheAsBitmap = true;
            return;
        }// end function

        override protected function init() : void
        {
            this.asset.alpha = 0;
            this.asset.y = -20;
            var _loc_1:* = new TimelineLite({onComplete:this.onComplete});
            _loc_1.append(TweenLite.to(this.asset, 0.3, new TweenLiteVars({y:0}).autoAlpha(1).ease(Back.easeOut)));
            _loc_1.append(TweenLite.to(this.asset, 0.5, new TweenLiteVars({y:20}).delay(this.hideTime).autoAlpha(0)));
            _loc_1.play();
            return;
        }// end function

        private function onComplete() : void
        {
            if (parent != null)
            {
                parent.removeChild(this);
            }
            return;
        }// end function

        override protected function updateDisplay() : void
        {
            return;
        }// end function

    }
}
