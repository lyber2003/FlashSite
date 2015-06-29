package components.popupWindow
{
    import components.singer.*;
    import controler.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;
    import language.*;
    import rabitui.component.*;
    import rabitui.controls.button.*;
    import rabitui.manager.*;
    import rabitui.model.*;
    import rabitui.uicore.*;
    import rcbiz.*;
    import rcbiz.events.*;

    public class HeartTipWindow extends UIObject
    {
        private var back:AssetHeartTipBack;
        private var convertBtn:ImageButton;
        private var closeBtn:AssetPopCloseBtn;
        private var titleTip:TipText;
        private var protoAgree:HeartTipAgree;

        public function HeartTipWindow()
        {
            return;
        }// end function

        override protected function createChildren() : void
        {
            this.back = new AssetHeartTipBack();
            addChild(this.back);
            this.titleTip = new TipText();
            var _loc_1:* = new TextFormat(null, 14, 11384003);
            this.titleTip.setMaxWidth(236);
            this.titleTip.setTextFormat(_loc_1);
            this.titleTip.setText(Lang.getString(10027));
            addChild(this.titleTip);
            this.protoAgree = new HeartTipAgree();
            var _loc_2:* = Lang.getString(10028) + Lang.getString(10029) + Lang.getString(10030);
            this.protoAgree.setText(_loc_2);
            addChild(this.protoAgree);
            this.convertBtn = new ImageButton(AgreeOkUpBmp, new Rectangle(8, 8, 128, 25), AgreeOkOverBmp, AgreeOkOverBmp);
            this.convertBtn.minWidth = 140;
            var _loc_3:* = new TextFormat("Arial", 20, 16777215);
            this.convertBtn.setData(Lang.getString(10033), _loc_3, new PaddingData(20, 20, 8, 10, 41));
            addChild(this.convertBtn);
            this.closeBtn = new AssetPopCloseBtn();
            addChild(this.closeBtn);
            setSize(462, 203, true);
            this.convertBtn.addEventListener(MouseEvent.CLICK, this.onConvertBtnClick, false, 0, true);
            this.closeBtn.addEventListener(MouseEvent.CLICK, this.onCloseBtnClick, false, 0, true);
            WidgetBiz.getInstance().showWidget.addEventListener(ShowEvent.CONVERT_HEART_RESULT, this.onConvertHeartResult, false, 0, true);
            return;
        }// end function

        override protected function updateDisplay() : void
        {
            this.titleTip.x = int((preferWidth - this.titleTip.preferWidth) / 2);
            this.titleTip.y = 16;
            this.protoAgree.x = int((preferWidth - this.protoAgree.preferWidth) / 2);
            this.protoAgree.y = 38 + 6;
            this.convertBtn.x = int((preferWidth - this.convertBtn.width) / 2);
            this.convertBtn.y = 140 + 6;
            this.closeBtn.y = 10;
            this.closeBtn.x = preferWidth - this.closeBtn.width - 10;
            return;
        }// end function

        override protected function onRemovedFromStage(event:Event) : void
        {
            WidgetBiz.getInstance().showWidget.removeEventListener(ShowEvent.CONVERT_HEART_RESULT, this.onConvertHeartResult, false);
            return;
        }// end function

        protected function onCloseBtnClick(event:MouseEvent) : void
        {
            PopUpManager.removePopUp(this);
            return;
        }// end function

        protected function onConvertHeartResult(event:ShowEvent) : void
        {
            var _loc_2:* = int(event.data.result);
            _loc_2 = _loc_2 % 10000;
            switch(_loc_2)
            {
                case 0:
                {
                    PopUpManager.centerPopUp(PopUpManager.Alert(Lang.getDulpString(10022, "10"), AlertIconType.WARN, Lang.getString(10021)));
                    PopUpManager.removePopUp(this);
                    break;
                }
                case 103:
                {
                    PopUpManager.removePopUp(this);
                    break;
                }
                case 106:
                {
                    PopUpManager.centerPopUp(PopUpManager.Alert(Lang.getString(10003), AlertIconType.WARN, Lang.getString(10021), true, true));
                    PopUpManager.removePopUp(this);
                    break;
                }
                case 104:
                {
                    PopUpManager.centerPopUp(TipManager.showWarnTip(Lang.getDulpString(10005, event.data.hour), null, 3));
                    PopUpManager.removePopUp(this);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        protected function onConvertBtnClick(event:MouseEvent) : void
        {
            WidgetBiz.getInstance().showWidget.protoApi.PConvertHeart(1);
            this.convertBtn.enabled = false;
            return;
        }// end function

    }
}
