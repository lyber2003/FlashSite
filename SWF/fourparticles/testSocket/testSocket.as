package  {
	
	import flash.display.MovieClip;
	import flash.net.*;
	import flash.events.*;
	import flash.display.StageAlign;
    import flash.display.StageScaleMode; 
	 
	import flash.utils.ByteArray; 
	
	
	public class testSocket extends MovieClip {
		
		
		private var _player:Player = new Player();
		private var _players:Vector.<Player> = new Vector.<Player>();
		private var moveUpDown:int = 0; 
		private var moveLeftRight:int = 0;
		private var speed:int = 4;
		
		
		private var _sock:Socket = new Socket(); 
		
		
		private var _runSend:Boolean = false;
		 
		
		public function testSocket() {
			// constructor code
			stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.align = StageAlign.TOP_LEFT;
            stage.addEventListener(Event.ACTIVATE, _activateHandler);
		}
		
		
		
		private function _activateHandler(e:Event):void {
			stage.removeEventListener(Event.ACTIVATE, _activateHandler);
			_player.x = 100;
			_player.y = 100;
			addChild(_player);
			
			stage.addEventListener(Event.ENTER_FRAME, _enterFrame);
			stage.addEventListener(MouseEvent.CLICK, _click);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, _keyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, _keyUp);
			stage.focus = stage;
			//trace(stage.focus);
			
			_sock.addEventListener(ProgressEvent.SOCKET_DATA, _progressEvent);
			_sock.addEventListener(DataEvent.DATA, _dataHandler); 
			_sock.connect("192.168.1.100", 2345);
			_setNewPos();
			
		}
		
		
		private function _click(e:MouseEvent):void {
			//trace(e);
			stage.focus = stage;
		}
		
		
		
		/* */
		private function _keyDown(e:KeyboardEvent):void {
			if(e.keyCode == 40) {
				moveUpDown = 1;
			} else if(e.keyCode == 38) {
				moveUpDown = -1;
			} else if(e.keyCode == 37) {
				moveLeftRight = -1;
			} else if(e.keyCode == 39) {
				moveLeftRight = 1;
			}
			
			 
		}
		
		/* */
		private function _keyUp(e:KeyboardEvent):void {
			 
			if(e.keyCode == 40 || e.keyCode == 38) {
				moveUpDown = 0;
			}
			if(e.keyCode == 37 || e.keyCode == 39) {
				moveLeftRight = 0;
			}
		}
		
		
		
		
		/* */
		private function _enterFrame(e:Event):void {
			var update:Boolean = false;
			if(moveUpDown != 0) {
				update = true;
				_player.y += speed * moveUpDown;
			}
			if(moveLeftRight != 0) {
				update = true;
				_player.x += speed *moveLeftRight;
			}
			
			if( update) {
				_setNewPos();
			}
		}
		
		/* */
		private function _drawPlayers():void {
			var l:int = _players.length;
			
			if(l == 0) return;
			for(var i:int = 0; i < l; i ++) {
				if(_players[i] == null) continue;
				
				addChild(_players[i]);
			}
		}
		
		/* */
		private function _setNewPos():void {
			 
			
			 
			 _sock.writeObject({act:"setData", x:_player.x,y:_player.y});
			_sock.flush();  
			 
			
			trace("_setNewPos");
			 
		}
		
		/* */
		private function _progressEvent(e:ProgressEvent):void {
			 trace("OBJ " + _sock.bytesAvailable );
			 
			 try {
				 var obj:Object;
				 if(_players.length == 0) {
						 _players[0] = new Player();
						 addChild(_players[0]);
				 }
					
				 var counter:int = 100;	
				 while(obj  = _sock.readObject() ) {	 
					 if(obj) {  
						 _players[0].x = obj.x;
						 _players[0].y = obj.y;
						 
					 }
					 counter --;
					 if(counter < 100) break;
				 }
				 
				 
			 } catch(err:Error) {
				 trace("_progressEvent " + err);
			 }
			  
		}
		
		/* */
		private function _dataHandler(event:DataEvent):void {
            trace("dataHandler: " + event.data);
			 
			 
        }
		
 
		
		
	}
	
}

class TestIfo {
	public var x:int;
	public var y:int;
}
