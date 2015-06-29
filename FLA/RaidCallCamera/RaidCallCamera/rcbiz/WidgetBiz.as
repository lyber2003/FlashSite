package rcbiz
{
    import com.debug.*;
    import flash.external.*;
    import rcbiz.core.*;
    import rcbiz.events.*;
    import rcbiz.interfaces.*;
    import rcbiz.widget.*;

    public class WidgetBiz extends Object
    {
        public var clientWidget:IClientWidget;
        public var showWidget:IShowWidget;
        public var flowerWidget:IFlowerWidget;
        public var videoWidget:IVideoWidget;
        private var _rc:RCConnector;
        private static var _instance:WidgetBiz;

        public function WidgetBiz()
        {
            this._rc = new RCConnector();
            this.clientWidget = new ClientWidget(this._rc);
            this.showWidget = new ShowWidget(this.clientWidget);
            this.flowerWidget = new FlowerWidget(this.clientWidget);
            this.videoWidget = new VideoWidget(this.clientWidget);
            return;
        }// end function

        protected function onInitComplete(event:ClientEvent) : void
        {
            DebugX.trace("----------------start Load init!----------------");
            this.showWidget.addEventListener(ShowEvent.HANDLE_SHARK_SUCESS, this.onHandleSharkSucess);
            this.showWidget.init();
            DebugX.trace("------------------end Load init!-----------------");
            return;
        }// end function

        protected function onHandleSharkSucess(event:ShowEvent) : void
        {
            this.flowerWidget.initialize();
            this.videoWidget.rcbiz.interfaces:IVideoWidget::init();
            return;
        }// end function

        public function init() : void
        {
            if (ExternalInterface.available)
            {
                DebugX.trace("-------------init RCWidget Biz!-------------------");
                this.clientWidget.protoApi.PSetFitMetric(254, 254, 254);
                this.clientWidget.addEventListener(ClientEvent.INIT_COMPELETE, this.onInitComplete);
                this.clientWidget.initialize();
            }
            return;
        }// end function

        public static function getInstance() : WidgetBiz
        {
            if (_instance == null)
            {
                _instance = new WidgetBiz;
            }
            return _instance;
        }// end function

    }
}
