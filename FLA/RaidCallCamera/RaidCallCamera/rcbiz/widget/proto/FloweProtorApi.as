package rcbiz.widget.proto
{
    import rcbiz.interfaces.proto.*;

    public class FloweProtorApi extends Object implements IFlowerProtoApi
    {
        private var api:IClientProtoApi;
        private var id:int;

        public function FloweProtorApi(param1:IClientProtoApi, param2:int)
        {
            this.api = param1;
            this.id = param2;
            return;
        }// end function

        public function PHandshake() : void
        {
            this.callServer("PHandshake");
            return;
        }// end function

        public function PSendFlower(param1:Object) : void
        {
            this.callServer("PSendFlower", param1);
            return;
        }// end function

        public function PGetFlowers(param1:Object) : void
        {
            this.callServer("PGetFlowers", param1);
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
