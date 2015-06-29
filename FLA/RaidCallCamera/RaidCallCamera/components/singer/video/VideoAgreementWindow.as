package components.singer.video
{
    import components.events.*;
    import components.singer.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;
    import language.*;
    import rabitui.controls.button.*;
    import rabitui.manager.*;
    import rabitui.model.*;
    import rabitui.uicore.*;

    public class VideoAgreementWindow extends UIObject
    {
        private var titleTip:TipText;
        private var protoAgree:VideoProtoAgree;
        private var agreeCheckBtn:AgreeCheckBtn;
        private var okBtn:ImageButton;
        private var sp:Sprite;
        private var closeBtn:AssetPopCloseBtn;

        public function VideoAgreementWindow()
        {
            return;
        }// end function

        override protected function createChildren() : void
        {
            this.sp = new Sprite();
            addChild(this.sp);
            this.titleTip = new TipText();
            var _loc_1:* = new TextFormat(null, 14, 11384003);
            this.titleTip.setMaxWidth(480);
            this.titleTip.setTextFormat(_loc_1);
            this.titleTip.setText(Lang.getString(10011));
            this.sp.addChild(this.titleTip);
            this.protoAgree = new VideoProtoAgree();
            this.sp.addChild(this.protoAgree);
            this.agreeCheckBtn = new AgreeCheckBtn();
            this.agreeCheckBtn.addEventListener(Event.CHANGE, this.onCheckChange);
            this.sp.addChild(this.agreeCheckBtn);
            this.okBtn = new ImageButton(AgreeOkUpBmp, new Rectangle(8, 8, 128, 25), AgreeOkOverBmp, AgreeOkOverBmp);
            var _loc_2:* = new TextFormat("Arial", 20, 16777215);
            this.okBtn.setData(Lang.getString(10034), _loc_2, new PaddingData(20, 20, 8, 10, 41));
            this.okBtn.minWidth = 140;
            this.okBtn.enabled = false;
            this.sp.addChild(this.okBtn);
            this.closeBtn = new AssetPopCloseBtn();
            addChild(this.closeBtn);
            this.okBtn.addEventListener(MouseEvent.CLICK, this.onOkClick);
            this.closeBtn.addEventListener(MouseEvent.CLICK, this.onCloseClick);
            return;
        }// end function

        private function onCheckChange(event:Event) : void
        {
            this.okBtn.enabled = this.agreeCheckBtn.bCheck;
            return;
        }// end function

        override protected function onAddedToStage(event:Event) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            if (stage.stageWidth > 538)
            {
                _loc_2 = 538;
            }
            else
            {
                _loc_2 = stage.stageWidth;
            }
            if (stage.stageHeight > 239)
            {
                _loc_3 = 239;
            }
            else
            {
                _loc_3 = stage.stageHeight;
            }
            setSize(_loc_2, _loc_3);
            x = (stage.stageWidth - preferWidth) / 2;
            y = (stage.stageHeight - preferHeight) / 2;
            return;
        }// end function

        protected function onStageResize(event:Event) : void
        {
            return;
        }// end function

        private function drawBack() : void
        {
            graphics.clear();
            graphics.beginFill(2369843);
            graphics.drawRect(0, 0, preferWidth, preferHeight);
            graphics.endFill();
            return;
        }// end function

        private function onOkClick(event:MouseEvent) : void
        {
            dispatchEvent(new CompomentEvent(CompomentEvent.AGREE_VIDEO_RULE));
            PopUpManager.removePopUp(this);
            return;
        }// end function

        private function onCloseClick(event:MouseEvent) : void
        {
            PopUpManager.removePopUp(this);
            return;
        }// end function

        override protected function updateDisplay() : void
        {
            this.drawBack();
            this.titleTip.x = int((preferWidth - this.titleTip.preferWidth) / 2);
            this.titleTip.y = 10;
            this.protoAgree.x = int((preferWidth - this.protoAgree.preferWidth) / 2);
            this.protoAgree.y = 50;
            this.agreeCheckBtn.x = this.protoAgree.x;
            this.agreeCheckBtn.y = 164;
            this.okBtn.x = int((preferWidth - this.okBtn.width) / 2);
            this.okBtn.y = this.agreeCheckBtn.y + this.agreeCheckBtn.preferHeight + 30;
            this.sp.y = int((preferHeight - 228) / 2);
            this.closeBtn.y = 20;
            this.closeBtn.x = preferWidth - this.closeBtn.width - 10;
            return;
        }// end function

    }
}
