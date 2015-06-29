package
{
import com.icecastplayer.IcecastPlayer;
import flash.display.Stage;
import flash.net.URLRequest;
import flash.display.Sprite;
import flash.text.TextField;
import flash.events.*;

//import flash.media.Sound;
import flash.media.SoundChannel; 
import flash.media.SoundMixer;
import flash.media.SoundTransform;
import flash.system.*;
Security.allowDomain("*");
    


  public class icecastPlayerApp extends flash.display.MovieClip
  {
	  
	  
	 

		//public  var icer:IcecastPlayer = new IcecastPlayer(new URLRequest("http://fs1.stream24.net:8260/stream"));
		public  var icer:IcecastPlayer = new IcecastPlayer(new URLRequest("http://37.57.234.41:2000/stream"));
    public function icecastPlayerApp()
    {
		trace("icecastPlayerApp loaded")
		//var player:IcecastPlayer = new IcecastPlayer(new URLRequest("http://37.57.234.41:1000/stream"));
		//var tf:TextField;
		//	tf = new TextField();
		//	tf.text = "    RRC"  ;
		//	addChild(tf);
		//trace("icecastPlayerApp");
      //var player:IcecastPlayer = new IcecastPlayer(new URLRequest("http://streaming201.radionomy.com:80/Jazz-in-Bolz"));
	  //icer.play();
	  
	  //создаем кнопочки
		    
	  
	  //var stage:Stage = this.stage;
	 // stage.SoundTransform(0.2, -1);	
			//SoundMixer.soundTransform = new SoundTransform(1, -1);
			
			
			
			//добавляем первую кнопку, затем перемещаем её на требуемое место
			
			
			//player.play();
			//this.btn3.addEventListener(MouseEvent.CLICK,  player.play);
	  
			//icer.play();
		
			//SoundMixer.soundTransform = new SoundTransform(0);
      
	  //player.stop();
    }
	
	
  }
}