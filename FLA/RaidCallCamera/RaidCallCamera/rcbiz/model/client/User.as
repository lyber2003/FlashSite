package rcbiz.model.client
{

    public class User extends Object
    {
        public var uid:int = 0;
        public var cookie:String;
        public var nick:String;
        public var sign:String;
        public var fbToken:String;
        public var silver:int;
        public var role:int;
        public var isOnMic:Boolean;
        public var isMe:Boolean;
        public var singerInfo:Singer;
        public var isLive:Boolean;
        public var imageUrl:String;
        public var isNew:Boolean;

        public function User()
        {
            this.singerInfo = new Singer();
            return;
        }// end function

    }
}
