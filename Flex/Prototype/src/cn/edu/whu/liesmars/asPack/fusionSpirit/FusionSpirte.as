package cn.edu.whu.liesmars.asPack.fusionSpirit
{
    import __AS3__.vec.*;
    
    import adobe.utils.*;
    
    import flash.accessibility.*;
    import flash.desktop.*;
    import flash.display.*;
    import flash.errors.*;
    import flash.events.*;
    import flash.external.*;
    import flash.filters.*;
    import flash.geom.*;
    import flash.media.*;
    import flash.net.*;
    import flash.printing.*;
    import flash.profiler.*;
    import flash.sampler.*;
    import flash.system.*;
    import flash.text.*;
    import flash.text.engine.*;
    import flash.ui.*;
    import flash.utils.*;
    import flash.xml.*;
    
    import mx.collections.ArrayCollection;
    import mx.collections.ArrayList;
    
    import valueObjects.PriPoint;
    import valueObjects.PriRelatedEdge;
    import valueObjects.PriRelatedModel;

    
    public dynamic class FusionSpirte
    {
		
		private var countFrame:int=0;
        public function FusionSpirte(relatedModel:PriRelatedModel,sprite:Sprite)
        {
			super();
			countFrame=0;
			if(relatedModel==null||sprite==null)
				return;
            
			this.relatedModel=relatedModel;	
			this.sprite=sprite;
			trace("sprite.width:"+sprite.width+" "+"sprite.height:"+sprite.height);
//			test();
			init();
			run();
            return;
        } 
		public function test():void{
			var v:Vertex = new Vertex();
			v.x = 0;
			v.y = 0;
			
			sprite.addChild(v);
		}
		public function stop():void{
			if(sprite==null)
				return;
			sprite.removeEventListener(Event.ENTER_FRAME,onEF);
		}
		public function init():void{
			countFrame=0;
			pointList=relatedModel.points;
			pointNum=pointList.length;
			n=pointNum;
			edgeList=relatedModel.edges;
		
			vertices=new Vector.<Vertex>(pointNum,true);
			edges=new Vector.<Vector.<PriRelatedEdge>>(pointNum,true);
			for(var i:int;i<pointNum;i++){
				edges[i]=new Vector.<PriRelatedEdge>(pointNum,true);
			}
			for each(var rsEdge:PriRelatedEdge in edgeList){
				edges[rsEdge.startPointIndex][rsEdge.endPointIndex]=rsEdge;
				edges[rsEdge.endPointIndex][rsEdge.startPointIndex]=rsEdge;
			}
			for(var k:int=0; k < pointNum; k++)
			{
				var v:Vertex = new Vertex();
				v.x = this.sprite.width/2-50+Math.random()*200;
				v.y = this.sprite.height/2-50+Math.random()*200;
				
				v.value=(pointList.getItemAt(k) as PriPoint).frame;
				vertices[k] = v;
				sprite.addChild(v);
				v.addEventListener(MouseEvent.MOUSE_DOWN, drag);
				v.addEventListener(MouseEvent.MOUSE_UP, sdrag);
				v.addEventListener(MouseEvent.MOUSE_OVER,mouseOverHandle);
				v.addEventListener(MouseEvent.MOUSE_OUT,mouseOutHandle);
			}
		}
		
		public function run():void{
			//this.makeRandom();
			//sprite.addEventListener(Event.ENTER_FRAME,onEF2);
			
			
			sprite.addEventListener(Event.ENTER_FRAME,onEF);
//			for(var i:int=0;i<200;i++){
//				onEF(null);
//			}
		}
		
		function onEF(e:Event):void
		{
//			if(countFrame==100)
//				stop();
			countFrame++;
			//trace(stage.width+" "+stage.height);
			for(i=0; i < n; i++) // loop through vertices
			{
				var v:Vertex = vertices[i];
				var u:Vertex;
				v.net_force.x = v.net_force.y = 0;
				for(j=0; j < n; j++) // loop through other vertices
				{
					if(i==j)continue;
					u = vertices[j]; 
					
					var rsq:Number = ((v.x-u.x)*(v.x-u.x)+(v.y-u.y)*(v.y-u.y));
					// 斥力
					if(rsq>10000)continue;
					v.net_force.x +=200 * (v.x-u.x) /rsq;
					v.net_force.y +=200 * (v.y-u.y) /rsq;
				}
				for(j=0; j < n; j++) // loop through edges
				{
					if(i==j)continue;
					if(edges[i][j]==null)continue;
					u = vertices[j];
					// 引力
//					var rsq:Number = ((v.x-u.x)*(v.x-u.x)+(v.y-u.y)*(v.y-u.y));
					
					v.net_force.x += 0.002*(u.x - v.x);
					v.net_force.y += 0.002*(u.y - v.y);
				}
				// counting the velocity (with damping 0.85)
				var forceTotleX:Number;
				var forceTotleY:Number;
				
				forceTotleX=v.velocity.x + v.net_force.x;
				forceTotleY=v.velocity.y + v.net_force.y;
				if(v.velocity.x + v.net_force.x<totleForceThrold&&v.velocity.x + v.net_force.x>-totleForceThrold)
					forceTotleX=0;
				if(v.velocity.y + v.net_force.y<totleForceThrold&&v.velocity.y + v.net_force.y>-totleForceThrold)
					forceTotleY=0;
				v.velocity.x = forceTotleX*0.85; 
				v.velocity.y = forceTotleY*0.85; 
			}
			for(i=0; i < n; i++) // set new positions
			{
				v = vertices[i];
				if(v.isDragged){ 
					v.x = sprite.mouseX; v.y = sprite.mouseY;
				}
				else {
					v.x += v.velocity.x; v.y += v.velocity.y;
					if(v.x<Vertex.VertexRad){
						v.x=Vertex.VertexRad;
					}if(v.y<Vertex.VertexRad){
						v.y=Vertex.VertexRad;
					}if(v.x>this.sprite.width-Vertex.VertexRad){
						v.x=this.sprite.width-Vertex.VertexRad;
					}if(v.y>this.sprite.height-Vertex.VertexRad){
						v.y=this.sprite.height-Vertex.VertexRad;
					}
				}
			}
			
		
			sprite.graphics.clear();
			
			var maxWidth:Number=-1;
			for(i=0; i < n; i++)
			{
				for(j=0; j < n; j++)
				{
					if(edges[i][j]==null) continue;
					if(maxWidth<edges[i][j].weight)
						maxWidth=edges[i][j].weight;
				}
			}
			
			
			
			for(i=0; i < n; i++)
			{
				for(j=0; j < n; j++)
				{
					if(edges[i][j]==null) continue;
					//trace(edges[i][j].level);
//					sprite.graphics.lineStyle(edges[i][j].level*2,0x333333,edges[i][j].weight*0.5);
					sprite.graphics.lineStyle(4,0x333333,edges[i][j].weight/maxWidth);
					sprite.graphics.moveTo(vertices[i].x, vertices[i].y);
					sprite.graphics.lineTo(vertices[j].x, vertices[j].y);
				}
			}
		}
		public function mouseOutHandle(arg1:flash.events.MouseEvent):void{
			if(this.sprite.getChildByName("tip")!=null)
				this.sprite.removeChild(txt);
		}
		public function mouseOverHandle(arg1:flash.events.MouseEvent):void{
			if(arg1.target.isDragged==true)
				return;
			txt.selectable=false;
			var vertex:Vertex=arg1.target as Vertex;
			if(vertex.value!=null)
			   txt.text=vertex.value;
			txt.width=txt.text.length*12;
			txt.height=20;
			//txt.background=0xf00000
			txt.x=(arg1.target as Vertex).x+10;
			txt.y=(arg1.target as Vertex).y;
			txt.name="tip";
			this.sprite.addChild(txt);
		}
		public function sdrag(arg1:flash.events.MouseEvent):void
		{
			arg1.target.isDragged = false;
			stop();
			return;
		}
		public function drag(arg1:flash.events.MouseEvent):void
		{
			arg1.target.isDragged = true;
			run();
			return;
		}
/*********************************************************************************
        public function makeRandom():void
        {
            if (this.n == 0 || this.e == 0) 
            {
                return;
            }
            if (this.e > (this.n * this.n - this.n) / 2) 
            {
                return;
            }
            while (sprite.numChildren > 5) 
            {
				sprite.removeChildAt((sprite.numChildren - 1));
            }
			//set of vertices
			vertices = new Vector.<Vertex>(n,true);
			
			//set of edges in symetric incidence matrix
			edges2 = new Vector.<Vector.<Boolean>>(n,true);
			
			for(i=0; i < n; i++)
				edges2[i] = new Vector.<Boolean>(n, true);
			while(e > 0) // add some edges
			{
				var a:int = Math.floor(Math.random()*n);
				var b:int = Math.floor(Math.random()*n);
				if(a==b || edges2[a][b])continue;
				edges2[a][b] = true;
				edges2[b][a] = true;
				e--;
			}
			// creating vertices
			for(i=0; i < n; i++)
			{
				var v:Vertex = new Vertex();
				v.x = 200+Math.random()*300;
				v.y = 100+Math.random()*200;
				vertices[i] = v;
				sprite.addChild(v);
				v.addEventListener(MouseEvent.MOUSE_DOWN, drag);
				v.addEventListener(MouseEvent.MOUSE_UP, sdrag);
			}
          return;
        }
		
		function onEF2(e:Event):void
		{
			//trace(stage.width+" "+stage.height);
			for(i=0; i < n; i++) // loop through vertices
			{
				var v:Vertex = vertices[i];
				var u:Vertex;
				v.net_force.x = v.net_force.y = 0;
				for(j=0; j < n; j++) // loop through other vertices
				{
					if(i==j)continue;
					u = vertices[j]; 
					// squared distance between "u" and "v" in 2D space
					var rsq:Number = ((v.x-u.x)*(v.x-u.x)+(v.y-u.y)*(v.y-u.y));
					// counting the repulsion between two vertices 
					if(rsq>2500)continue;
					v.net_force.x +=50 * (v.x-u.x) /rsq;
					v.net_force.y +=50 * (v.y-u.y) /rsq;
				}
				for(j=0; j < n; j++) // loop through edges
				{
					if(i==j)continue;
					if(!edges2[i][j])continue;
					u = vertices[j];
					// countin the attraction
					var rsq:Number = ((v.x-u.x)*(v.x-u.x)+(v.y-u.y)*(v.y-u.y));
					//if(rsq>1000)continue;
					v.net_force.x += 0.02*(u.x - v.x);
					v.net_force.y += 0.02*(u.y - v.y);
				}
				// counting the velocity (with damping 0.85)
				var forceTotleX:Number;
				var forceTotleY:Number;
				
				forceTotleX=v.velocity.x + v.net_force.x;
				forceTotleY=v.velocity.y + v.net_force.y;
				if(v.velocity.x + v.net_force.x<totleForceThrold&&v.velocity.x + v.net_force.x>-totleForceThrold)
					forceTotleX=0;
				if(v.velocity.y + v.net_force.y<totleForceThrold&&v.velocity.y + v.net_force.y>-totleForceThrold)
					forceTotleY=0;
				v.velocity.x = forceTotleX*0.85; 
				v.velocity.y = forceTotleY*0.85; 
			}
			for(i=0; i < n; i++) // set new positions
			{
				v = vertices[i];
				if(v.isDragged){ v.x = sprite.mouseX; v.y = sprite.mouseY; }
				else { v.x += v.velocity.x; v.y += v.velocity.y; }
			}
			
			trace(v.x+" "+v.y);
			// drawing edges
			sprite.graphics.clear();
			sprite.graphics.lineStyle(3,0x333333,0.1);
			for(i=0; i < n; i++)
			{
				for(j=0; j < n; j++)
				{
					if(!edges2[i][j]) continue;
					sprite.graphics.moveTo(vertices[i].x, vertices[i].y);
					sprite.graphics.lineTo(vertices[j].x, vertices[j].y);
				}
			}
		}
 ***********************************************************/
		

		
        public var edges:Vector.<Vector.<PriRelatedEdge>>;
		public var edges2:Vector.<Vector.<Boolean>>;
        public var i:int;

        public var j:int;

        public var e:int;

        public var n:int;

        public var vertices:Vector.<Vertex>;
		
		public  var totleForceThrold:Number=5;
		
		private var relatedModel:PriRelatedModel;
		private var pointList:ArrayCollection;
		private var edgeList:ArrayCollection;
		private var pointNum:int;
        private var sprite:Sprite;
		public var viewPort:Sprite = null;
		public var layerContainer:Sprite = null;
		private var txt:TextField=new TextField();
    }
}
