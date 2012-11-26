package com.xenojoshua.as3demo.battle.display.render
{
	import com.greensock.TweenLite;
	import com.greensock.plugins.AutoAlphaPlugin;
	import com.greensock.plugins.TweenPlugin;
	import com.xenojoshua.af.utils.console.XafConsole;
	import com.xenojoshua.af.utils.timer.XafTimerManager;
	import com.xenojoshua.as3demo.battle.display.layers.AppBattleGridManager;
	import com.xenojoshua.as3demo.battle.logic.AppBattleProcessor;
	import com.xenojoshua.as3demo.mvc.model.enum.battle.AppSoldierAnimeName;
	import com.xenojoshua.as3demo.mvc.model.vo.battle.AppBattleSoldier;
	import com.xenojoshua.as3demo.mvc.view.battle.AppBattleMediator;
	import com.xenojoshua.as3demo.mvc.view.battle.AppBattleView;
	import com.xenojoshua.as3demo.mvc.view.battle.soldier.AppBattleSoldierView;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import org.osflash.signals.Signal;

	public class AppBattleRender
	{
		private static var _instance:AppBattleRender;
		
		/**
		 * Get instance of AppBattleRender.
		 * @return AppBattleRender _instance
		 */
		public static function get instance():AppBattleRender {
			if (!AppBattleRender._instance) {
				AppBattleRender._instance = new AppBattleRender();
			}
			return AppBattleRender._instance;
		}
		
		/**
		 * Initialize AppBattleRender.
		 * @return void
		 */
		public function AppBattleRender() {
			this._atkSoldiers = new Object();
			this._defSoldiers = new Object();
			this._playList = new Array();
			this._playListParams = new Array();
			this._playListDelay = new Array();
			this._playingCount = 0;
			this._playDelay = 0;
			this._currentQueueIndex = 0;
		}
		
		/**
		 * Destory the render.
		 * @return void
		 */
		public function dispose():void {
			for (var atkGridId:String in this._atkSoldiers) {
				this._atkSoldiers[atkGridId].dispose();
			}
			this._atkSoldiers = {};
			for (var defGridId:String in this._defSoldiers) {
				this._atkSoldiers[defGridId].dispose();
			}
			this._defSoldiers = {};
			
			this._playList = [];
			this._playListParams = [];
			this._playListDelay = [];
			
			this._playingCount = 0;
			this._playDelay = 0;
			this._currentQueueIndex = 0;
		}
		
		private var DELAY_TIMER_NAME:String = 'AppBattleRenderDelayTimer';
		private var ATK_MV_SIZE_FACTOR:Number = 0.5;
		private var FADE_MV_SIZE_FACTOR:Number = 0.2;
		private var FADE_SPEED:Number = 0.5; // fade in x seconds
		
		private var _atkSoldiers:Object; // <gridId:int, view:AppBattleSoldierView>
		private var _defSoldiers:Object; // <gridId:int, view:AppBattleSoldierView>
		
		/**
		 * this._playList:Array = [
		 *     [AppBattleRender.instance.playStand, AppBattleRender.instance.playAttack], // these two animes will be played first (one by one)
		 *     [AppBattleRender.instance.playHurt] // then after two animes above finished, this anime will be played
		 * ];
		 * this._playListParams:Array = [
		 *     [[soldier], [soldier, target]], // parameter array of the two animes with index 0
		 *     [[soldier]]
		 * ];
		 * this._playListDelay:Array = [
		 *     1000, // delay between index 0 animes and index 1 animes (delay: how many milliseconds after the animes of index 0 finished)
		 *     0
		 * ];
		 */
		private var _playList:Array;       // <index:int, animeFuncArr:Array>
		private var _playListParams:Array; // <index:int, animeFuncParamsArr:Array>
		private var _playListDelay:Array;  // <index:int, animeFuncDelay:Array>
		
		// STATUS
		private var _playingCount:int;
		private var _playDelay:int;
		private var _currentQueueIndex:int;
		
		// MOVE POINTS
		private var _moveFadeX:Number;   // fade end point x
		private var _moveFadeY:Number;   // fade end point y
		private var _moveAppearX:Number; // appear point x
		private var _moveAppearY:Number; // appear point y
		private var _moveEndX:Number;    // end point x
		private var _moveEndY:Number;    // end point y
		
		//-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
		//-* DATA INITIALIZATION
		//-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
		/**
		 * Register battle soldier views.
		 * @param Array attackers 'AppBattleSoldierInfo'
		 * @param Array defenders 'AppBattleSoldierInfo'
		 * @return AppBattleRender render
		 */
		public function registerBattleSoldierView(attackers:Array, defenders:Array):AppBattleRender {
			for each (var atkSoldier:AppBattleSoldier in attackers) {
				var atkSoldierView:AppBattleSoldierView = new AppBattleSoldierView();
				var atkGrid:DisplayObjectContainer = AppBattleGridManager.instance.getAtkGrid(atkSoldier.gridId);
				atkGrid.addChild(atkSoldierView);
				this._atkSoldiers[atkSoldier.gridId] = atkSoldierView;
				this.playStand(atkSoldier);
			}
			for each (var defSoldier:AppBattleSoldier in defenders) {
				var defSoldierView:AppBattleSoldierView = new AppBattleSoldierView();
				var defGrid:DisplayObjectContainer = AppBattleGridManager.instance.getDefGrid(defSoldier.gridId);
				defGrid.addChild(defSoldierView);
				this._defSoldiers[defSoldier.gridId] = defSoldierView;
				this.playStand(defSoldier);
			}
			return this;
		}
		
		//-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
		//-* ANIME QUEUE
		//-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
		/**
		 * Push an animation function into queue.
		 * @param int index
		 * @param Function animeFunc
		 * @param Array animeParams
		 * @param int animeDelay default 0
		 * @return AppBattleRender render
		 */
		public function pushAnimeIntoQueue(
			index:int, animeFunc:Function,
			animeParams:Array, animeDelay:int = 0
		):AppBattleRender {
			if (!this._playList.hasOwnProperty(index)) {
				this._playList[index]       = new Array();
				this._playListParams[index] = new Array();
				this._playListDelay[index]  = 0;
			}
			
			this._playList[index].push(animeFunc);
			this._playListParams[index].push(animeParams);
			if (animeDelay > this._playListDelay[index]) {
				this._playListDelay[index] = animeDelay;
			}
			
			return this;
		}
		
		/**
		 * Play the anime queue.
		 * @return void
		 */
		public function playQueue():void {
			this.removeQueueDelay(); // no matter delay timer exists or not, call remove first
			var isAnyAnimeInQueue:Boolean = false; // mark no anime left first

			for (var index:String in this._playList) {
				isAnyAnimeInQueue = true; // has anime left to play
				this._currentQueueIndex = Number(index);
				
				var queue:Array = this._playList[index];
				var queueParams:Array = this._playListParams[index];
				var queueDelay:int = this._playListDelay[index];
				// loop current index of queue, play all the animes
				for (var queuePos:String in queue) {
					var animeFunc:Function = queue[queuePos];
					var animeFuncParams:Array = queueParams[queuePos];
					animeFunc.apply(null, animeFuncParams); // play the anmie
					if (animeFunc != this.playStand) { // do not count stand anime
						++this._playingCount;
					}
				}
				if (queueDelay > 0) {
					this._playDelay = queueDelay;
				}
			}
			
			if (!isAnyAnimeInQueue) {
				AppBattleProcessor.instance.loop();
			}
		}
		
		/**
		 * Called when one anime ends.
		 * @return void
		 */
		private function onSingleAnimeEnd():void {
			--this._playingCount;
			if (this._playingCount <= 0) { // all animes of this loop has been finished
				// reset playing count
				this._playingCount = 0;
				// remove finished queue loop
				delete this._playList[this._currentQueueIndex];
				delete this._playListParams[this._currentQueueIndex];
				delete this._playListDelay[this._currentQueueIndex];
				this._currentQueueIndex = 0;
				// check delay
				if (this._playDelay) { // means need to delay, then play the next loop of anime queue
					// reset delay time
					this._playDelay = 0;
					this.setQueueDelay();
				} else  {
					this.playQueue();
				}
			}
		}
		
		/**
		 * Set queue play delay timer.
		 * @return void
		 */
		private function setQueueDelay():void {
			XafTimerManager.instance.registerTimer(this.DELAY_TIMER_NAME, this._playDelay, this.playQueue, 1);
		}
		
		/**
		 * Remove registered queue play delay timer.
		 * @return void
		 */
		private function removeQueueDelay():void {
			XafTimerManager.instance.removeTimer(this.DELAY_TIMER_NAME);
		}
		
		//-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
		//-* ANIME FUNCTIONS
		//-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
		/**
		 * Play soldier stand anime.
		 * This anime will call anime end at the beginning when it's playing.
		 * @param AppBattleSoldier soldier
		 * @return void
		 */
		public function playStand(soldier:AppBattleSoldier):void {
			var view:AppBattleSoldierView = this.getSoldierView(soldier);
			if (!view) {
				return;
			}
			view.removeRoleLayer();
			
			var movie:MovieClip = AppBattleAnimeManager.instance.getRoleStand(soldier.roleId, soldier.isAttacker);
			view.addRoleMovie(movie);
			
			movie.gotoAndPlay(1);
		}
		
		/**
		 * Play soldier attack anime.
		 * @param AppBattleSoldier soldier
		 * @return void
		 */
		public function playAttack(soldier:AppBattleSoldier):void {
			XafConsole.instance.log(XafConsole.DEBUG, 'AppBattleRender: Anime playAttack start: ' + (soldier.isAttacker ? 'ATK' : 'DEF') + '[' + soldier.gridId + ']');
			var view:AppBattleSoldierView = this.getSoldierView(soldier);
			if (!view) {
				return;
			}
			view.removeRoleLayer();
			
			var movie:MovieClip = AppBattleAnimeManager.instance.getRoleAttack(soldier.roleId, soldier.isAttacker);
			view.addRoleMovie(movie);
			var render:AppBattleRender = this;
			var attackEnd:Function = function(e:Event):void {
				var display:MovieClip = e.target as MovieClip;
				if (display.currentFrame == display.totalFrames) {
					display.removeEventListener(Event.ENTER_FRAME, attackEnd);
					render.playStand(soldier);
					XafConsole.instance.log(XafConsole.DEBUG, 'AppBattleRender: Anime playAttack end: ' + (soldier.isAttacker ? 'ATK' : 'DEF') + '[' + soldier.gridId + ']');
					render.onSingleAnimeEnd();
				}
			};
			movie.addEventListener(Event.ENTER_FRAME, attackEnd);
			movie.gotoAndPlay(1);
		}
		
		/**
		 * Play soldier skill anime.
		 * @param AppBattleSoldier soldier
		 * @return void
		 */
		public function playSkill(soldier:AppBattleSoldier):void {
			var view:AppBattleSoldierView = this.getSoldierView(soldier);
			if (!view) {
				return;
			}
			view.removeRoleLayer();
			
			var movie:MovieClip = AppBattleAnimeManager.instance.getRoleSkill(soldier.roleId, soldier.isAttacker);
			view.addRoleMovie(movie);
			var render:AppBattleRender = this;
			var skillEnd:Function = function(e:Event):void {
				var display:MovieClip = e.target as MovieClip;
				if (display.currentFrame == display.totalFrames) {
					display.removeEventListener(Event.ENTER_FRAME, skillEnd);
					render.playStand(soldier);
					render.onSingleAnimeEnd();
				}
			};
			movie.addEventListener(Event.ENTER_FRAME, skillEnd);
			movie.gotoAndPlay(1);
		}
		
		/**
		 * Play soldier hurt anime.
		 * @param AppBattleSoldier soldier
		 * @return void
		 */
		public function playHurt(soldier:AppBattleSoldier):void {
			var view:AppBattleSoldierView = this.getSoldierView(soldier);
			if (!view) {
				return;
			}
			view.removeRoleLayer();
			
			var movie:MovieClip = AppBattleAnimeManager.instance.getRoleHit(soldier.roleId, soldier.isAttacker);
			view.addRoleMovie(movie);
			var render:AppBattleRender = this;
			var hurtEnd:Function = function(e:Event):void {
				var display:MovieClip = e.target as MovieClip;
				if (display.currentFrame == display.totalFrames) {
					display.removeEventListener(Event.ENTER_FRAME, hurtEnd);
					render.playStand(soldier);
					render.onSingleAnimeEnd();
				}
			};
			movie.addEventListener(Event.ENTER_FRAME, hurtEnd);
			movie.gotoAndPlay(1);
		}
		
		/**
		 * Play attack effect on defender (attack hurt recipient).
		 * @param AppBattleSoldier attacker attack caster
		 * @param AppBattleSoldier defender attack recipient
		 * @return void
		 */
		public function playAttackEffect(attacker:AppBattleSoldier, defender:AppBattleSoldier):void {
			var view:AppBattleSoldierView = this.getSoldierView(defender);
			if (!view) {
				return;
			}
			view.removeEffectLayer();
			
			var movie:MovieClip = AppBattleAnimeManager.instance.getAttackEffect(
				attacker.isMagic ? AppBattleAnimeManager.ATTACK_TYPE_MGK : AppBattleAnimeManager.ATTACK_TYPE_PHY,
				defender.isAttacker
			);
			view.addEffectMovie(movie);
			var render:AppBattleRender = this;
			var effectEnd:Function = function(e:Event):void {
				var display:MovieClip = e.target as MovieClip;
				if (display.currentFrame == display.totalFrames) {
					display.removeEventListener(Event.ENTER_FRAME, effectEnd);
					view.removeEffectLayer();
					render.onSingleAnimeEnd();
				}
			};
			movie.addEventListener(Event.ENTER_FRAME, effectEnd);
			movie.gotoAndPlay(1);
		}
		
		/**
		 * Play skill effect on defender (skill hurt recipient).
		 * @param AppBattleSoldier attacker skill caster
		 * @param AppBattleSoldier defender skill recipient
		 * @return void
		 */
		public function playSkillEffect(attacker:AppBattleSoldier, defender:AppBattleSoldier):void {
			var view:AppBattleSoldierView = this.getSoldierView(defender);
			if (!view) {
				return;
			}
			view.removeEffectLayer();
			
			var movie:MovieClip = AppBattleAnimeManager.instance.getSkillEffect(attacker.skillId, defender.isAttacker);
			view.addEffectMovie(movie);
			var render:AppBattleRender = this;
			var effectEnd:Function = function(e:Event):void {
				var display:MovieClip = e.target as MovieClip;
				if (display.currentFrame == display.totalFrames) {
					display.removeEventListener(Event.ENTER_FRAME, effectEnd);
					view.removeEffectLayer();
					render.onSingleAnimeEnd();
				}
			};
			movie.addEventListener(Event.ENTER_FRAME, effectEnd);
			movie.gotoAndPlay(1);
		}
		
		/**
		 * Play die anime.
		 * @param AppBattleSoldier soldier
		 * @return void
		 */
		public function playDie(soldier:AppBattleSoldier):void {
			var view:AppBattleSoldierView = this.getSoldierView(soldier);
			if (!view) {
				return;
			}
			TweenPlugin.activate([AutoAlphaPlugin]);
			TweenLite.to(view.getRoleMovie(), 0.5, {
				autoAlpha: 0, onComplete: this.onDieEnd, onCompleteParams: [soldier, view]
			});
		}
		
		/**
		 * Callback when die anime ends.
		 * @param AppBattleSoldier soldier
		 * @param AppBattleSoldierView view
		 * @return void
		 */
		private function onDieEnd(soldier:AppBattleSoldier, view:AppBattleSoldierView):void {
			// dispose the view
			view.dispose();
			// remove manager handler
			if (soldier.isAttacker) {
				delete this._atkSoldiers[soldier.gridId];
			} else {
				delete this._defSoldiers[soldier.gridId];
			}
			AppBattleProcessor.instance.removeDeadSoldier(soldier.gridId, soldier.isAttacker);
			this.onSingleAnimeEnd();
		}
		
		//-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
		//-* MOVE ANIMATION
		//-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
		/**
		 * Play role move anime, start to fade.
		 * @param AppBattleSoldier actor
		 * @param AppBattleSoldier recipient
		 * @return void
		 */
		public function playMoveTo(actor:AppBattleSoldier, recipient:AppBattleSoldier):void {
			/**
			 * There are FIVE concepts on stage
			 * 1. stage layer: AppBattleView (XafConst.SCREEN_BATTLE)
			 * 2. battle grid layer: AppBattleGridView (AppBattleGridManager) [Point(0, 0) of AppBattleView]
			 * 3. battle grids: movies in AppBAttleGridView, those grids has absolute points on stage [Point(x, y) of AppBattleGridView]
			 * 4. soldier view: AppBattleSoldierView (AppBattleRender) [Point(0, 0) of battle grid movie]
			 * 5. soldier movie: movies on AppBattleSoldierView._roleLayer [Point(0, 0) of AppBattleSoldierView]
			 * 
			 * If you want to move a soldier movie, you have to calculate the relative position of the soldier view,
			 * from the absolute points of the grids.
			 */
			var actView:AppBattleSoldierView = this.getSoldierView(actor);
			if (!actView) {
				return;
			}
			var actMovie:MovieClip = actView.getRoleMovie();
			var actGrid:DisplayObjectContainer = AppBattleGridManager.instance.getAtkGrid(actor.gridId);
			var recGrid:DisplayObjectContainer = AppBattleGridManager.instance.getDefGrid(recipient.gridId);
			
			// actor start point on stage (absolute point on stage)
			var absStartX:Number = actGrid.x;
			var absStartY:Number = actGrid.y;
			// actor target end point on stage (absolute point on stage)
			var absTargetX:Number = actor.isAttacker ? (recGrid.x - actMovie.width * this.ATK_MV_SIZE_FACTOR) : (recGrid.x + actMovie.width * this.ATK_MV_SIZE_FACTOR);
			var absTargetY:Number = recGrid.y;
			// actor start to appear point on stage (absolute point on stage)
			var absStartToAppearX:Number = actor.isAttacker ? (absTargetX - actMovie.width * this.FADE_MV_SIZE_FACTOR) : (absTargetX + actMovie.width * this.FADE_MV_SIZE_FACTOR);
			var absStartToAppearY:Number = absTargetY - actMovie.height * this.FADE_MV_SIZE_FACTOR;
			
			// actor fade end point (relative point on actor view)
			this._moveFadeX = actor.isAttacker ? 0 + actMovie.width * this.FADE_MV_SIZE_FACTOR : 0 - actMovie.width * this.FADE_MV_SIZE_FACTOR;
			this._moveFadeY = 0 - actMovie.height * this.FADE_MV_SIZE_FACTOR;
			// actor start to appear point
			this._moveAppearX = absStartToAppearX - absStartX;
			this._moveAppearY = absStartToAppearY - absStartY;
			// actor start to end point
			this._moveEndX = absTargetX - absStartX;
			this._moveEndY = absTargetY - absStartY;
			
			this.startToFade(actor, actMovie);
		}
		
		/**
		 * Play role move anime, start to fade.
		 * From START point to FADE point.
		 * @param AppBattleSoldier actor
		 * @param MovieClip actMovie
		 * @return void
		 */
		private function startToFade(actor:AppBattleSoldier, actMovie:MovieClip):void {
			TweenPlugin.activate([AutoAlphaPlugin]);
			TweenLite.to(
				actMovie, this.FADE_SPEED, {
					x: this._moveFadeX, y: this._moveFadeY, autoAlpha: 0,
					onComplete: this.onMoveStartFadeEnd,
					onCompleteParams: [actor, actMovie]
				}
			);
		}
		
		/**
		 * Play role move anime, fade end, start to show.
		 * From APPEAR point to END point.
		 * @param AppBattleSoldier actor
		 * @param MovieClip actMovie
		 * @return void
		 */
		private function onMoveStartFadeEnd(actor:AppBattleSoldier, actMovie:MovieClip):void {
			actMovie.x = this._moveAppearX;
			actMovie.y = this._moveAppearY;
			actMovie.alpha = 0;
			actMovie.visible = true;
			
			TweenLite.to(
				actMovie, this.FADE_SPEED, {
					x: this._moveEndX, y: this._moveEndY, autoAlpha: 1,
					onComplete: this.onMoveStartShowEnd,
					onCompleteParams: [actor]
				}
			);
		}
		
		/**
		 * Play role move anime, show end.
		 * @param AppBattleSoldier actor
		 * @return void
		 */
		private function onMoveStartShowEnd(actor:AppBattleSoldier):void {
			this.playStand(actor);
			this.onSingleAnimeEnd();
		}
		
		/**
		 * Play role movie anime, start to move back.
		 * From END point to APPEAR point.
		 * @param AppBattleSoldier actor
		 * @param MovieClip actMovie
		 * @return void
		 */
		public function playMoveBack(actor:AppBattleSoldier):void {
			var actView:AppBattleSoldierView = this.getSoldierView(actor);
			if (!actView) {
				return;
			}
			var actMovie:MovieClip = actView.getRoleMovie();
			TweenLite.to(
				actMovie, this.FADE_SPEED, {
					x: this._moveAppearX, y: this._moveAppearY, autoAlpha: 0,
					onComplete: this.onMoveBackFadeEnd,
					onCompleteParams: [actor, actMovie]
				}
			);
		}
		
		/**
		 * Play role move anime, fade end, start to back.
		 * From FADE point to START point.
		 * @param AppBattleSoldier actor
		 * @param MovieClip actMovie
		 * @return void
		 */
		private function onMoveBackFadeEnd(actor:AppBattleSoldier, actMovie:MovieClip):void {
			actMovie.x = this._moveFadeX;
			actMovie.y = this._moveFadeY;
			actMovie.alpha = 0;
			actMovie.visible = true;
			
			TweenLite.to(
				actMovie, this.FADE_SPEED, {
					x: 0, y: 0, autoAlpha: 1,
					onComplete: this.onMoveBackShowEnd,
					onCompleteParams: [actor]
				}
			);
		}
		
		/**
		 * Play role move anime, total end.
		 * @param AppBattleSoldier actor
		 * @return void
		 */
		private function onMoveBackShowEnd(actor:AppBattleSoldier):void {
			this._moveFadeX   = this._moveFadeY   = 0;
			this._moveAppearX = this._moveAppearY = 0;
			this._moveEndX    = this._moveEndY    = 0;
			this.playStand(actor);
			this.onSingleAnimeEnd();
		}
		
		//-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
		//-* UTILITIES
		//-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
		/**
		 * Get soldier view from manager.
		 * @param AppBattleSoldier soldier
		 * @return AppBattleSoldierView view
		 */
		private function getSoldierView(soldier:AppBattleSoldier):AppBattleSoldierView {
			var soldiers:Object = soldier.isAttacker ? this._atkSoldiers : this._defSoldiers;
			
			return soldiers[soldier.gridId];
		}
	}
}