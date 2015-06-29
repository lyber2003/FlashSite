package components.singer
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;
    import language.*;
    import rabitui.controls.button.*;
    import rabitui.manager.*;
    import rabitui.model.*;
    import rabitui.uicore.*;

    public class VideoConver extends UIObject
    {
        private var liveTip:Asset_livevideotip;
        public var playBtn:Asset_btn_playvideo;
        public var stopPlayBtn:Asset_btn_stopvideo;
        public var stopPublishBtn:ImageButton;
        public var publishBtn:Asset_btn_startcam;
        public var _bRollOver:Boolean;
        public var _status:String = "STATUS_PLAY";
        public static const STATUS_PUBLISH:String = "STATUS_PUBLISH";
        public static const STATUS_UNPUBLISH:String = "STATUS_UNPUBLISH";
        public static const STATUS_PLAY:String = "STATUS_PLAY";
        public static const STATUS_STOP:String = "STATUS_STOP";
        public static const STATUS_LIVE_STOP:String = "STATUS_LIVE_STOP";

        public function VideoConver()
        {
            return;
        }// end function

        override protected function createChildren() : void
        {
            this.stopPlayBtn = new Asset_btn_stopvideo();
            addChild(this.stopPlayBtn);
            this.stopPublishBtn = new ImageButton(AssetStopLiveBmp, new Rectangle(8, 8, 104, 14), AssetStopLiveBmp, AssetStopLiveBmp);
            var _loc_1:* = new TextFormat("tohoma", 20, 16777215);
            this.stopPublishBtn.setData(Lang.getString(10025), _loc_1, new PaddingData(20, 20, 8, 10, 41));
            this.stopPublishBtn.minWidth = 140;
            addChild(this.stopPublishBtn);
            this.playBtn = new Asset_btn_playvideo();
            addChild(this.playBtn);
            this.publishBtn = new Asset_btn_startcam();
            addChild(this.publishBtn);
            this.liveTip = new Asset_livevideotip();
            addChild(this.liveTip);
            _update(true);
            return;
        }// end function

        override protected function init() : void
        {
            this.status = STATUS_PLAY;
            addEventListener(MouseEvent.ROLL_OVER, this.onRollOver);
            addEventListener(MouseEvent.ROLL_OUT, this.onRollOut);
            this.publishBtn.addEventListener(MouseEvent.ROLL_OVER, this.onBtnRollOver);
            this.publishBtn.addEventListener(MouseEvent.ROLL_OUT, this.onBtnRollOut);
            this.playBtn.addEventListener(MouseEvent.ROLL_OVER, this.onBtnRollOver);
            this.playBtn.addEventListener(MouseEvent.ROLL_OUT, this.onBtnRollOut);
            this.stopPlayBtn.addEventListener(MouseEvent.ROLL_OVER, this.onBtnRollOver);
            this.stopPlayBtn.addEventListener(MouseEvent.ROLL_OUT, this.onBtnRollOut);
            return;
        }// end function

        private function onBtnRollOver(event:MouseEvent) : void
        {
            var _loc_2:* = "";
            var _loc_3:* = event.currentTarget as DisplayObject;
            switch(_loc_3)
            {
                case this.publishBtn:
                {
                    _loc_2 = Lang.getString(10036);
                    break;
                }
                case this.playBtn:
                {
                    _loc_2 = Lang.getString(10038);
                    break;
                }
                case this.stopPlayBtn:
                {
                    _loc_2 = Lang.getString(10037);
                    break;
                }
                default:
                {
                    break;
                }
            }
            var _loc_4:* = localToGlobal(new Point(_loc_3.x, _loc_3.y - 30));
            TipManager.showTip(_loc_2, _loc_4, TipAlignModel.RIGHT);
            return;
        }// end function

        private function onBtnRollOut(event:MouseEvent) : void
        {
            TipManager.removeTip();
            return;
        }// end function

        private function onRollOver(event:MouseEvent) : void
        {
            this._bRollOver = true;
            this.updateState();
            return;
        }// end function

        private function onRollOut(event:MouseEvent) : void
        {
            this._bRollOver = false;
            this.updateState();
            return;
        }// end function

        public function set status(param1:String) : void
        {
            this._status = param1;
            this.updateState();
            return;
        }// end function

        private function updateState() : void
        {
            this.stopPlayBtn.visible = this._status == STATUS_PLAY && this._bRollOver;
            this.playBtn.visible = this._status == STATUS_LIVE_STOP;
            this.publishBtn.visible = this._status == STATUS_UNPUBLISH;
            this.stopPublishBtn.visible = this._status == STATUS_PUBLISH && this._bRollOver;
            this.liveTip.visible = this._status == STATUS_LIVE_STOP;
            return;
        }// end function

        private function drawConver() : void
        {
            graphics.clear();
            graphics.beginFill(0, 0);
            graphics.drawRect(0, 0, preferWidth, preferHeight);
            graphics.endFill();
            return;
        }// end function

        override protected function updateDisplay() : void
        {
            this.drawConver();
            this.publishBtn.x = int((preferWidth - this.publishBtn.width) / 2);
            this.publishBtn.y = this.playBtn.y;
            this.playBtn.x = int((preferWidth - this.playBtn.width) / 2);
            this.playBtn.y = int((preferHeight - this.playBtn.height) / 2);
            this.stopPublishBtn.x = int((preferWidth - this.stopPublishBtn.width) / 2);
            this.stopPublishBtn.y = int((preferHeight - this.stopPublishBtn.height) / 2);
            this.stopPlayBtn.x = int((preferWidth - this.stopPlayBtn.width) / 2);
            this.stopPlayBtn.y = int((preferHeight - this.stopPlayBtn.height) / 2);
            this.liveTip.x = preferWidth - this.liveTip.width;
            return;
        }// end function

    }
}
