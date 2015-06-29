package rcbiz.model.show.video
{

    public class StreamObject extends Object
    {
        public var result:uint;
        public var cmd:String;
        public var url:String;
        public var stream:String;
        public var token:String;
        public var specifier:String;
        public var protocols:Array;

        public function StreamObject(param1:Object) : void
        {
            if (param1.result != null)
            {
                this.result = param1.result;
            }
            if (param1.cmd != null)
            {
                this.cmd = param1.cmd;
            }
            if (param1.url != null)
            {
                this.url = param1.url;
            }
            if (param1.stream != null)
            {
                this.stream = param1.stream;
            }
            if (param1.token != null)
            {
                this.token = param1.token;
            }
            if (param1.specifier != null)
            {
                this.specifier = param1.specifier;
            }
            if (param1.protocols != null)
            {
                this.protocols = param1.protocols;
            }
            return;
        }// end function

    }
}
