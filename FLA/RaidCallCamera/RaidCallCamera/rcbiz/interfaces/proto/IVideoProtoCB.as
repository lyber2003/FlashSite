package rcbiz.interfaces.proto
{

    public interface IVideoProtoCB
    {

        public function IVideoProtoCB();

        function RLiveHandshake(param1:Object) : void;

        function RCreateStream(param1:Object) : void;

        function BStreamBegin(param1:Object) : void;

        function BStreamEnd(param1:Object) : void;

        function RPlayStream(param1:Object) : void;

        function RGetStream(param1:Object) : void;

        function RSetVideoEnable(param1:Object) : void;

        function BVideoEnableChange(param1:Object) : void;

        function RPlayStreamEx(param1:Object) : void;

    }
}
