<template>
	<view class="content" style="padding: 10rpx 20rpx;">
		<view style="display: flex;width: 100%;">
			<view 
			class="tab-select-item" 
			:style="{'background-color':playType === 0?'#2B98F0':'#A8D6F8'}" 
			@click="playType = 0">
			直播
			</view>
			<view
			class="tab-select-item" 
			:style="{'background-color':playType === 1?'#2B98F0':'#A8D6F8'}" 
			@click="playType = 1">
			回放
			</view>
		</view>
		<view class="live-fill-view">
			<!-- 直播UI -->
			<view v-show="playType === 0">
				<input 
				class="live-input" 
				:value="liveInfo.userId" 
				@input="(event)=>{liveInfo.userId = event.detail.value}" 
				placeholder="请输入用户ID" />
				<input 
				class="live-input" 
				:value="liveInfo.channelId" 
				@input="(event)=>{liveInfo.channelId = event.detail.value}" 
				placeholder="请输入频道ID" />
				<input 
				class="live-input" 
				:value="liveInfo.appId" 
				@input="(event)=>{liveInfo.appId = event.detail.value}" 
				placeholder="请输入App ID" />
				<input 
				class="live-input"
				:value="liveInfo.appSecret"
				@input="(event)=>{liveInfo.appSecret = event.detail.value}" 
				placeholder="请输入App Secret" />
			</view>
			<!-- 回放UI -->
			<view v-show="playType === 1">
				<input
				class="live-input" 
				:value="playbackInfo.userId" 
				@input="(event)=>{playbackInfo.userId = event.detail.value}" 
				placeholder="请输入用户ID" />
				<input 
				class="live-input" 
				:value="playbackInfo.channelId" 
				@input="(event)=>{playbackInfo.channelId = event.detail.value}" 
				placeholder="请输入频道ID" />
				<input 
				class="live-input" 
				:value="playbackInfo.appId" 
				@input="(event)=>{playbackInfo.appId = event.detail.value}" 
				placeholder="请输入App ID" />
				<input 
				class="live-input"
				:value="playbackInfo.appSecret"
				@input="(event)=>{playbackInfo.appSecret = event.detail.value}" 
				placeholder="请输入App Secret" />
				<input 
				class="live-input"
				:value="playbackInfo.vid"
				@input="(event)=>{playbackInfo.vid = event.detail.value}" 
				placeholder="请输入视频Vid" />
		        <view class="uni-list-cell uni-list-cell-pd">
					<view class="uni-list-cell-db">点播列表</view>
					<switch
					@change="(event)=>{isVideoList = event.detail.value?1:0}"
					 />
				</view>
			</view>
		</view>
		<button type="primary" style="padding: 0 250rpx; margin: 30rpx;" @click="setUserInfo">登录</button>
		
		<view style="display: flex;width: 100%;">
			<view 
			class="tab-select-item" 
			:style="{'background-color':sceneType === 1?'#2B98F0':'#A8D6F8'}"
			@click="sceneType = 1">
			云课堂场景
			</view>
			<view class="tab-select-item"
			:style="{'background-color':sceneType === 2?'#2B98F0':'#A8D6F8'}"
			@click="sceneType = 2">
			直播带货场景
			</view>
		</view>
	</view>
</template>

<script>
	var playModule = uni.requireNativePlugin("PLV-LiveScenesPlugin-PlayModule")
	var configModule = uni.requireNativePlugin("PLV-LiveScenesPlugin-ConfigModule")
	const playConfig = {
		userId: "",
		appId: "",
		appSecret: "",
	}
	
	export default {
		data() {
			return {
				sceneType: 1, //场景类型 1云课堂场景, 2直播带货场景
				playType: 0  ,//播放类型 0直播，1回放
				isVideoList: 0, //回放中是否进入回放列表0回放视频 1回放列表
				liveInfo: {
					channelId: "2239947",
					userId: playConfig.userId,
					appId: playConfig.appId,
					appSecret: playConfig.appSecret,
				},
				playbackInfo: {
					channelId: "2239947",
					userId: playConfig.userId,
					appId: playConfig.appId,
					appSecret: playConfig.appSecret,
					vid: ""
				},
				// 配置直播间用户信息
				viewerData:{
					viewerId:"iOS用户ID",//开发者自己用户系统的ID。如用户手机号码等唯一标识符
					viewerName:"iOS用户昵称",
					viewerAvatar:"https://img-cdn-qiniu.dcloud.net.cn/uploads/avatar/001/53/87/39_avatar_max.jpg",
				},
			}
		},
		onLoad() {
			this.setViewerInfo();
		},
		methods: {
			setViewerInfo() {
				configModule.setViewerInfo({
					viewerId:this.viewerData.viewerId,
					viewerName:this.viewerData.viewerName,
					viewerAvatar:this.viewerData.viewerAvatar,
				}, (result) => {
					uni.showToast({
						title: result.isSuccess ? "setViewerInfo succeed" : result.errMsg,
						icon: "none"
					})
				})
			},
			// 设置多场景的账号属性
			setUserInfo() {
				var configInfo = this.playType === 0 ? this.liveInfo : this.playbackInfo;
				var that = this;
				configModule.setConfig({
					appId: configInfo.appId,
					userId: configInfo.userId,
					appSecret: configInfo.appSecret
				}, (result) => {
					if (result.isSuccess) {
						that.startLive();
					} else {
						uni.showToast({
							title: result.errMsg,
							icon: "none"
						})	
					}
				});
			},
			startLive() {
				console.log("Start live  " + JSON.stringify(this.liveInfo));				
				if(this.playType === 0) {
					// 直播
					playModule.loginLiveRoom(this.sceneType, {
						channelId: this.liveInfo.channelId
					}, (result) => {
						uni.showToast({
							title: result.isSuccess ? "login succeed" : result.errMsg,
							icon: "none"
						})
					});	
				} else if(this.playType === 1) {
					// 回放
					playModule.loginPlaybackRoom(this.sceneType, {
						channelId: this.playbackInfo.channelId,
						videoId: this.playbackInfo.vid,
						vodType: this.isVideoList
					}, (result) => {
						uni.showToast({
							title: result.isSuccess ? "login succeed" : result.errMsg,
							icon: "none"
						})
					});	
				}
			}
		}
	}
</script>

<style>
	.content {
		display: flex;
		flex-direction: column;
		align-items: center;
		justify-content: center;
		height: 100%;
	}

	.tab-select-view {
		display: flex;
		width: 100%;
	}

	.tab-select-item {
		flex: 0.5;
		padding: 20rpx 0;
		text-align: center;
		color: white;
	}

	.live-fill-view {
		padding: 10rpx 0;
		width: 100%;
	}

	.live-input {
		min-height: 35px;
		height: 35px;
		border-bottom: 1px solid #cccccc;
		font-size: 14px;
		padding-top: 10rpx;
	}
	.uni-list-cell {
		position: relative;
		display: -webkit-box;
		display: -webkit-flex;
		display: flex;
		-webkit-box-orient: horizontal;
		-webkit-box-direction: normal;
		-webkit-flex-direction: row;
		flex-direction: row;
		-webkit-box-pack: justify;
		-webkit-justify-content: space-between;
		justify-content: space-between;
		-webkit-box-align: center;
		-webkit-align-items: center;
		align-items: center;
		padding: 20rpx 0;
	}
	.uni-list-cell::after {
	    position: absolute;
	    z-index: 3;
	    right: 0;
	    bottom: 0;
	    left: 15px;
	    height: 1px;
	    content: "";
	    -webkit-transform: scaleY(.5);
	    transform: scaleY(.5);
	    background-color: #c8c7cc;
	}
</style>
