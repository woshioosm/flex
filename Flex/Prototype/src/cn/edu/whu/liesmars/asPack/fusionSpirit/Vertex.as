package cn.edu.whu.liesmars.asPack.fusionSpirit
{
    import flash.display.*;
    import flash.geom.*;
    
    //import valueObjects.AdvancedFrame;
    
    public class Vertex extends flash.display.Sprite
    {
        public function Vertex()
        {
            this.velocity = new flash.geom.Point();
            this.net_force = new flash.geom.Point();
            super();
            with (graphics) 
            {
                beginFill(0x00ffff);
                drawEllipse(-VertexRad, -VertexRad, 24, 24);
                endFill();
            }
		
            return;
        }
        public  static var VertexRad:int=12;
        public var isDragged:Boolean=false;

        public var net_force:flash.geom.Point;

        public var velocity:flash.geom.Point;
		
		public var value:String="";
		
		
	   
    }
}
