package rcbiz.interfaces.proto
{

    public interface IVideoProtoApi
    {

        public function IVideoProtoApi();

        function PLiveHandshake() : void;

        function PCreateStream(param1:int) : void;

        function PPlayStream(param1:Array, param2:int) : void;

        function PGetStream() : void;

        function PSetVideoEnable(param1:int) : void;

        function PDeleteStream() : void;

        function PPlayStreamEx(param1:Array) : void;

    }
}
