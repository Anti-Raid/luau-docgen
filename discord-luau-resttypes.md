# Types

## Response

[[ Base ]] --

<details>
<summary>Raw Type</summary>

```luau
-- [[ Base ]] --
type Response<DATA> = DATA
```

</details>

## Request

<details>
<summary>Raw Type</summary>

```luau
type Request<DATA> = DATA
```

</details>

## CreateMessageAttachment

An attachment in a message

<details>
<summary>Raw Type</summary>

```luau
--- An attachment in a message
type CreateMessageAttachment = {
	--- The filename of the attachment
	filename: string,

	--- The description (if any) of the attachment
	description: string?,

	--- The content of the attachment
	content: {Primitives.byte}
}
```

</details>

### filename

The filename of the attachment

Field with the following constraints:

- Type: string
- Constraints: None

### description

The description (if any) of the attachment

Field with the following constraints:

- Type: string
- Constraints: None

### content

The content of the attachment

[Documentor] Unsupported type: Module

## CreateInteractionRequest

[[ Requests ]] --

https://discord.com/developers/docs/interactions/receiving-and-responding#create-interaction-response

<details>
<summary>Raw Type</summary>

```luau
-- [[ Requests ]] --
-- https://discord.com/developers/docs/interactions/receiving-and-responding#create-interaction-response
type CreateInteractionRequest = Request<objects.InteractionResponseObject>
```

</details>

## EditOriginalInteractionRequest

https://discord.com/developers/docs/interactions/receiving-and-responding#edit-original-interaction-response

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/receiving-and-responding#edit-original-interaction-response
type EditOriginalInteractionRequest = Request<objects.Partial<objects.MessageObject>>
```

</details>

## CreateFollowupMessageRequest

https://discord.com/developers/docs/interactions/receiving-and-responding#create-followup-message

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/receiving-and-responding#create-followup-message
type CreateFollowupMessageRequest = Request<objects.Partial<objects.MessageObject>>
```

</details>

## EditFollowupMessageRequest

https://discord.com/developers/docs/interactions/receiving-and-responding#edit-followup-message

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/receiving-and-responding#edit-followup-message
type EditFollowupMessageRequest = Request<objects.Partial<objects.MessageObject>>
```

</details>

## CreateAutoModerationRuleRequest

https://discord.com/developers/docs/resources/auto-moderation#create-auto-moderation-rule

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/auto-moderation#create-auto-moderation-rule
type CreateAutoModerationRuleRequest = Request<{
	name: string?,

	event_type: objects.AutomoderationRuleEventType,

	trigger_type: objects.AutomoderationRuleTriggerType?,

	trigger_metadata: objects.AutomoderationRuleTriggerMetadataObject?,

	actions: {objects.AutomoderationActionObject}?,

	enabled: boolean?,

	exempt_roles: {objects.Snowflake}?,

	exempt_channels: {objects.Snowflake}?
}>
```

</details>

## ModifyAutoModerationRuleRequest

https://discord.com/developers/docs/resources/auto-moderation#modify-auto-moderation-rule

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/auto-moderation#modify-auto-moderation-rule
type ModifyAutoModerationRuleRequest = Request<{
	name: string?,

	event_type: objects.AutomoderationRuleEventType,

	trigger_metadata: objects.AutomoderationRuleTriggerMetadataObject?,

	actions: {objects.AutomoderationActionObject}?,

	enabled: boolean?,

	exempt_roles: {objects.Snowflake}?,

	exempt_channels: {objects.Snowflake}?
}>
```

</details>

## EditCurrentApplicationRequest

https://discord.com/developers/docs/resources/application#edit-current-application

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/application#edit-current-application
type EditCurrentApplicationRequest = Request<{
	custom_install_url: string,

	description: string,

	role_connections_verification_url: string,

	install_params: objects.InstallParamsObject,

	integration_types_config: {
		[objects.IntegrationType]: unknown
	},

	flags: number,

	icon: string?,

	cover_image: string?,

	interactions_endpoint_url: string,

	tags: {string}
}>
```

</details>

## ModifyChannelRequest

https://discord.com/developers/docs/resources/channel#modify-channel

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#modify-channel
type ModifyChannelRequest = Request<{
	name: string?,

	type: objects.ChannelType,

	icon: string?,

	position: number?,

	topic: string?,

	nsfw: boolean?,

	rate_limit_per_user: number?,

	bitrate: number?,

	user_limit: number?,

	permission_overwrites: {objects.OverwriteObject}?,

	parent_id: objects.Snowflake?,

	rtc_region: string?,

	video_quality_mode: objects.VideoQualityMode,

	default_auto_archive_duration: number?,

	flags: number?,

	available_tags: {objects.ForumTagObject}?,

	default_reaction_emoji: objects.DefaultReactionObject?,

	default_thread_rate_limit_per_user: number?,

	default_sort_order: objects.SortOrderType?,

	default_forum_layout: objects.ForumLayoutType?,

	archived: boolean?,

	auto_archive_duration: number?,

	locked: boolean?,

	invitable: boolean?,

	--- the IDs of the set of tags that have been applied to a thread in a GUILD_FORUM or a GUILD_MEDIA channel; limited to 5
	applied_tags: {objects.Snowflake}
}>
```

</details>

## CreateMessageRequest

https://discord.com/developers/docs/resources/channel#create-message

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#create-message
type CreateMessageRequest = Request<{
	content: string?,

	nonce: (string | number)?,

	tts: boolean?,

	embeds: {objects.EmbedObject}?,

	allowed_mentions: objects.AllowedMentionObject?,

	message_reference: objects.MessageReferenceObject?,

	components: {objects.ComponentObjects}?,

	sticker_ids: {objects.Snowflake}?,

	-- files: { },
	-- payload_json: string,
	attachments: {CreateMessageAttachment}?,

	flags: number?,

	enforce_nonce: boolean?,

	poll: objects.PollObject?
}>
```

</details>

## EditMessageRequest

https://discord.com/developers/docs/resources/channel#edit-message

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#edit-message
type EditMessageRequest = Request<{
	content: string?,

	embeds: {objects.EmbedObject}?,

	allowed_mentions: {objects.AllowedMentionObject}?,

	components: {objects.ComponentObjects}?,

	-- files: { },
	-- payload_json: string,
	attachments: {CreateMessageAttachment}?,

	flags: number?
}>
```

</details>

## CreateChannelInviteRequest

https://discord.com/developers/docs/resources/channel#create-channel-invite

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#create-channel-invite
type CreateChannelInviteRequest = Request<{
	max_age: number?,

	max_uses: number?,

	temporary: boolean?,

	unique: boolean?,

	target_type: objects.InviteTargetTypes?,

	target_user_id: objects.Snowflake?,

	target_application_id: objects.Snowflake?
}>
```

</details>

## BulkDeleteMessagesRequest

https://discord.com/developers/docs/resources/channel#bulk-delete-messages

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#bulk-delete-messages
type BulkDeleteMessagesRequest = Request<{
	messages: {objects.Snowflake}
}>
```

</details>

## FollowAnnouncementChannelRequest

https://discord.com/developers/docs/resources/channel#follow-announcement-channel

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#follow-announcement-channel
type FollowAnnouncementChannelRequest = Request<{
	webhook_channel_id: objects.Snowflake
}>
```

</details>

## GroupDMAddRecipientRequest

https://discord.com/developers/docs/resources/channel#group-dm-add-recipient

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#group-dm-add-recipient
type GroupDMAddRecipientRequest = Request<{
	access_token: string,

	nick: string
}>
```

</details>

## StartThreadFromMessageRequest

https://discord.com/developers/docs/resources/channel#start-thread-from-message

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#start-thread-from-message
type StartThreadFromMessageRequest = Request<{
	name: string,

	auto_archive_duration: number?,

	rate_limit_per_user: number?
}>
```

</details>

## StartThreadWithoutMessageRequest

https://discord.com/developers/docs/resources/channel#start-thread-without-message

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#start-thread-without-message
type StartThreadWithoutMessageRequest = Request<{
	name: string,

	auto_archive_duration: number?,

	type: objects.ChannelType?,

	invitable: boolean?,

	rate_limit_per_user: number?
}>
```

</details>

## StartThreadInForumOrMediaChannelRequest

https://discord.com/developers/docs/resources/channel#start-thread-in-forum-or-media-channel

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#start-thread-in-forum-or-media-channel
type StartThreadInForumOrMediaChannelRequest = Request<{
	name: string,

	auto_archive_duration: number?,

	rate_limit_per_user: number?,

	--files: { },
	-- payload_json: string,
	applied_tags: {objects.Snowflake},

	message: objects.ForumAndMediaThreadMessageObject?
}>
```

</details>

## CreateGuildEmojiRequest

https://discord.com/developers/docs/resources/emoji#create-guild-emoji

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/emoji#create-guild-emoji
type CreateGuildEmojiRequest = Request<{
	name: string,

	image: string,

	roles: {objects.Snowflake}
}>
```

</details>

## ModifyGuildEmojiRequest

https://discord.com/developers/docs/resources/emoji#modify-guild-emoji

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/emoji#modify-guild-emoji
type ModifyGuildEmojiRequest = Request<{
	name: string,

	roles: {objects.Snowflake}
}>
```

</details>

## CreateGuildRequest

https://discord.com/developers/docs/resources/guild#create-guild

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#create-guild
type CreateGuildRequest = Request<{
	name: string,

	region: string?,

	icon: string?,

	verification_level: objects.VerificationLevel?,

	default_message_notifications: objects.DefaultMessageNotification?,

	explicit_content_filter: objects.ExplicitContentFilterLevel?,

	roles: {objects.GuildRoleObject}?,

	channels: {objects.ChannelObject}?,

	afk_channel_id: objects.Snowflake,

	afk_timeout: number,

	system_channel_id: objects.Snowflake?,

	system_channel_flags: objects.SystemChannelFlags?
}>
```

</details>

## ModifyGuildRequest

https://discord.com/developers/docs/resources/guild#modify-guild

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#modify-guild
type ModifyGuildRequest = Request<objects.Partial<{
	name: string,

	verification_level: objects.VerificationLevel?,

	default_message_notifications: objects.DefaultMessageNotification?,

	explicit_content_filter: objects.ExplicitContentFilterLevel?,

	afk_channel_id: objects.Snowflake?,

	afk_timeout: number?,

	icon: string?,

	owner_id: objects.Snowflake,

	splash: string?,

	discovery_splash: string?,

	banner: string?,

	system_channel_id: objects.Snowflake?,

	system_channel_flags: objects.SystemChannelFlags?,

	rules_channel_id: objects.Snowflake?,

	public_updates_channel_id: objects.Snowflake?,

	preferred_locale: objects.LanguageLocales?,

	features: {objects.GuildFeature}?,

	description: string?,

	premium_progress_bar_enabled: boolean?,

	safety_alerts_channel_id: objects.Snowflake?
}>>
```

</details>

## CreateGuildChannelRequest

https://discord.com/developers/docs/resources/guild#create-guild-channel

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#create-guild-channel
type CreateGuildChannelRequest = Request<objects.Partial<{
	name: string,

	type: objects.ChannelType,

	topic: string?,

	bitrate: number?,

	user_limit: number?,

	rate_limit_per_user: number?,

	position: number,

	permission_overwrites: {objects.OverwriteObject},

	parent_id: objects.Snowflake?,

	nsfw: boolean?,

	rtc_region: string?,

	video_quality_mode: objects.VideoQualityMode?,

	default_auto_archive_duration: number?,

	default_reaction_emoji: objects.EmojiObject?,

	available_tags: {objects.ForumTagObject}?,

	default_sort_order: objects.SortOrderType?,

	default_forum_layout: objects.ForumLayoutType?,

	default_thread_rate_limit_per_user: number?
}>>
```

</details>

## ModifyGuildChannelPositionsRequest

https://discord.com/developers/docs/resources/guild#modify-guild-channel-positions

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#modify-guild-channel-positions
type ModifyGuildChannelPositionsRequest = Request<{
	id: objects.Snowflake,

	position: number?,

	lock_permissions: boolean?,

	parent_id: objects.Snowflake?
}>
```

</details>

## AddGuildMemberRequest

https://discord.com/developers/docs/resources/guild#add-guild-member

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#add-guild-member
type AddGuildMemberRequest = Request<{
	access_token: string,

	nick: string?,

	roles: {objects.Snowflake}?,

	mute: boolean?,

	deaf: boolean?
}>
```

</details>

## ModifyGuildMemberRequest

https://discord.com/developers/docs/resources/guild#modify-guild-member

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#modify-guild-member
type ModifyGuildMemberRequest = Request<{
	nick: string?,

	roles: {objects.Snowflake}?,

	mute: boolean?,

	deaf: boolean?,

	channel_id: (objects.Snowflake | boolean)?,

	communication_disabled_until: string?,

	flags: objects.GuildMemberFlags?
}>
```

</details>

## ModifyCurrentMemberRequest

https://discord.com/developers/docs/resources/guild#modify-current-member

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#modify-current-member
type ModifyCurrentMemberRequest = Request<{
	nick: string
}>
```

</details>

## CreateGuildBanRequest

https://discord.com/developers/docs/resources/guild#create-guild-ban

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#create-guild-ban
type CreateGuildBanRequest = Request<{
	delete_message_days: number?,

	delete_message_seconds: number?
}>
```

</details>

## BulkGuildBanRequest

https://discord.com/developers/docs/resources/guild#bulk-guild-ban

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#bulk-guild-ban
type BulkGuildBanRequest = Request<{
	user_ids: {objects.Snowflake},

	delete_message_seconds: number?
}>
```

</details>

## CreateGuildRoleRequest

https://discord.com/developers/docs/resources/guild#create-guild-role

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#create-guild-role
type CreateGuildRoleRequest = Request<{
	name: string?,

	permissions: string?,

	color: number?,

	hoist: boolean?,

	icon: string?,

	unicode_emoji: string?,

	mentionable: boolean?
}>
```

</details>

## ModifyGuildRolePositionsRequest

https://discord.com/developers/docs/resources/guild#modify-guild-role-positions

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#modify-guild-role-positions
type ModifyGuildRolePositionsRequest = Request<{
	id: objects.Snowflake,

	position: number
}>
```

</details>

## ModifyGuildRoleRequest

https://discord.com/developers/docs/resources/guild#modify-guild-role

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#modify-guild-role
type ModifyGuildRoleRequest = Request<{
	name: string?,

	permissions: string?,

	color: number?,

	hoist: boolean?,

	icon: string?,

	unicode_emoji: string?,

	mentionable: boolean?
}>
```

</details>

## ModifyGuildMFALevelRequest

https://discord.com/developers/docs/resources/guild#modify-guild-mfa-level

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#modify-guild-mfa-level
type ModifyGuildMFALevelRequest = Request<{
	level: objects.MFALevel
}>
```

</details>

## BeginGuildPruneRequest

https://discord.com/developers/docs/resources/guild#begin-guild-prune

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#begin-guild-prune
type BeginGuildPruneRequest = Request<{
	days: number,

	compute_prune_count: boolean,

	include_ruoles: {objects.Snowflake},

	reason: string?
}>
```

</details>

## ModifyGuildWelcomeScreenRequest

https://discord.com/developers/docs/resources/guild#modify-guild-welcome-screen

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#modify-guild-welcome-screen
type ModifyGuildWelcomeScreenRequest = Request<{
	enabled: boolean?,

	welcome_channels: {objects.WelcomeScreenChannelObject},

	description: string?
}>
```

</details>

## ModifyGuildOnboardingRequest

https://discord.com/developers/docs/resources/guild#modify-guild-onboarding

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#modify-guild-onboarding
type ModifyGuildOnboardingRequest = Request<{
	prompts: {objects.OnboardingPromptObject}?,

	default_channel_ids: {objects.Snowflake}?,

	enabled: boolean?,

	mode: objects.OnboardingMode?
}>
```

</details>

## ModifyCurrentUserVoiceStateRequest

https://discord.com/developers/docs/resources/guild#modify-current-user-voice-state

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#modify-current-user-voice-state
type ModifyCurrentUserVoiceStateRequest = Request<{
	channel_id: objects.Snowflake?,

	suppress: boolean?,

	request_to_speak_timestamp: string?
}>
```

</details>

## ModifyUserVoiceStateRequest

https://discord.com/developers/docs/resources/guild#modify-user-voice-state

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#modify-user-voice-state
type ModifyUserVoiceStateRequest = Request<{
	channel_id: objects.Snowflake?,

	suppress: boolean?
}>
```

</details>

## CreateGuildScheduledEventRequest

https://discord.com/developers/docs/resources/guild-scheduled-event#create-guild-scheduled-event

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild-scheduled-event#create-guild-scheduled-event
type CreateGuildScheduledEventRequest = Request<{
	channel_id: objects.Snowflake?,

	entity_metadata: objects.GuildScheduledEventEntityMetadata,

	name: string,

	privacy_level: objects.PrivacyLevel,

	scheduled_start_time: string,

	scheduled_end_time: string?,

	description: string?,

	entity_type: objects.GuildScheduledEventEntityType,

	image: string?
}>
```

</details>

## ModifyGuildScheduledEventRequest

https://discord.com/developers/docs/resources/guild-scheduled-event#modify-guild-scheduled-event

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild-scheduled-event#modify-guild-scheduled-event
type ModifyGuildScheduledEventRequest = Request<{
	channel_id: objects.Snowflake?,

	entity_metadata: objects.GuildScheduledEventEntityMetadata,

	name: string,

	privacy_level: objects.PrivacyLevel,

	scheduled_start_time: string,

	scheduled_end_time: string?,

	description: string?,

	entity_type: objects.GuildScheduledEventEntityType,

	status: objects.GuildScheduledEventStatus?,

	image: string?
}>
```

</details>

## CreateGuildFromGuildTemplateRequest

https://discord.com/developers/docs/resources/guild-template#create-guild-from-guild-template

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild-template#create-guild-from-guild-template
type CreateGuildFromGuildTemplateRequest = Request<{
	name: string,

	icon: string?
}>
```

</details>

## CreateGuildTemplateRequest

https://discord.com/developers/docs/resources/guild-template#create-guild-template

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild-template#create-guild-template
type CreateGuildTemplateRequest = Request<{
	name: string,

	description: string?
}>
```

</details>

## ModifyGuildTemplateRequest

https://discord.com/developers/docs/resources/guild-template#modify-guild-template

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild-template#modify-guild-template
type ModifyGuildTemplateRequest = Request<{
	name: string?,

	description: string?
}>
```

</details>

## CreateStageInstanceRequest

https://discord.com/developers/docs/resources/stage-instance#create-stage-instance

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/stage-instance#create-stage-instance
type CreateStageInstanceRequest = Request<{
	channel_id: objects.Snowflake,

	topic: string,

	privacy_level: objects.PrivacyLevel?,

	send_start_notification: boolean?,

	guild_scheduled_event_id: objects.Snowflake?
}>
```

</details>

## ModifyStageInstanceRequest

https://discord.com/developers/docs/resources/stage-instance#modify-stage-instance

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/stage-instance#modify-stage-instance
type ModifyStageInstanceRequest = Request<{
	topic: string,

	privacy_level: objects.PrivacyLevel
}>
```

</details>

## CreateGuildStickerRequest

https://discord.com/developers/docs/resources/sticker#create-guild-sticker

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/sticker#create-guild-sticker
type CreateGuildStickerRequest = Request<{
	name: string,

	description: string,

	tags: {string},

	file: string
}>
```

</details>

## ModifyGuildStickerRequest

https://discord.com/developers/docs/resources/sticker#modify-guild-sticker

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/sticker#modify-guild-sticker
type ModifyGuildStickerRequest = Request<{
	name: string,

	description: string?,

	tags: string
}>
```

</details>

## ModifyCurrentUserRequest

https://discord.com/developers/docs/resources/user#modify-current-user

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/user#modify-current-user
type ModifyCurrentUserRequest = Request<{
	username: string,

	avatar: string?,

	banner: string?
}>
```

</details>

## CreateDMRequest

https://discord.com/developers/docs/resources/user#create-dm

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/user#create-dm
type CreateDMRequest = Request<{
	recipient_id: objects.Snowflake
}>
```

</details>

## CreateGroupDMRequest

https://discord.com/developers/docs/resources/user#create-group-dm

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/user#create-group-dm
type CreateGroupDMRequest = Request<{
	access_tokens: {string},

	nicks: {
		[objects.Snowflake]: string
	}
}>
```

</details>

## UpdateCurrentUserApplicationRoleConnectionRequest

https://discord.com/developers/docs/resources/user#update-current-user-application-role-connection

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/user#update-current-user-application-role-connection
type UpdateCurrentUserApplicationRoleConnectionRequest = Request<{
	platform_name: string?,

	platform_username: string?,

	metadata: objects.ApplicationRoleConnectionMetadataObject?
}>
```

</details>

## CreateWebhookRequest

https://discord.com/developers/docs/resources/webhook#create-webhook

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/webhook#create-webhook
type CreateWebhookRequest = Request<{
	name: string,

	avatar: string?
}>
```

</details>

## ModifyWebhookRequest

https://discord.com/developers/docs/resources/webhook#modify-webhook

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/webhook#modify-webhook
type ModifyWebhookRequest = Request<{
	name: string,

	avatar: string,

	channel_id: objects.Snowflake
}>
```

</details>

## ExecuteWebhookRequest

https://discord.com/developers/docs/resources/webhook#execute-webhook

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/webhook#execute-webhook
type ExecuteWebhookRequest = Request<{
	content: string,

	username: string,

	avatar_url: string,

	tts: boolean,

	embeds: {objects.EmbedObject},

	allowed_mentions: objects.AllowedMentionObject,

	components: {objects.ComponentObjects},

	-- files: { },
	-- payload_json: string,
	attachments: {CreateMessageAttachment},

	flags: number,

	thread_name: string,

	applied_tags: {objects.Snowflake},

	poll: objects.PollObject
}>
```

</details>

## ExecuteSlackCompatibleWebhookRequest

https://discord.com/developers/docs/resources/webhook#execute-slackcompatible-webhook

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/webhook#execute-slackcompatible-webhook
type ExecuteSlackCompatibleWebhookRequest = Request<{}>
```

</details>

## ExecuteGithubCompatibleWebhookRequest

https://discord.com/developers/docs/resources/webhook#execute-githubcompatible-webhook

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/webhook#execute-githubcompatible-webhook
type ExecuteGithubCompatibleWebhookRequest = Request<{}>
```

</details>

## EditWebhookMessageRequest

https://discord.com/developers/docs/resources/webhook#edit-webhook-message

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/webhook#edit-webhook-message
type EditWebhookMessageRequest = Request<{
	content: string,

	embeds: {objects.EmbedObject},

	allowed_mentions: objects.AllowedMentionObject,

	components: {objects.ComponentObjects},

	-- files: { },
	-- payload_json: string,
	attachments: {CreateMessageAttachment},

	poll: objects.PollObject?
}>
```

</details>

## EditChannelPermissionsRequest

https://discord.com/developers/docs/resources/channel#edit-channel-permissions

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#edit-channel-permissions
type EditChannelPermissionsRequest = Request<{
	allow: string?,

	deny: string?,

	type: number
}>
```

</details>

## ModifyGuildWidgetRequest

https://discord.com/developers/docs/resources/guild#modify-guild-widget

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#modify-guild-widget
type ModifyGuildWidgetRequest = Request<objects.GuildWidgetSettingsObject>
```

</details>

## CrosspostMessageRequest

https://discord.com/developers/docs/resources/channel#crosspost-message

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#crosspost-message
type CrosspostMessageRequest = Request<objects.MessageObject>
```

</details>

## CreateGlobalApplicationCommandRequest

https://discord.com/developers/docs/interactions/application-commands#create-global-application-command

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/application-commands#create-global-application-command
type CreateGlobalApplicationCommandRequest = Request<{
	name: string,

	name_localizations: {
		[objects.LanguageLocales]: string
	}?,

	description: string?,

	description_localizations: {
		[objects.LanguageLocales]: string
	}?,

	options: {objects.ApplicationCommandOptionObject}?,

	default_member_permissions: string?,

	dm_permission: boolean?,

	default_permission: boolean,

	integration_types: {objects.IntegrationType}?,

	contexts: {objects.InteractionContextType}?,

	type: objects.ApplicationCommandType?,

	nsfw: boolean?
}>
```

</details>

## EditGlobalApplicationCommandRequest

https://discord.com/developers/docs/interactions/application-commands#edit-global-application-command

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/application-commands#edit-global-application-command
type EditGlobalApplicationCommandRequest = Request<{
	name: string,

	name_localizations: {
		[objects.LanguageLocales]: string
	}?,

	description: string?,

	description_localizations: {
		[objects.LanguageLocales]: string
	}?,

	options: {objects.ApplicationCommandOptionObject}?,

	default_member_permissions: string?,

	dm_permission: boolean?,

	default_permission: boolean,

	integration_types: {objects.IntegrationType}?,

	contexts: {objects.InteractionContextType}?,

	nsfw: boolean?
}>
```

</details>

## CreateGuildApplicationCommandRequest

https://discord.com/developers/docs/interactions/application-commands#create-guild-application-command

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/application-commands#create-guild-application-command
type CreateGuildApplicationCommandRequest = Request<{
	name: string,

	name_localizations: {
		[objects.LanguageLocales]: string
	}?,

	description: string?,

	description_localizations: {
		[objects.LanguageLocales]: string
	}?,

	options: {objects.ApplicationCommandOptionObject}?,

	default_member_permissions: string?,

	dm_permission: boolean?,

	default_permission: boolean,

	integration_types: {objects.IntegrationType}?,

	contexts: {objects.InteractionContextType}?,

	type: objects.ApplicationCommandType?,

	nsfw: boolean?,

	-- 1 = AppHandler, 2 = DiscordLaunchActivity
	handler: number?
}>
```

</details>

## EditGuildApplicationCommandRequest

https://discord.com/developers/docs/interactions/application-commands#edit-guild-application-command

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/application-commands#edit-guild-application-command
type EditGuildApplicationCommandRequest = Request<{
	name: string,

	name_localizations: {
		[objects.LanguageLocales]: string
	}?,

	description: string?,

	description_localizations: {
		[objects.LanguageLocales]: string
	}?,

	options: {objects.ApplicationCommandOptionObject}?,

	default_member_permissions: string?,

	dm_permission: boolean?,

	default_permission: boolean,

	integration_types: {objects.IntegrationType}?,

	contexts: {objects.InteractionContextType}?,

	nsfw: boolean?
}>
```

</details>

## BulkOverwriteGlobalApplicationCommandsRequest

https://discord.com/developers/docs/interactions/application-commands#bulk-overwrite-global-application-commands

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/application-commands#bulk-overwrite-global-application-commands
type BulkOverwriteGlobalApplicationCommandsRequest = Request<{objects.ApplicationCommandObject}>
```

</details>

## BulkOverwriteGuildApplicationCommandsRequest

https://discord.com/developers/docs/interactions/application-commands#bulk-overwrite-guild-application-commands

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/application-commands#bulk-overwrite-guild-application-commands
type BulkOverwriteGuildApplicationCommandsRequest = Request<{{
	id: objects.Snowflake?,

	name: string,

	name_localizations: {
		[objects.LanguageLocales]: string
	}?,

	description: string?,

	description_localizations: {
		[objects.LanguageLocales]: string
	}?,

	options: {objects.ApplicationCommandOptionObject}?,

	default_member_permissions: string?,

	dm_permission: boolean?,

	default_permission: boolean,

	integration_types: {objects.IntegrationType}?,

	contexts: {objects.InteractionContextType}?,

	type: objects.ApplicationCommandType?,

	nsfw: boolean?
}}>
```

</details>

## EditApplicationCommandPermissionsRequest

https://discord.com/developers/docs/interactions/application-commands#edit-application-command-permissions

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/application-commands#edit-application-command-permissions
type EditApplicationCommandPermissionsRequest = Request<{
	permissions: {objects.GuildApplicationCommandPermissionObject}
}>
```

</details>

## GetCurrentUserVoiceStateResponse

[[ Responses ]] --

https://discord.com/developers/docs/resources/voice#get-current-user-voice-state

<details>
<summary>Raw Type</summary>

```luau
-- [[ Responses ]] --
-- https://discord.com/developers/docs/resources/voice#get-current-user-voice-state
type GetCurrentUserVoiceStateResponse = Response<objects.VoiceStateObject>
```

</details>

## GetUserVoiceStateResponse

https://discord.com/developers/docs/resources/voice#get-user-voice-state

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/voice#get-user-voice-state
type GetUserVoiceStateResponse = Response<objects.VoiceStateObject>
```

</details>

## GetGlobalApplicationCommandsResponse

https://discord.com/developers/docs/interactions/application-commands#get-global-application-commands

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/application-commands#get-global-application-commands
type GetGlobalApplicationCommandsResponse = Response<{objects.ApplicationCommandObject}>
```

</details>

## CreateGlobalApplicationCommandResponse

https://discord.com/developers/docs/interactions/application-commands#create-global-application-command

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/application-commands#create-global-application-command
type CreateGlobalApplicationCommandResponse = Response<objects.ApplicationCommandObject>
```

</details>

## GetGlobalApplicationCommandResponse

https://discord.com/developers/docs/interactions/application-commands#get-global-application-command

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/application-commands#get-global-application-command
type GetGlobalApplicationCommandResponse = Response<objects.ApplicationCommandObject>
```

</details>

## EditGlobalApplicationCommandResponse

https://discord.com/developers/docs/interactions/application-commands#edit-global-application-command

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/application-commands#edit-global-application-command
type EditGlobalApplicationCommandResponse = Response<objects.ApplicationCommandObject>
```

</details>

## DeleteGlobalApplicationCommandResponse

https://discord.com/developers/docs/interactions/application-commands#delete-global-application-command

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/application-commands#delete-global-application-command
type DeleteGlobalApplicationCommandResponse = Response<nil>
```

</details>

## BulkOverwriteGlobalApplicationCommandsResponse

https://discord.com/developers/docs/interactions/application-commands#bulk-overwrite-global-application-commands

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/application-commands#bulk-overwrite-global-application-commands
type BulkOverwriteGlobalApplicationCommandsResponse = Response<{objects.ApplicationCommandObject}>
```

</details>

## GetGuildApplicationCommandsResponse

https://discord.com/developers/docs/interactions/application-commands#get-guild-application-commands

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/application-commands#get-guild-application-commands
type GetGuildApplicationCommandsResponse = Response<{objects.ApplicationCommandObject}>
```

</details>

## CreateGuildApplicationCommandResponse

https://discord.com/developers/docs/interactions/application-commands#create-guild-application-command

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/application-commands#create-guild-application-command
type CreateGuildApplicationCommandResponse = Response<objects.ApplicationCommandObject>
```

</details>

## GetGuildApplicationCommandResponse

https://discord.com/developers/docs/interactions/application-commands#get-guild-application-command

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/application-commands#get-guild-application-command
type GetGuildApplicationCommandResponse = Response<objects.ApplicationCommandObject>
```

</details>

## EditGuildApplicationCommandResponse

https://discord.com/developers/docs/interactions/application-commands#edit-guild-application-command

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/application-commands#edit-guild-application-command
type EditGuildApplicationCommandResponse = Response<objects.ApplicationCommandObject>
```

</details>

## DeleteGuildApplicationCommandResponse

https://discord.com/developers/docs/interactions/application-commands#delete-guild-application-command

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/application-commands#delete-guild-application-command
type DeleteGuildApplicationCommandResponse = Response<nil>
```

</details>

## BulkOverwriteGuildApplicationCommandsResponse

https://discord.com/developers/docs/interactions/application-commands#bulk-overwrite-guild-application-commands

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/application-commands#bulk-overwrite-guild-application-commands
type BulkOverwriteGuildApplicationCommandsResponse = Response<{objects.ApplicationCommandObject}>
```

</details>

## GetGuildApplicationCommandPermissionsResponse

https://discord.com/developers/docs/interactions/application-commands#get-guild-application-command-permissions

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/application-commands#get-guild-application-command-permissions
type GetGuildApplicationCommandPermissionsResponse = Response<{objects.GuildApplicationCommandPermissionsObject}>
```

</details>

## GetApplicationCommandPermissionsResponse

https://discord.com/developers/docs/interactions/application-commands#get-application-command-permissions

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/application-commands#get-application-command-permissions
type GetApplicationCommandPermissionsResponse = Response<{objects.GuildApplicationCommandPermissionsObject}>
```

</details>

## EditApplicationCommandPermissionsResponse

https://discord.com/developers/docs/interactions/application-commands#edit-application-command-permissions

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/application-commands#edit-application-command-permissions
type EditApplicationCommandPermissionsResponse = Response<objects.GuildApplicationCommandPermissionsObject>
```

</details>

## GetCurrentApplicationResponse

https://discord.com/developers/docs/resources/application#get-current-application

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/application#get-current-application
type GetCurrentApplicationResponse = Response<{objects.ApplicationObject}>
```

</details>

## EditCurrentApplicationResponse

https://discord.com/developers/docs/resources/application#edit-current-application

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/application#edit-current-application
type EditCurrentApplicationResponse = Response<{objects.ApplicationObject}>
```

</details>

## GetApplicationRoleConnectionMetadataRecordsResponse

https://discord.com/developers/docs/resources/application-role-connection-metadata#get-application-role-connection-metadata-records

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/application-role-connection-metadata#get-application-role-connection-metadata-records
type GetApplicationRoleConnectionMetadataRecordsResponse = Response<objects.ApplicationRoleConnectionMetadataObject>
```

</details>

## UpdateApplicationRoleConnectionMetadataRecordsResponse

https://discord.com/developers/docs/resources/application-role-connection-metadata#update-application-role-connection-metadata-records

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/application-role-connection-metadata#update-application-role-connection-metadata-records
type UpdateApplicationRoleConnectionMetadataRecordsResponse = Response<objects.ApplicationRoleConnectionMetadataObject>
```

</details>

## GetGuildAuditLogResponse

https://discord.com/developers/docs/resources/audit-log#get-guild-audit-log

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/audit-log#get-guild-audit-log
type GetGuildAuditLogResponse = Response<objects.AuditLogObject>
```

</details>

## ListAutoModerationRulesForGuildResponse

https://discord.com/developers/docs/resources/auto-moderation#list-auto-moderation-rules-for-guild

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/auto-moderation#list-auto-moderation-rules-for-guild
type ListAutoModerationRulesForGuildResponse = Response<{objects.AutomoderationRuleObject}>
```

</details>

## GetAutoModerationRuleResponse

https://discord.com/developers/docs/resources/auto-moderation#get-auto-moderation-rule

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/auto-moderation#get-auto-moderation-rule
type GetAutoModerationRuleResponse = Response<objects.AutomoderationRuleObject>
```

</details>

## CreateAutoModerationRuleResponse

https://discord.com/developers/docs/resources/auto-moderation#create-auto-moderation-rule

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/auto-moderation#create-auto-moderation-rule
type CreateAutoModerationRuleResponse = Response<objects.AutomoderationRuleObject>
```

</details>

## ModifyAutoModerationRuleResponse

https://discord.com/developers/docs/resources/auto-moderation#modify-auto-moderation-rule

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/auto-moderation#modify-auto-moderation-rule
type ModifyAutoModerationRuleResponse = Response<objects.AutomoderationRuleObject>
```

</details>

## DeleteAutoModerationRuleResponse

https://discord.com/developers/docs/resources/auto-moderation#delete-auto-moderation-rule

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/auto-moderation#delete-auto-moderation-rule
type DeleteAutoModerationRuleResponse = Response<nil>
```

</details>

## GetChannelResponse

https://discord.com/developers/docs/resources/channel#get-channel

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#get-channel
type GetChannelResponse = Response<objects.ChannelObject & (objects.ThreadMemberObject?)>
```

</details>

## ModifyChannelResponse

https://discord.com/developers/docs/resources/channel#modify-channel

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#modify-channel
type ModifyChannelResponse = Response<objects.ChannelObject>
```

</details>

## DeleteCloseChannelResponse

https://discord.com/developers/docs/resources/channel#deleteclose-channel

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#deleteclose-channel
type DeleteCloseChannelResponse = Response<objects.ChannelObject>
```

</details>

## GetChannelMessagesResponse

https://discord.com/developers/docs/resources/channel#get-channel-messages

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#get-channel-messages
type GetChannelMessagesResponse = Response<{objects.MessageObject}>
```

</details>

## GetChannelMessageResponse

https://discord.com/developers/docs/resources/channel#get-channel-message

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#get-channel-message
type GetChannelMessageResponse = Response<objects.MessageObject>
```

</details>

## CreateMessageResponse

https://discord.com/developers/docs/resources/channel#create-message

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#create-message
type CreateMessageResponse = Response<objects.MessageObject>
```

</details>

## CrosspostMessageResponse

https://discord.com/developers/docs/resources/channel#crosspost-message

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#crosspost-message
type CrosspostMessageResponse = Response<objects.MessageObject>
```

</details>

## CreateReactionResponse

https://discord.com/developers/docs/resources/channel#create-reaction

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#create-reaction
type CreateReactionResponse = Response<nil>
```

</details>

## DeleteOwnReactionResponse

https://discord.com/developers/docs/resources/channel#delete-own-reaction

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#delete-own-reaction
type DeleteOwnReactionResponse = Response<nil>
```

</details>

## DeleteUserReactionResponse

https://discord.com/developers/docs/resources/channel#delete-user-reaction

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#delete-user-reaction
type DeleteUserReactionResponse = Response<nil>
```

</details>

## GetReactionsResponse

https://discord.com/developers/docs/resources/channel#get-reactions

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#get-reactions
type GetReactionsResponse = Response<{objects.UserObject}>
```

</details>

## DeleteAllReactionsResponse

https://discord.com/developers/docs/resources/channel#delete-all-reactions

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#delete-all-reactions
type DeleteAllReactionsResponse = Response<nil>
```

</details>

## DeleteAllReactionsForEmojiResponse

https://discord.com/developers/docs/resources/channel#delete-all-reactions-for-emoji

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#delete-all-reactions-for-emoji
type DeleteAllReactionsForEmojiResponse = Response<nil>
```

</details>

## EditMessageResponse

https://discord.com/developers/docs/resources/channel#edit-message

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#edit-message
type EditMessageResponse = Response<objects.MessageObject>
```

</details>

## DeleteMessageResponse

https://discord.com/developers/docs/resources/channel#delete-message

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#delete-message
type DeleteMessageResponse = Response<nil>
```

</details>

## BulkDeleteMessageResponse

https://discord.com/developers/docs/resources/channel#bulk-delete-messages

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#bulk-delete-messages
type BulkDeleteMessageResponse = Response<nil>
```

</details>

## EditChannelPermissionsResponse

https://discord.com/developers/docs/resources/channel#edit-channel-permissions

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#edit-channel-permissions
type EditChannelPermissionsResponse = Response<nil>
```

</details>

## GetChannelInvitesResponse

https://discord.com/developers/docs/resources/channel#get-channel-invites

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#get-channel-invites
type GetChannelInvitesResponse = Response<{objects.InviteObject & objects.InviteMetadataObject}>
```

</details>

## CreateChannelInviteResponse

https://discord.com/developers/docs/resources/channel#create-channel-invite

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#create-channel-invite
type CreateChannelInviteResponse = Response<objects.InviteObject>
```

</details>

## DeleteChannelPermissionResponse

https://discord.com/developers/docs/resources/channel#delete-channel-permission

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#delete-channel-permission
type DeleteChannelPermissionResponse = Response<nil>
```

</details>

## FollowAnnouncementChannelResponse

https://discord.com/developers/docs/resources/channel#follow-announcement-channel

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#follow-announcement-channel
type FollowAnnouncementChannelResponse = Response<objects.FollowedChannelObject>
```

</details>

## TriggerTypingIndicatorResponse

https://discord.com/developers/docs/resources/channel#trigger-typing-indicator

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#trigger-typing-indicator
type TriggerTypingIndicatorResponse = Response<nil>
```

</details>

## GetPinnedMessagesResponse

https://discord.com/developers/docs/resources/channel#get-pinned-messages

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#get-pinned-messages
type GetPinnedMessagesResponse = Response<{objects.MessageObject}>
```

</details>

## PinMessageResponse

https://discord.com/developers/docs/resources/channel#pin-message

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#pin-message
type PinMessageResponse = Response<nil>
```

</details>

## UnpinMessageResponse

https://discord.com/developers/docs/resources/channel#unpin-message

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#unpin-message
type UnpinMessageResponse = Response<nil>
```

</details>

## GroupDMAddRecipientResponse

https://discord.com/developers/docs/resources/channel#group-dm-add-recipient

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#group-dm-add-recipient
type GroupDMAddRecipientResponse = Response<nil>
```

</details>

## GroupDMRemoveRecipientResponse

https://discord.com/developers/docs/resources/channel#group-dm-remove-recipient

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#group-dm-remove-recipient
type GroupDMRemoveRecipientResponse = Response<nil>
```

</details>

## StartThreadFromMessageResponse

https://discord.com/developers/docs/resources/channel#start-thread-from-message

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#start-thread-from-message
type StartThreadFromMessageResponse = Response<objects.ChannelObject>
```

</details>

## StartThreadWithoutMessageResponse

https://discord.com/developers/docs/resources/channel#start-thread-without-message

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#start-thread-without-message
type StartThreadWithoutMessageResponse = Response<objects.ChannelObject>
```

</details>

## StartThreadInForumOrMediaChannelResponse

https://discord.com/developers/docs/resources/channel#start-thread-in-forum-or-media-channel

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#start-thread-in-forum-or-media-channel
type StartThreadInForumOrMediaChannelResponse = Response<objects.ChannelObject>
```

</details>

## JoinThreadResponse

https://discord.com/developers/docs/resources/channel#join-thread

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#join-thread
type JoinThreadResponse = Response<nil>
```

</details>

## AddThreadMemberResponse

https://discord.com/developers/docs/resources/channel#add-thread-member

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#add-thread-member
type AddThreadMemberResponse = Response<nil>
```

</details>

## LeaveThreadResponse

https://discord.com/developers/docs/resources/channel#leave-thread

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#leave-thread
type LeaveThreadResponse = Response<nil>
```

</details>

## RemoveThreadMemberResponse

https://discord.com/developers/docs/resources/channel#remove-thread-member

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#remove-thread-member
type RemoveThreadMemberResponse = Response<nil>
```

</details>

## GetThreadMemberResponse

https://discord.com/developers/docs/resources/channel#get-thread-member

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#get-thread-member
type GetThreadMemberResponse = Response<objects.ThreadMemberObject>
```

</details>

## ListThreadMembersResponse

https://discord.com/developers/docs/resources/channel#list-thread-members

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#list-thread-members
type ListThreadMembersResponse = Response<{objects.ThreadMemberObject}>
```

</details>

## ListPublicArchivedThreadsResponse

https://discord.com/developers/docs/resources/channel#list-public-archived-threads

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#list-public-archived-threads
type ListPublicArchivedThreadsResponse = Response<{
	threads: {objects.ChannelObject},

	members: {objects.ThreadMemberObject},

	has_more: boolean
}>
```

</details>

## ListPrivateArchivedThreadsResponse

https://discord.com/developers/docs/resources/channel#list-private-archived-threads

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#list-private-archived-threads
type ListPrivateArchivedThreadsResponse = Response<{
	threads: {objects.ChannelObject},

	members: {objects.ThreadMemberObject},

	has_more: boolean
}>
```

</details>

## ListJoinedPrivateArchivedThreadsResponse

https://discord.com/developers/docs/resources/channel#list-joined-private-archived-threads

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#list-joined-private-archived-threads
type ListJoinedPrivateArchivedThreadsResponse = Response<{
	threads: {objects.ChannelObject},

	members: {objects.ThreadMemberObject},

	has_more: boolean
}>
```

</details>

## ListGuildEmojisResponse

https://discord.com/developers/docs/resources/emoji#list-guild-emojis

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/emoji#list-guild-emojis
type ListGuildEmojisResponse = Response<{objects.EmojiObject}>
```

</details>

## GetGuildEmojiResponse

https://discord.com/developers/docs/resources/emoji#get-guild-emoji

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/emoji#get-guild-emoji
type GetGuildEmojiResponse = Response<objects.EmojiObject>
```

</details>

## CreateGuildEmojiResponse

https://discord.com/developers/docs/resources/emoji#create-guild-emoji

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/emoji#create-guild-emoji
type CreateGuildEmojiResponse = Response<objects.EmojiObject>
```

</details>

## ModifyGuildEmojiResponse

https://discord.com/developers/docs/resources/emoji#modify-guild-emoji

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/emoji#modify-guild-emoji
type ModifyGuildEmojiResponse = Response<objects.EmojiObject>
```

</details>

## DeleteGuildEmojiResponse

https://discord.com/developers/docs/resources/emoji#delete-guild-emoji

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/emoji#delete-guild-emoji
type DeleteGuildEmojiResponse = Response<nil>
```

</details>

## CreateGuildResponse

https://discord.com/developers/docs/resources/guild#create-guild

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#create-guild
type CreateGuildResponse = Response<objects.GuildObject>
```

</details>

## GetGuildResponse

https://discord.com/developers/docs/resources/guild#get-guild

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#get-guild
type GetGuildResponse = Response<objects.GuildObject>
```

</details>

## GetGuildPreviewResponse

https://discord.com/developers/docs/resources/guild#get-guild

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#get-guild
type GetGuildPreviewResponse = Response<objects.GuildPreviewObject>
```

</details>

## ModifyGuildResponse

https://discord.com/developers/docs/resources/guild#modify-guild

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#modify-guild
type ModifyGuildResponse = Response<objects.GuildObject>
```

</details>

## DeleteGuildResponse

https://discord.com/developers/docs/resources/guild#delete-guild

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#delete-guild
type DeleteGuildResponse = Response<nil>
```

</details>

## GetGuildChannelsResponse

https://discord.com/developers/docs/resources/guild#get-guild-channels

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#get-guild-channels
type GetGuildChannelsResponse = Response<{objects.ChannelObject}>
```

</details>

## CreateGuildChannelResponse

https://discord.com/developers/docs/resources/guild#create-guild-channel

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#create-guild-channel
type CreateGuildChannelResponse = Response<objects.ChannelObject>
```

</details>

## ModifyGuildChannelPositionsResponse

https://discord.com/developers/docs/resources/guild#modify-guild-channel-positions

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#modify-guild-channel-positions
type ModifyGuildChannelPositionsResponse = Response<nil>
```

</details>

## ListActiveGuildThreadsResponse

https://discord.com/developers/docs/resources/guild#list-active-guild-threads

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#list-active-guild-threads
type ListActiveGuildThreadsResponse = Response<{
	threads: {objects.ChannelObject},

	members: {objects.ThreadMemberObject}
}>
```

</details>

## GetGuildMemberResponse

https://discord.com/developers/docs/resources/guild#get-guild-member

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#get-guild-member
type GetGuildMemberResponse = Response<objects.GuildMemberObject>
```

</details>

## ListGuildMembersResponse

https://discord.com/developers/docs/resources/guild#list-guild-members

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#list-guild-members
type ListGuildMembersResponse = Response<{objects.GuildMemberObject}>
```

</details>

## SearchGuildMembersResponse

https://discord.com/developers/docs/resources/guild#search-guild-members

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#search-guild-members
type SearchGuildMembersResponse = Response<{objects.GuildMemberObject}>
```

</details>

## AddGuildMemberResponse

https://discord.com/developers/docs/resources/guild#add-guild-member

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#add-guild-member
type AddGuildMemberResponse = Response<objects.GuildMemberObject>
```

</details>

## ModifyGuildMemberResponse

https://discord.com/developers/docs/resources/guild#modify-guild-member

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#modify-guild-member
type ModifyGuildMemberResponse = Response<objects.GuildMemberObject>
```

</details>

## ModifyCurrentMemberResponse

https://discord.com/developers/docs/resources/guild#modify-current-member

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#modify-current-member
type ModifyCurrentMemberResponse = Response<objects.GuildMemberObject>
```

</details>

## AddGuildMemberRoleResponse

https://discord.com/developers/docs/resources/guild#add-guild-member-role

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#add-guild-member-role
type AddGuildMemberRoleResponse = Response<nil>
```

</details>

## RemoveGuildMemberRoleResponse

https://discord.com/developers/docs/resources/guild#remove-guild-member-role

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#remove-guild-member-role
type RemoveGuildMemberRoleResponse = Response<nil>
```

</details>

## RemoveGuildMemberResponse

https://discord.com/developers/docs/resources/guild#remove-guild-member

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#remove-guild-member
type RemoveGuildMemberResponse = Response<nil>
```

</details>

## GetGuildBansResponse

https://discord.com/developers/docs/resources/guild#get-guild-bans

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#get-guild-bans
type GetGuildBansResponse = Response<{objects.BanObject}>
```

</details>

## GetGuildBanResponse

https://discord.com/developers/docs/resources/guild#get-guild-ban

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#get-guild-ban
type GetGuildBanResponse = Response<objects.BanObject>
```

</details>

## CreateGuildBanResponse

https://discord.com/developers/docs/resources/guild#create-guild-ban

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#create-guild-ban
type CreateGuildBanResponse = Response<nil>
```

</details>

## RemoveGuildBanResponse

https://discord.com/developers/docs/resources/guild#remove-guild-ban

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#remove-guild-ban
type RemoveGuildBanResponse = Response<nil>
```

</details>

## BulkGuildBanResponse

https://discord.com/developers/docs/resources/guild#bulk-guild-ban

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#bulk-guild-ban
type BulkGuildBanResponse = Response<{
	banned_users: {objects.Snowflake},

	failed_users: {objects.Snowflake}
}>
```

</details>

## GetGuildRolesResponse

https://discord.com/developers/docs/resources/guild#get-guild-roles

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#get-guild-roles
type GetGuildRolesResponse = Response<{objects.GuildRoleObject}>
```

</details>

## GetGuildRoleResponse

https://discord.com/developers/docs/resources/guild#get-guild-roles

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#get-guild-roles
type GetGuildRoleResponse = Response<objects.GuildRoleObject>
```

</details>

## CreateGuildRoleResponse

https://discord.com/developers/docs/resources/guild#create-guild-role

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#create-guild-role
type CreateGuildRoleResponse = Response<objects.GuildRoleObject>
```

</details>

## ModifyGuildRolePositionsResponse

https://discord.com/developers/docs/resources/guild#modify-guild-role-positions

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#modify-guild-role-positions
type ModifyGuildRolePositionsResponse = Response<{objects.GuildRoleObject}>
```

</details>

## ModifyGuildRoleResponse

https://discord.com/developers/docs/resources/guild#modify-guild-role

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#modify-guild-role
type ModifyGuildRoleResponse = Response<objects.GuildRoleObject>
```

</details>

## ModifyGuildMFALevelResponse

https://discord.com/developers/docs/resources/guild#modify-guild-mfa-level

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#modify-guild-mfa-level
type ModifyGuildMFALevelResponse = Response<unknown>
```

</details>

## DeleteGuildRoleResponse

https://discord.com/developers/docs/resources/guild#delete-guild-role

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#delete-guild-role
type DeleteGuildRoleResponse = Response<nil>
```

</details>

## GetGuildPruneCountResponse

https://discord.com/developers/docs/resources/guild#get-guild-prune-count

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#get-guild-prune-count
type GetGuildPruneCountResponse = Response<{
	pruned: number
}>
```

</details>

## BeginGuildPruneResponse

https://discord.com/developers/docs/resources/guild#begin-guild-prune

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#begin-guild-prune
type BeginGuildPruneResponse = Response<{
	pruned: number
}>
```

</details>

## GetGuildVoiceRegionsResponse

https://discord.com/developers/docs/resources/guild#get-guild-voice-regions

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#get-guild-voice-regions
type GetGuildVoiceRegionsResponse = Response<{objects.VoiceRegionObject}>
```

</details>

## GetGuildInvitesResponse

https://discord.com/developers/docs/resources/guild#get-guild-invites

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#get-guild-invites
type GetGuildInvitesResponse = Response<{objects.InviteObject & objects.InviteMetadataObject}>
```

</details>

## GetGuildIntegrationsResponse

https://discord.com/developers/docs/resources/guild#get-guild-integrations

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#get-guild-integrations
type GetGuildIntegrationsResponse = Response<{objects.IntegrationObject}>
```

</details>

## DeleteGuildIntegrationResponse

https://discord.com/developers/docs/resources/guild#delete-guild-integration

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#delete-guild-integration
type DeleteGuildIntegrationResponse = Response<nil>
```

</details>

## GetGuildWidgetSettingsResponse

https://discord.com/developers/docs/resources/guild#get-guild-widget-settings

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#get-guild-widget-settings
type GetGuildWidgetSettingsResponse = Response<objects.GuildWidgetSettingsObject>
```

</details>

## ModifyGuildWidgetResponse

https://discord.com/developers/docs/resources/guild#modify-guild-widget

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#modify-guild-widget
type ModifyGuildWidgetResponse = Response<objects.GuildWidgetSettingsObject>
```

</details>

## GetGuildWidgetResponse

https://discord.com/developers/docs/resources/guild#get-guild-widget

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#get-guild-widget
type GetGuildWidgetResponse = Response<objects.GuildWidgetObject>
```

</details>

## GetGuildVanityUrlResponse

https://discord.com/developers/docs/resources/guild#get-guild-vanity-url

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#get-guild-vanity-url
type GetGuildVanityUrlResponse = Response<objects.GuildVanityUrl>
```

</details>

## GetGuildWidgetImageResponse

https://discord.com/developers/docs/resources/guild#get-guild-widget-image

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#get-guild-widget-image
type GetGuildWidgetImageResponse = Response<string>
```

</details>

## GetGuildWelcomeScreenResponse

https://discord.com/developers/docs/resources/guild#get-guild-welcome-screen

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#get-guild-welcome-screen
type GetGuildWelcomeScreenResponse = Response<objects.WelcomeScreenObject>
```

</details>

## ModifyGuildWelcomeScreenResponse

https://discord.com/developers/docs/resources/guild#modify-guild-welcome-screen

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#modify-guild-welcome-screen
type ModifyGuildWelcomeScreenResponse = Response<objects.WelcomeScreenObject>
```

</details>

## GetGuildOnboardingResponse

https://discord.com/developers/docs/resources/guild#get-guild-onboarding

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#get-guild-onboarding
type GetGuildOnboardingResponse = Response<objects.GuildOnboardingObject>
```

</details>

## ModifyGuildOnboardingResponse

https://discord.com/developers/docs/resources/guild#modify-guild-onboarding

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#modify-guild-onboarding
type ModifyGuildOnboardingResponse = Response<objects.GuildOnboardingObject>
```

</details>

## ModifyCurrentUserVoiceStateResponse

https://discord.com/developers/docs/resources/guild#modify-current-user-voice-state

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#modify-current-user-voice-state
type ModifyCurrentUserVoiceStateResponse = Response<nil>
```

</details>

## ModifyUserVoiceStateResponse

https://discord.com/developers/docs/resources/guild#modify-user-voice-state

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#modify-user-voice-state
type ModifyUserVoiceStateResponse = Response<unknown>
```

</details>

## ListScheduledEventsForGuildResponse

https://discord.com/developers/docs/resources/guild-scheduled-event#list-scheduled-events-for-guild

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild-scheduled-event#list-scheduled-events-for-guild
type ListScheduledEventsForGuildResponse = Response<{objects.GuildScheduledEventObject}>
```

</details>

## CreateGuildScheduledEventResponse

https://discord.com/developers/docs/resources/guild-scheduled-event#create-guild-scheduled-event

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild-scheduled-event#create-guild-scheduled-event
type CreateGuildScheduledEventResponse = Response<objects.GuildScheduledEventObject>
```

</details>

## GetGuildScheduledEventResponse

https://discord.com/developers/docs/resources/guild-scheduled-event#get-guild-scheduled-event

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild-scheduled-event#get-guild-scheduled-event
type GetGuildScheduledEventResponse = Response<objects.GuildScheduledEventObject>
```

</details>

## ModifyGuildScheduledEventResponse

https://discord.com/developers/docs/resources/guild-scheduled-event#modify-guild-scheduled-event

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild-scheduled-event#modify-guild-scheduled-event
type ModifyGuildScheduledEventResponse = Response<objects.GuildScheduledEventObject>
```

</details>

## DeleteGuildScheduledEventResponse

https://discord.com/developers/docs/resources/guild-scheduled-event#delete-guild-scheduled-event

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild-scheduled-event#delete-guild-scheduled-event
type DeleteGuildScheduledEventResponse = Response<nil>
```

</details>

## GetGuildScheduledEventUsersResponse

https://discord.com/developers/docs/resources/guild-scheduled-event#get-guild-scheduled-event-users

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild-scheduled-event#get-guild-scheduled-event-users
type GetGuildScheduledEventUsersResponse = Response<{objects.GuildScheduledEventUserObject}>
```

</details>

## GetGuildTemplateResponse

https://discord.com/developers/docs/resources/guild-template#get-guild-template

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild-template#get-guild-template
type GetGuildTemplateResponse = Response<objects.GuildTemplateObject>
```

</details>

## CreateGuildFromGuildTemplateResponse

https://discord.com/developers/docs/resources/guild-template#create-guild-from-guild-template

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild-template#create-guild-from-guild-template
type CreateGuildFromGuildTemplateResponse = Response<objects.GuildObject>
```

</details>

## GetGuildTemplatesResponse

https://discord.com/developers/docs/resources/guild-template#get-guild-templates

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild-template#get-guild-templates
type GetGuildTemplatesResponse = Response<objects.GuildTemplateObject>
```

</details>

## CreateGuildTemplateResponse

https://discord.com/developers/docs/resources/guild-template#create-guild-template

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild-template#create-guild-template
type CreateGuildTemplateResponse = Response<objects.GuildTemplateObject>
```

</details>

## SyncGuildTemplateResponse

https://discord.com/developers/docs/resources/guild-template#sync-guild-template

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild-template#sync-guild-template
type SyncGuildTemplateResponse = Response<objects.GuildTemplateObject>
```

</details>

## ModifyGuildTemplateResponse

https://discord.com/developers/docs/resources/guild-template#modify-guild-template

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild-template#modify-guild-template
type ModifyGuildTemplateResponse = Response<objects.GuildTemplateObject>
```

</details>

## DeleteGuildTemplateResponse

https://discord.com/developers/docs/resources/guild-template#delete-guild-template

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild-template#delete-guild-template
type DeleteGuildTemplateResponse = Response<objects.GuildTemplateObject>
```

</details>

## GetInviteResponse

https://discord.com/developers/docs/resources/invite#get-invite

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/invite#get-invite
type GetInviteResponse = Response<objects.InviteObject>
```

</details>

## DeleteInviteResponse

https://discord.com/developers/docs/resources/invite#delete-invite

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/invite#delete-invite
type DeleteInviteResponse = Response<objects.InviteObject>
```

</details>

## GetAnswerVotersResponse

https://discord.com/developers/docs/resources/poll#get-answer-voters

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/poll#get-answer-voters
type GetAnswerVotersResponse = Response<{objects.UserObject}>
```

</details>

## EndPollResponse

https://discord.com/developers/docs/resources/poll#end-poll

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/poll#end-poll
type EndPollResponse = Response<objects.MessageObject>
```

</details>

## CreateStageInstanceResponse

https://discord.com/developers/docs/resources/stage-instance#create-stage-instance

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/stage-instance#create-stage-instance
type CreateStageInstanceResponse = Response<objects.StageInstanceObject>
```

</details>

## GetStageInstanceResponse

https://discord.com/developers/docs/resources/stage-instance#get-stage-instance

discord-fixme: make a PR to declare what this API returns.

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/stage-instance#get-stage-instance
-- discord-fixme: make a PR to declare what this API returns.
type GetStageInstanceResponse = Response<objects.StageInstanceObject>
```

</details>

## ModifyStageInstanceResponse

https://discord.com/developers/docs/resources/stage-instance#modify-stage-instance

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/stage-instance#modify-stage-instance
type ModifyStageInstanceResponse = Response<objects.StageInstanceObject>
```

</details>

## DeleteStageInstanceResponse

https://discord.com/developers/docs/resources/stage-instance#delete-stage-instance

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/stage-instance#delete-stage-instance
type DeleteStageInstanceResponse = Response<nil>
```

</details>

## GetStickerResponse

https://discord.com/developers/docs/resources/sticker#get-sticker

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/sticker#get-sticker
type GetStickerResponse = Response<objects.StickerObject>
```

</details>

## ListStickerPacksResponse

https://discord.com/developers/docs/resources/sticker#list-sticker-packs

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/sticker#list-sticker-packs
type ListStickerPacksResponse = Response<{
	sticker_packs: {objects.StickerPackObject}
}>
```

</details>

## ListGuildStickersResponse

https://discord.com/developers/docs/resources/sticker#list-guild-stickers

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/sticker#list-guild-stickers
type ListGuildStickersResponse = Response<{objects.StickerObject}>
```

</details>

## GetGuildStickerResponse

https://discord.com/developers/docs/resources/sticker#get-guild-sticker

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/sticker#get-guild-sticker
type GetGuildStickerResponse = Response<objects.StickerObject>
```

</details>

## CreateGuildStickerResponse

https://discord.com/developers/docs/resources/sticker#create-guild-sticker

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/sticker#create-guild-sticker
type CreateGuildStickerResponse = Response<objects.StickerObject>
```

</details>

## ModifyGuildStickerResponse

https://discord.com/developers/docs/resources/sticker#modify-guild-sticker

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/sticker#modify-guild-sticker
type ModifyGuildStickerResponse = Response<objects.StickerObject>
```

</details>

## DeleteGuildStickerResponse

https://discord.com/developers/docs/resources/sticker#delete-guild-sticker

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/sticker#delete-guild-sticker
type DeleteGuildStickerResponse = Response<nil>
```

</details>

## GetCurrentUserResponse

https://discord.com/developers/docs/resources/user#get-current-user

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/user#get-current-user
type GetCurrentUserResponse = Response<objects.UserObject>
```

</details>

## GetUserResponse

https://discord.com/developers/docs/resources/user#get-user

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/user#get-user
type GetUserResponse = Response<objects.UserObject>
```

</details>

## ModifyCurrentUserResponse

https://discord.com/developers/docs/resources/user#modify-current-user

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/user#modify-current-user
type ModifyCurrentUserResponse = Response<objects.UserObject>
```

</details>

## GetCurrentUserGuildsResponse

https://discord.com/developers/docs/resources/user#get-current-user-guilds

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/user#get-current-user-guilds
type GetCurrentUserGuildsResponse = Response<{objects.GuildObject}>
```

</details>

## GetCurrentUserGuildMemberResponse

https://discord.com/developers/docs/resources/user#get-current-user-guild-member

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/user#get-current-user-guild-member
type GetCurrentUserGuildMemberResponse = Response<objects.GuildMemberObject>
```

</details>

## LeaveGuildResponse

https://discord.com/developers/docs/resources/user#leave-guild

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/user#leave-guild
type LeaveGuildResponse = Response<nil>
```

</details>

## CreateDMResponse

https://discord.com/developers/docs/resources/user#create-dm

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/user#create-dm
type CreateDMResponse = Response<objects.ChannelObject>
```

</details>

## CreateGroupDMResponse

https://discord.com/developers/docs/resources/user#create-group-dm

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/user#create-group-dm
type CreateGroupDMResponse = Response<objects.ChannelObject>
```

</details>

## GetCurrentUserConnectionResponse

https://discord.com/developers/docs/resources/user#get-current-user-connections

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/user#get-current-user-connections
type GetCurrentUserConnectionResponse = Response<objects.ConnectionObject>
```

</details>

## GetCurrentUserApplicationRoleConnectionResponse

https://discord.com/developers/docs/resources/user#get-current-user-application-role-connection

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/user#get-current-user-application-role-connection
type GetCurrentUserApplicationRoleConnectionResponse = Response<objects.ApplicationRoleConnectionObject>
```

</details>

## UpdateCurrentUserApplicationRoleConnectionResponse

https://discord.com/developers/docs/resources/user#update-current-user-application-role-connection

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/user#update-current-user-application-role-connection
type UpdateCurrentUserApplicationRoleConnectionResponse = Response<objects.ApplicationRoleConnectionObject>
```

</details>

## ListVoiceRegionsResponse

https://discord.com/developers/docs/resources/voice

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/voice
type ListVoiceRegionsResponse = Response<{objects.VoiceRegionObject}>
```

</details>

## CreateWebhookResponse

https://discord.com/developers/docs/resources/webhook#create-webhook

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/webhook#create-webhook
type CreateWebhookResponse = Response<objects.WebhookObject>
```

</details>

## GetChannelWebhooksResponse

https://discord.com/developers/docs/resources/webhook#get-channel-webhooks

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/webhook#get-channel-webhooks
type GetChannelWebhooksResponse = Response<{objects.WebhookObject}>
```

</details>

## GetGuildWebhooksResponse

https://discord.com/developers/docs/resources/webhook#get-guild-webhooks

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/webhook#get-guild-webhooks
type GetGuildWebhooksResponse = Response<{objects.WebhookObject}>
```

</details>

## GetWebhookResponse

https://discord.com/developers/docs/resources/webhook#get-webhook

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/webhook#get-webhook
type GetWebhookResponse = Response<objects.WebhookObject>
```

</details>

## GetWebhookWithTokenResponse

https://discord.com/developers/docs/resources/webhook#get-webhook-with-token

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/webhook#get-webhook-with-token
type GetWebhookWithTokenResponse = Response<objects.WebhookObject>
```

</details>

## ModifyWebhookResponse

https://discord.com/developers/docs/resources/webhook#modify-webhook

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/webhook#modify-webhook
type ModifyWebhookResponse = Response<objects.WebhookObject>
```

</details>

## ModifyWebhookWithTokenResponse

https://discord.com/developers/docs/resources/webhook#modify-webhook-with-token

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/webhook#modify-webhook-with-token
type ModifyWebhookWithTokenResponse = Response<objects.WebhookObject>
```

</details>

## DeleteWebhookResponse

https://discord.com/developers/docs/resources/webhook#delete-webhook

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/webhook#delete-webhook
type DeleteWebhookResponse = Response<nil>
```

</details>

## DeleteWebhookWitHTokenResponse

https://discord.com/developers/docs/resources/webhook#delete-webhook-with-token

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/webhook#delete-webhook-with-token
type DeleteWebhookWitHTokenResponse = Response<nil>
```

</details>

## ExecuteWebhookResponse

https://discord.com/developers/docs/resources/webhook#execute-webhook

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/webhook#execute-webhook
type ExecuteWebhookResponse = Response<objects.MessageObject?>
```

</details>

## ExecuteSlackCompatibleWebhookResponse

https://discord.com/developers/docs/resources/webhook#execute-slackcompatible-webhook

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/webhook#execute-slackcompatible-webhook
type ExecuteSlackCompatibleWebhookResponse = Response<unknown>
```

</details>

## ExecuteGitCompatibleWebhookResponse

https://discord.com/developers/docs/resources/webhook#execute-githubcompatible-webhook

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/webhook#execute-githubcompatible-webhook
type ExecuteGitCompatibleWebhookResponse = Response<unknown>
```

</details>

## GetWebhookMessageResponse

https://discord.com/developers/docs/resources/webhook#get-webhook-message

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/webhook#get-webhook-message
type GetWebhookMessageResponse = Response<objects.MessageObject>
```

</details>

## EditWebhookMessageResponse

https://discord.com/developers/docs/resources/webhook#edit-webhook-message

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/webhook#edit-webhook-message
type EditWebhookMessageResponse = Response<objects.MessageObject>
```

</details>

## DeleteWebhookMessageResponse

https://discord.com/developers/docs/resources/webhook#delete-webhook-message

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/webhook#delete-webhook-message
type DeleteWebhookMessageResponse = Response<nil>
```

</details>

## GetGatewayResponse

https://discord.com/developers/docs/topics/gateway#get-gateway

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/topics/gateway#get-gateway
type GetGatewayResponse = Response<{
	url: string
}>
```

</details>

## GetGatewayBotResponse

https://discord.com/developers/docs/topics/gateway#get-gateway-bot

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/topics/gateway#get-gateway-bot
type GetGatewayBotResponse = Response<{
	url: string,

	shards: number,

	session_start_limit: objects.SessionStartLimitObject
}>
```

</details>

## CreateInteractionResponse

https://discord.com/developers/docs/interactions/receiving-and-responding#create-interaction-response

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/receiving-and-responding#create-interaction-response
type CreateInteractionResponse = Response<{
	resource: {
		message: objects.MessageObject?
	}
}>
```

</details>

## GetOriginalInteractionResponse

https://discord.com/developers/docs/interactions/receiving-and-responding#get-original-interaction-response

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/receiving-and-responding#get-original-interaction-response
type GetOriginalInteractionResponse = Response<objects.MessageObject>
```

</details>

## EditOriginalInteractionResponse

https://discord.com/developers/docs/interactions/receiving-and-responding#edit-original-interaction-response

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/receiving-and-responding#edit-original-interaction-response
type EditOriginalInteractionResponse = Response<objects.MessageObject>
```

</details>

## DeleteOriginalInteractionResponse

https://discord.com/developers/docs/interactions/receiving-and-responding#delete-original-interaction-response

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/receiving-and-responding#delete-original-interaction-response
type DeleteOriginalInteractionResponse = Response<nil>
```

</details>

## CreateFollowupMessageResponse

https://discord.com/developers/docs/interactions/receiving-and-responding#create-followup-message

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/receiving-and-responding#create-followup-message
type CreateFollowupMessageResponse = Response<objects.MessageObject>
```

</details>

## GetFollowupMessageResponse

https://discord.com/developers/docs/interactions/receiving-and-responding#get-followup-message

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/receiving-and-responding#get-followup-message
type GetFollowupMessageResponse = Response<objects.MessageObject>
```

</details>

## EditFollowupMessageResponse

https://discord.com/developers/docs/interactions/receiving-and-responding#edit-followup-message

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/receiving-and-responding#edit-followup-message
type EditFollowupMessageResponse = Response<objects.MessageObject>
```

</details>

## DeleteFollowupMessageResponse

https://discord.com/developers/docs/interactions/receiving-and-responding#delete-followup-message

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/receiving-and-responding#delete-followup-message
type DeleteFollowupMessageResponse = Response<nil>
```

</details>

