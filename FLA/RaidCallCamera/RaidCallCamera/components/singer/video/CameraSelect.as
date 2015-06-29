package components.singer.video
{
    import flash.display.*;
    import flash.events.*;
    import flash.media.*;
    import language.*;
    import rabitui.manager.*;
    import rabitui.uicore.*;

    public class CameraSelect extends UIObject
    {
        private var asset:Asset_cam_select;
        private var listContainor:Sprite;
        public var selectedCamera:String;

        public function CameraSelect()
        {
            return;
        }// end function

        override protected function init() : void
        {
            this.rescan();
            return;
        }// end function

        public function rescan() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = 0;
            var _loc_3:* = null;
            this.selectedCamera = "";
            this.listContainor.removeChildren();
            if (Camera.getCamera() != null)
            {
                _loc_1 = Camera.names;
                _loc_2 = 0;
                while (_loc_2 < _loc_1.length)
                {
                    
                    _loc_3 = new CameraSelectItem();
                    _loc_3.data = _loc_2;
                    _loc_3.setLabel(_loc_1[_loc_2]);
                    _loc_3.y = _loc_2 * 38;
                    _loc_3.addEventListener(MouseEvent.CLICK, this.onItemClick);
                    this.listContainor.addChild(_loc_3);
                    _loc_2++;
                }
            }
            this.updateDisplay();
            return;
        }// end function

        override protected function createChildren() : void
        {
            this.asset = new Asset_cam_select();
            this.asset.title.text = Lang.getString(10035);
            addChild(this.asset);
            this.listContainor = new Sprite();
            addChild(this.listContainor);
            return;
        }// end function

        private function onItemClick(event:MouseEvent) : void
        {
            var _loc_2:* = event.currentTarget as CameraSelectItem;
            this.selectedCamera = String(_loc_2.data);
            dispatchEvent(new CameraSelectEvent(this.selectedCamera));
            this.remove();
            return;
        }// end function

        override protected function onAddedToStage(event:Event) : void
        {
            stage.addEventListener(MouseEvent.MOUSE_DOWN, this.onStageMouseDown);
            return;
        }// end function

        private function onStageMouseDown(event:MouseEvent) : void
        {
            if (!hitTestPoint(event.stageX, event.stageY))
            {
                this.remove();
            }
            return;
        }// end function

        override protected function onRemovedFromStage(event:Event) : void
        {
            stage.removeEventListener(MouseEvent.MOUSE_DOWN, this.onStageMouseDown);
            return;
        }// end function

        private function remove() : void
        {
            PopUpManager.removePopUp(this);
            return;
        }// end function

        override protected function updateDisplay() : void
        {
            this.listContainor.y = 36;
            this.listContainor.x = 5;
            this.asset.back.height = this.listContainor.y + this.listContainor.height + 6;
            return;
        }// end function

    }
}
