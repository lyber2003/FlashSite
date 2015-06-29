package rcbiz.interfaces
{
    import flash.utils.*;
    import rcbiz.interfaces.proto.*;
    import rcbiz.model.*;

    public interface IShowWidget
    {

        public function IShowWidget();

        function get protoApi() : IShowProtoApi;

        function init() : void;

        function initShowWidget() : void;

        function get bWidgetInit() : Boolean;

        function get multiGiftingData() : Array;

        function get giftData() : Dictionary;

        function get classified() : Dictionary;

        function get packetData() : Array;

        function get showToolList() : Array;

        function get toolPacketList() : Array;

        function get state() : int;

        function get errorMessage() : String;

        function set errorMessage(param1:String) : void;

        function getShowToolItemById(param1:uint) : PropItemInfo;

        function changeVoiceNormal() : void;

        function setBg(param1:int, param2:int) : void;

        function get background() : uint;

        function set background(param1:uint) : void;

        function get toolStateList() : Dictionary;

        function get effectUrl() : String;

        function set effectUrl(param1:String) : void;

        function set effect(param1:uint) : void;

        function get effect() : uint;

        function get backGroundUrl() : String;

        function set backGroundUrl(param1:String) : void;

        function get voiceChangeTime() : int;

        function get refreshTime() : Number;

        function get eggInfoArr() : Array;

        function get refreshCost() : Number;

        function navigatToMyHomePage() : void;

        function navigatToHomePage(param1:int) : void;

        function navigatToSingerPage() : void;

        function navigateToFBPage() : void;

        function navigatToActivetyHome() : void;

        function playGame(param1:int) : void;

        function isFollowSinger(param1:int) : Boolean;

        function updateFollowSinger(param1:int, param2:Boolean) : void;

        function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void;

        function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void;

    }
}
