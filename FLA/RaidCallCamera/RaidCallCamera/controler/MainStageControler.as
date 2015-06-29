package controler
{
    import animation.*;
    import com.carlcalderon.arthropod.*;
    import components.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import helper.*;
    import rcbiz.events.*;
    import rcbiz.model.client.*;
    import utils.*;

    public class MainStageControler extends RCControlerBase
    {
        private var singerController:SingerPanelControler;
        private var flowerController:FlowerController;
        private var heartController:HeartController;
        private var mainStage:MainStage;

        public function MainStageControler(param1:Sprite)
        {
            this.mainStage = param1 as MainStage;
            this.singerController = new SingerPanelControler(this.mainStage.singerPanel, this.mainStage);
            this.flowerController = new FlowerController(this.mainStage.heartAndFlower.flowerBtn, this.mainStage.heartAndFlower.flowerLabel);
            this.heartController = new HeartController(this.mainStage.heartAndFlower.heartBtn, this.mainStage.heartAndFlower.heartLabel);
            clientWidget.addEventListener(ClientEvent.MIC_MODE_CHANGE, this.onUpdateMainStatus);
            this.singerController.addEventListener(LiveStreamEvent.LIVE_STATUS_CHANGE, this.onUpdateMainStatus);
            showWidget.rcbiz.interfaces:IShowWidget::addEventListener(ShowEvent.HEART_NOTIFY, this.onHeartNofity);
            showWidget.rcbiz.interfaces:IShowWidget::addEventListener(ShowEvent.SINGER_INFO_UPDATE, this.onSingerInfoUpdate);
            return;
        }// end function

        private function onSingerInfoUpdate(event:ShowEvent) : void
        {
            var _loc_2:* = clientWidget.channel.micMode;
            if (_loc_2 == MicMode.MIC_MODE_EMPTY || _loc_2 == MicMode.NOT_MIC_MODE)
            {
                this.mainStage.heartAndFlower.nameText.text = "";
            }
            else
            {
                this.mainStage.heartAndFlower.nameText.text = clientWidget.singer.nick;
            }
            var _loc_3:* = GetURLHelper.getAvator(clientWidget.singer.uid);
            this.mainStage.micNodelNoLive.setUrl(_loc_3);
            return;
        }// end function

        protected function onHeartNofity(event:ShowEvent) : void
        {
            var _loc_2:* = this.mainStage.localToGlobal(new Point(this.mainStage.heartAndFlower.x, this.mainStage.heartAndFlower.y));
            var _loc_3:* = this.mainStage.localToGlobal(new Point(this.mainStage.singerPanel.x + this.mainStage.singerPanel.preferWidth / 2, this.mainStage.singerPanel.y + this.mainStage.singerPanel.preferHeight / 2));
            AnimationManager.addAnimation(new SendHeartAnimation(_loc_2, _loc_3, event.data.receiver));
            return;
        }// end function

        private function onUpdateMainStatus(event:Event) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = this.singerController.videoStatus;
            var _loc_4:* = clientWidget.singer;
            switch(clientWidget.channel.micMode)
            {
                case MicMode.MIC_MODE_EMPTY:
                {
                    _loc_2 = MainStage.STATUS_MIC_MODEL_EMPTY;
                    this.mainStage.heartAndFlower.nameText.text = "";
                    break;
                }
                case MicMode.MIC_MODE_ONLINE:
                {
                    if (_loc_4.isOnMic && _loc_4.isMe)
                    {
                        _loc_2 = MainStage.STATUS_MIC_MODEL_LIVE;
                    }
                    else if (videoWidget.isLive)
                    {
                        _loc_2 = MainStage.STATUS_MIC_MODEL_LIVE;
                    }
                    else
                    {
                        _loc_2 = MainStage.STATUS_MIC_MODEL_NO_LIVE;
                    }
                    break;
                }
                case MicMode.NOT_MIC_MODE:
                {
                    _loc_2 = MainStage.STATUS_NOT_MIC_MODEL;
                    this.mainStage.heartAndFlower.nameText.text = "";
                    break;
                }
                default:
                {
                    break;
                }
            }
            Debug.log("onUpdateMainStatus:" + _loc_2 + "," + videoWidget.isLive + "," + _loc_4.isOnMic);
            this.mainStage.updateStatus(_loc_2);
            return;
        }// end function

    }
}
