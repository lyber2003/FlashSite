package rcbiz.interfaces
{
    import rcbiz.interfaces.proto.*;

    public interface IVideoWidget
    {

        public function IVideoWidget();

        function get protoApi() : IVideoProtoApi;

        function init() : void;

        function get isReady() : Boolean;

        function get isLive() : Boolean;

        function set isLive(param1:Boolean) : void;

        function get isAgreeRule() : Boolean;

        function set isAgreeRule(param1:Boolean) : void;

        function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void;

        function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void;

    }
}
