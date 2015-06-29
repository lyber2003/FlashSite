package
{
    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.events.NetStatusEvent;
    import flash.media.Camera;
    import flash.media.Microphone;
    import flash.media.Video;
    import flash.net.GroupSpecifier;
    import flash.net.NetConnection;
    import flash.net.NetGroup;
    import flash.net.NetStream;
    import flash.text.TextField;
    import flash.text.TextFieldAutoSize;
    import flash.text.TextFormat;
    
    import fl.controls.Button;
    import fl.controls.TextInput;
    import flash.system.Security;
	import flash.system.SecurityPanel;

	Security.showSettings(SecurityPanel.CAMERA);
	
	
	
    [SWF(width="320", height="240")]
    public class p2pPart3 extends Sprite
    {
        // поле ввода имени
        private var nameInput:TextInput;
        //
        // поле ввода группы
        private var groupInput:TextInput;
        // кнопка установки соединения
        private var button:Button;
        public function p2pPart3()
        {
			this.addEventListener(Event.ADDED_TO_STAGE, init);
            
            //
            createUI();
        }
		function init(e:Event):void{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			this.graphics.lineStyle(1, 0x999999);
            this.graphics.drawRect(0, 0, this.stage.stageWidth-1, this.stage.stageHeight-1);
            this.stage.scaleMode = StageScaleMode.SHOW_ALL;
            this.stage.align = StageAlign.TOP_LEFT;	
			
		}
        
        // ******************************************************************************************
        // создание интерфейса, кнопок и текстовых полей ********************************************
        // ******************************************************************************************
        
        private function createUI():void
        {
            //var label:TextField = createLabel('введите имя,');
            //label.x = 30;
            //label.y = 60;
            //
            // создаем поле выода имени
            nameInput = new TextInput();
            //this.addChild(nameInput);
			
			nameInput.text="Name"+ + Math.random();
            nameInput.x = 120;
            nameInput.y = 70;
            //nameInput.addEventListener(Event.CHANGE, inputChangeHadnler);
            //
            //label = createLabel('введите группу');
            //label.x = 30;
            //label.y = 100;
            //
            // создаем поле выода имени
            groupInput = new TextInput();
            //this.addChild(groupInput);
            groupInput.x = 120;
            groupInput.y = 100;
            //groupInput.addEventListener(Event.CHANGE, inputChangeHadnler);
            //
            //label = createLabel('и нажмите ->');
            //label.x = 30;
            //label.y = 90;
            //
            // создаем кнопку установки соединения
            button = new Button();
            button.label = 'connect';
           // button.addEventListener(MouseEvent.CLICK, clickHandler);
            //this.addChild(button);
            button.x = 120;
            button.y = 130;
			
			groupInput.text="con"
			
			connect();
            button.enabled = nameInput.text != '' && groupInput.text != '';
        }
        
        private function createLabel(text:String):TextField
        {
            var label:TextField = new TextField();
            label.defaultTextFormat = new TextFormat('Tahoma', 11);
            label.autoSize = TextFieldAutoSize.LEFT;
            label.text = text;
            this.addChild(label);
            return label;
        }
        
        private function inputChangeHadnler(event:Event):void
        {
            button.enabled = nameInput.text != '' && groupInput.text != '';
        }
        
        /**
         * обработчик события клика по кнопке
         */
        private function clickHandler(event:MouseEvent):void
        {
            if (DeveloperKey == '' || DeveloperKey == 'укажите ваш ключ') {
                trace('ВНИМАНИЕ! Вы не указали свой ключ разраюотчика в параметре DeveloperKey');
                return;
            }
            // делаем элементы неактивными
            button.enabled = false;
            nameInput.enabled = false;
            groupInput.enabled = false;
            //
            //
            // устанавливаем соединение
            connect();
        }
        
        // ******************************************************************************************
        // работа с p2p, подключение к p2p и публикация своего видео ********************************
        // ******************************************************************************************
        
        // ссылка на сервер Adobe
        public static const StratusAddress:String = "rtmfp://stratus.adobe.com/";
        // ваш персональный ключ разработчика
        
        
        public static const DeveloperKey:String = "ae77ed20b821c076440d4bfa-b82e3b3a92d1";
        // вспомогательный объект
        // для установки p2p-соединия
        private var netConnection:NetConnection;
        // объект который будет напрямую
        // работать с p2p сетью
        private var netGroup:NetGroup;
        //
        // стрим для отправки данных в сеть
        private var netStreamPublishVideo:NetStream;
        // стрим для получения данных из сети
        private var streamPlayer:NetStream;
        
        /**
         * Метод инициализирующий
         * установку соединения
         */        
        private function connect():void
        {
            netConnection = new NetConnection();
            //  слушаем событие
            netConnection.addEventListener(NetStatusEvent.NET_STATUS, netConnectionHandler);
            // стартуем установку соединения
            // используя ссылку на сервер Adobe
            // и ваш ключ разработчика
            netConnection.connect(StratusAddress + DeveloperKey);
        }
        
        /**
         * Обработчик событий NetConnection #1
         */
        private function netConnectionHandler(event:NetStatusEvent):void
        {
            trace('netConnection:', event.info.code);
            switch(event.info.code)
            {
                // устанвока с NetConnection
                // прошла успешно
                case "NetConnection.Connect.Success":
                    onConnect();
                    break;
                // устанвока соединения с p2p сетью
                // прошла успешно
                case "NetGroup.Connect.Success":
                    onGroupConnect();
                    break;
                // стрим успешно подключился к сети
                case "NetStream.Connect.Success":
                    onStreamPublicherConnect(event.info.stream);
                    break;
            }
        }
        
        
        
        // мой peerId
        private var myPeerId:String;
        // данные для подклчюения
        private var groupSpecifier:GroupSpecifier;
        private function onConnect():void
        {
            myPeerId = netConnection.nearID;
            //
            // создаем класс который содержит
            // информацию для подклчюения
            groupSpecifier = new GroupSpecifier(groupInput.text);
            // данные отправляются в режиме multicast
            groupSpecifier.multicastEnabled = true;
            // сообщаем что флешки могут
            // создавать связь между собой
            groupSpecifier.serverChannelEnabled = true;
            // сообщаем что флешки могут
            // отправлять сообщения методом Post
            groupSpecifier.postingEnabled = true;
            //
            // создаем объект для подклчюения к p2p
            netGroup = new NetGroup(netConnection, groupSpecifier.groupspecWithAuthorizations());
            // начинаем слушать события NetGroup
            netGroup.addEventListener(NetStatusEvent.NET_STATUS, netGroupHandler);
        }
        
        /**
         * Обработчик события об успешности
         * подключения к p2p сети
         */
        private function onGroupConnect():void
        {
            netStreamPublishVideo = new NetStream(netConnection, groupSpecifier.groupspecWithAuthorizations());
        }
        
        /**
         * Обработчик об успешности подключения
         * стрима для публикации видео
         */
        private function onStreamPublicherConnect(stream:NetStream):void
        {
			
			var frontCamera:Camera = tryGetFrontCamera();
				if (!frontCamera) {
					//Front facing camera unavailable
					return;
				}
			
            // подключаем камеру и микрофон
			// var camera:Camera = Camera.getCamera();
			//if (camera == null) return;
			var camera:Camera = frontCamera;
            camera.setMode(320, 240, 15);
            camera.setQuality(0, 80);
            netStreamPublishVideo.attachCamera(camera);
            netStreamPublishVideo.attachAudio(Microphone.getMicrophone());
            //
            // создаем имя нашего видео потока
            var myStreamName:String = 'video_'+nameInput.text;
            // публикуем видео в именном потоке
            netStreamPublishVideo.publish(myStreamName);
        }
		
		public function tryGetFrontCamera():Camera {
			var numCameras:uint = (Camera.isSupported) ? Camera.names.length : 0;
			for (var i:uint = 0; i < numCameras; i++) {
				var cam = Camera.getCamera(String(i));
				//if (cam && cam.position == CameraPosition.FRONT) {
					return cam;
				//}
			} 
		return null;
		}
		
		
		
        
        /**
         * Обработчик событий NetConnection #2
         */
        private function netGroupHandler(event:NetStatusEvent):void
        {
            trace('netGroup:', event.info.code);
            switch(event.info.code)
            {
                // В сети появился новый поток
                case "NetGroup.MulticastStream.PublishNotify":
                    var streamName:String = event.info.name;
                    multicastStreamNotify(streamName);
                    break;
            }
        }
 
        // ******************************************************************************************
        // работа с p2p, воспроизведение полученного видео потока ***********************************
        // ******************************************************************************************
        
        // визуальный объект который отображает видео
        private var videoView:Video;
        /**
         * Метод вызывается когда
         * в сети обнаруживается новый поток данных
         */
        private function multicastStreamNotify(streamName:String):void
        {
            // создаем объект который загружает данные из сети
            streamPlayer = new NetStream(netConnection, groupSpecifier.groupspecWithAuthorizations());
            streamPlayer.addEventListener(NetStatusEvent.NET_STATUS, streamPlayHandler);
            // и воспроизводим именной видео поток
            streamPlayer.play(streamName);
        }
        
        /**
         * Обработчик событий NetConnection #3
         */
        private function streamPlayHandler(event:NetStatusEvent):void
        {
            trace('streamPlay:', event.info.code);
            switch (event.info.code) {
                // воспроизведение началось
                // создаем визуальный объект
                // для отображения видео
                case 'NetStream.Play.Start':
                    videoView = new Video();
                    videoView.attachNetStream(streamPlayer);
                    this.addChild(videoView);
					videoView.width=320;
					videoView.height=240;
                    videoView.x = 0;
                    videoView.y = 0;
                    break;
            }
        }
    }
}