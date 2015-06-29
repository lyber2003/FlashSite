package rcbiz.interfaces.proto
{

    public interface IFlowerProtoCB
    {

        public function IFlowerProtoCB();

        function RHandshake(param1:Object) : void;

        function RSendFlower(param1:Object) : void;

        function RGetFlowers(param1:Object) : void;

        function RFlowerNotify(param1:Object) : void;

        function RSpeakerNotify(param1:Object) : void;

    }
}
