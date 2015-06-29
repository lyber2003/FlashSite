package rcbiz.interfaces.proto
{

    public interface IClientProtoCB
    {

        public function IClientProtoCB();

        function RGetUserNick(param1:String) : void;

        function RInitCompelete() : void;

        function CGetVideoEnable() : void;

        function CSetVideoEnable(param1:int) : void;

        function BSwitchChannel(param1:int, param2:int) : void;

        function BMicUserChange(param1:String) : void;

        function BChannelModeChange(param1:int) : void;

        function BReconnected() : void;

        function BDestroyFlash() : void;

        function BEnableVideoWidget(param1:int) : void;

        function BIsUserInChannel(param1:String, param2:String) : void;

        function BCPUNotify(param1:int) : void;

    }
}
