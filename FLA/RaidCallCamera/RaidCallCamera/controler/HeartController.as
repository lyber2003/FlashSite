package controler
{
    import animation.*;
    import components.popupWindow.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;
    import language.*;
    import rabitui.manager.*;
    import rcbiz.events.*;
    import rcbiz.model.client.*;
    import utils.*;

    public class HeartController extends RCControlerBase
    {
        private var heartBtn:Asset_heart_btn;
        private var heartLabel:TextField;

        public function HeartController(param1:Asset_heart_btn, param2:TextField)
        {
            this.heartBtn = param1;
            this.heartLabel = param2;
            param1.addEventListener(MouseEvent.CLICK, this.onHeartBtnClick);
            showWidget.addEventListener(ShowEvent.HEART_NOTIFY, this.onHeartNotify);
            showWidget.addEventListener(ShowEvent.SEND_HEART_RESULT, this.onSendHeartResult);
            showWidget.addEventListener(ShowEvent.SINGER_INFO_UPDATE, this.onSingerInfoChange);
            clientWidget.rcbiz.interfaces:IClientWidget::addEventListener(ClientEvent.MIC_MODE_CHANGE, this.onUpdateStatus);
            return;
        }// end function

        protected function onSendHeartResult(event:ShowEvent) : void
        {
            var _loc_2:* = int(event.data.result);
            _loc_2 = _loc_2 % 10000;
            _loc_2 = 101;
            switch(_loc_2)
            {
                case 0:
                {
                    break;
                }
                case 109:
                {
                    TipManager.showWarnTip(Lang.getString(10004), this.heartBtn.localToGlobal(new Point(0, this.heartBtn.height + 20)));
                    break;
                }
                case 105:
                {
                    TipManager.showWarnTip(Lang.getString(10018), this.heartBtn.localToGlobal(new Point(0, this.heartBtn.height + 20)));
                    break;
                }
                case 101:
                {
                    PopUpManager.centerPopUp(PopUpManager.createPopUp(HeartTipWindow, true));
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        protected function onSingerInfoChange(event:ShowEvent) : void
        {
            var _loc_2:* = clientWidget.channel.micMode;
            if (_loc_2 == MicMode.MIC_MODE_EMPTY || _loc_2 == MicMode.NOT_MIC_MODE)
            {
                this.heartLabel.text = "";
            }
            else
            {
                this.heartLabel.text = UtilTool.joinBycomma(String(clientWidget.singer.singerInfo.charm));
            }
            return;
        }// end function

        private function onUpdateStatus(event:ClientEvent) : void
        {
            var _loc_2:* = clientWidget.channel.micMode;
            if (_loc_2 == MicMode.MIC_MODE_EMPTY || _loc_2 == MicMode.NOT_MIC_MODE)
            {
                this.heartLabel.text = "";
            }
            return;
        }// end function

        protected function onHeartNotify(event:ShowEvent) : void
        {
            this.heartLabel.text = String(clientWidget.singer.singerInfo.charm);
            AnimationManager.addAnimation(new AddOneAnimation(this.heartBtn.localToGlobal(new Point(this.heartBtn.x + this.heartBtn.width, this.heartBtn.y))));
            return;
        }// end function

        private function onHeartBtnClick(event:MouseEvent) : void
        {
            if (!this.heartBtn.enabled)
            {
                return;
            }
            if (clientWidget.singer.isMe)
            {
                TipManager.showWarnTip(Lang.getString(10018), this.heartBtn.localToGlobal(new Point(0, this.heartBtn.height + 20)), 1);
            }
            else if (clientWidget.channel.micMode == MicMode.MIC_MODE_EMPTY)
            {
                TipManager.showWarnTip(Lang.getString(10019), this.heartBtn.localToGlobal(new Point(0, this.heartBtn.height + 20)), 1);
            }
            else
            {
                showWidget.protoApi.PSendHeart();
            }
            UtilTool.disableButtonBySecond(this.heartBtn, 1);
            return;
        }// end function

    }
}
