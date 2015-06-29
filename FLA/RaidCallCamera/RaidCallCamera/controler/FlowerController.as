package controler
{
    import animation.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;
    import language.*;
    import rabitui.manager.*;
    import rcbiz.events.*;
    import rcbiz.model.client.*;
    import utils.*;

    public class FlowerController extends RCControlerBase
    {
        private var flowerBtn:Asset_flower_btn;
        private var flowerLabel:TextField;

        public function FlowerController(param1:Asset_flower_btn, param2:TextField)
        {
            this.flowerBtn = param1;
            this.flowerLabel = param2;
            this.flowerBtn.addEventListener(MouseEvent.CLICK, this.onFlowerBtnClick);
            flowerWidget.addEventListener(FlowerEvent.SINGER_FLOWER_CHANGE, this.onSingerFlowerChange);
            flowerWidget.addEventListener(FlowerEvent.FLOWER_NOTIFY, this.onFlowerNotify);
            flowerWidget.addEventListener(FlowerEvent.SEND_FLOWER_RESULT, this.onSendFlowerResult);
            clientWidget.rcbiz.interfaces:IClientWidget::addEventListener(ClientEvent.MIC_MODE_CHANGE, this.onUpdateStatus);
            return;
        }// end function

        private function onUpdateStatus(event:ClientEvent) : void
        {
            var _loc_2:* = clientWidget.channel.micMode;
            if (_loc_2 == MicMode.MIC_MODE_EMPTY || _loc_2 == MicMode.NOT_MIC_MODE)
            {
                this.flowerLabel.text = "";
            }
            return;
        }// end function

        protected function onSingerFlowerChange(event:FlowerEvent) : void
        {
            this.flowerLabel.text = UtilTool.joinBycomma(String(clientWidget.singer.singerInfo.totalFlower));
            return;
        }// end function

        private function onFlowerNotify(event:FlowerEvent) : void
        {
            this.flowerLabel.text = UtilTool.joinBycomma(String(clientWidget.singer.singerInfo.totalFlower));
            AnimationManager.addFlowerAnimation();
            return;
        }// end function

        private function onFlowerBtnClick(event:MouseEvent) : void
        {
            if (!this.flowerBtn.enabled)
            {
                return;
            }
            if (clientWidget.singer.isMe)
            {
                TipManager.showWarnTip(Lang.getString(10015), this.flowerBtn.localToGlobal(new Point(-100, 60)), 1);
            }
            else if (clientWidget.channel.micMode == MicMode.MIC_MODE_EMPTY)
            {
                TipManager.showWarnTip(Lang.getString(10016), this.flowerBtn.localToGlobal(new Point(-100, 60)), 1);
            }
            else
            {
                flowerWidget.sendFlower();
            }
            UtilTool.disableButtonBySecond(this.flowerBtn, 0.5);
            return;
        }// end function

        protected function onSendFlowerResult(event:FlowerEvent) : void
        {
            var _loc_2:* = null;
            if (event.data.result == 0)
            {
                AnimationManager.addAnimation(new AddOneAnimation(this.flowerBtn.localToGlobal(new Point(this.flowerBtn.x + this.flowerBtn.width, this.flowerBtn.y)), 1, 1));
            }
            else if (event.data.result == 2)
            {
                _loc_2 = Lang.getDulpString(10017, event.data.remain_second);
                TipManager.showWarnTip(_loc_2, this.flowerBtn.localToGlobal(new Point(-100, 60)), 1);
            }
            return;
        }// end function

    }
}
