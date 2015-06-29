package rcbiz.interfaces
{
    import rcbiz.interfaces.proto.*;
    import rcbiz.model.client.*;

    public interface IClientWidget
    {

        public function IClientWidget();

        function initialize() : void;

        function registerWidgetListner(param1:int, param2:Object) : void;

        function setChannVideoEnable(param1:int) : void;

        function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void;

        function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void;

        function get videoEnable() : Boolean;

        function set videoEnable(param1:Boolean) : void;

        function get protoApi() : IClientProtoApi;

        function get channel() : Channel;

        function get group() : Group;

        function get myInfo() : User;

        function get bChannInited() : Boolean;

        function get bBinding() : Boolean;

        function get singer() : User;

    }
}
