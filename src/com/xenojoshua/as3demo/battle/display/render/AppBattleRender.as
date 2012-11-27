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
				var atkGrid:DisplayObjectContainer = AppBattleGridManager.instance.getGrid(atkSoldier);
				atkGrid.addChild(atkSoldierView);
				this._atkSoldiers[atkSoldier.gridId] = atkSoldierView;
				this.playStand(atkSoldier);
			}
			for each (var defSoldier:AppBattleSoldier in defenders) {
				var defSoldierView:AppBattleSoldierView = new AppBattleSoldierView();
				var defGrid:DisplayObjectContainer = AppBattleGridManager.instance.getGrid(defSoldier);
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
			if (this._playingCount > 0) {
				return; // still playing, do not continue play the new animes
			}
			
			this.removeQueueDelay(); // no matter delay timer exists or not, call remove first
			var isAnyAnimeInQueue:Boolean = false; // mark no anime left first

			for (var index:String in this._playList) {
// FIXME 这里不能一次全部都for掉，因为这一级的循环控制的是几个动画播放先后层级之间的关系，每次playQueue的时候应该将一个index下数组内的所有动画都播掉
// 它们是应该一起播掉的，然后等它们全部播完(this._playingCount <= 0)，这个时候才进入下一个index播放
// P.S 改造战场格子，移动的定位以格子定位，不要自己计算位置，然后在AppBattleSoldierView中添加一个层，专门用来放置移动过来的人
// 将移动动画简化，移动启动和定位的时候没有位移变化，而是简单的渐进渐出
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
				break;
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
			XafConsole.instance.log(XafConsole.DEBUG, 'AppBattleRender: onSingleAnimeEnd, left playing count: ' + this._playingCount);
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
					this.setQueueDelay();
					this._playDelay = 0;
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
		 * @param AppBattleSoldier actor
		 * @return void
		 */
		public function playStand(actor:AppBattleSoldier):void {
			//XafConsole.instance.log(XafConsole.DEBUG, 'AppBattleRender: Anime playStand start: ' + (soldier.isAttacker ? 'ATK' : 'DEF') + '[' + soldier.gridId + ']');
			var view:AppBattleSoldierView = this.getSoldierView(actor);
			if (!view) {
				return;
			}
			view.removeRoleLayer();
			
			var movie:MovieClip = AppBattleAnimeManager.instance.getRoleStand(actor.roleId, actor.isAttacker);
			view.addRoleMovie(movie);
			
			movie.gotoAndPlay(1);
		}
		
		/**
		 * Play soldier attack anime.
		 * @param AppBattleSoldier actor
		 * @return void
		 */
		public function playAttack(actor:AppBattleSoldier):void {
			XafConsole.instance.log(XafConsole.DEBUG, 'AppBattleRender: Anime playAttack start: ' + (actor.isAttacker ? 'ATK' : 'DEF') + '[' + actor.gridId + ']');
			var view:AppBattleSoldierView = this.getSoldierView(actor);
			if (!view) {
				return;
			}
			view.removeRoleLayer();
			
			var movie:MovieClip = AppBattleAnimeManager.instance.getRoleAttack(actor.roleId, actor.isAttacker);
			view.addRoleMovie(movie);
			var render:AppBattleRender = this;
			var attackEnd:Function = function(e:Event):void {
				var display:MovieClip = e.target as MovieClip;
				if (display.currentFrame == display.totalFrames) {
					display.removeEventListener(Event.ENTER_FRAME, attackEnd);
					render.playStand(actor);
					XafConsole.instance.log(XafConsole.DEBUG, 'AppBattleRender: Anime playAttack end: ' + (actor.isAttacker ? 'ATK' : 'DEF') + '[' + actor.gridId + ']');
					render.onSingleAnimeEnd();
				}
			};
			movie.addEventListener(Event.ENTER_FRAME, attackEnd);
			movie.gotoAndPlay(1);
		}
		
		/**
		 * Play soldier skill anime.
		 * @param AppBattleSoldier actor
		 * @return void
		 */
		public function playSkill(actor:AppBattleSoldier):void {
			XafConsole.instance.log(XafConsole.DEBUG, 'AppBattleRender: Anime playSkill start: ' + (actor.isAttacker ? 'ATK' : 'DEF') + '[' + actor.gridId + ']');
			var view:AppBattleSoldierView = this.getSoldierView(actor);
			if (!view) {
				return;
			}
			view.removeRoleLayer();
			
			var movie:MovieClip = AppBattleAnimeManager.instance.getRoleSkill(actor.roleId, actor.isAttacker);
			view.addRoleMovie(movie);
			var render:AppBattleRender = this;
			var skillEnd:Function = function(e:Event):void {
				var display:MovieClip = e.target as MovieClip;
				if (display.currentFrame == display.totalFrames) {
					display.removeEventListener(Event.ENTER_FRAME, skillEnd);
					render.playStand(actor);
					XafConsole.instance.log(XafConsole.DEBUG, 'AppBattleRender: Anime playSkill end: ' + (actor.isAttacker ? 'ATK' : 'DEF') + '[' + actor.gridId + ']');
					render.onSingleAnimeEnd();
				}
			};
			movie.addEventListener(Event.ENTER_FRAME, skillEnd);
			movie.gotoAndPlay(1);
		}
		
		/**
		 * Play soldier hurt anime.
		 * @param AppBattleSoldier actor
		 * @return void
		 */
		public function playHurt(actor:AppBattleSoldier):void {
			XafConsole.instance.log(XafConsole.DEBUG, 'AppBattleRender: Anime playHurt start: ' + (actor.isAttacker ? 'ATK' : 'DEF') + '[' + actor.gridId + ']');
			var view:AppBattleSoldierView = this.getSoldierView(actor);
			if (!view) {
				return;
			}
			view.removeRoleLayer();
			
			var movie:MovieClip = AppBattleAnimeManager.instance.getRoleHit(actor.roleId, actor.isAttacker);
			view.addRoleMovie(movie);
			var render:AppBattleRender = this;
			var hurtEnd:Function = function(e:Event):void {
				var display:MovieClip = e.target as MovieClip;
				if (display.currentFrame == display.totalFrames) {
					display.removeEventListener(Event.ENTER_FRAME, hurtEnd);
					render.playStand(actor);
					XafConsole.instance.log(XafConsole.DEBUG, 'AppBattleRender: Anime playHurt end: ' + (actor.isAttacker ? 'ATK' : 'DEF') + '[' + actor.gridId + ']');
					render.onSingleAnimeEnd();
				}
			};
			movie.addEventListener(Event.ENTER_FRAME, hurtEnd);
			movie.gotoAndPlay(1);
		}
		
		/**
		 * Play attack effect on defender (attack hurt recipient).
		 * @param AppBattleSoldier actor attack caster
		 * @param AppBattleSoldier recipient attack recipient
		 * @return void
		 */
		public function playAttackEffect(actor:AppBattleSoldier, recipient:AppBattleSoldier):void {
			XafConsole.instance.log(XafConsole.DEBUG, 'AppBattleRender: Anime playAttackEffect start: ' + (actor.isAttacker ? 'ATK' : 'DEF') + '[' + actor.gridId + '] deals on ' + (recipient.isAttacker ? 'ATK' : 'DEF') + '[' + recipient.gridId + ']');
			var view:AppBattleSoldierView = this.getSoldierView(recipient);
			if (!view) {
				return;
			}
			view.removeEffectLayer();
			
			var movie:MovieClip = AppBattleAnimeManager.instance.getAttackEffect(
				actor.isMagic ? AppBattleAnimeManager.ATTACK_TYPE_MGK : AppBattleAnimeManager.ATTACK_TYPE_PHY,
				recipient.isAttacker
			);
			view.addEffectMovie(movie);
			var render:AppBattleRender = this;
			var effectEnd:Function = function(e:Event):void {
				var display:MovieClip = e.target as MovieClip;
				if (display.currentFrame == display.totalFrames) {
					display.removeEventListener(Event.ENTER_FRAME, effectEnd);
					view.removeEffectLayer();
					XafConsole.instance.log(XafConsole.DEBUG, 'AppBattleRender: Anime playAttackEffect end: ' + (actor.isAttacker ? 'ATK' : 'DEF') + '[' + actor.gridId + '] deals on ' + (recipient.isAttacker ? 'ATK' : 'DEF') + '[' + recipient.gridId + ']');
					render.onSingleAnimeEnd();
				}
			};
			movie.addEventListener(Event.ENTER_FRAME, effectEnd);
			movie.gotoAndPlay(1);
		}
		
		/**
		 * Play skill effect on defender (skill hurt recipient).
		 * @param AppBattleSoldier actor skill caster
		 * @param AppBattleSoldier recipient skill recipient
		 * @return void
		 */
		public function playSkillEffect(actor:AppBattleSoldier, recipient:AppBattleSoldier):void {
			XafConsole.instance.log(XafConsole.DEBUG, 'AppBattleRender: Anime playAttackEffect start: ' + (actor.isAttacker ? 'ATK' : 'DEF') + '[' + actor.gridId + '] deals on ' + (recipient.isAttacker ? 'ATK' : 'DEF') + '[' + recipient.gridId + ']');
			var view:AppBattleSoldierView = this.getSoldierView(recipient);
			if (!view) {
				return;
			}
			view.removeEffectLayer();
			
			var movie:MovieClip = AppBattleAnimeManager.instance.getSkillEffect(actor.skillId, recipient.isAttacker);
			view.addEffectMovie(movie);
			var render:AppBattleRender = this;
			var effectEnd:Function = function(e:Event):void {
				var display:MovieClip = e.target as MovieClip;
				if (display.currentFrame == display.totalFrames) {
					display.removeEventListener(Event.ENTER_FRAME, effectEnd);
					view.removeEffectLayer();
					XafConsole.instance.log(XafConsole.DEBUG, 'AppBattleRender: Anime playAttackEffect end: ' + (actor.isAttacker ? 'ATK' : 'DEF') + '[' + actor.gridId + '] deals on ' + (recipient.isAttacker ? 'ATK' : 'DEF') + '[' + recipient.gridId + ']');
					render.onSingleAnimeEnd();
				}
			};
			movie.addEventListener(Event.ENTER_FRAME, effectEnd);
			movie.gotoAndPlay(1);
		}
		
		/**
		 * Play die anime.
		 * @param AppBattleSoldier actor
		 * @return void
		 */
		public function playDie(actor:AppBattleSoldier):void {
			XafConsole.instance.log(XafConsole.DEBUG, 'AppBattleRender: Anime playDie start: ' + (actor.isAttacker ? 'ATK' : 'DEF') + '[' + actor.gridId + ']');
			var view:AppBattleSoldierView = this.getSoldierView(actor);
			if (!view) {
				return;
			}
			TweenPlugin.activate([AutoAlphaPlugin]);
			TweenLite.to(view, 0.5, {
				autoAlpha: 0, onComplete: this.onDieEnd, onCompleteParams: [actor, view]
			});
		}
		
		/**
		 * Callback when die anime ends.
		 * @param AppBattleSoldier actor
		 * @param AppBattleSoldierView view
		 * @return void
		 */
		private function onDieEnd(actor:AppBattleSoldier, view:AppBattleSoldierView):void {
			// dispose the view
			view.dispose();
			// remove manager handler
			if (actor.isAttacker) {
				delete this._atkSoldiers[actor.gridId];
			} else {
				delete this._defSoldiers[actor.gridId];
			}
			AppBattleProcessor.instance.removeDeadSoldier(actor.gridId, actor.isAttacker);
			XafConsole.instance.log(XafConsole.DEBUG, 'AppBattleRender: Anime onDieEnd end: ' + (actor.isAttacker ? 'ATK' : 'DEF') + '[' + actor.gridId + ']');
			this.onSingleAnimeEnd();
		}
		
		//-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
		//-* MOVE ANIMATION
		//-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
		/**
		 * Play role move to target grid anime.
		 * @param AppBattleSoldier actor
		 * @param AppBattleSoldier recipient
		 * @return void
		 */
		public function playMoveTo(actor:AppBattleSoldier, recipient:AppBattleSoldier):void {
			XafConsole.instance.log(XafConsole.DEBUG, 'AppBattleRender: Anime playMoveTo start: FROM: ' + (actor.isAttacker ? 'ATK' : 'DEF') + '[' + actor.gridId + ']' + ', TO: ' + (recipient.isAttacker ? 'ATK' : 'DEF') + '[' + recipient.gridId + ']');
			var view:AppBattleSoldierView = this.getSoldierView(actor);
			if (!view) {
				return;
			}
			TweenPlugin.activate([AutoAlphaPlugin]);
			TweenLite.to(view, 0.5, {
				autoAlpha: 0, onComplete: this.moveToFadeEnd, onCompleteParams: [actor, recipient]
			});
		}
		
		/**
		 * Move to, fade end, change AppBattleSoldierView position.
		 * @param AppBattleSoldier actor
		 * @param AppBattleSoldier recipient
		 * @return void
		 */
		private function moveToFadeEnd(actor:AppBattleSoldier, recipient:AppBattleSoldier):void {
			var view:AppBattleSoldierView = this.getSoldierView(actor);
			if (!view) {
				return;
			}
			AppBattleGridManager.instance.getGrid(actor).removeChild(view);
			AppBattleGridManager.instance.getTargetGrid(recipient).addChild(view);
			TweenPlugin.activate([AutoAlphaPlugin]);
			TweenLite.to(view, 0.5, {
				autoAlpha: 1, onComplete: this.moveToShowEnd, onCompleteParams: [actor]
			});
		}
		
		/**
		 * Move to, show end, end the anime playing logic.
		 * @param AppBattleSoldier actor
		 * @return void
		 */
		private function moveToShowEnd(actor:AppBattleSoldier):void {
			var view:AppBattleSoldierView = this.getSoldierView(actor);
			if (!view) {
				return;
			}
			this.playStand(actor);
			this.onSingleAnimeEnd();
		}
		
		/**
		 * Play role movie anime, start to move back.
		 * From END point to APPEAR point.
		 * @param AppBattleSoldier actor
		 * @param AppBattleSoldier recipient
		 * @return void
		 */
		public function playMoveBack(actor:AppBattleSoldier, recipient:AppBattleSoldier):void {
			XafConsole.instance.log(XafConsole.DEBUG, 'AppBattleRender: Anime playMoveBack');
			var view:AppBattleSoldierView = this.getSoldierView(actor);
			if (!view) {
				return;
			}
			TweenPlugin.activate([AutoAlphaPlugin]);
			TweenLite.to(view, 0.5, {
				autoAlpha: 0, onComplete: this.moveBackFadeEnd, onCompleteParams: [actor, recipient]
			});
		}
		
		/**
		 * Move back, fade end, change AppBattleSoldierView position.
		 * @param AppBattleSoldier actor
		 * @param AppBattleSoldier recipient
		 * @return void
		 */
		private function moveBackFadeEnd(actor:AppBattleSoldier, recipient:AppBattleSoldier):void {
			var view:AppBattleSoldierView = this.getSoldierView(actor);
			if (!view) {
				return;
			}
			AppBattleGridManager.instance.getTargetGrid(recipient).removeChild(view);
			AppBattleGridManager.instance.getGrid(actor).addChild(view);
			TweenPlugin.activate([AutoAlphaPlugin]);
			TweenLite.to(view, 0.5, {
				autoAlpha: 1, onComplete: this.moveBackShowEnd, onCompleteParams: [actor]
			});
		}
		
		/**
		 * Move back, show end, end the anime playing logic.
		 * @param AppBattleSoldier actor
		 * @return void
		 */
		private function moveBackShowEnd(actor:AppBattleSoldier):void {
			var view:AppBattleSoldierView = this.getSoldierView(actor);
			if (!view) {
				return;
			}
			this.playStand(actor);
			this.onSingleAnimeEnd();
		}
		
		//-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
		//-* UTILITIES
		//-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
		/**
		 * Get soldier view from manager.
		 * @param AppBattleSoldier actor
		 * @return AppBattleSoldierView view
		 */
		private function getSoldierView(actor:AppBattleSoldier):AppBattleSoldierView {
			var actViews:Object = actor.isAttacker ? this._atkSoldiers : this._defSoldiers;
			return actViews[actor.gridId];
		}
	}
}