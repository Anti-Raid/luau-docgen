<div id="Types"></div>

# Types

<div id="Response"></div>

## Response

[[ Base ]] --

<details>
<summary>Raw Type</summary>

```luau
-- [[ Base ]] --
type Response<DATA> = DATA
```

</details>

[DATA](#DATA)

<div id="Request"></div>

## Request

<details>
<summary>Raw Type</summary>

```luau
type Request<DATA> = DATA
```

</details>

[DATA](#DATA)

<div id="CreateMessageAttachment"></div>

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

<div id="filename"></div>

### filename

The filename of the attachment

[string](#string)

<div id="description"></div>

### description

The description (if any) of the attachment

*This field is optional and may not be specified*

[string?](#string)?

<div id="content"></div>

### content

The content of the attachment

*This field is an array type*

[Primitives](#module.Primitives).[#byte](#byte)

<div id="CreateInteractionRequest"></div>

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

[#Request](#Request)<[objects](#module.objects).[#InteractionResponseObject](#InteractionResponseObject)

><div id="EditOriginalInteractionRequest"></div>

## EditOriginalInteractionRequest

https://discord.com/developers/docs/interactions/receiving-and-responding#edit-original-interaction-response

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/receiving-and-responding#edit-original-interaction-response
type EditOriginalInteractionRequest = Request<objects.Partial<objects.MessageObject>>
```

</details>

[#Request](#Request)<[objects](#module.objects).[#Partial](#Partial)<[objects](#module.objects).[#MessageObject](#MessageObject)

>

><div id="CreateFollowupMessageRequest"></div>

## CreateFollowupMessageRequest

https://discord.com/developers/docs/interactions/receiving-and-responding#create-followup-message

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/receiving-and-responding#create-followup-message
type CreateFollowupMessageRequest = Request<objects.Partial<objects.MessageObject>>
```

</details>

[#Request](#Request)<[objects](#module.objects).[#Partial](#Partial)<[objects](#module.objects).[#MessageObject](#MessageObject)

>

><div id="EditFollowupMessageRequest"></div>

## EditFollowupMessageRequest

https://discord.com/developers/docs/interactions/receiving-and-responding#edit-followup-message

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/receiving-and-responding#edit-followup-message
type EditFollowupMessageRequest = Request<objects.Partial<objects.MessageObject>>
```

</details>

[#Request](#Request)<[objects](#module.objects).[#Partial](#Partial)<[objects](#module.objects).[#MessageObject](#MessageObject)

>

><div id="CreateAutoModerationRuleRequest"></div>

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

[#Request](#Request)<, [objects](#module.objects).[#AutomoderationRuleEventType](#AutomoderationRuleEventType)

, , , , , , ><div id="ModifyAutoModerationRuleRequest"></div>

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

[#Request](#Request)<, [objects](#module.objects).[#AutomoderationRuleEventType](#AutomoderationRuleEventType)

, , , , , ><div id="EditCurrentApplicationRequest"></div>

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

[#Request](#Request)<[string](#string), [string](#string), [string](#string), [objects](#module.objects).[#InstallParamsObject](#InstallParamsObject)

, [unknown](#unknown), [number](#number), , , [string](#string), *This field is an array type*

[{string}](#string)

><div id="ModifyChannelRequest"></div>

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

[#Request](#Request)<, [objects](#module.objects).[#ChannelType](#ChannelType)

, , , , , , , , , , , [objects](#module.objects).[#VideoQualityMode](#VideoQualityMode)

, , , , , , , , , , , , *This field is an array type*

[objects](#module.objects).[#Snowflake](#Snowflake)

><div id="CreateMessageRequest"></div>

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

[#Request](#Request)<, , , , , , , , , , , ><div id="EditMessageRequest"></div>

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

[#Request](#Request)<, , , , , ><div id="CreateChannelInviteRequest"></div>

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

[#Request](#Request)<, , , , , , ><div id="BulkDeleteMessagesRequest"></div>

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

[#Request](#Request)<*This field is an array type*

[objects](#module.objects).[#Snowflake](#Snowflake)

><div id="FollowAnnouncementChannelRequest"></div>

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

[#Request](#Request)<[objects](#module.objects).[#Snowflake](#Snowflake)

><div id="GroupDMAddRecipientRequest"></div>

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

[#Request](#Request)<[string](#string), [string](#string)><div id="StartThreadFromMessageRequest"></div>

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

[#Request](#Request)<[string](#string), , ><div id="StartThreadWithoutMessageRequest"></div>

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

[#Request](#Request)<[string](#string), , , , ><div id="StartThreadInForumOrMediaChannelRequest"></div>

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

[#Request](#Request)<[string](#string), , , *This field is an array type*

[objects](#module.objects).[#Snowflake](#Snowflake)

, ><div id="CreateGuildEmojiRequest"></div>

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

[#Request](#Request)<[string](#string), [string](#string), *This field is an array type*

[objects](#module.objects).[#Snowflake](#Snowflake)

><div id="ModifyGuildEmojiRequest"></div>

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

[#Request](#Request)<[string](#string), *This field is an array type*

[objects](#module.objects).[#Snowflake](#Snowflake)

><div id="CreateGuildRequest"></div>

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

[#Request](#Request)<[string](#string), , , , , , , , [objects](#module.objects).[#Snowflake](#Snowflake)

, [number](#number), , ><div id="ModifyGuildRequest"></div>

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

[#Request](#Request)<[objects](#module.objects).[#Partial](#Partial)<[string](#string), , , , , , , [objects](#module.objects).[#Snowflake](#Snowflake)

, , , , , , , , , , , , >

><div id="CreateGuildChannelRequest"></div>

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

[#Request](#Request)<[objects](#module.objects).[#Partial](#Partial)<[string](#string), [objects](#module.objects).[#ChannelType](#ChannelType)

, , , , , [number](#number), *This field is an array type*

[objects](#module.objects).[#OverwriteObject](#OverwriteObject)

, , , , , , , , , , >

><div id="ModifyGuildChannelPositionsRequest"></div>

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

[#Request](#Request)<[objects](#module.objects).[#Snowflake](#Snowflake)

, , , ><div id="AddGuildMemberRequest"></div>

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

[#Request](#Request)<[string](#string), , , , ><div id="ModifyGuildMemberRequest"></div>

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

[#Request](#Request)<, , , , , , ><div id="ModifyCurrentMemberRequest"></div>

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

[#Request](#Request)<[string](#string)><div id="CreateGuildBanRequest"></div>

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

[#Request](#Request)<, ><div id="BulkGuildBanRequest"></div>

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

[#Request](#Request)<*This field is an array type*

[objects](#module.objects).[#Snowflake](#Snowflake)

, ><div id="CreateGuildRoleRequest"></div>

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

[#Request](#Request)<, , , , , , ><div id="ModifyGuildRolePositionsRequest"></div>

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

[#Request](#Request)<[objects](#module.objects).[#Snowflake](#Snowflake)

, [number](#number)><div id="ModifyGuildRoleRequest"></div>

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

[#Request](#Request)<, , , , , , ><div id="ModifyGuildMFALevelRequest"></div>

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

[#Request](#Request)<[objects](#module.objects).[#MFALevel](#MFALevel)

><div id="BeginGuildPruneRequest"></div>

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

[#Request](#Request)<[number](#number), [boolean](#boolean), *This field is an array type*

[objects](#module.objects).[#Snowflake](#Snowflake)

, ><div id="ModifyGuildWelcomeScreenRequest"></div>

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

[#Request](#Request)<, *This field is an array type*

[objects](#module.objects).[#WelcomeScreenChannelObject](#WelcomeScreenChannelObject)

, ><div id="ModifyGuildOnboardingRequest"></div>

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

[#Request](#Request)<, , , ><div id="ModifyCurrentUserVoiceStateRequest"></div>

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

[#Request](#Request)<, , ><div id="ModifyUserVoiceStateRequest"></div>

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

[#Request](#Request)<, ><div id="CreateGuildScheduledEventRequest"></div>

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

[#Request](#Request)<, [objects](#module.objects).[#GuildScheduledEventEntityMetadata](#GuildScheduledEventEntityMetadata)

, [string](#string), [objects](#module.objects).[#PrivacyLevel](#PrivacyLevel)

, [string](#string), , , [objects](#module.objects).[#GuildScheduledEventEntityType](#GuildScheduledEventEntityType)

, ><div id="ModifyGuildScheduledEventRequest"></div>

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

[#Request](#Request)<, [objects](#module.objects).[#GuildScheduledEventEntityMetadata](#GuildScheduledEventEntityMetadata)

, [string](#string), [objects](#module.objects).[#PrivacyLevel](#PrivacyLevel)

, [string](#string), , , [objects](#module.objects).[#GuildScheduledEventEntityType](#GuildScheduledEventEntityType)

, , ><div id="CreateGuildFromGuildTemplateRequest"></div>

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

[#Request](#Request)<[string](#string), ><div id="CreateGuildTemplateRequest"></div>

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

[#Request](#Request)<[string](#string), ><div id="ModifyGuildTemplateRequest"></div>

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

[#Request](#Request)<, ><div id="CreateStageInstanceRequest"></div>

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

[#Request](#Request)<[objects](#module.objects).[#Snowflake](#Snowflake)

, [string](#string), , , ><div id="ModifyStageInstanceRequest"></div>

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

[#Request](#Request)<[string](#string), [objects](#module.objects).[#PrivacyLevel](#PrivacyLevel)

><div id="CreateGuildStickerRequest"></div>

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

[#Request](#Request)<[string](#string), [string](#string), *This field is an array type*

[{string}](#string)

, [string](#string)><div id="ModifyGuildStickerRequest"></div>

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

[#Request](#Request)<[string](#string), , [string](#string)><div id="ModifyCurrentUserRequest"></div>

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

[#Request](#Request)<[string](#string), , ><div id="CreateDMRequest"></div>

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

[#Request](#Request)<[objects](#module.objects).[#Snowflake](#Snowflake)

><div id="CreateGroupDMRequest"></div>

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

[#Request](#Request)<*This field is an array type*

[{string}](#string)

, [string](#string)><div id="UpdateCurrentUserApplicationRoleConnectionRequest"></div>

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

[#Request](#Request)<, , ><div id="CreateWebhookRequest"></div>

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

[#Request](#Request)<[string](#string), ><div id="ModifyWebhookRequest"></div>

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

[#Request](#Request)<[string](#string), [string](#string), [objects](#module.objects).[#Snowflake](#Snowflake)

><div id="ExecuteWebhookRequest"></div>

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

[#Request](#Request)<[string](#string), [string](#string), [string](#string), [boolean](#boolean), *This field is an array type*

[objects](#module.objects).[#EmbedObject](#EmbedObject)

, [objects](#module.objects).[#AllowedMentionObject](#AllowedMentionObject)

, *This field is an array type*

[objects](#module.objects).[#ComponentObjects](#ComponentObjects)

, *This field is an array type*

[{CreateMessageAttachment}](#CreateMessageAttachment)

, [number](#number), [string](#string), *This field is an array type*

[objects](#module.objects).[#Snowflake](#Snowflake)

, [objects](#module.objects).[#PollObject](#PollObject)

><div id="ExecuteSlackCompatibleWebhookRequest"></div>

## ExecuteSlackCompatibleWebhookRequest

https://discord.com/developers/docs/resources/webhook#execute-slackcompatible-webhook

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/webhook#execute-slackcompatible-webhook
type ExecuteSlackCompatibleWebhookRequest = Request<{}>
```

</details>

[#Request](#Request)<><div id="ExecuteGithubCompatibleWebhookRequest"></div>

## ExecuteGithubCompatibleWebhookRequest

https://discord.com/developers/docs/resources/webhook#execute-githubcompatible-webhook

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/webhook#execute-githubcompatible-webhook
type ExecuteGithubCompatibleWebhookRequest = Request<{}>
```

</details>

[#Request](#Request)<><div id="EditWebhookMessageRequest"></div>

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

[#Request](#Request)<[string](#string), *This field is an array type*

[objects](#module.objects).[#EmbedObject](#EmbedObject)

, [objects](#module.objects).[#AllowedMentionObject](#AllowedMentionObject)

, *This field is an array type*

[objects](#module.objects).[#ComponentObjects](#ComponentObjects)

, *This field is an array type*

[{CreateMessageAttachment}](#CreateMessageAttachment)

, ><div id="EditChannelPermissionsRequest"></div>

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

[#Request](#Request)<, , [number](#number)><div id="ModifyGuildWidgetRequest"></div>

## ModifyGuildWidgetRequest

https://discord.com/developers/docs/resources/guild#modify-guild-widget

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#modify-guild-widget
type ModifyGuildWidgetRequest = Request<objects.GuildWidgetSettingsObject>
```

</details>

[#Request](#Request)<[objects](#module.objects).[#GuildWidgetSettingsObject](#GuildWidgetSettingsObject)

><div id="CrosspostMessageRequest"></div>

## CrosspostMessageRequest

https://discord.com/developers/docs/resources/channel#crosspost-message

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#crosspost-message
type CrosspostMessageRequest = Request<objects.MessageObject>
```

</details>

[#Request](#Request)<[objects](#module.objects).[#MessageObject](#MessageObject)

><div id="CreateGlobalApplicationCommandRequest"></div>

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

[#Request](#Request)<[string](#string), , , , , , , [boolean](#boolean), , , , ><div id="EditGlobalApplicationCommandRequest"></div>

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

[#Request](#Request)<[string](#string), , , , , , , [boolean](#boolean), , , ><div id="CreateGuildApplicationCommandRequest"></div>

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

[#Request](#Request)<[string](#string), , , , , , , [boolean](#boolean), , , , , ><div id="EditGuildApplicationCommandRequest"></div>

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

[#Request](#Request)<[string](#string), , , , , , , [boolean](#boolean), , , ><div id="BulkOverwriteGlobalApplicationCommandsRequest"></div>

## BulkOverwriteGlobalApplicationCommandsRequest

https://discord.com/developers/docs/interactions/application-commands#bulk-overwrite-global-application-commands

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/application-commands#bulk-overwrite-global-application-commands
type BulkOverwriteGlobalApplicationCommandsRequest = Request<{objects.ApplicationCommandObject}>
```

</details>

[#Request](#Request)<*This field is an array type*

[objects](#module.objects).[#ApplicationCommandObject](#ApplicationCommandObject)

><div id="BulkOverwriteGuildApplicationCommandsRequest"></div>

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

[#Request](#Request)<*This field is an array type*

*This is an inline table type with the following fields*

<div id="id"></div>

#### id

*This field is optional and may not be specified*

[objects](#module.objects).[#Snowflake](#Snowflake)

?

<div id="name"></div>

#### name

[string](#string)

<div id="name_localizations"></div>

#### name_localizations

*This field is optional and may not be specified*

[string](#string)?

<div id="description"></div>

#### description

*This field is optional and may not be specified*

[string?](#string)?

<div id="description_localizations"></div>

#### description_localizations

*This field is optional and may not be specified*

[string](#string)?

<div id="options"></div>

#### options

*This field is optional and may not be specified*

*This field is an array type*

[objects](#module.objects).[#ApplicationCommandOptionObject](#ApplicationCommandOptionObject)

?

<div id="default_member_permissions"></div>

#### default_member_permissions

*This field is optional and may not be specified*

[string?](#string)?

<div id="dm_permission"></div>

#### dm_permission

*This field is optional and may not be specified*

[boolean?](#boolean)?

<div id="default_permission"></div>

#### default_permission

[boolean](#boolean)

<div id="integration_types"></div>

#### integration_types

*This field is optional and may not be specified*

*This field is an array type*

[objects](#module.objects).[#IntegrationType](#IntegrationType)

?

<div id="contexts"></div>

#### contexts

*This field is optional and may not be specified*

*This field is an array type*

[objects](#module.objects).[#InteractionContextType](#InteractionContextType)

?

<div id="type"></div>

#### type

*This field is optional and may not be specified*

[objects](#module.objects).[#ApplicationCommandType](#ApplicationCommandType)

?

<div id="nsfw"></div>

#### nsfw

*This field is optional and may not be specified*

[boolean?](#boolean)?

><div id="EditApplicationCommandPermissionsRequest"></div>

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

[#Request](#Request)<*This field is an array type*

[objects](#module.objects).[#GuildApplicationCommandPermissionObject](#GuildApplicationCommandPermissionObject)

><div id="GetCurrentUserVoiceStateResponse"></div>

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

[#Response](#Response)<[objects](#module.objects).[#VoiceStateObject](#VoiceStateObject)

><div id="GetUserVoiceStateResponse"></div>

## GetUserVoiceStateResponse

https://discord.com/developers/docs/resources/voice#get-user-voice-state

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/voice#get-user-voice-state
type GetUserVoiceStateResponse = Response<objects.VoiceStateObject>
```

</details>

[#Response](#Response)<[objects](#module.objects).[#VoiceStateObject](#VoiceStateObject)

><div id="GetGlobalApplicationCommandsResponse"></div>

## GetGlobalApplicationCommandsResponse

https://discord.com/developers/docs/interactions/application-commands#get-global-application-commands

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/application-commands#get-global-application-commands
type GetGlobalApplicationCommandsResponse = Response<{objects.ApplicationCommandObject}>
```

</details>

[#Response](#Response)<*This field is an array type*

[objects](#module.objects).[#ApplicationCommandObject](#ApplicationCommandObject)

><div id="CreateGlobalApplicationCommandResponse"></div>

## CreateGlobalApplicationCommandResponse

https://discord.com/developers/docs/interactions/application-commands#create-global-application-command

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/application-commands#create-global-application-command
type CreateGlobalApplicationCommandResponse = Response<objects.ApplicationCommandObject>
```

</details>

[#Response](#Response)<[objects](#module.objects).[#ApplicationCommandObject](#ApplicationCommandObject)

><div id="GetGlobalApplicationCommandResponse"></div>

## GetGlobalApplicationCommandResponse

https://discord.com/developers/docs/interactions/application-commands#get-global-application-command

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/application-commands#get-global-application-command
type GetGlobalApplicationCommandResponse = Response<objects.ApplicationCommandObject>
```

</details>

[#Response](#Response)<[objects](#module.objects).[#ApplicationCommandObject](#ApplicationCommandObject)

><div id="EditGlobalApplicationCommandResponse"></div>

## EditGlobalApplicationCommandResponse

https://discord.com/developers/docs/interactions/application-commands#edit-global-application-command

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/application-commands#edit-global-application-command
type EditGlobalApplicationCommandResponse = Response<objects.ApplicationCommandObject>
```

</details>

[#Response](#Response)<[objects](#module.objects).[#ApplicationCommandObject](#ApplicationCommandObject)

><div id="DeleteGlobalApplicationCommandResponse"></div>

## DeleteGlobalApplicationCommandResponse

https://discord.com/developers/docs/interactions/application-commands#delete-global-application-command

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/application-commands#delete-global-application-command
type DeleteGlobalApplicationCommandResponse = Response<nil>
```

</details>

[#Response](#Response)<[nil](#nil)><div id="BulkOverwriteGlobalApplicationCommandsResponse"></div>

## BulkOverwriteGlobalApplicationCommandsResponse

https://discord.com/developers/docs/interactions/application-commands#bulk-overwrite-global-application-commands

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/application-commands#bulk-overwrite-global-application-commands
type BulkOverwriteGlobalApplicationCommandsResponse = Response<{objects.ApplicationCommandObject}>
```

</details>

[#Response](#Response)<*This field is an array type*

[objects](#module.objects).[#ApplicationCommandObject](#ApplicationCommandObject)

><div id="GetGuildApplicationCommandsResponse"></div>

## GetGuildApplicationCommandsResponse

https://discord.com/developers/docs/interactions/application-commands#get-guild-application-commands

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/application-commands#get-guild-application-commands
type GetGuildApplicationCommandsResponse = Response<{objects.ApplicationCommandObject}>
```

</details>

[#Response](#Response)<*This field is an array type*

[objects](#module.objects).[#ApplicationCommandObject](#ApplicationCommandObject)

><div id="CreateGuildApplicationCommandResponse"></div>

## CreateGuildApplicationCommandResponse

https://discord.com/developers/docs/interactions/application-commands#create-guild-application-command

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/application-commands#create-guild-application-command
type CreateGuildApplicationCommandResponse = Response<objects.ApplicationCommandObject>
```

</details>

[#Response](#Response)<[objects](#module.objects).[#ApplicationCommandObject](#ApplicationCommandObject)

><div id="GetGuildApplicationCommandResponse"></div>

## GetGuildApplicationCommandResponse

https://discord.com/developers/docs/interactions/application-commands#get-guild-application-command

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/application-commands#get-guild-application-command
type GetGuildApplicationCommandResponse = Response<objects.ApplicationCommandObject>
```

</details>

[#Response](#Response)<[objects](#module.objects).[#ApplicationCommandObject](#ApplicationCommandObject)

><div id="EditGuildApplicationCommandResponse"></div>

## EditGuildApplicationCommandResponse

https://discord.com/developers/docs/interactions/application-commands#edit-guild-application-command

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/application-commands#edit-guild-application-command
type EditGuildApplicationCommandResponse = Response<objects.ApplicationCommandObject>
```

</details>

[#Response](#Response)<[objects](#module.objects).[#ApplicationCommandObject](#ApplicationCommandObject)

><div id="DeleteGuildApplicationCommandResponse"></div>

## DeleteGuildApplicationCommandResponse

https://discord.com/developers/docs/interactions/application-commands#delete-guild-application-command

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/application-commands#delete-guild-application-command
type DeleteGuildApplicationCommandResponse = Response<nil>
```

</details>

[#Response](#Response)<[nil](#nil)><div id="BulkOverwriteGuildApplicationCommandsResponse"></div>

## BulkOverwriteGuildApplicationCommandsResponse

https://discord.com/developers/docs/interactions/application-commands#bulk-overwrite-guild-application-commands

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/application-commands#bulk-overwrite-guild-application-commands
type BulkOverwriteGuildApplicationCommandsResponse = Response<{objects.ApplicationCommandObject}>
```

</details>

[#Response](#Response)<*This field is an array type*

[objects](#module.objects).[#ApplicationCommandObject](#ApplicationCommandObject)

><div id="GetGuildApplicationCommandPermissionsResponse"></div>

## GetGuildApplicationCommandPermissionsResponse

https://discord.com/developers/docs/interactions/application-commands#get-guild-application-command-permissions

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/application-commands#get-guild-application-command-permissions
type GetGuildApplicationCommandPermissionsResponse = Response<{objects.GuildApplicationCommandPermissionsObject}>
```

</details>

[#Response](#Response)<*This field is an array type*

[objects](#module.objects).[#GuildApplicationCommandPermissionsObject](#GuildApplicationCommandPermissionsObject)

><div id="GetApplicationCommandPermissionsResponse"></div>

## GetApplicationCommandPermissionsResponse

https://discord.com/developers/docs/interactions/application-commands#get-application-command-permissions

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/application-commands#get-application-command-permissions
type GetApplicationCommandPermissionsResponse = Response<{objects.GuildApplicationCommandPermissionsObject}>
```

</details>

[#Response](#Response)<*This field is an array type*

[objects](#module.objects).[#GuildApplicationCommandPermissionsObject](#GuildApplicationCommandPermissionsObject)

><div id="EditApplicationCommandPermissionsResponse"></div>

## EditApplicationCommandPermissionsResponse

https://discord.com/developers/docs/interactions/application-commands#edit-application-command-permissions

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/application-commands#edit-application-command-permissions
type EditApplicationCommandPermissionsResponse = Response<objects.GuildApplicationCommandPermissionsObject>
```

</details>

[#Response](#Response)<[objects](#module.objects).[#GuildApplicationCommandPermissionsObject](#GuildApplicationCommandPermissionsObject)

><div id="GetCurrentApplicationResponse"></div>

## GetCurrentApplicationResponse

https://discord.com/developers/docs/resources/application#get-current-application

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/application#get-current-application
type GetCurrentApplicationResponse = Response<{objects.ApplicationObject}>
```

</details>

[#Response](#Response)<*This field is an array type*

[objects](#module.objects).[#ApplicationObject](#ApplicationObject)

><div id="EditCurrentApplicationResponse"></div>

## EditCurrentApplicationResponse

https://discord.com/developers/docs/resources/application#edit-current-application

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/application#edit-current-application
type EditCurrentApplicationResponse = Response<{objects.ApplicationObject}>
```

</details>

[#Response](#Response)<*This field is an array type*

[objects](#module.objects).[#ApplicationObject](#ApplicationObject)

><div id="GetApplicationRoleConnectionMetadataRecordsResponse"></div>

## GetApplicationRoleConnectionMetadataRecordsResponse

https://discord.com/developers/docs/resources/application-role-connection-metadata#get-application-role-connection-metadata-records

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/application-role-connection-metadata#get-application-role-connection-metadata-records
type GetApplicationRoleConnectionMetadataRecordsResponse = Response<objects.ApplicationRoleConnectionMetadataObject>
```

</details>

[#Response](#Response)<[objects](#module.objects).[#ApplicationRoleConnectionMetadataObject](#ApplicationRoleConnectionMetadataObject)

><div id="UpdateApplicationRoleConnectionMetadataRecordsResponse"></div>

## UpdateApplicationRoleConnectionMetadataRecordsResponse

https://discord.com/developers/docs/resources/application-role-connection-metadata#update-application-role-connection-metadata-records

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/application-role-connection-metadata#update-application-role-connection-metadata-records
type UpdateApplicationRoleConnectionMetadataRecordsResponse = Response<objects.ApplicationRoleConnectionMetadataObject>
```

</details>

[#Response](#Response)<[objects](#module.objects).[#ApplicationRoleConnectionMetadataObject](#ApplicationRoleConnectionMetadataObject)

><div id="GetGuildAuditLogResponse"></div>

## GetGuildAuditLogResponse

https://discord.com/developers/docs/resources/audit-log#get-guild-audit-log

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/audit-log#get-guild-audit-log
type GetGuildAuditLogResponse = Response<objects.AuditLogObject>
```

</details>

[#Response](#Response)<[objects](#module.objects).[#AuditLogObject](#AuditLogObject)

><div id="ListAutoModerationRulesForGuildResponse"></div>

## ListAutoModerationRulesForGuildResponse

https://discord.com/developers/docs/resources/auto-moderation#list-auto-moderation-rules-for-guild

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/auto-moderation#list-auto-moderation-rules-for-guild
type ListAutoModerationRulesForGuildResponse = Response<{objects.AutomoderationRuleObject}>
```

</details>

[#Response](#Response)<*This field is an array type*

[objects](#module.objects).[#AutomoderationRuleObject](#AutomoderationRuleObject)

><div id="GetAutoModerationRuleResponse"></div>

## GetAutoModerationRuleResponse

https://discord.com/developers/docs/resources/auto-moderation#get-auto-moderation-rule

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/auto-moderation#get-auto-moderation-rule
type GetAutoModerationRuleResponse = Response<objects.AutomoderationRuleObject>
```

</details>

[#Response](#Response)<[objects](#module.objects).[#AutomoderationRuleObject](#AutomoderationRuleObject)

><div id="CreateAutoModerationRuleResponse"></div>

## CreateAutoModerationRuleResponse

https://discord.com/developers/docs/resources/auto-moderation#create-auto-moderation-rule

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/auto-moderation#create-auto-moderation-rule
type CreateAutoModerationRuleResponse = Response<objects.AutomoderationRuleObject>
```

</details>

[#Response](#Response)<[objects](#module.objects).[#AutomoderationRuleObject](#AutomoderationRuleObject)

><div id="ModifyAutoModerationRuleResponse"></div>

## ModifyAutoModerationRuleResponse

https://discord.com/developers/docs/resources/auto-moderation#modify-auto-moderation-rule

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/auto-moderation#modify-auto-moderation-rule
type ModifyAutoModerationRuleResponse = Response<objects.AutomoderationRuleObject>
```

</details>

[#Response](#Response)<[objects](#module.objects).[#AutomoderationRuleObject](#AutomoderationRuleObject)

><div id="DeleteAutoModerationRuleResponse"></div>

## DeleteAutoModerationRuleResponse

https://discord.com/developers/docs/resources/auto-moderation#delete-auto-moderation-rule

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/auto-moderation#delete-auto-moderation-rule
type DeleteAutoModerationRuleResponse = Response<nil>
```

</details>

[#Response](#Response)<[nil](#nil)><div id="GetChannelResponse"></div>

## GetChannelResponse

https://discord.com/developers/docs/resources/channel#get-channel

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#get-channel
type GetChannelResponse = Response<objects.ChannelObject & (objects.ThreadMemberObject?)>
```

</details>

[#Response](#Response)<[objects](#module.objects).[#ChannelObject](#ChannelObject)

 & ><div id="ModifyChannelResponse"></div>

## ModifyChannelResponse

https://discord.com/developers/docs/resources/channel#modify-channel

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#modify-channel
type ModifyChannelResponse = Response<objects.ChannelObject>
```

</details>

[#Response](#Response)<[objects](#module.objects).[#ChannelObject](#ChannelObject)

><div id="DeleteCloseChannelResponse"></div>

## DeleteCloseChannelResponse

https://discord.com/developers/docs/resources/channel#deleteclose-channel

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#deleteclose-channel
type DeleteCloseChannelResponse = Response<objects.ChannelObject>
```

</details>

[#Response](#Response)<[objects](#module.objects).[#ChannelObject](#ChannelObject)

><div id="GetChannelMessagesResponse"></div>

## GetChannelMessagesResponse

https://discord.com/developers/docs/resources/channel#get-channel-messages

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#get-channel-messages
type GetChannelMessagesResponse = Response<{objects.MessageObject}>
```

</details>

[#Response](#Response)<*This field is an array type*

[objects](#module.objects).[#MessageObject](#MessageObject)

><div id="GetChannelMessageResponse"></div>

## GetChannelMessageResponse

https://discord.com/developers/docs/resources/channel#get-channel-message

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#get-channel-message
type GetChannelMessageResponse = Response<objects.MessageObject>
```

</details>

[#Response](#Response)<[objects](#module.objects).[#MessageObject](#MessageObject)

><div id="CreateMessageResponse"></div>

## CreateMessageResponse

https://discord.com/developers/docs/resources/channel#create-message

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#create-message
type CreateMessageResponse = Response<objects.MessageObject>
```

</details>

[#Response](#Response)<[objects](#module.objects).[#MessageObject](#MessageObject)

><div id="CrosspostMessageResponse"></div>

## CrosspostMessageResponse

https://discord.com/developers/docs/resources/channel#crosspost-message

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#crosspost-message
type CrosspostMessageResponse = Response<objects.MessageObject>
```

</details>

[#Response](#Response)<[objects](#module.objects).[#MessageObject](#MessageObject)

><div id="CreateReactionResponse"></div>

## CreateReactionResponse

https://discord.com/developers/docs/resources/channel#create-reaction

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#create-reaction
type CreateReactionResponse = Response<nil>
```

</details>

[#Response](#Response)<[nil](#nil)><div id="DeleteOwnReactionResponse"></div>

## DeleteOwnReactionResponse

https://discord.com/developers/docs/resources/channel#delete-own-reaction

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#delete-own-reaction
type DeleteOwnReactionResponse = Response<nil>
```

</details>

[#Response](#Response)<[nil](#nil)><div id="DeleteUserReactionResponse"></div>

## DeleteUserReactionResponse

https://discord.com/developers/docs/resources/channel#delete-user-reaction

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#delete-user-reaction
type DeleteUserReactionResponse = Response<nil>
```

</details>

[#Response](#Response)<[nil](#nil)><div id="GetReactionsResponse"></div>

## GetReactionsResponse

https://discord.com/developers/docs/resources/channel#get-reactions

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#get-reactions
type GetReactionsResponse = Response<{objects.UserObject}>
```

</details>

[#Response](#Response)<*This field is an array type*

[objects](#module.objects).[#UserObject](#UserObject)

><div id="DeleteAllReactionsResponse"></div>

## DeleteAllReactionsResponse

https://discord.com/developers/docs/resources/channel#delete-all-reactions

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#delete-all-reactions
type DeleteAllReactionsResponse = Response<nil>
```

</details>

[#Response](#Response)<[nil](#nil)><div id="DeleteAllReactionsForEmojiResponse"></div>

## DeleteAllReactionsForEmojiResponse

https://discord.com/developers/docs/resources/channel#delete-all-reactions-for-emoji

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#delete-all-reactions-for-emoji
type DeleteAllReactionsForEmojiResponse = Response<nil>
```

</details>

[#Response](#Response)<[nil](#nil)><div id="EditMessageResponse"></div>

## EditMessageResponse

https://discord.com/developers/docs/resources/channel#edit-message

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#edit-message
type EditMessageResponse = Response<objects.MessageObject>
```

</details>

[#Response](#Response)<[objects](#module.objects).[#MessageObject](#MessageObject)

><div id="DeleteMessageResponse"></div>

## DeleteMessageResponse

https://discord.com/developers/docs/resources/channel#delete-message

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#delete-message
type DeleteMessageResponse = Response<nil>
```

</details>

[#Response](#Response)<[nil](#nil)><div id="BulkDeleteMessageResponse"></div>

## BulkDeleteMessageResponse

https://discord.com/developers/docs/resources/channel#bulk-delete-messages

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#bulk-delete-messages
type BulkDeleteMessageResponse = Response<nil>
```

</details>

[#Response](#Response)<[nil](#nil)><div id="EditChannelPermissionsResponse"></div>

## EditChannelPermissionsResponse

https://discord.com/developers/docs/resources/channel#edit-channel-permissions

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#edit-channel-permissions
type EditChannelPermissionsResponse = Response<nil>
```

</details>

[#Response](#Response)<[nil](#nil)><div id="GetChannelInvitesResponse"></div>

## GetChannelInvitesResponse

https://discord.com/developers/docs/resources/channel#get-channel-invites

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#get-channel-invites
type GetChannelInvitesResponse = Response<{objects.InviteObject & objects.InviteMetadataObject}>
```

</details>

[#Response](#Response)<*This field is an array type*

Intersection of:

<details>
<summary>Type 1</summary>

[objects](#module.objects).[#InviteObject](#InviteObject)

</details>

<details>
<summary>Type 2</summary>

[objects](#module.objects).[#InviteMetadataObject](#InviteMetadataObject)

</details>

><div id="CreateChannelInviteResponse"></div>

## CreateChannelInviteResponse

https://discord.com/developers/docs/resources/channel#create-channel-invite

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#create-channel-invite
type CreateChannelInviteResponse = Response<objects.InviteObject>
```

</details>

[#Response](#Response)<[objects](#module.objects).[#InviteObject](#InviteObject)

><div id="DeleteChannelPermissionResponse"></div>

## DeleteChannelPermissionResponse

https://discord.com/developers/docs/resources/channel#delete-channel-permission

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#delete-channel-permission
type DeleteChannelPermissionResponse = Response<nil>
```

</details>

[#Response](#Response)<[nil](#nil)><div id="FollowAnnouncementChannelResponse"></div>

## FollowAnnouncementChannelResponse

https://discord.com/developers/docs/resources/channel#follow-announcement-channel

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#follow-announcement-channel
type FollowAnnouncementChannelResponse = Response<objects.FollowedChannelObject>
```

</details>

[#Response](#Response)<[objects](#module.objects).[#FollowedChannelObject](#FollowedChannelObject)

><div id="TriggerTypingIndicatorResponse"></div>

## TriggerTypingIndicatorResponse

https://discord.com/developers/docs/resources/channel#trigger-typing-indicator

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#trigger-typing-indicator
type TriggerTypingIndicatorResponse = Response<nil>
```

</details>

[#Response](#Response)<[nil](#nil)><div id="GetPinnedMessagesResponse"></div>

## GetPinnedMessagesResponse

https://discord.com/developers/docs/resources/channel#get-pinned-messages

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#get-pinned-messages
type GetPinnedMessagesResponse = Response<{objects.MessageObject}>
```

</details>

[#Response](#Response)<*This field is an array type*

[objects](#module.objects).[#MessageObject](#MessageObject)

><div id="PinMessageResponse"></div>

## PinMessageResponse

https://discord.com/developers/docs/resources/channel#pin-message

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#pin-message
type PinMessageResponse = Response<nil>
```

</details>

[#Response](#Response)<[nil](#nil)><div id="UnpinMessageResponse"></div>

## UnpinMessageResponse

https://discord.com/developers/docs/resources/channel#unpin-message

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#unpin-message
type UnpinMessageResponse = Response<nil>
```

</details>

[#Response](#Response)<[nil](#nil)><div id="GroupDMAddRecipientResponse"></div>

## GroupDMAddRecipientResponse

https://discord.com/developers/docs/resources/channel#group-dm-add-recipient

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#group-dm-add-recipient
type GroupDMAddRecipientResponse = Response<nil>
```

</details>

[#Response](#Response)<[nil](#nil)><div id="GroupDMRemoveRecipientResponse"></div>

## GroupDMRemoveRecipientResponse

https://discord.com/developers/docs/resources/channel#group-dm-remove-recipient

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#group-dm-remove-recipient
type GroupDMRemoveRecipientResponse = Response<nil>
```

</details>

[#Response](#Response)<[nil](#nil)><div id="StartThreadFromMessageResponse"></div>

## StartThreadFromMessageResponse

https://discord.com/developers/docs/resources/channel#start-thread-from-message

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#start-thread-from-message
type StartThreadFromMessageResponse = Response<objects.ChannelObject>
```

</details>

[#Response](#Response)<[objects](#module.objects).[#ChannelObject](#ChannelObject)

><div id="StartThreadWithoutMessageResponse"></div>

## StartThreadWithoutMessageResponse

https://discord.com/developers/docs/resources/channel#start-thread-without-message

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#start-thread-without-message
type StartThreadWithoutMessageResponse = Response<objects.ChannelObject>
```

</details>

[#Response](#Response)<[objects](#module.objects).[#ChannelObject](#ChannelObject)

><div id="StartThreadInForumOrMediaChannelResponse"></div>

## StartThreadInForumOrMediaChannelResponse

https://discord.com/developers/docs/resources/channel#start-thread-in-forum-or-media-channel

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#start-thread-in-forum-or-media-channel
type StartThreadInForumOrMediaChannelResponse = Response<objects.ChannelObject>
```

</details>

[#Response](#Response)<[objects](#module.objects).[#ChannelObject](#ChannelObject)

><div id="JoinThreadResponse"></div>

## JoinThreadResponse

https://discord.com/developers/docs/resources/channel#join-thread

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#join-thread
type JoinThreadResponse = Response<nil>
```

</details>

[#Response](#Response)<[nil](#nil)><div id="AddThreadMemberResponse"></div>

## AddThreadMemberResponse

https://discord.com/developers/docs/resources/channel#add-thread-member

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#add-thread-member
type AddThreadMemberResponse = Response<nil>
```

</details>

[#Response](#Response)<[nil](#nil)><div id="LeaveThreadResponse"></div>

## LeaveThreadResponse

https://discord.com/developers/docs/resources/channel#leave-thread

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#leave-thread
type LeaveThreadResponse = Response<nil>
```

</details>

[#Response](#Response)<[nil](#nil)><div id="RemoveThreadMemberResponse"></div>

## RemoveThreadMemberResponse

https://discord.com/developers/docs/resources/channel#remove-thread-member

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#remove-thread-member
type RemoveThreadMemberResponse = Response<nil>
```

</details>

[#Response](#Response)<[nil](#nil)><div id="GetThreadMemberResponse"></div>

## GetThreadMemberResponse

https://discord.com/developers/docs/resources/channel#get-thread-member

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#get-thread-member
type GetThreadMemberResponse = Response<objects.ThreadMemberObject>
```

</details>

[#Response](#Response)<[objects](#module.objects).[#ThreadMemberObject](#ThreadMemberObject)

><div id="ListThreadMembersResponse"></div>

## ListThreadMembersResponse

https://discord.com/developers/docs/resources/channel#list-thread-members

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#list-thread-members
type ListThreadMembersResponse = Response<{objects.ThreadMemberObject}>
```

</details>

[#Response](#Response)<*This field is an array type*

[objects](#module.objects).[#ThreadMemberObject](#ThreadMemberObject)

><div id="ListPublicArchivedThreadsResponse"></div>

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

[#Response](#Response)<*This field is an array type*

[objects](#module.objects).[#ChannelObject](#ChannelObject)

, *This field is an array type*

[objects](#module.objects).[#ThreadMemberObject](#ThreadMemberObject)

, [boolean](#boolean)><div id="ListPrivateArchivedThreadsResponse"></div>

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

[#Response](#Response)<*This field is an array type*

[objects](#module.objects).[#ChannelObject](#ChannelObject)

, *This field is an array type*

[objects](#module.objects).[#ThreadMemberObject](#ThreadMemberObject)

, [boolean](#boolean)><div id="ListJoinedPrivateArchivedThreadsResponse"></div>

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

[#Response](#Response)<*This field is an array type*

[objects](#module.objects).[#ChannelObject](#ChannelObject)

, *This field is an array type*

[objects](#module.objects).[#ThreadMemberObject](#ThreadMemberObject)

, [boolean](#boolean)><div id="ListGuildEmojisResponse"></div>

## ListGuildEmojisResponse

https://discord.com/developers/docs/resources/emoji#list-guild-emojis

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/emoji#list-guild-emojis
type ListGuildEmojisResponse = Response<{objects.EmojiObject}>
```

</details>

[#Response](#Response)<*This field is an array type*

[objects](#module.objects).[#EmojiObject](#EmojiObject)

><div id="GetGuildEmojiResponse"></div>

## GetGuildEmojiResponse

https://discord.com/developers/docs/resources/emoji#get-guild-emoji

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/emoji#get-guild-emoji
type GetGuildEmojiResponse = Response<objects.EmojiObject>
```

</details>

[#Response](#Response)<[objects](#module.objects).[#EmojiObject](#EmojiObject)

><div id="CreateGuildEmojiResponse"></div>

## CreateGuildEmojiResponse

https://discord.com/developers/docs/resources/emoji#create-guild-emoji

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/emoji#create-guild-emoji
type CreateGuildEmojiResponse = Response<objects.EmojiObject>
```

</details>

[#Response](#Response)<[objects](#module.objects).[#EmojiObject](#EmojiObject)

><div id="ModifyGuildEmojiResponse"></div>

## ModifyGuildEmojiResponse

https://discord.com/developers/docs/resources/emoji#modify-guild-emoji

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/emoji#modify-guild-emoji
type ModifyGuildEmojiResponse = Response<objects.EmojiObject>
```

</details>

[#Response](#Response)<[objects](#module.objects).[#EmojiObject](#EmojiObject)

><div id="DeleteGuildEmojiResponse"></div>

## DeleteGuildEmojiResponse

https://discord.com/developers/docs/resources/emoji#delete-guild-emoji

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/emoji#delete-guild-emoji
type DeleteGuildEmojiResponse = Response<nil>
```

</details>

[#Response](#Response)<[nil](#nil)><div id="CreateGuildResponse"></div>

## CreateGuildResponse

https://discord.com/developers/docs/resources/guild#create-guild

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#create-guild
type CreateGuildResponse = Response<objects.GuildObject>
```

</details>

[#Response](#Response)<[objects](#module.objects).[#GuildObject](#GuildObject)

><div id="GetGuildResponse"></div>

## GetGuildResponse

https://discord.com/developers/docs/resources/guild#get-guild

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#get-guild
type GetGuildResponse = Response<objects.GuildObject>
```

</details>

[#Response](#Response)<[objects](#module.objects).[#GuildObject](#GuildObject)

><div id="GetGuildPreviewResponse"></div>

## GetGuildPreviewResponse

https://discord.com/developers/docs/resources/guild#get-guild

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#get-guild
type GetGuildPreviewResponse = Response<objects.GuildPreviewObject>
```

</details>

[#Response](#Response)<[objects](#module.objects).[#GuildPreviewObject](#GuildPreviewObject)

><div id="ModifyGuildResponse"></div>

## ModifyGuildResponse

https://discord.com/developers/docs/resources/guild#modify-guild

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#modify-guild
type ModifyGuildResponse = Response<objects.GuildObject>
```

</details>

[#Response](#Response)<[objects](#module.objects).[#GuildObject](#GuildObject)

><div id="DeleteGuildResponse"></div>

## DeleteGuildResponse

https://discord.com/developers/docs/resources/guild#delete-guild

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#delete-guild
type DeleteGuildResponse = Response<nil>
```

</details>

[#Response](#Response)<[nil](#nil)><div id="GetGuildChannelsResponse"></div>

## GetGuildChannelsResponse

https://discord.com/developers/docs/resources/guild#get-guild-channels

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#get-guild-channels
type GetGuildChannelsResponse = Response<{objects.ChannelObject}>
```

</details>

[#Response](#Response)<*This field is an array type*

[objects](#module.objects).[#ChannelObject](#ChannelObject)

><div id="CreateGuildChannelResponse"></div>

## CreateGuildChannelResponse

https://discord.com/developers/docs/resources/guild#create-guild-channel

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#create-guild-channel
type CreateGuildChannelResponse = Response<objects.ChannelObject>
```

</details>

[#Response](#Response)<[objects](#module.objects).[#ChannelObject](#ChannelObject)

><div id="ModifyGuildChannelPositionsResponse"></div>

## ModifyGuildChannelPositionsResponse

https://discord.com/developers/docs/resources/guild#modify-guild-channel-positions

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#modify-guild-channel-positions
type ModifyGuildChannelPositionsResponse = Response<nil>
```

</details>

[#Response](#Response)<[nil](#nil)><div id="ListActiveGuildThreadsResponse"></div>

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

[#Response](#Response)<*This field is an array type*

[objects](#module.objects).[#ChannelObject](#ChannelObject)

, *This field is an array type*

[objects](#module.objects).[#ThreadMemberObject](#ThreadMemberObject)

><div id="GetGuildMemberResponse"></div>

## GetGuildMemberResponse

https://discord.com/developers/docs/resources/guild#get-guild-member

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#get-guild-member
type GetGuildMemberResponse = Response<objects.GuildMemberObject>
```

</details>

[#Response](#Response)<[objects](#module.objects).[#GuildMemberObject](#GuildMemberObject)

><div id="ListGuildMembersResponse"></div>

## ListGuildMembersResponse

https://discord.com/developers/docs/resources/guild#list-guild-members

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#list-guild-members
type ListGuildMembersResponse = Response<{objects.GuildMemberObject}>
```

</details>

[#Response](#Response)<*This field is an array type*

[objects](#module.objects).[#GuildMemberObject](#GuildMemberObject)

><div id="SearchGuildMembersResponse"></div>

## SearchGuildMembersResponse

https://discord.com/developers/docs/resources/guild#search-guild-members

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#search-guild-members
type SearchGuildMembersResponse = Response<{objects.GuildMemberObject}>
```

</details>

[#Response](#Response)<*This field is an array type*

[objects](#module.objects).[#GuildMemberObject](#GuildMemberObject)

><div id="AddGuildMemberResponse"></div>

## AddGuildMemberResponse

https://discord.com/developers/docs/resources/guild#add-guild-member

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#add-guild-member
type AddGuildMemberResponse = Response<objects.GuildMemberObject>
```

</details>

[#Response](#Response)<[objects](#module.objects).[#GuildMemberObject](#GuildMemberObject)

><div id="ModifyGuildMemberResponse"></div>

## ModifyGuildMemberResponse

https://discord.com/developers/docs/resources/guild#modify-guild-member

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#modify-guild-member
type ModifyGuildMemberResponse = Response<objects.GuildMemberObject>
```

</details>

[#Response](#Response)<[objects](#module.objects).[#GuildMemberObject](#GuildMemberObject)

><div id="ModifyCurrentMemberResponse"></div>

## ModifyCurrentMemberResponse

https://discord.com/developers/docs/resources/guild#modify-current-member

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#modify-current-member
type ModifyCurrentMemberResponse = Response<objects.GuildMemberObject>
```

</details>

[#Response](#Response)<[objects](#module.objects).[#GuildMemberObject](#GuildMemberObject)

><div id="AddGuildMemberRoleResponse"></div>

## AddGuildMemberRoleResponse

https://discord.com/developers/docs/resources/guild#add-guild-member-role

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#add-guild-member-role
type AddGuildMemberRoleResponse = Response<nil>
```

</details>

[#Response](#Response)<[nil](#nil)><div id="RemoveGuildMemberRoleResponse"></div>

## RemoveGuildMemberRoleResponse

https://discord.com/developers/docs/resources/guild#remove-guild-member-role

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#remove-guild-member-role
type RemoveGuildMemberRoleResponse = Response<nil>
```

</details>

[#Response](#Response)<[nil](#nil)><div id="RemoveGuildMemberResponse"></div>

## RemoveGuildMemberResponse

https://discord.com/developers/docs/resources/guild#remove-guild-member

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#remove-guild-member
type RemoveGuildMemberResponse = Response<nil>
```

</details>

[#Response](#Response)<[nil](#nil)><div id="GetGuildBansResponse"></div>

## GetGuildBansResponse

https://discord.com/developers/docs/resources/guild#get-guild-bans

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#get-guild-bans
type GetGuildBansResponse = Response<{objects.BanObject}>
```

</details>

[#Response](#Response)<*This field is an array type*

[objects](#module.objects).[#BanObject](#BanObject)

><div id="GetGuildBanResponse"></div>

## GetGuildBanResponse

https://discord.com/developers/docs/resources/guild#get-guild-ban

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#get-guild-ban
type GetGuildBanResponse = Response<objects.BanObject>
```

</details>

[#Response](#Response)<[objects](#module.objects).[#BanObject](#BanObject)

><div id="CreateGuildBanResponse"></div>

## CreateGuildBanResponse

https://discord.com/developers/docs/resources/guild#create-guild-ban

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#create-guild-ban
type CreateGuildBanResponse = Response<nil>
```

</details>

[#Response](#Response)<[nil](#nil)><div id="RemoveGuildBanResponse"></div>

## RemoveGuildBanResponse

https://discord.com/developers/docs/resources/guild#remove-guild-ban

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#remove-guild-ban
type RemoveGuildBanResponse = Response<nil>
```

</details>

[#Response](#Response)<[nil](#nil)><div id="BulkGuildBanResponse"></div>

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

[#Response](#Response)<*This field is an array type*

[objects](#module.objects).[#Snowflake](#Snowflake)

, *This field is an array type*

[objects](#module.objects).[#Snowflake](#Snowflake)

><div id="GetGuildRolesResponse"></div>

## GetGuildRolesResponse

https://discord.com/developers/docs/resources/guild#get-guild-roles

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#get-guild-roles
type GetGuildRolesResponse = Response<{objects.GuildRoleObject}>
```

</details>

[#Response](#Response)<*This field is an array type*

[objects](#module.objects).[#GuildRoleObject](#GuildRoleObject)

><div id="GetGuildRoleResponse"></div>

## GetGuildRoleResponse

https://discord.com/developers/docs/resources/guild#get-guild-roles

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#get-guild-roles
type GetGuildRoleResponse = Response<objects.GuildRoleObject>
```

</details>

[#Response](#Response)<[objects](#module.objects).[#GuildRoleObject](#GuildRoleObject)

><div id="CreateGuildRoleResponse"></div>

## CreateGuildRoleResponse

https://discord.com/developers/docs/resources/guild#create-guild-role

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#create-guild-role
type CreateGuildRoleResponse = Response<objects.GuildRoleObject>
```

</details>

[#Response](#Response)<[objects](#module.objects).[#GuildRoleObject](#GuildRoleObject)

><div id="ModifyGuildRolePositionsResponse"></div>

## ModifyGuildRolePositionsResponse

https://discord.com/developers/docs/resources/guild#modify-guild-role-positions

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#modify-guild-role-positions
type ModifyGuildRolePositionsResponse = Response<{objects.GuildRoleObject}>
```

</details>

[#Response](#Response)<*This field is an array type*

[objects](#module.objects).[#GuildRoleObject](#GuildRoleObject)

><div id="ModifyGuildRoleResponse"></div>

## ModifyGuildRoleResponse

https://discord.com/developers/docs/resources/guild#modify-guild-role

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#modify-guild-role
type ModifyGuildRoleResponse = Response<objects.GuildRoleObject>
```

</details>

[#Response](#Response)<[objects](#module.objects).[#GuildRoleObject](#GuildRoleObject)

><div id="ModifyGuildMFALevelResponse"></div>

## ModifyGuildMFALevelResponse

https://discord.com/developers/docs/resources/guild#modify-guild-mfa-level

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#modify-guild-mfa-level
type ModifyGuildMFALevelResponse = Response<unknown>
```

</details>

[#Response](#Response)<[unknown](#unknown)><div id="DeleteGuildRoleResponse"></div>

## DeleteGuildRoleResponse

https://discord.com/developers/docs/resources/guild#delete-guild-role

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#delete-guild-role
type DeleteGuildRoleResponse = Response<nil>
```

</details>

[#Response](#Response)<[nil](#nil)><div id="GetGuildPruneCountResponse"></div>

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

[#Response](#Response)<[number](#number)><div id="BeginGuildPruneResponse"></div>

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

[#Response](#Response)<[number](#number)><div id="GetGuildVoiceRegionsResponse"></div>

## GetGuildVoiceRegionsResponse

https://discord.com/developers/docs/resources/guild#get-guild-voice-regions

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#get-guild-voice-regions
type GetGuildVoiceRegionsResponse = Response<{objects.VoiceRegionObject}>
```

</details>

[#Response](#Response)<*This field is an array type*

[objects](#module.objects).[#VoiceRegionObject](#VoiceRegionObject)

><div id="GetGuildInvitesResponse"></div>

## GetGuildInvitesResponse

https://discord.com/developers/docs/resources/guild#get-guild-invites

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#get-guild-invites
type GetGuildInvitesResponse = Response<{objects.InviteObject & objects.InviteMetadataObject}>
```

</details>

[#Response](#Response)<*This field is an array type*

Intersection of:

<details>
<summary>Type 1</summary>

[objects](#module.objects).[#InviteObject](#InviteObject)

</details>

<details>
<summary>Type 2</summary>

[objects](#module.objects).[#InviteMetadataObject](#InviteMetadataObject)

</details>

><div id="GetGuildIntegrationsResponse"></div>

## GetGuildIntegrationsResponse

https://discord.com/developers/docs/resources/guild#get-guild-integrations

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#get-guild-integrations
type GetGuildIntegrationsResponse = Response<{objects.IntegrationObject}>
```

</details>

[#Response](#Response)<*This field is an array type*

[objects](#module.objects).[#IntegrationObject](#IntegrationObject)

><div id="DeleteGuildIntegrationResponse"></div>

## DeleteGuildIntegrationResponse

https://discord.com/developers/docs/resources/guild#delete-guild-integration

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#delete-guild-integration
type DeleteGuildIntegrationResponse = Response<nil>
```

</details>

[#Response](#Response)<[nil](#nil)><div id="GetGuildWidgetSettingsResponse"></div>

## GetGuildWidgetSettingsResponse

https://discord.com/developers/docs/resources/guild#get-guild-widget-settings

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#get-guild-widget-settings
type GetGuildWidgetSettingsResponse = Response<objects.GuildWidgetSettingsObject>
```

</details>

[#Response](#Response)<[objects](#module.objects).[#GuildWidgetSettingsObject](#GuildWidgetSettingsObject)

><div id="ModifyGuildWidgetResponse"></div>

## ModifyGuildWidgetResponse

https://discord.com/developers/docs/resources/guild#modify-guild-widget

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#modify-guild-widget
type ModifyGuildWidgetResponse = Response<objects.GuildWidgetSettingsObject>
```

</details>

[#Response](#Response)<[objects](#module.objects).[#GuildWidgetSettingsObject](#GuildWidgetSettingsObject)

><div id="GetGuildWidgetResponse"></div>

## GetGuildWidgetResponse

https://discord.com/developers/docs/resources/guild#get-guild-widget

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#get-guild-widget
type GetGuildWidgetResponse = Response<objects.GuildWidgetObject>
```

</details>

[#Response](#Response)<[objects](#module.objects).[#GuildWidgetObject](#GuildWidgetObject)

><div id="GetGuildVanityUrlResponse"></div>

## GetGuildVanityUrlResponse

https://discord.com/developers/docs/resources/guild#get-guild-vanity-url

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#get-guild-vanity-url
type GetGuildVanityUrlResponse = Response<objects.GuildVanityUrl>
```

</details>

[#Response](#Response)<[objects](#module.objects).[#GuildVanityUrl](#GuildVanityUrl)

><div id="GetGuildWidgetImageResponse"></div>

## GetGuildWidgetImageResponse

https://discord.com/developers/docs/resources/guild#get-guild-widget-image

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#get-guild-widget-image
type GetGuildWidgetImageResponse = Response<string>
```

</details>

[#Response](#Response)<[string](#string)><div id="GetGuildWelcomeScreenResponse"></div>

## GetGuildWelcomeScreenResponse

https://discord.com/developers/docs/resources/guild#get-guild-welcome-screen

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#get-guild-welcome-screen
type GetGuildWelcomeScreenResponse = Response<objects.WelcomeScreenObject>
```

</details>

[#Response](#Response)<[objects](#module.objects).[#WelcomeScreenObject](#WelcomeScreenObject)

><div id="ModifyGuildWelcomeScreenResponse"></div>

## ModifyGuildWelcomeScreenResponse

https://discord.com/developers/docs/resources/guild#modify-guild-welcome-screen

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#modify-guild-welcome-screen
type ModifyGuildWelcomeScreenResponse = Response<objects.WelcomeScreenObject>
```

</details>

[#Response](#Response)<[objects](#module.objects).[#WelcomeScreenObject](#WelcomeScreenObject)

><div id="GetGuildOnboardingResponse"></div>

## GetGuildOnboardingResponse

https://discord.com/developers/docs/resources/guild#get-guild-onboarding

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#get-guild-onboarding
type GetGuildOnboardingResponse = Response<objects.GuildOnboardingObject>
```

</details>

[#Response](#Response)<[objects](#module.objects).[#GuildOnboardingObject](#GuildOnboardingObject)

><div id="ModifyGuildOnboardingResponse"></div>

## ModifyGuildOnboardingResponse

https://discord.com/developers/docs/resources/guild#modify-guild-onboarding

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#modify-guild-onboarding
type ModifyGuildOnboardingResponse = Response<objects.GuildOnboardingObject>
```

</details>

[#Response](#Response)<[objects](#module.objects).[#GuildOnboardingObject](#GuildOnboardingObject)

><div id="ModifyCurrentUserVoiceStateResponse"></div>

## ModifyCurrentUserVoiceStateResponse

https://discord.com/developers/docs/resources/guild#modify-current-user-voice-state

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#modify-current-user-voice-state
type ModifyCurrentUserVoiceStateResponse = Response<nil>
```

</details>

[#Response](#Response)<[nil](#nil)><div id="ModifyUserVoiceStateResponse"></div>

## ModifyUserVoiceStateResponse

https://discord.com/developers/docs/resources/guild#modify-user-voice-state

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#modify-user-voice-state
type ModifyUserVoiceStateResponse = Response<unknown>
```

</details>

[#Response](#Response)<[unknown](#unknown)><div id="ListScheduledEventsForGuildResponse"></div>

## ListScheduledEventsForGuildResponse

https://discord.com/developers/docs/resources/guild-scheduled-event#list-scheduled-events-for-guild

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild-scheduled-event#list-scheduled-events-for-guild
type ListScheduledEventsForGuildResponse = Response<{objects.GuildScheduledEventObject}>
```

</details>

[#Response](#Response)<*This field is an array type*

[objects](#module.objects).[#GuildScheduledEventObject](#GuildScheduledEventObject)

><div id="CreateGuildScheduledEventResponse"></div>

## CreateGuildScheduledEventResponse

https://discord.com/developers/docs/resources/guild-scheduled-event#create-guild-scheduled-event

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild-scheduled-event#create-guild-scheduled-event
type CreateGuildScheduledEventResponse = Response<objects.GuildScheduledEventObject>
```

</details>

[#Response](#Response)<[objects](#module.objects).[#GuildScheduledEventObject](#GuildScheduledEventObject)

><div id="GetGuildScheduledEventResponse"></div>

## GetGuildScheduledEventResponse

https://discord.com/developers/docs/resources/guild-scheduled-event#get-guild-scheduled-event

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild-scheduled-event#get-guild-scheduled-event
type GetGuildScheduledEventResponse = Response<objects.GuildScheduledEventObject>
```

</details>

[#Response](#Response)<[objects](#module.objects).[#GuildScheduledEventObject](#GuildScheduledEventObject)

><div id="ModifyGuildScheduledEventResponse"></div>

## ModifyGuildScheduledEventResponse

https://discord.com/developers/docs/resources/guild-scheduled-event#modify-guild-scheduled-event

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild-scheduled-event#modify-guild-scheduled-event
type ModifyGuildScheduledEventResponse = Response<objects.GuildScheduledEventObject>
```

</details>

[#Response](#Response)<[objects](#module.objects).[#GuildScheduledEventObject](#GuildScheduledEventObject)

><div id="DeleteGuildScheduledEventResponse"></div>

## DeleteGuildScheduledEventResponse

https://discord.com/developers/docs/resources/guild-scheduled-event#delete-guild-scheduled-event

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild-scheduled-event#delete-guild-scheduled-event
type DeleteGuildScheduledEventResponse = Response<nil>
```

</details>

[#Response](#Response)<[nil](#nil)><div id="GetGuildScheduledEventUsersResponse"></div>

## GetGuildScheduledEventUsersResponse

https://discord.com/developers/docs/resources/guild-scheduled-event#get-guild-scheduled-event-users

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild-scheduled-event#get-guild-scheduled-event-users
type GetGuildScheduledEventUsersResponse = Response<{objects.GuildScheduledEventUserObject}>
```

</details>

[#Response](#Response)<*This field is an array type*

[objects](#module.objects).[#GuildScheduledEventUserObject](#GuildScheduledEventUserObject)

><div id="GetGuildTemplateResponse"></div>

## GetGuildTemplateResponse

https://discord.com/developers/docs/resources/guild-template#get-guild-template

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild-template#get-guild-template
type GetGuildTemplateResponse = Response<objects.GuildTemplateObject>
```

</details>

[#Response](#Response)<[objects](#module.objects).[#GuildTemplateObject](#GuildTemplateObject)

><div id="CreateGuildFromGuildTemplateResponse"></div>

## CreateGuildFromGuildTemplateResponse

https://discord.com/developers/docs/resources/guild-template#create-guild-from-guild-template

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild-template#create-guild-from-guild-template
type CreateGuildFromGuildTemplateResponse = Response<objects.GuildObject>
```

</details>

[#Response](#Response)<[objects](#module.objects).[#GuildObject](#GuildObject)

><div id="GetGuildTemplatesResponse"></div>

## GetGuildTemplatesResponse

https://discord.com/developers/docs/resources/guild-template#get-guild-templates

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild-template#get-guild-templates
type GetGuildTemplatesResponse = Response<objects.GuildTemplateObject>
```

</details>

[#Response](#Response)<[objects](#module.objects).[#GuildTemplateObject](#GuildTemplateObject)

><div id="CreateGuildTemplateResponse"></div>

## CreateGuildTemplateResponse

https://discord.com/developers/docs/resources/guild-template#create-guild-template

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild-template#create-guild-template
type CreateGuildTemplateResponse = Response<objects.GuildTemplateObject>
```

</details>

[#Response](#Response)<[objects](#module.objects).[#GuildTemplateObject](#GuildTemplateObject)

><div id="SyncGuildTemplateResponse"></div>

## SyncGuildTemplateResponse

https://discord.com/developers/docs/resources/guild-template#sync-guild-template

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild-template#sync-guild-template
type SyncGuildTemplateResponse = Response<objects.GuildTemplateObject>
```

</details>

[#Response](#Response)<[objects](#module.objects).[#GuildTemplateObject](#GuildTemplateObject)

><div id="ModifyGuildTemplateResponse"></div>

## ModifyGuildTemplateResponse

https://discord.com/developers/docs/resources/guild-template#modify-guild-template

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild-template#modify-guild-template
type ModifyGuildTemplateResponse = Response<objects.GuildTemplateObject>
```

</details>

[#Response](#Response)<[objects](#module.objects).[#GuildTemplateObject](#GuildTemplateObject)

><div id="DeleteGuildTemplateResponse"></div>

## DeleteGuildTemplateResponse

https://discord.com/developers/docs/resources/guild-template#delete-guild-template

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild-template#delete-guild-template
type DeleteGuildTemplateResponse = Response<objects.GuildTemplateObject>
```

</details>

[#Response](#Response)<[objects](#module.objects).[#GuildTemplateObject](#GuildTemplateObject)

><div id="GetInviteResponse"></div>

## GetInviteResponse

https://discord.com/developers/docs/resources/invite#get-invite

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/invite#get-invite
type GetInviteResponse = Response<objects.InviteObject>
```

</details>

[#Response](#Response)<[objects](#module.objects).[#InviteObject](#InviteObject)

><div id="DeleteInviteResponse"></div>

## DeleteInviteResponse

https://discord.com/developers/docs/resources/invite#delete-invite

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/invite#delete-invite
type DeleteInviteResponse = Response<objects.InviteObject>
```

</details>

[#Response](#Response)<[objects](#module.objects).[#InviteObject](#InviteObject)

><div id="GetAnswerVotersResponse"></div>

## GetAnswerVotersResponse

https://discord.com/developers/docs/resources/poll#get-answer-voters

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/poll#get-answer-voters
type GetAnswerVotersResponse = Response<{objects.UserObject}>
```

</details>

[#Response](#Response)<*This field is an array type*

[objects](#module.objects).[#UserObject](#UserObject)

><div id="EndPollResponse"></div>

## EndPollResponse

https://discord.com/developers/docs/resources/poll#end-poll

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/poll#end-poll
type EndPollResponse = Response<objects.MessageObject>
```

</details>

[#Response](#Response)<[objects](#module.objects).[#MessageObject](#MessageObject)

><div id="CreateStageInstanceResponse"></div>

## CreateStageInstanceResponse

https://discord.com/developers/docs/resources/stage-instance#create-stage-instance

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/stage-instance#create-stage-instance
type CreateStageInstanceResponse = Response<objects.StageInstanceObject>
```

</details>

[#Response](#Response)<[objects](#module.objects).[#StageInstanceObject](#StageInstanceObject)

><div id="GetStageInstanceResponse"></div>

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

[#Response](#Response)<[objects](#module.objects).[#StageInstanceObject](#StageInstanceObject)

><div id="ModifyStageInstanceResponse"></div>

## ModifyStageInstanceResponse

https://discord.com/developers/docs/resources/stage-instance#modify-stage-instance

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/stage-instance#modify-stage-instance
type ModifyStageInstanceResponse = Response<objects.StageInstanceObject>
```

</details>

[#Response](#Response)<[objects](#module.objects).[#StageInstanceObject](#StageInstanceObject)

><div id="DeleteStageInstanceResponse"></div>

## DeleteStageInstanceResponse

https://discord.com/developers/docs/resources/stage-instance#delete-stage-instance

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/stage-instance#delete-stage-instance
type DeleteStageInstanceResponse = Response<nil>
```

</details>

[#Response](#Response)<[nil](#nil)><div id="GetStickerResponse"></div>

## GetStickerResponse

https://discord.com/developers/docs/resources/sticker#get-sticker

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/sticker#get-sticker
type GetStickerResponse = Response<objects.StickerObject>
```

</details>

[#Response](#Response)<[objects](#module.objects).[#StickerObject](#StickerObject)

><div id="ListStickerPacksResponse"></div>

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

[#Response](#Response)<*This field is an array type*

[objects](#module.objects).[#StickerPackObject](#StickerPackObject)

><div id="ListGuildStickersResponse"></div>

## ListGuildStickersResponse

https://discord.com/developers/docs/resources/sticker#list-guild-stickers

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/sticker#list-guild-stickers
type ListGuildStickersResponse = Response<{objects.StickerObject}>
```

</details>

[#Response](#Response)<*This field is an array type*

[objects](#module.objects).[#StickerObject](#StickerObject)

><div id="GetGuildStickerResponse"></div>

## GetGuildStickerResponse

https://discord.com/developers/docs/resources/sticker#get-guild-sticker

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/sticker#get-guild-sticker
type GetGuildStickerResponse = Response<objects.StickerObject>
```

</details>

[#Response](#Response)<[objects](#module.objects).[#StickerObject](#StickerObject)

><div id="CreateGuildStickerResponse"></div>

## CreateGuildStickerResponse

https://discord.com/developers/docs/resources/sticker#create-guild-sticker

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/sticker#create-guild-sticker
type CreateGuildStickerResponse = Response<objects.StickerObject>
```

</details>

[#Response](#Response)<[objects](#module.objects).[#StickerObject](#StickerObject)

><div id="ModifyGuildStickerResponse"></div>

## ModifyGuildStickerResponse

https://discord.com/developers/docs/resources/sticker#modify-guild-sticker

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/sticker#modify-guild-sticker
type ModifyGuildStickerResponse = Response<objects.StickerObject>
```

</details>

[#Response](#Response)<[objects](#module.objects).[#StickerObject](#StickerObject)

><div id="DeleteGuildStickerResponse"></div>

## DeleteGuildStickerResponse

https://discord.com/developers/docs/resources/sticker#delete-guild-sticker

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/sticker#delete-guild-sticker
type DeleteGuildStickerResponse = Response<nil>
```

</details>

[#Response](#Response)<[nil](#nil)><div id="GetCurrentUserResponse"></div>

## GetCurrentUserResponse

https://discord.com/developers/docs/resources/user#get-current-user

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/user#get-current-user
type GetCurrentUserResponse = Response<objects.UserObject>
```

</details>

[#Response](#Response)<[objects](#module.objects).[#UserObject](#UserObject)

><div id="GetUserResponse"></div>

## GetUserResponse

https://discord.com/developers/docs/resources/user#get-user

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/user#get-user
type GetUserResponse = Response<objects.UserObject>
```

</details>

[#Response](#Response)<[objects](#module.objects).[#UserObject](#UserObject)

><div id="ModifyCurrentUserResponse"></div>

## ModifyCurrentUserResponse

https://discord.com/developers/docs/resources/user#modify-current-user

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/user#modify-current-user
type ModifyCurrentUserResponse = Response<objects.UserObject>
```

</details>

[#Response](#Response)<[objects](#module.objects).[#UserObject](#UserObject)

><div id="GetCurrentUserGuildsResponse"></div>

## GetCurrentUserGuildsResponse

https://discord.com/developers/docs/resources/user#get-current-user-guilds

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/user#get-current-user-guilds
type GetCurrentUserGuildsResponse = Response<{objects.GuildObject}>
```

</details>

[#Response](#Response)<*This field is an array type*

[objects](#module.objects).[#GuildObject](#GuildObject)

><div id="GetCurrentUserGuildMemberResponse"></div>

## GetCurrentUserGuildMemberResponse

https://discord.com/developers/docs/resources/user#get-current-user-guild-member

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/user#get-current-user-guild-member
type GetCurrentUserGuildMemberResponse = Response<objects.GuildMemberObject>
```

</details>

[#Response](#Response)<[objects](#module.objects).[#GuildMemberObject](#GuildMemberObject)

><div id="LeaveGuildResponse"></div>

## LeaveGuildResponse

https://discord.com/developers/docs/resources/user#leave-guild

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/user#leave-guild
type LeaveGuildResponse = Response<nil>
```

</details>

[#Response](#Response)<[nil](#nil)><div id="CreateDMResponse"></div>

## CreateDMResponse

https://discord.com/developers/docs/resources/user#create-dm

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/user#create-dm
type CreateDMResponse = Response<objects.ChannelObject>
```

</details>

[#Response](#Response)<[objects](#module.objects).[#ChannelObject](#ChannelObject)

><div id="CreateGroupDMResponse"></div>

## CreateGroupDMResponse

https://discord.com/developers/docs/resources/user#create-group-dm

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/user#create-group-dm
type CreateGroupDMResponse = Response<objects.ChannelObject>
```

</details>

[#Response](#Response)<[objects](#module.objects).[#ChannelObject](#ChannelObject)

><div id="GetCurrentUserConnectionResponse"></div>

## GetCurrentUserConnectionResponse

https://discord.com/developers/docs/resources/user#get-current-user-connections

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/user#get-current-user-connections
type GetCurrentUserConnectionResponse = Response<objects.ConnectionObject>
```

</details>

[#Response](#Response)<[objects](#module.objects).[#ConnectionObject](#ConnectionObject)

><div id="GetCurrentUserApplicationRoleConnectionResponse"></div>

## GetCurrentUserApplicationRoleConnectionResponse

https://discord.com/developers/docs/resources/user#get-current-user-application-role-connection

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/user#get-current-user-application-role-connection
type GetCurrentUserApplicationRoleConnectionResponse = Response<objects.ApplicationRoleConnectionObject>
```

</details>

[#Response](#Response)<[objects](#module.objects).[#ApplicationRoleConnectionObject](#ApplicationRoleConnectionObject)

><div id="UpdateCurrentUserApplicationRoleConnectionResponse"></div>

## UpdateCurrentUserApplicationRoleConnectionResponse

https://discord.com/developers/docs/resources/user#update-current-user-application-role-connection

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/user#update-current-user-application-role-connection
type UpdateCurrentUserApplicationRoleConnectionResponse = Response<objects.ApplicationRoleConnectionObject>
```

</details>

[#Response](#Response)<[objects](#module.objects).[#ApplicationRoleConnectionObject](#ApplicationRoleConnectionObject)

><div id="ListVoiceRegionsResponse"></div>

## ListVoiceRegionsResponse

https://discord.com/developers/docs/resources/voice

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/voice
type ListVoiceRegionsResponse = Response<{objects.VoiceRegionObject}>
```

</details>

[#Response](#Response)<*This field is an array type*

[objects](#module.objects).[#VoiceRegionObject](#VoiceRegionObject)

><div id="CreateWebhookResponse"></div>

## CreateWebhookResponse

https://discord.com/developers/docs/resources/webhook#create-webhook

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/webhook#create-webhook
type CreateWebhookResponse = Response<objects.WebhookObject>
```

</details>

[#Response](#Response)<[objects](#module.objects).[#WebhookObject](#WebhookObject)

><div id="GetChannelWebhooksResponse"></div>

## GetChannelWebhooksResponse

https://discord.com/developers/docs/resources/webhook#get-channel-webhooks

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/webhook#get-channel-webhooks
type GetChannelWebhooksResponse = Response<{objects.WebhookObject}>
```

</details>

[#Response](#Response)<*This field is an array type*

[objects](#module.objects).[#WebhookObject](#WebhookObject)

><div id="GetGuildWebhooksResponse"></div>

## GetGuildWebhooksResponse

https://discord.com/developers/docs/resources/webhook#get-guild-webhooks

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/webhook#get-guild-webhooks
type GetGuildWebhooksResponse = Response<{objects.WebhookObject}>
```

</details>

[#Response](#Response)<*This field is an array type*

[objects](#module.objects).[#WebhookObject](#WebhookObject)

><div id="GetWebhookResponse"></div>

## GetWebhookResponse

https://discord.com/developers/docs/resources/webhook#get-webhook

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/webhook#get-webhook
type GetWebhookResponse = Response<objects.WebhookObject>
```

</details>

[#Response](#Response)<[objects](#module.objects).[#WebhookObject](#WebhookObject)

><div id="GetWebhookWithTokenResponse"></div>

## GetWebhookWithTokenResponse

https://discord.com/developers/docs/resources/webhook#get-webhook-with-token

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/webhook#get-webhook-with-token
type GetWebhookWithTokenResponse = Response<objects.WebhookObject>
```

</details>

[#Response](#Response)<[objects](#module.objects).[#WebhookObject](#WebhookObject)

><div id="ModifyWebhookResponse"></div>

## ModifyWebhookResponse

https://discord.com/developers/docs/resources/webhook#modify-webhook

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/webhook#modify-webhook
type ModifyWebhookResponse = Response<objects.WebhookObject>
```

</details>

[#Response](#Response)<[objects](#module.objects).[#WebhookObject](#WebhookObject)

><div id="ModifyWebhookWithTokenResponse"></div>

## ModifyWebhookWithTokenResponse

https://discord.com/developers/docs/resources/webhook#modify-webhook-with-token

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/webhook#modify-webhook-with-token
type ModifyWebhookWithTokenResponse = Response<objects.WebhookObject>
```

</details>

[#Response](#Response)<[objects](#module.objects).[#WebhookObject](#WebhookObject)

><div id="DeleteWebhookResponse"></div>

## DeleteWebhookResponse

https://discord.com/developers/docs/resources/webhook#delete-webhook

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/webhook#delete-webhook
type DeleteWebhookResponse = Response<nil>
```

</details>

[#Response](#Response)<[nil](#nil)><div id="DeleteWebhookWitHTokenResponse"></div>

## DeleteWebhookWitHTokenResponse

https://discord.com/developers/docs/resources/webhook#delete-webhook-with-token

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/webhook#delete-webhook-with-token
type DeleteWebhookWitHTokenResponse = Response<nil>
```

</details>

[#Response](#Response)<[nil](#nil)><div id="ExecuteWebhookResponse"></div>

## ExecuteWebhookResponse

https://discord.com/developers/docs/resources/webhook#execute-webhook

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/webhook#execute-webhook
type ExecuteWebhookResponse = Response<objects.MessageObject?>
```

</details>

[#Response](#Response)<><div id="ExecuteSlackCompatibleWebhookResponse"></div>

## ExecuteSlackCompatibleWebhookResponse

https://discord.com/developers/docs/resources/webhook#execute-slackcompatible-webhook

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/webhook#execute-slackcompatible-webhook
type ExecuteSlackCompatibleWebhookResponse = Response<unknown>
```

</details>

[#Response](#Response)<[unknown](#unknown)><div id="ExecuteGitCompatibleWebhookResponse"></div>

## ExecuteGitCompatibleWebhookResponse

https://discord.com/developers/docs/resources/webhook#execute-githubcompatible-webhook

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/webhook#execute-githubcompatible-webhook
type ExecuteGitCompatibleWebhookResponse = Response<unknown>
```

</details>

[#Response](#Response)<[unknown](#unknown)><div id="GetWebhookMessageResponse"></div>

## GetWebhookMessageResponse

https://discord.com/developers/docs/resources/webhook#get-webhook-message

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/webhook#get-webhook-message
type GetWebhookMessageResponse = Response<objects.MessageObject>
```

</details>

[#Response](#Response)<[objects](#module.objects).[#MessageObject](#MessageObject)

><div id="EditWebhookMessageResponse"></div>

## EditWebhookMessageResponse

https://discord.com/developers/docs/resources/webhook#edit-webhook-message

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/webhook#edit-webhook-message
type EditWebhookMessageResponse = Response<objects.MessageObject>
```

</details>

[#Response](#Response)<[objects](#module.objects).[#MessageObject](#MessageObject)

><div id="DeleteWebhookMessageResponse"></div>

## DeleteWebhookMessageResponse

https://discord.com/developers/docs/resources/webhook#delete-webhook-message

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/webhook#delete-webhook-message
type DeleteWebhookMessageResponse = Response<nil>
```

</details>

[#Response](#Response)<[nil](#nil)><div id="GetGatewayResponse"></div>

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

[#Response](#Response)<[string](#string)><div id="GetGatewayBotResponse"></div>

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

[#Response](#Response)<[string](#string), [number](#number), [objects](#module.objects).[#SessionStartLimitObject](#SessionStartLimitObject)

><div id="CreateInteractionResponse"></div>

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

[#Response](#Response)<><div id="GetOriginalInteractionResponse"></div>

## GetOriginalInteractionResponse

https://discord.com/developers/docs/interactions/receiving-and-responding#get-original-interaction-response

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/receiving-and-responding#get-original-interaction-response
type GetOriginalInteractionResponse = Response<objects.MessageObject>
```

</details>

[#Response](#Response)<[objects](#module.objects).[#MessageObject](#MessageObject)

><div id="EditOriginalInteractionResponse"></div>

## EditOriginalInteractionResponse

https://discord.com/developers/docs/interactions/receiving-and-responding#edit-original-interaction-response

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/receiving-and-responding#edit-original-interaction-response
type EditOriginalInteractionResponse = Response<objects.MessageObject>
```

</details>

[#Response](#Response)<[objects](#module.objects).[#MessageObject](#MessageObject)

><div id="DeleteOriginalInteractionResponse"></div>

## DeleteOriginalInteractionResponse

https://discord.com/developers/docs/interactions/receiving-and-responding#delete-original-interaction-response

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/receiving-and-responding#delete-original-interaction-response
type DeleteOriginalInteractionResponse = Response<nil>
```

</details>

[#Response](#Response)<[nil](#nil)><div id="CreateFollowupMessageResponse"></div>

## CreateFollowupMessageResponse

https://discord.com/developers/docs/interactions/receiving-and-responding#create-followup-message

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/receiving-and-responding#create-followup-message
type CreateFollowupMessageResponse = Response<objects.MessageObject>
```

</details>

[#Response](#Response)<[objects](#module.objects).[#MessageObject](#MessageObject)

><div id="GetFollowupMessageResponse"></div>

## GetFollowupMessageResponse

https://discord.com/developers/docs/interactions/receiving-and-responding#get-followup-message

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/receiving-and-responding#get-followup-message
type GetFollowupMessageResponse = Response<objects.MessageObject>
```

</details>

[#Response](#Response)<[objects](#module.objects).[#MessageObject](#MessageObject)

><div id="EditFollowupMessageResponse"></div>

## EditFollowupMessageResponse

https://discord.com/developers/docs/interactions/receiving-and-responding#edit-followup-message

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/receiving-and-responding#edit-followup-message
type EditFollowupMessageResponse = Response<objects.MessageObject>
```

</details>

[#Response](#Response)<[objects](#module.objects).[#MessageObject](#MessageObject)

><div id="DeleteFollowupMessageResponse"></div>

## DeleteFollowupMessageResponse

https://discord.com/developers/docs/interactions/receiving-and-responding#delete-followup-message

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/receiving-and-responding#delete-followup-message
type DeleteFollowupMessageResponse = Response<nil>
```

</details>

[#Response](#Response)<[nil](#nil)>