package rcbiz.widget.proto
{
    import rcbiz.interfaces.proto.*;

    public class VideoProtoApi extends Object implements IVideoProtoApi
    {
        private var api:IClientProtoApi;
        private var id:int;

        public function VideoProtoApi(param1:IClientProtoApi, param2:int)
        {
            this.api = param1;
            this.id = param2;
            return;
        }// end function

        public function PLiveHandshake() : void
        {
            this.callServer("PLiveHandshake");
            return;
        }// end function

        public function PGetStream() : void
        {
            this.callServer("PGetStream");
            return;
        }// end function

        public function PCreateStream(param1:int) : void
        {
            this.callServer("PCreateStream", {region:param1});
            return;
        }// end function

        public function PDeleteStream() : void
        {
            this.callServer("PDeleteStream");
            return;
        }// end function

        public function PPlayStream(param1:Array, param2:int) : void
        {
            if (param1 == null)
            {
                this.callServer("PPlayStream", {region:param2});
            }
            else
            {
                this.callServer("PPlayStream", {protocols:param1, region:param2});
            }
            return;
        }// end function

        public function PSetVideoEnable(param1:int) : void
        {
            this.callServer("PSetVideoEnable", {enable:param1});
            return;
        }// end function

        public function PPlayStreamEx(param1:Array) : void
        {
            this.callServer("PPlayStreamEx", {protocols:param1});
            return;
        }// end function

        private function callServer(param1:String, param2:Object = null) : void
        {
            if (param2 == null)
            {
                param2 = new Object();
            }
            param2.cmd = param1;
            this.api.SecCallServer(this.id, JSON.stringify(param2));
            return;
        }// end function

    }
}
