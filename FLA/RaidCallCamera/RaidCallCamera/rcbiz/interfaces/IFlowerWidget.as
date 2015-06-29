package rcbiz.interfaces
{
    import rcbiz.interfaces.proto.*;

    public interface IFlowerWidget
    {

        public function IFlowerWidget();

        function get protoApi() : IFlowerProtoApi;

        function initialize() : void;

        function sendFlower() : void;

        function get maxFlower() : int;

        function get flowerTime() : int;

        function get myFlowerNum() : int;

        function get remainTime() : int;

        function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void;

        function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void;

    }
}
