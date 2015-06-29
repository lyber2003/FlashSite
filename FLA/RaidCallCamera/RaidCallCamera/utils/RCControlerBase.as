package utils
{
    import flash.events.*;
    import rcbiz.*;
    import rcbiz.interfaces.*;

    public class RCControlerBase extends EventDispatcher
    {
        public var clientWidget:IClientWidget;
        public var showWidget:IShowWidget;
        public var flowerWidget:IFlowerWidget;
        public var videoWidget:IVideoWidget;

        public function RCControlerBase()
        {
            this.clientWidget = WidgetBiz.getInstance().clientWidget;
            this.showWidget = WidgetBiz.getInstance().showWidget;
            this.flowerWidget = WidgetBiz.getInstance().flowerWidget;
            this.videoWidget = WidgetBiz.getInstance().videoWidget;
            return;
        }// end function

    }
}
