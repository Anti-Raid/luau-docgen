# Partial



<details>
<summary>Raw Type</summary>

```luau
type Partial<T> = MakePartial<T>
```

</details>

# Snowflake



<details>
<summary>Raw Type</summary>

```luau
type Snowflake = string
```

</details>

# PremiumTypes

https://discord.com/developers/docs/resources/user#user-object-premium-types

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/user#user-object-premium-types
type PremiumTypes = number
```

</details>

# LanguageLocales

https://discord.com/developers/docs/reference#locales

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/reference#locales
type LanguageLocales = "id" | "da" | "de" | "en-GB" | "en-US" | "es-ES" | "fr" | "hr" | "it" | "lt" | "nl" | "no" | "pl" | "pt-BR" | "ro" | "fi" | "sv-SE" | "vi" | "tr" | "cs" | "el" | "bg" | "ru" | "uk" | "hi" | "th" | "zn-CH" | "ja" | "ko"
```

</details>

# MembershipState

https://discord.com/developers/docs/topics/teams#data-models-membership-state-enum

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/topics/teams#data-models-membership-state-enum
type MembershipState = number
```

</details>

# TeamMemberRole

https://discord.com/developers/docs/topics/teams#data-models-membership-state-enum

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/topics/teams#data-models-membership-state-enum
type TeamMemberRole = "Owner" | "Admin" | "Developer" | "Read-only"
```

</details>

# VerificationLevel

https://discord.com/developers/docs/resources/guild#guild-object-verification-level

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#guild-object-verification-level
type VerificationLevel = number
```

</details>

# DefaultMessageNotification

https://discord.com/developers/docs/resources/guild#guild-object-default-message-notification-level

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#guild-object-default-message-notification-level
type DefaultMessageNotification = number
```

</details>

# ExplicitContentFilterLevel

https://discord.com/developers/docs/resources/guild#guild-object-explicit-content-filter-level

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#guild-object-explicit-content-filter-level
type ExplicitContentFilterLevel = number
```

</details>

# MFALevel

https://discord.com/developers/docs/resources/guild#guild-object-explicit-content-filter-level

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#guild-object-explicit-content-filter-level
type MFALevel = number
```

</details>

# GuildNSFWLevel

https://discord.com/developers/docs/resources/guild#guild-object-guild-nsfw-level

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#guild-object-guild-nsfw-level
type GuildNSFWLevel = number
```

</details>

# PremiumTier

https://discord.com/developers/docs/resources/guild#guild-object-premium-tier

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#guild-object-premium-tier
type PremiumTier = number
```

</details>

# SystemChannelFlags

https://discord.com/developers/docs/resources/guild#guild-object-system-channel-flags

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#guild-object-system-channel-flags
type SystemChannelFlags = number
```

</details>

# GuildFeature

https://discord.com/developers/docs/resources/guild#guild-object-guild-features

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#guild-object-guild-features
type GuildFeature = "ANIMATED_BANNER" | "ANIMATED_ICON" | "APPLICATION_COMMAND_PERMISSIONS_V2" | "AUTO_MODERATION" | "BANNER" | "COMMUNITY" | "CREATOR_MONETIZABLE_PROVISIONAL" | "CREATOR_STORE_PAGE" | "DEVELOPER_SUPPORT_SERVER" | "DISCOVERABLE" | "FEATURABLE" | "INVITES_DISABLED" | "INVITE_SPLASH" | "MEMBER_VERIFICATION_GATE_ENABLED" | "MORE_STICKERS" | "NEWS" | "PARTNERED" | "PREVIEW_ENABLED" | "RAID_ALERTS_DISABLED" | "ROLE_ICONS" | "ROLE_SUBSCRIPTIONS_AVAILABLE_FOR_PURCHASE" | "ROLE_SUBSCRIPTIONS_ENABLED" | "TICKETED_EVENTS_ENABLED" | "VANITY_URL" | "VERIFIED" | "VIP_REGIONS" | "WELCOME_SCREEN_ENABLED"
```

</details>

# MutableGuildFeatures

https://discord.com/developers/docs/resources/guild#guild-object-mutable-guild-features

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#guild-object-mutable-guild-features
type MutableGuildFeatures = "COMMUNITY" | "DISCOVERABLE" | "INVITES_DISABLED" | "RAID_ALERTS_DISABLED"
```

</details>

# StickerType

https://discord.com/developers/docs/resources/sticker#sticker-object-sticker-types

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/sticker#sticker-object-sticker-types
type StickerType = number
```

</details>

# StickerFormatType

https://discord.com/developers/docs/resources/sticker#sticker-object-sticker-format-types

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/sticker#sticker-object-sticker-format-types
type StickerFormatType = number
```

</details>

# OAuth2Scopes

https://discord.com/developers/docs/topics/oauth2#shared-resources-oauth2-scopes

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/topics/oauth2#shared-resources-oauth2-scopes
type OAuth2Scopes = "activities.read" | "activities.write" | "applications.builds.read" | "applications.builds.upload" | "applications.commands" | "applications.commands.update" | "applications.commands.permissions.update" | "applications.entitlements" | "applications.store.update" | "bot" | "connections" | "dm_channels.read" | "email" | "gdm.join" | "guilds" | "guilds.join" | "guilds.members.read" | "identify" | "messages.read" | "relationships.read" | "role_connections.write" | "rpc" | "rpc.activities.write" | "rpc.notifications.read" | "rpc.voice.read" | "rpc.voice.write" | "voice" | "webhook.incoming"
```

</details>

# IntegrationType

https://discord.com/developers/docs/resources/guild#integration-object
"twitch" | "youtube" | "discord" | "guild_subscriptions"

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#integration-object
-- "twitch" | "youtube" | "discord" | "guild_subscriptions"
type IntegrationType = number
```

</details>

# ApplicationIntegrationType

https://discord.com/developers/docs/resources/application#application-object-application-integration-types

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/application#application-object-application-integration-types
type ApplicationIntegrationType = number
```

</details>

# ApplicationCommandPermissionType

https://discord.com/developers/docs/interactions/application-commands#application-command-permissions-object-application-command-permission-type

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/application-commands#application-command-permissions-object-application-command-permission-type
type ApplicationCommandPermissionType = number
```

</details>

# AutomoderationRuleEventType

https://discord.com/developers/docs/resources/auto-moderation#auto-moderation-rule-object-event-types

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/auto-moderation#auto-moderation-rule-object-event-types
type AutomoderationRuleEventType = number
```

</details>

# AutomoderationRuleTriggerType

https://discord.com/developers/docs/resources/auto-moderation#auto-moderation-rule-object-trigger-types

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/auto-moderation#auto-moderation-rule-object-trigger-types
type AutomoderationRuleTriggerType = number
```

</details>

# AutomoderationRuleKeywordPresetType

https://discord.com/developers/docs/resources/auto-moderation#auto-moderation-rule-object-keyword-preset-types

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/auto-moderation#auto-moderation-rule-object-keyword-preset-types
type AutomoderationRuleKeywordPresetType = number
```

</details>

# AutomoderationActionType

https://discord.com/developers/docs/resources/auto-moderation#auto-moderation-action-object-action-types

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/auto-moderation#auto-moderation-action-object-action-types
type AutomoderationActionType = number
```

</details>

# ChannelType

https://discord.com/developers/docs/resources/channel#channel-object-channel-types

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#channel-object-channel-types
type ChannelType = number
```

</details>

# VideoQualityMode

https://discord.com/developers/docs/resources/channel#channel-object-video-quality-modes

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#channel-object-video-quality-modes
type VideoQualityMode = number
```

</details>

# ChannelFlags

https://discord.com/developers/docs/resources/channel#channel-object-channel-flags

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#channel-object-channel-flags
type ChannelFlags = number
```

</details>

# SortOrderType

https://discord.com/developers/docs/resources/channel#channel-object-sort-order-types

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#channel-object-sort-order-types
type SortOrderType = number
```

</details>

# ForumLayoutType

https://discord.com/developers/docs/resources/channel#channel-object-forum-layout-types

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#channel-object-forum-layout-types
type ForumLayoutType = number
```

</details>

# OverwriteObjectType

https://discord.com/developers/docs/resources/channel#overwrite-object

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#overwrite-object
type OverwriteObjectType = number
```

</details>

# EntitlementType

https://discord.com/developers/docs/monetization/entitlements#entitlement-object-entitlement-types

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/monetization/entitlements#entitlement-object-entitlement-types
type EntitlementType = number
```

</details>

# ActivityType

https://discord.com/developers/docs/topics/gateway-events#activity-object-activity-types

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/topics/gateway-events#activity-object-activity-types
type ActivityType = number
```

</details>

# PrivacyLevel

https://discord.com/developers/docs/resources/stage-instance#stage-instance-object-privacy-level

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/stage-instance#stage-instance-object-privacy-level
type PrivacyLevel = number
```

</details>

# GuildScheduledEventStatus

https://discord.com/developers/docs/resources/guild-scheduled-event#guild-scheduled-event-object-guild-scheduled-event-status

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild-scheduled-event#guild-scheduled-event-object-guild-scheduled-event-status
type GuildScheduledEventStatus = number
```

</details>

# GuildScheduledEventEntityType

https://discord.com/developers/docs/resources/guild-scheduled-event#guild-scheduled-event-object-guild-scheduled-event-entity-types

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild-scheduled-event#guild-scheduled-event-object-guild-scheduled-event-entity-types
type GuildScheduledEventEntityType = number
```

</details>

# IntegrationExpireBehaviours

https://discord.com/developers/docs/resources/guild#integration-object-integration-expire-behaviors

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#integration-object-integration-expire-behaviors
type IntegrationExpireBehaviours = number
```

</details>

# InteractionType

https://discord.com/developers/docs/interactions/receiving-and-responding#interaction-object-interaction-type

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/receiving-and-responding#interaction-object-interaction-type
type InteractionType = number
```

</details>

# EmbedType

https://discord.com/developers/docs/resources/message#embed-object-embed-types

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/message#embed-object-embed-types
type EmbedType = "Rich" | "Image" | "Video" | "GIFV" | "Article" | "Link" | "PollResult"
```

</details>

# MessageType

https://discord.com/developers/docs/resources/channel#message-object-message-types

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#message-object-message-types
type MessageType = number
```

</details>

# MessageActivityType

https://discord.com/developers/docs/resources/channel#message-object-message-activity-types

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#message-object-message-activity-types
type MessageActivityType = number
```

</details>

# ButtonStyle

https://discord.com/developers/docs/interactions/message-components#button-object-button-styles

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/message-components#button-object-button-styles
type ButtonStyle = number
```

</details>

# TextInputStyles

https://discord.com/developers/docs/interactions/message-components#text-input-object-text-input-styles

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/message-components#text-input-object-text-input-styles
type TextInputStyles = number
```

</details>

# PollLayoutType

https://discord.com/developers/docs/resources/poll#layout-type

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/poll#layout-type
type PollLayoutType = number
```

</details>

# ApplicationCommandOptionType

https://discord.com/developers/docs/interactions/application-commands#application-command-object-application-command-option-type

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/application-commands#application-command-object-application-command-option-type
type ApplicationCommandOptionType = number
```

</details>

# InteractionContextType

https://discord.com/developers/docs/interactions/receiving-and-responding#interaction-object-interaction-context-types

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/receiving-and-responding#interaction-object-interaction-context-types
type InteractionContextType = number
```

</details>

# InviteTypes

https://discord.com/developers/docs/resources/invite#invite-object-invite-types

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/invite#invite-object-invite-types
type InviteTypes = number
```

</details>

# InviteTargetTypes

https://discord.com/developers/docs/resources/invite#invite-object-invite-target-types

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/invite#invite-object-invite-target-types
type InviteTargetTypes = number
```

</details>

# ReactionType

https://discord.com/developers/docs/resources/channel#get-reactions-reaction-types

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#get-reactions-reaction-types
type ReactionType = number
```

</details>

# ApplicationRoleConnectionMetadataType

https://discord.com/developers/docs/resources/application-role-connection-metadata#application-role-connection-metadata-object-application-role-connection-metadata-type

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/application-role-connection-metadata#application-role-connection-metadata-object-application-role-connection-metadata-type
type ApplicationRoleConnectionMetadataType = number
```

</details>

# ApplicationCommandType

https://discord.com/developers/docs/interactions/application-commands#application-command-object-application-command-types

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/application-commands#application-command-object-application-command-types
type ApplicationCommandType = number
```

</details>

# AuditLogEventType

https://discord.com/developers/docs/resources/audit-log#audit-log-entry-object-audit-log-events

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/audit-log#audit-log-entry-object-audit-log-events
type AuditLogEventType = number
```

</details>

# WebhookType

https://discord.com/developers/docs/resources/webhook#webhook-object-webhook-types

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/webhook#webhook-object-webhook-types
type WebhookType = number
```

</details>

# OnboardingMode

https://discord.com/developers/docs/resources/guild#guild-onboarding-object-onboarding-mode

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#guild-onboarding-object-onboarding-mode
type OnboardingMode = number
```

</details>

# PromptTypes

https://discord.com/developers/docs/resources/guild#guild-onboarding-object-prompt-types

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#guild-onboarding-object-prompt-types
type PromptTypes = number
```

</details>

# ConnectionObjectServices

https://discord.com/developers/docs/resources/user#connection-object-services

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/user#connection-object-services
type ConnectionObjectServices = "battlenet" | "bungie" | "domain" | "ebay" | "epicgames" | "facebook" | "github" | "instagram" | "leagueoflegends" | "paypal" | "playstation" | "reddit" | "riotgames" | "spotify" | "skype" | "stream" | "tiktok" | "twitch" | "twitter" | "xbox" | "youtube"
```

</details>

# AllowedMentionTypes

https://discord.com/developers/docs/resources/channel#allowed-mentions-object-allowed-mention-types

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#allowed-mentions-object-allowed-mention-types
type AllowedMentionTypes = "roles" | "users" | "everyone"
```

</details>

# ConnectionVisibilityTypes

https://discord.com/developers/docs/resources/user#connection-object-visibility-types

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/user#connection-object-visibility-types
type ConnectionVisibilityTypes = number
```

</details>

# MessageReferenceType

https://discord.com/developers/docs/resources/channel#message-reference-types

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#message-reference-types
type MessageReferenceType = number
```

</details>

# GuildMemberFlags

https://discord.com/developers/docs/resources/guild#guild-member-object-guild-member-flags

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#guild-member-object-guild-member-flags
type GuildMemberFlags = number
```

</details>

# InteractionCallbackType

https://discord.com/developers/docs/interactions/receiving-and-responding#interaction-response-object-interaction-callback-type

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/receiving-and-responding#interaction-response-object-interaction-callback-type
type InteractionCallbackType = number
```

</details>

# ActivityTimestampObject

https://discord.com/developers/docs/topics/gateway-events#activity-object-activity-timestamps

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/topics/gateway-events#activity-object-activity-timestamps
type ActivityTimestampObject = {
	start: number,

	["end"]: number
}
```

</details>

## Fields

## start

## ["end"]

# ActivityEmojiObject

https://discord.com/developers/docs/topics/gateway-events#activity-object-activity-emoji

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/topics/gateway-events#activity-object-activity-emoji
type ActivityEmojiObject = {
	name: string,

	id: Snowflake,

	animated: boolean?
}
```

</details>

## Fields

## name

## id

## animated

# ActivityPartyObject

https://discord.com/developers/docs/topics/gateway-events#activity-object-activity-party

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/topics/gateway-events#activity-object-activity-party
type ActivityPartyObject = {
	id: string,

	size: {number}
}
```

</details>

## Fields

## id

## size

# ActivityAssetsObject

https://discord.com/developers/docs/topics/gateway-events#activity-object-activity-assets

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/topics/gateway-events#activity-object-activity-assets
type ActivityAssetsObject = {
	large_image: string,

	large_text: string,

	small_image: string,

	small_text: string
}
```

</details>

## Fields

## large_image

## large_text

## small_image

## small_text

# ActivitySecretsObject

https://discord.com/developers/docs/topics/gateway-events#activity-object-activity-secrets

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/topics/gateway-events#activity-object-activity-secrets
type ActivitySecretsObject = {
	join: string?,

	spectate: string?,

	match: string?
}
```

</details>

## Fields

## join

## spectate

## match

# ActivityButtonsObject

https://discord.com/developers/docs/topics/gateway-events#activity-object-activity-buttons

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/topics/gateway-events#activity-object-activity-buttons
type ActivityButtonsObject = {
	label: string,

	url: string
}
```

</details>

## Fields

## label

## url

# ActivityObject

https://discord.com/developers/docs/topics/gateway-events#activity-object

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/topics/gateway-events#activity-object
type ActivityObject = {
	name: string,

	type: number,

	url: string?,

	created_at: number,

	timestamps: ActivityTimestampObject,

	application_id: Snowflake,

	details: string?,

	state: string?,

	emoji: ActivityEmojiObject?,

	party: ActivityPartyObject?,

	assets: ActivityAssetsObject?,

	secrets: ActivitySecretsObject?,

	instance: boolean?,

	flags: number?,

	buttons: {ActivityButtonsObject}?
}
```

</details>

## Fields

## name

## type

## url

## created_at

## timestamps

## application_id

## details

## state

## emoji

## party

## assets

## secrets

## instance

## flags

## buttons

# PresenceObject

https://discord.com/developers/docs/topics/gateway-events#update-presence

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/topics/gateway-events#update-presence
type PresenceObject = {
	since: number,

	activities: {ActivityObject},

	status: string,

	afk: boolean
}
```

</details>

## Fields

## since

## activities

## status

## afk

# IdentifyPropertiesObject

https://discord.com/developers/docs/topics/gateway-events#identify-identify-connection-properties

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/topics/gateway-events#identify-identify-connection-properties
type IdentifyPropertiesObject = {
	os: string,

	browser: string,

	device: string
}
```

</details>

## Fields

## os

## browser

## device

# AvatarDecorationDataObject

https://discord.com/developers/docs/resources/user#avatar-decoration-data-object

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/user#avatar-decoration-data-object
type AvatarDecorationDataObject = {
	asset: string,

	sku_id: Snowflake
}
```

</details>

## Fields

## asset

## sku_id

# UserObject

https://discord.com/developers/docs/resources/user#user-object

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/user#user-object
type UserObject = {
	id: Snowflake,

	username: string,

	discriminator: string,

	global_name: string,

	avatar: string,

	bot: boolean?,

	system: boolean?,

	mfa_enabled: boolean?,

	banner: string?,

	accent_color: number?,

	locale: LanguageLocales?,

	verified: boolean?,

	email: string?,

	flags: number?,

	premium_type: PremiumTypes?,

	public_flags: number?,

	avatar_decoration_data: AvatarDecorationDataObject?
}
```

</details>

## Fields

## id

## username

## discriminator

## global_name

## avatar

## bot

## system

## mfa_enabled

## banner

## accent_color

## locale

## verified

## email

## flags

## premium_type

## public_flags

## avatar_decoration_data

# UnavailableGuildObject

https://discord.com/developers/docs/resources/guild#unavailable-guild-object

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#unavailable-guild-object
type UnavailableGuildObject = {
	id: Snowflake,

	unavailable: boolean
}
```

</details>

## Fields

## id

## unavailable

# TeamMemberObject

https://discord.com/developers/docs/topics/teams#data-models-team-member-object

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/topics/teams#data-models-team-member-object
type TeamMemberObject = {
	membership_state: MembershipState,

	team_id: Snowflake,

	user: UserObject,

	role: TeamMemberRole
}
```

</details>

## Fields

## membership_state

## team_id

## user

## role

# TeamObject

https://discord.com/developers/docs/topics/teams#data-models-team-object

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/topics/teams#data-models-team-object
type TeamObject = {
	icon: string,

	id: Snowflake,

	members: {TeamMemberObject},

	name: string,

	owner_user_id: Snowflake
}
```

</details>

## Fields

## icon

## id

## members

## name

## owner_user_id

# GuildRoleTagObject

https://discord.com/developers/docs/topics/permissions#role-object-role-tags-structure

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/topics/permissions#role-object-role-tags-structure
type GuildRoleTagObject = {
	bot_id: Snowflake?,

	integration_id: Snowflake?,

	premium_subscriber: nil,

	subscription_listing_id: Snowflake,

	available_for_purchase: nil,

	guild_connections: nil
}
```

</details>

## Fields

## bot_id

## integration_id

## premium_subscriber

## subscription_listing_id

## available_for_purchase

## guild_connections

# GuildRoleObject

https://discord.com/developers/docs/topics/permissions#role-object

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/topics/permissions#role-object
type GuildRoleObject = {
	id: Snowflake?,

	name: string,

	color: number,

	hoist: boolean,

	icon: string?,

	unicode_emoji: string?,

	position: number,

	permissions: string,

	managed: boolean,

	mentionable: boolean,

	tags: GuildRoleTagObject?,

	flags: number
}
```

</details>

## Fields

## id

## name

## color

## hoist

## icon

## unicode_emoji

## position

## permissions

## managed

## mentionable

## tags

## flags

# EmojiObject

https://discord.com/developers/docs/resources/emoji#emoji-object

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/emoji#emoji-object
type EmojiObject = {
	id: Snowflake?,

	name: string,

	roles: {Snowflake}?,

	user: UserObject?,

	require_colons: boolean?,

	managed: boolean?,

	animated: boolean?,

	available: boolean?
}
```

</details>

## Fields

## id

## name

## roles

## user

## require_colons

## managed

## animated

## available

# WelcomeScreenChannelObject

https://discord.com/developers/docs/resources/guild#welcome-screen-object-welcome-screen-channel-structure

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#welcome-screen-object-welcome-screen-channel-structure
type WelcomeScreenChannelObject = {
	channel_id: Snowflake?,

	description: string?,

	emoji_id: Snowflake?,

	emoji_name: string?
}
```

</details>

## Fields

## channel_id

## description

## emoji_id

## emoji_name

# WelcomeScreenObject

https://discord.com/developers/docs/resources/guild#welcome-screen-object

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#welcome-screen-object
type WelcomeScreenObject = {
	description: string,

	welcome_channels: {WelcomeScreenChannelObject}
}
```

</details>

## Fields

## description

## welcome_channels

# StickerObject

https://discord.com/developers/docs/resources/sticker#sticker-object

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/sticker#sticker-object
type StickerObject = {
	id: Snowflake,

	pack_id: Snowflake,

	name: string,

	description: string?,

	tags: string,

	asset: string?,

	type: StickerType,

	format_type: StickerFormatType,

	available: boolean?,

	guild_id: Snowflake?,

	user: UserObject?,

	sort_value: number?
}
```

</details>

## Fields

## id

## pack_id

## name

## description

## tags

## asset

## type

## format_type

## available

## guild_id

## user

## sort_value

# GuildObject

https://discord.com/developers/docs/resources/guild#guild-object

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#guild-object
type GuildObject = {
	id: Snowflake?,

	name: string?,

	icon: string?,

	icon_hash: string?,

	splash: string?,

	discovery_splash: string?,

	owner: boolean?,

	owner_id: Snowflake?,

	permissions: string?,

	region: string?,

	afk_channel_id: Snowflake?,

	afk_timeout: number?,

	widget_enabled: boolean?,

	widget_channel_id: Snowflake?,

	verification_level: VerificationLevel?,

	default_message_notifications: DefaultMessageNotification?,

	explicit_content_filter: ExplicitContentFilterLevel?,

	roles: {GuildRoleObject}?,

	emojis: {EmojiObject}?,

	features: {GuildFeature}?,

	mfa_level: MFALevel?,

	application_id: Snowflake?,

	system_channel_id: Snowflake?,

	system_channel_flags: SystemChannelFlags?,

	rules_channel_id: Snowflake?,

	max_presences: number?,

	max_members: number?,

	vanity_url_code: string?,

	description: string?,

	banner: string?,

	premium_tier: PremiumTier?,

	premium_subscription_count: number?,

	preferred_locale: LanguageLocales?,

	public_updates_channel_id: Snowflake?,

	max_video_channel_users: number?,

	max_stage_video_channel_users: number?,

	approximate_member_count: number?,

	approximate_presence_count: number?,

	welcome_screen: WelcomeScreenObject?,

	nsfw_level: GuildNSFWLevel?,

	stickers: {StickerObject}?,

	premium_progress_bar_enabled: boolean?,

	safety_alerts_channel_id: Snowflake?
}
```

</details>

## Fields

## id

## name

## icon

## icon_hash

## splash

## discovery_splash

## owner

## owner_id

## permissions

## region

## afk_channel_id

## afk_timeout

## widget_enabled

## widget_channel_id

## verification_level

## default_message_notifications

## explicit_content_filter

## roles

## emojis

## features

## mfa_level

## application_id

## system_channel_id

## system_channel_flags

## rules_channel_id

## max_presences

## max_members

## vanity_url_code

## description

## banner

## premium_tier

## premium_subscription_count

## preferred_locale

## public_updates_channel_id

## max_video_channel_users

## max_stage_video_channel_users

## approximate_member_count

## approximate_presence_count

## welcome_screen

## nsfw_level

## stickers

## premium_progress_bar_enabled

## safety_alerts_channel_id

# InstallParamsObject

https://discord.com/developers/docs/resources/application#install-params-object

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/application#install-params-object
type InstallParamsObject = {
	scopes: {OAuth2Scopes},

	permissions: string
}
```

</details>

## Fields

## scopes

## permissions

# ApplicationObject

https://discord.com/developers/docs/resources/application#application-object

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/application#application-object
type ApplicationObject = {
	id: Snowflake,

	name: string,

	icon: string?,

	description: string,

	rpc_origins: {string}?,

	bot_public: boolean,

	bot_require_code_grant: boolean,

	bot: UserObject?,

	terms_of_service_url: string?,

	privacy_policy_url: string?,

	owner: UserObject?,

	summary: string,

	verify_key: string,

	team: TeamObject?,

	guild_id: Snowflake?,

	guild: GuildObject?,

	primary_sku_id: Snowflake?,

	slug: string?,

	cover_image: string?,

	flags: number?,

	approximate_guild_count: number?,

	redirect_uris: {string}?,

	interactions_endpoint_url: string?,

	role_connections_verification_url: string?,

	tags: {string}?,

	install_params: InstallParamsObject?,

	integration_types_config: {
		[ApplicationIntegrationType]: boolean
	}?,

	custom_install_url: string?
}
```

</details>

## Fields

## id

## name

## icon

## description

## rpc_origins

## bot_public

## bot_require_code_grant

## bot

## terms_of_service_url

## privacy_policy_url

## owner

## summary

## verify_key

## team

## guild_id

## guild

## primary_sku_id

## slug

## cover_image

## flags

## approximate_guild_count

## redirect_uris

## interactions_endpoint_url

## role_connections_verification_url

## tags

## install_params

## integration_types_config

## custom_install_url

# GuildApplicationCommandPermissionObject

https://discord.com/developers/docs/interactions/application-commands#application-command-permissions-object-application-command-permissions-structure

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/application-commands#application-command-permissions-object-application-command-permissions-structure
type GuildApplicationCommandPermissionObject = {
	id: Snowflake,

	type: ApplicationCommandPermissionType,

	permission: boolean
}
```

</details>

## Fields

## id

## type

## permission

# GuildApplicationCommandPermissionsObject

https://discord.com/developers/docs/interactions/application-commands#application-command-permissions-object-guild-application-command-permissions-structure

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/application-commands#application-command-permissions-object-guild-application-command-permissions-structure
type GuildApplicationCommandPermissionsObject = {
	id: Snowflake,

	application_id: Snowflake,

	guild_id: Snowflake,

	permissions: {GuildApplicationCommandPermissionObject}
}
```

</details>

## Fields

## id

## application_id

## guild_id

## permissions

# AutomoderationRuleTriggerMetadataObject

https://discord.com/developers/docs/resources/auto-moderation#auto-moderation-rule-object-trigger-metadata

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/auto-moderation#auto-moderation-rule-object-trigger-metadata
type AutomoderationRuleTriggerMetadataObject = {
	keyword_filter: {string},

	regex_patterns: {string},

	presets: {AutomoderationRuleKeywordPresetType},

	allow_list: {string},

	mention_total_limit: number,

	mention_raid_protection_enabled: boolean
}
```

</details>

## Fields

## keyword_filter

## regex_patterns

## presets

## allow_list

## mention_total_limit

## mention_raid_protection_enabled

# AutmoderationActionMetadataObject

https://discord.com/developers/docs/resources/auto-moderation#auto-moderation-action-object-action-metadata

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/auto-moderation#auto-moderation-action-object-action-metadata
type AutmoderationActionMetadataObject = {
	channel_id: Snowflake,

	duration_seconds: number,

	custom_message: string?
}
```

</details>

## Fields

## channel_id

## duration_seconds

## custom_message

# AutomoderationActionObject

https://discord.com/developers/docs/resources/auto-moderation#auto-moderation-action-object

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/auto-moderation#auto-moderation-action-object
type AutomoderationActionObject = {
	type: AutomoderationActionType,

	metadata: AutmoderationActionMetadataObject?
}
```

</details>

## Fields

## type

## metadata

# AutomoderationRuleObject

https://discord.com/developers/docs/resources/auto-moderation#auto-moderation-rule-object

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/auto-moderation#auto-moderation-rule-object
type AutomoderationRuleObject = {
	id: Snowflake,

	guild_id: Snowflake,

	name: string,

	creator_id: Snowflake,

	event_type: AutomoderationRuleEventType,

	trigger_type: AutomoderationRuleTriggerType,

	trigger_metadata: AutomoderationRuleTriggerMetadataObject,

	actions: {AutomoderationActionObject},

	enabled: boolean,

	exempt_roles: {Snowflake},

	exempt_channels: {Snowflake}
}
```

</details>

## Fields

## id

## guild_id

## name

## creator_id

## event_type

## trigger_type

## trigger_metadata

## actions

## enabled

## exempt_roles

## exempt_channels

# OverwriteObject

https://discord.com/developers/docs/resources/channel#overwrite-object

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#overwrite-object
type OverwriteObject = {
	id: Snowflake,

	type: OverwriteObjectType,

	allow: string,

	deny: string
}
```

</details>

## Fields

## id

## type

## allow

## deny

# ThreadMetadataObject

https://discord.com/developers/docs/resources/channel#thread-metadata-object

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#thread-metadata-object
type ThreadMetadataObject = {
	archived: boolean,

	auto_archive_duration: number,

	archive_timestamp: string,

	locked: boolean,

	invitable: boolean?,

	create_timestamp: string
}
```

</details>

## Fields

## archived

## auto_archive_duration

## archive_timestamp

## locked

## invitable

## create_timestamp

# GuildMemberObject

https://discord.com/developers/docs/resources/guild#guild-member-object

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#guild-member-object
type GuildMemberObject = {
	user: UserObject?,

	nick: string?,

	avatar: string?,

	roles: {Snowflake},

	joined_at: string,

	premium_since: string?,

	deaf: boolean,

	mute: boolean,

	flags: number,

	pending: boolean?,

	permissions: string?,

	communication_disabled_until: string?,

	avatar_decoration_data: AvatarDecorationDataObject?
}
```

</details>

## Fields

## user

## nick

## avatar

## roles

## joined_at

## premium_since

## deaf

## mute

## flags

## pending

## permissions

## communication_disabled_until

## avatar_decoration_data

# ThreadMemberObject

https://discord.com/developers/docs/resources/channel#thread-member-object

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#thread-member-object
type ThreadMemberObject = {
	id: Snowflake?,

	user_id: Snowflake?,

	join_timestamp: string,

	flags: number,

	member: GuildMemberObject?
}
```

</details>

## Fields

## id

## user_id

## join_timestamp

## flags

## member

# ForumTagObject

https://discord.com/developers/docs/resources/channel#forum-tag-object

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#forum-tag-object
type ForumTagObject = {
	id: Snowflake,

	name: string,

	moderated: boolean,

	emoji_id: string?,

	emoji_name: string?
}
```

</details>

## Fields

## id

## name

## moderated

## emoji_id

## emoji_name

# DefaultReactionObject

https://discord.com/developers/docs/resources/channel#default-reaction-object

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#default-reaction-object
type DefaultReactionObject = {
	emoji_id: string?,

	emoji_name: string?
}
```

</details>

## Fields

## emoji_id

## emoji_name

# ChannelObject

https://discord.com/developers/docs/resources/channel#channel-object

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#channel-object
type ChannelObject = {
	id: Snowflake?,

	type: ChannelType,

	guild_id: Snowflake?,

	position: number,

	permission_overwrites: {OverwriteObject},

	name: string,

	topic: string?,

	nsfw: boolean?,

	last_message_id: Snowflake?,

	bitrate: number?,

	user_limit: number?,

	rate_limit_per_user: number?,

	recipients: {UserObject}?,

	icon: string?,

	owner_id: Snowflake?,

	application_id: Snowflake?,

	managed: boolean?,

	parent_id: Snowflake?,

	last_pin_timestamp: string?,

	rtc_region: string?,

	video_quality_mode: VideoQualityMode?,

	message_count: number?,

	member_count: number?,

	thread_metadata: ThreadMetadataObject?,

	member: ThreadMemberObject?,

	default_auto_archive_duration: number?,

	permissions: string?,

	flags: ChannelFlags?,

	total_message_sent: number?,

	available_tags: {ForumTagObject}?,

	applied_tags: {Snowflake}?,

	default_reaction_emoji: DefaultReactionObject?,

	default_thread_rate_limit_per_user: number?,

	default_sort_order: SortOrderType?,

	default_forum_layout: ForumLayoutType?
}
```

</details>

## Fields

## id

## type

## guild_id

## position

## permission_overwrites

## name

## topic

## nsfw

## last_message_id

## bitrate

## user_limit

## rate_limit_per_user

## recipients

## icon

## owner_id

## application_id

## managed

## parent_id

## last_pin_timestamp

## rtc_region

## video_quality_mode

## message_count

## member_count

## thread_metadata

## member

## default_auto_archive_duration

## permissions

## flags

## total_message_sent

## available_tags

## applied_tags

## default_reaction_emoji

## default_thread_rate_limit_per_user

## default_sort_order

## default_forum_layout

# EntitlementObject

https://discord.com/developers/docs/monetization/entitlements#entitlement-object

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/monetization/entitlements#entitlement-object
type EntitlementObject = {
	id: Snowflake,

	sku_id: Snowflake,

	application_id: Snowflake,

	user_id: Snowflake?,

	type: EntitlementType,

	deleted: boolean,

	starts_at: string?,

	ends_at: string?,

	guild_id: Snowflake?,

	consumed: boolean?
}
```

</details>

## Fields

## id

## sku_id

## application_id

## user_id

## type

## deleted

## starts_at

## ends_at

## guild_id

## consumed

# VoiceStateObject

https://discord.com/developers/docs/resources/voice#voice-state-object

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/voice#voice-state-object
type VoiceStateObject = {
	guild_id: Snowflake?,

	channel_id: Snowflake?,

	user_id: Snowflake,

	member: GuildMemberObject?,

	session_id: string,

	deaf: boolean,

	mute: boolean,

	self_deaf: boolean,

	self_mute: boolean,

	self_stream: boolean?,

	self_video: boolean,

	suppress: boolean,

	request_to_speak_timestamp: string?
}
```

</details>

## Fields

## guild_id

## channel_id

## user_id

## member

## session_id

## deaf

## mute

## self_deaf

## self_mute

## self_stream

## self_video

## suppress

## request_to_speak_timestamp

# ClientStatusObject

https://discord.com/developers/docs/topics/gateway-events#client-status-object

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/topics/gateway-events#client-status-object
type ClientStatusObject = {
	desktop: string?,

	mobile: string?,

	web: string?
}
```

</details>

## Fields

## desktop

## mobile

## web

# PresenceUpdateObject

https://discord.com/developers/docs/topics/gateway-events#presence-update

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/topics/gateway-events#presence-update
type PresenceUpdateObject = {
	user: UserObject,

	guild_id: Snowflake,

	status: string,

	activities: {ActivityObject},

	client_status: ClientStatusObject
}
```

</details>

## Fields

## user

## guild_id

## status

## activities

## client_status

# StageInstanceObject

https://discord.com/developers/docs/resources/stage-instance#stage-instance-object

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/stage-instance#stage-instance-object
type StageInstanceObject = {
	id: Snowflake,

	guild_id: Snowflake,

	channel_id: Snowflake,

	topic: string,

	privacy_level: PrivacyLevel,

	discoverable_disabled: boolean,

	guild_scheduled_event_id: Snowflake?
}
```

</details>

## Fields

## id

## guild_id

## channel_id

## topic

## privacy_level

## discoverable_disabled

## guild_scheduled_event_id

# GuildScheduledEventEntityMetadata

https://discord.com/developers/docs/resources/guild-scheduled-event#guild-scheduled-event-object-guild-scheduled-event-entity-metadata

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild-scheduled-event#guild-scheduled-event-object-guild-scheduled-event-entity-metadata
type GuildScheduledEventEntityMetadata = {
	location: string
}
```

</details>

## Fields

## location

# GuildScheduledEventObject

https://discord.com/developers/docs/resources/guild-scheduled-event#guild-scheduled-event-object

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild-scheduled-event#guild-scheduled-event-object
type GuildScheduledEventObject = {
	id: Snowflake,

	guild_id: Snowflake,

	channel_id: Snowflake?,

	creator_id: Snowflake?,

	name: string,

	description: string?,

	scheduled_start_time: string,

	scheduled_end_time: string?,

	privacy_level: PrivacyLevel,

	status: GuildScheduledEventStatus,

	entity_type: GuildScheduledEventEntityType,

	entity_id: Snowflake?,

	entity_metadata: GuildScheduledEventEntityMetadata?,

	creator: UserObject?,

	user_count: number,

	image: string?
}
```

</details>

## Fields

## id

## guild_id

## channel_id

## creator_id

## name

## description

## scheduled_start_time

## scheduled_end_time

## privacy_level

## status

## entity_type

## entity_id

## entity_metadata

## creator

## user_count

## image

# IntegrationAccountObject

https://discord.com/developers/docs/resources/guild#integration-account-object

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#integration-account-object
type IntegrationAccountObject = {
	id: string,

	name: string
}
```

</details>

## Fields

## id

## name

# IntegrationObject

https://discord.com/developers/docs/resources/guild#integration-object

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#integration-object
type IntegrationObject = {
	id: Snowflake,

	name: string,

	type: IntegrationType,

	enabled: boolean,

	syncing: boolean?,

	role_id: Snowflake?,

	enable_emoticons: boolean?,

	expire_behaviour: IntegrationExpireBehaviours?,

	expire_grace_period: number?,

	user: UserObject?,

	account: IntegrationAccountObject,

	synced_at: string?,

	subscriber_count: number?,

	revoked: boolean?,

	application: IntegrationApplicationObject?,

	scopes: {OAuth2Scopes}?
}
```

</details>

## Fields

## id

## name

## type

## enabled

## syncing

## role_id

## enable_emoticons

## expire_behaviour

## expire_grace_period

## user

## account

## synced_at

## subscriber_count

## revoked

## application

## scopes

# ChannelMentionObject

https://discord.com/developers/docs/resources/channel#channel-mention-object

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#channel-mention-object
type ChannelMentionObject = {
	id: Snowflake,

	guild_id: Snowflake,

	type: ChannelType,

	name: string
}
```

</details>

## Fields

## id

## guild_id

## type

## name

# AttachmentObject

https://discord.com/developers/docs/resources/channel#attachment-object

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#attachment-object
type AttachmentObject = Partial<{
	id: Snowflake,

	filename: string,

	title: string?,

	description: string?,

	content_type: string?,

	size: number,

	url: string,

	proxy_url: string,

	height: number?,

	width: number?,

	ephemeral: boolean?,

	duration_secs: number?,

	waveform: string?,

	flags: number
}>
```

</details>

# EmbedFooterObject

https://discord.com/developers/docs/resources/channel#embed-object-embed-footer-structure

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#embed-object-embed-footer-structure
type EmbedFooterObject = {
	text: string,

	icon_url: string?,

	proxy_icon_url: string?
}
```

</details>

## Fields

## text

## icon_url

## proxy_icon_url

# EmbedImageObject

https://discord.com/developers/docs/resources/channel#embed-object-embed-image-structure

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#embed-object-embed-image-structure
type EmbedImageObject = {
	url: string,

	proxy_url: string?,

	height: number?,

	width: number?
}
```

</details>

## Fields

## url

## proxy_url

## height

## width

# EmbedProviderObject

https://discord.com/developers/docs/resources/channel#embed-object-embed-provider-structure

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#embed-object-embed-provider-structure
type EmbedProviderObject = {
	name: string?,

	url: string?
}
```

</details>

## Fields

## name

## url

# EmbedAuthorObject

https://discord.com/developers/docs/resources/channel#embed-object-embed-author-structure

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#embed-object-embed-author-structure
type EmbedAuthorObject = {
	name: string,

	url: string?,

	icon_url: string?,

	proxy_icon_url: string?
}
```

</details>

## Fields

## name

## url

## icon_url

## proxy_icon_url

# EmbedFieldObject

https://discord.com/developers/docs/resources/channel#embed-object-embed-field-structure

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#embed-object-embed-field-structure
type EmbedFieldObject = {
	name: string,

	value: string,

	inline: boolean?
}
```

</details>

## Fields

## name

## value

## inline

# EmbedThumbnailObject

https://discord.com/developers/docs/resources/channel#embed-object-embed-thumbnail-structure

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#embed-object-embed-thumbnail-structure
type EmbedThumbnailObject = {
	url: string,

	proxy_url: string?,

	height: number?,

	width: number?
}
```

</details>

## Fields

## url

## proxy_url

## height

## width

# EmbedVideoObject

https://discord.com/developers/docs/resources/channel#embed-object-embed-video-structure

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#embed-object-embed-video-structure
type EmbedVideoObject = {
	url: string,

	proxy_url: string?,

	height: number?,

	width: number?
}
```

</details>

## Fields

## url

## proxy_url

## height

## width

# EmbedObject

https://discord.com/developers/docs/resources/message#embed-object

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/message#embed-object
type EmbedObject = {
	title: string?,

	type: EmbedType?,

	description: string?,

	url: string?,

	timestamp: string?,

	color: number?,

	footer: EmbedFooterObject?,

	image: EmbedImageObject?,

	thumbnail: EmbedThumbnailObject?,

	video: EmbedVideoObject?,

	provider: EmbedProviderObject?,

	author: EmbedAuthorObject?,

	fields: {EmbedFieldObject}?
}
```

</details>

## Fields

## title

## type

## description

## url

## timestamp

## color

## footer

## image

## thumbnail

## video

## provider

## author

## fields

# ReactionCountDetailsObject

https://discord.com/developers/docs/resources/channel#reaction-count-details-object

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#reaction-count-details-object
type ReactionCountDetailsObject = {
	burst: number,

	normal: number
}
```

</details>

## Fields

## burst

## normal

# ReactionObject

https://discord.com/developers/docs/resources/channel#reaction-object

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#reaction-object
type ReactionObject = {
	count: number,

	count_details: ReactionCountDetailsObject,

	me: boolean,

	me_burst: boolean,

	emoji: EmojiObject,

	burst_colors: {string}
}
```

</details>

## Fields

## count

## count_details

## me

## me_burst

## emoji

## burst_colors

# MessageActivityObject

https://discord.com/developers/docs/resources/channel#message-object-message-activity-structure

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#message-object-message-activity-structure
type MessageActivityObject = {
	type: MessageActivityType,

	party_id: string
}
```

</details>

## Fields

## type

## party_id

# MessageReferenceObject

https://discord.com/developers/docs/resources/channel#message-reference-object-message-reference-structure

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#message-reference-object-message-reference-structure
type MessageReferenceObject = {
	type: MessageReferenceType?,

	message_id: Snowflake?,

	channel_id: Snowflake?,

	guild_id: Snowflake?,

	fail_if_not_exists: boolean?
}
```

</details>

## Fields

## type

## message_id

## channel_id

## guild_id

## fail_if_not_exists

# MessageInteractionMetadatObject

https://discord.com/developers/docs/resources/channel#message-interaction-metadata-object-message-interaction-metadata-structure

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#message-interaction-metadata-object-message-interaction-metadata-structure
type MessageInteractionMetadatObject = {
	id: Snowflake,

	type: InteractionType,

	user: UserObject,

	authorizing_integration_owners: {
		[ApplicationIntegrationType]: Snowflake
	},

	original_response_message_id: Snowflake?,

	interacted_message_id: Snowflake?,

	triggering_interaction_metadata: MessageInteractionMetadatObject
}
```

</details>

## Fields

## id

## type

## user

## authorizing_integration_owners

## original_response_message_id

## interacted_message_id

## triggering_interaction_metadata

# MessageInteractionObject

https://discord.com/developers/docs/interactions/receiving-and-responding#message-interaction-object-message-interaction-structure

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/receiving-and-responding#message-interaction-object-message-interaction-structure
type MessageInteractionObject = {
	id: string,

	type: InteractionType,

	name: string,

	user: UserObject,

	member: GuildMemberObject?
}
```

</details>

## Fields

## id

## type

## name

## user

## member

# SelectOptionObject

https://discord.com/developers/docs/interactions/message-components#select-menu-object-select-option-structure

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/message-components#select-menu-object-select-option-structure
type SelectOptionObject = {
	label: string,

	value: string,

	description: string?,

	emoji: EmojiObject?,

	default: boolean
}
```

</details>

## Fields

## label

## value

## description

## emoji

## default

# SelectDefaultValueObject

https://discord.com/developers/docs/interactions/message-components#select-menu-object-select-default-value-structure

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/message-components#select-menu-object-select-default-value-structure
type SelectDefaultValueObject = {
	id: Snowflake,

	type: string
}
```

</details>

## Fields

## id

## type

# ActionRowComponentObject

https://discord.com/developers/docs/interactions/message-components#action-rows

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/message-components#action-rows
type ActionRowComponentObject = {
	type: number,

	components: {ComponentObjects}
}
```

</details>

## Fields

## type

## components

# ButtonComponentObject

https://discord.com/developers/docs/interactions/message-components#button-object

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/message-components#button-object
type ButtonComponentObject = Partial<{
	type: number,

	style: ButtonStyle,

	label: string?,

	emoji: EmojiObject?,

	custom_id: string?,

	sku_id: string?,

	url: string?,

	disabled: boolean?
}>
```

</details>

# SelectMenuComponentObject

https://discord.com/developers/docs/interactions/message-components#select-menu-object

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/message-components#select-menu-object
type SelectMenuComponentObject = {
	type: number,

	custom_id: string,

	options: {SelectOptionObject}?,

	channel_types: {ChannelType}?,

	placeholder: string?,

	default_values: {SelectDefaultValueObject}?,

	min_values: number?,

	max_values: number?,

	disabled: boolean?
}
```

</details>

## Fields

## type

## custom_id

## options

## channel_types

## placeholder

## default_values

## min_values

## max_values

## disabled

# TextInputComponentObject

https://discord.com/developers/docs/interactions/message-components#select-menu-object

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/message-components#select-menu-object
type TextInputComponentObject = {
	type: number,

	custom_id: string,

	style: TextInputStyles,

	label: string,

	min_length: number?,

	max_length: number?,

	required: boolean?,

	value: string?,

	placeholder: string?
}
```

</details>

## Fields

## type

## custom_id

## style

## label

## min_length

## max_length

## required

## value

## placeholder

# ComponentObjects

https://discord.com/developers/docs/interactions/message-components#message-components

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/message-components#message-components
type ComponentObjects = ActionRowComponentObject | ButtonComponentObject | SelectMenuComponentObject | TextInputComponentObject
```

</details>

# SitckerItemObject

https://discord.com/developers/docs/resources/sticker#sticker-item-object

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/sticker#sticker-item-object
type SitckerItemObject = {
	id: Snowflake,

	name: string,

	format_type: StickerFormatType
}
```

</details>

## Fields

## id

## name

## format_type

# RoleSubscriptionDataObject

https://discord.com/developers/docs/resources/channel#role-subscription-data-object

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#role-subscription-data-object
type RoleSubscriptionDataObject = {
	role_subscription_listing_id: Snowflake,

	tier_name: string,

	total_months_subscribed: number,

	is_renewal: boolean
}
```

</details>

## Fields

## role_subscription_listing_id

## tier_name

## total_months_subscribed

## is_renewal

# PollMediaObject

https://discord.com/developers/docs/resources/poll#poll-media-object-poll-media-object-structure

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/poll#poll-media-object-poll-media-object-structure
type PollMediaObject = {
	text: string?,

	emoji: Partial<EmojiObject>?
}
```

</details>

## Fields

## text

## emoji

# PollAnswerObject

https://discord.com/developers/docs/resources/poll#poll-answer-object-poll-answer-object-structure

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/poll#poll-answer-object-poll-answer-object-structure
type PollAnswerObject = {
	answer_id: number,

	poll_media: PollMediaObject
}
```

</details>

## Fields

## answer_id

## poll_media

# PollAnswerCountObject

https://discord.com/developers/docs/resources/poll#poll-results-object-poll-answer-count-object-structure

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/poll#poll-results-object-poll-answer-count-object-structure
type PollAnswerCountObject = {
	id: number,

	count: number,

	me_voted: boolean
}
```

</details>

## Fields

## id

## count

## me_voted

# PollResultObject

https://discord.com/developers/docs/resources/poll#poll-results-object-poll-results-object-structure

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/poll#poll-results-object-poll-results-object-structure
type PollResultObject = {
	is_finalized: boolean,

	answer_counts: {PollAnswerCountObject}
}
```

</details>

## Fields

## is_finalized

## answer_counts

# PollObject

https://discord.com/developers/docs/resources/poll#poll-object

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/poll#poll-object
type PollObject = {
	question: PollMediaObject,

	answers: {PollAnswerObject},

	expiry: string?,

	--fixme: for some reason luau's type system doesn't like this being a `boolean`????
	allow_multiselect: true | false,

	layout_type: PollLayoutType,

	results: PollResultObject?
}
```

</details>

## Fields

## question

## answers

## expiry

## allow_multiselect

fixme: for some reason luau's type system doesn't like this being a `boolean`????

## layout_type

## results

# MessageCallObject

https://discord.com/developers/docs/resources/channel#message-call-object

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#message-call-object
type MessageCallObject = {
	participants: {UserObject},

	ended_timestamp: string
}
```

</details>

## Fields

## participants

## ended_timestamp

# MessageObject

https://discord.com/developers/docs/resources/channel#message-object

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#message-object
type MessageObject = {
	id: Snowflake?,

	channel_id: Snowflake?,

	author: UserObject?,

	content: string?,

	timestamp: string?,

	edited_timestamp: string?,

	tts: boolean?,

	mention_everyone: boolean?,

	mentions: {UserObject}?,

	mention_roles: {GuildRoleObject}?,

	mention_channels: {ChannelMentionObject}?,

	attachments: {AttachmentObject}?,

	embeds: {EmbedObject}?,

	reactions: {ReactionObject}?,

	nonce: string?,

	pinned: boolean?,

	webhook_id: Snowflake?,

	type: MessageType?,

	activity: MessageActivityObject?,

	application: ApplicationObject?,

	application_id: Snowflake?,

	message_reference: MessageReferenceObject?,

	flags: number?,

	referenced_message: MessageObject?,

	interaction_metadata: MessageInteractionMetadatObject?,

	interaction: MessageInteractionObject?,

	thread: ChannelObject?,

	components: {ComponentObjects}?,

	sticker_items: {SitckerItemObject}?,

	stickers: {StickerObject}?,

	position: number?,

	role_subscription_data: RoleSubscriptionDataObject?,

	resolved: ResolvedDataStructure?,

	poll: PollObject?,

	call: MessageCallObject?
}
```

</details>

## Fields

## id

## channel_id

## author

## content

## timestamp

## edited_timestamp

## tts

## mention_everyone

## mentions

## mention_roles

## mention_channels

## attachments

## embeds

## reactions

## nonce

## pinned

## webhook_id

## type

## activity

## application

## application_id

## message_reference

## flags

## referenced_message

## interaction_metadata

## interaction

## thread

## components

## sticker_items

## stickers

## position

## role_subscription_data

## resolved

## poll

## call

# ResolvedDataStructure

https://discord.com/developers/docs/interactions/receiving-and-responding#interaction-object-resolved-data-structure

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/receiving-and-responding#interaction-object-resolved-data-structure
type ResolvedDataStructure = {
	users: {UserObject}?,

	members: {GuildMemberObject}?,

	roles: {GuildRoleObject}?,

	channels: {ChannelObject}?,

	messages: {MessageObject}?,

	attachments: {AttachmentObject}?
}
```

</details>

## Fields

## users

## members

## roles

## channels

## messages

## attachments

# ApplicationCommandInteractionDataOptionObject

https://discord.com/developers/docs/interactions/receiving-and-responding#interaction-object-application-command-interaction-data-option-structure]

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/receiving-and-responding#interaction-object-application-command-interaction-data-option-structure]
type ApplicationCommandInteractionDataOptionObject = {
	name: string,

	type: ApplicationCommandOptionType,

	value: (string | number | boolean)?,

	options: {ApplicationCommandInteractionDataOptionObject},

	focused: boolean
}
```

</details>

## Fields

## name

## type

## value

## options

## focused

# InteractionDataObject

https://discord.com/developers/docs/interactions/receiving-and-responding#interaction-object-interaction-data

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/receiving-and-responding#interaction-object-interaction-data
type InteractionDataObject = {
	id: Snowflake,

	name: string,

	type: number,

	resolved: ResolvedDataStructure?,

	options: {ApplicationCommandInteractionDataOptionObject}?,

	guild_id: Snowflake?,

	target_id: Snowflake?,

	custom_id: string?,

	component_type: number?,

	values: {SelectOptionObject}?,

	components: {ComponentObjects}?
}
```

</details>

## Fields

## id

## name

## type

## resolved

## options

## guild_id

## target_id

## custom_id

## component_type

## values

## components

# InteractionObject

https://discord.com/developers/docs/interactions/receiving-and-responding#interaction-object-interaction-structure

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/receiving-and-responding#interaction-object-interaction-structure
type InteractionObject = {
	id: Snowflake,

	application_id: Snowflake,

	type: InteractionType,

	data: InteractionDataObject?,

	guild: GuildObject?,

	guild_id: Snowflake?,

	channel: ChannelObject?,

	channel_id: Snowflake?,

	member: GuildMemberObject?,

	user: UserObject?,

	token: string,

	version: number,

	message: MessageObject?,

	app_permissions: string,

	locale: LanguageLocales?,

	guild_locale: LanguageLocales?,

	entitlements: {EntitlementObject},

	authorizing_integration_owners: {IntegrationType},

	context: InteractionContextType
}
```

</details>

## Fields

## id

## application_id

## type

## data

## guild

## guild_id

## channel

## channel_id

## member

## user

## token

## version

## message

## app_permissions

## locale

## guild_locale

## entitlements

## authorizing_integration_owners

## context

# ApplicationRoleConnectionMetadataObject

https://discord.com/developers/docs/resources/application-role-connection-metadata#application-role-connection-metadata-object

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/application-role-connection-metadata#application-role-connection-metadata-object
type ApplicationRoleConnectionMetadataObject = {
	type: ApplicationRoleConnectionMetadataType,

	key: string,

	name: string,

	name_localizations: {
		[LanguageLocales]: string
	}?,

	description: string,

	description_localizations: {
		[LanguageLocales]: string
	}?
}
```

</details>

## Fields

## type

## key

## name

## name_localizations

## description

## description_localizations

# ApplicationCommandOptionChoiceObject

https://discord.com/developers/docs/interactions/application-commands#application-command-object-application-command-option-choice-structure

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/application-commands#application-command-object-application-command-option-choice-structure
type ApplicationCommandOptionChoiceObject = {
	name: string,

	name_localizations: {
		[LanguageLocales]: string
	}?,

	value: string | number
}
```

</details>

## Fields

## name

## name_localizations

## value

# ApplicationCommandOptionObject

https://discord.com/developers/docs/interactions/application-commands#application-command-object-application-command-option-structure

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/application-commands#application-command-object-application-command-option-structure
type ApplicationCommandOptionObject = {
	type: ApplicationCommandOptionType,

	name: string,

	name_localizations: {
		[LanguageLocales]: string
	}?,

	description: string?,

	description_localizations: {
		[LanguageLocales]: string
	}?,

	required: boolean?,

	choices: {ApplicationCommandOptionChoiceObject},

	options: {ApplicationCommandOptionObject}?,

	channel_types: {ChannelType}?,

	min_value: number?,

	max_value: number?,

	min_length: number?,

	max_length: number?,

	autocomplete: boolean?
}
```

</details>

## Fields

## type

## name

## name_localizations

## description

## description_localizations

## required

## choices

## options

## channel_types

## min_value

## max_value

## min_length

## max_length

## autocomplete

# ApplicationCommandObject

https://discord.com/developers/docs/interactions/application-commands#application-command-object

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/application-commands#application-command-object
type ApplicationCommandObject = {
	id: Snowflake?,

	type: ApplicationCommandType?,

	application_id: Snowflake?,

	guild_id: Snowflake?,

	name: string,

	name_localizations: {
		[LanguageLocales]: string
	}?,

	description: string,

	description_localizations: {
		[LanguageLocales]: string
	}?,

	options: {ApplicationCommandOptionObject}?,

	default_member_permissions: string?,

	dm_permission: string?,

	default_permission: boolean?,

	nsfw: boolean?,

	integration_types: {IntegrationType}?,

	contexts: {InteractionContextType}?,

	version: Snowflake?
}
```

</details>

## Fields

## id

## type

## application_id

## guild_id

## name

## name_localizations

## description

## description_localizations

## options

## default_member_permissions

## dm_permission

## default_permission

## nsfw

## integration_types

## contexts

## version

# AuditLogChangeObject

https://discord.com/developers/docs/resources/audit-log#audit-log-change-object

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/audit-log#audit-log-change-object
type AuditLogChangeObject = {
	new_value: any?,

	old_value: any?,

	key: string
}
```

</details>

## Fields

## new_value

## old_value

## key

# OptionalAuditEntryInfoObject

https://discord.com/developers/docs/resources/audit-log#audit-log-entry-object-optional-audit-entry-info

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/audit-log#audit-log-entry-object-optional-audit-entry-info
type OptionalAuditEntryInfoObject = {
	application_id: Snowflake,

	auto_moderation_rule_name: string,

	auto_moderation_rule_trigger_type: AutomoderationRuleTriggerType,

	channel_id: Snowflake,

	count: string,

	delete_member_days: string,

	id: Snowflake,

	members_removed: string,

	message_id: Snowflake,

	role_name: string,

	type: string,

	integration_type: IntegrationType
}
```

</details>

## Fields

## application_id

## auto_moderation_rule_name

## auto_moderation_rule_trigger_type

## channel_id

## count

## delete_member_days

## id

## members_removed

## message_id

## role_name

## type

## integration_type

# AuditLogEntryObject

https://discord.com/developers/docs/resources/audit-log#audit-log-entry-object

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/audit-log#audit-log-entry-object
type AuditLogEntryObject = {
	target_id: string?,

	changes: {AuditLogChangeObject}?,

	user_id: Snowflake?,

	id: Snowflake,

	action_type: AuditLogEventType,

	options: {OptionalAuditEntryInfoObject}?,

	reason: string?
}
```

</details>

## Fields

## target_id

## changes

## user_id

## id

## action_type

## options

## reason

# WebhookObject

https://discord.com/developers/docs/resources/webhook#webhook-object

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/webhook#webhook-object
type WebhookObject = {
	id: Snowflake,

	type: WebhookType,

	guild_id: Snowflake?,

	channel_id: Snowflake?,

	user: UserObject?,

	name: string?,

	avatar: string?,

	token: string?,

	application_id: Snowflake?,

	source_guild: GuildObject?,

	source_channel: ChannelObject?,

	url: string?
}
```

</details>

## Fields

## id

## type

## guild_id

## channel_id

## user

## name

## avatar

## token

## application_id

## source_guild

## source_channel

## url

# AuditLogObject

https://discord.com/developers/docs/resources/audit-log#audit-log-object

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/audit-log#audit-log-object
type AuditLogObject = {
	application_commands: {ApplicationCommandObject},

	audit_log_entries: {AuditLogEntryObject},

	auto_moderation_rules: {AutomoderationRuleObject},

	guild_scheduled_events: {GuildScheduledEventObject},

	integrations: {IntegrationObject},

	threads: {ChannelObject},

	users: {UserObject},

	webhooks: {WebhookObject}
}
```

</details>

## Fields

## application_commands

## audit_log_entries

## auto_moderation_rules

## guild_scheduled_events

## integrations

## threads

## users

## webhooks

# InviteObject

https://discord.com/developers/docs/resources/invite#invite-object

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/invite#invite-object
type InviteObject = {
	type: InviteTypes,

	code: string,

	guild: GuildObject?,

	channel: ChannelObject?,

	inviter: UserObject?,

	target_type: InviteTargetTypes,

	target_user: UserObject?,

	target_application: ApplicationObject?,

	approximate_presence_count: number?,

	approximate_member_count: number?,

	expires_at: string?,

	stage_instance: StageInstanceObject?,

	guild_scheduled_event: GuildScheduledEventObject?
}
```

</details>

## Fields

## type

## code

## guild

## channel

## inviter

## target_type

## target_user

## target_application

## approximate_presence_count

## approximate_member_count

## expires_at

## stage_instance

## guild_scheduled_event

# GuildVanityUrl

https://discord.com/developers/docs/resources/guild#get-guild-vanity-url

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#get-guild-vanity-url
type GuildVanityUrl = {
	code: string,

	uses: number
}
```

</details>

## Fields

## code

## uses

# InviteMetadataObject

https://discord.com/developers/docs/resources/invite#invite-metadata-object

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/invite#invite-metadata-object
type InviteMetadataObject = {
	uses: number,

	max_uses: number,

	max_age: number,

	temporary: boolean,

	created_at: string
}
```

</details>

## Fields

## uses

## max_uses

## max_age

## temporary

## created_at

# FollowedChannelObject

https://discord.com/developers/docs/resources/channel#followed-channel-object

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#followed-channel-object
type FollowedChannelObject = {
	channel_id: Snowflake,

	webhook_id: Snowflake
}
```

</details>

## Fields

## channel_id

## webhook_id

# GuildPreviewObject

https://discord.com/developers/docs/resources/guild#guild-preview-object

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#guild-preview-object
type GuildPreviewObject = {
	id: Snowflake,

	name: string,

	icon: string?,

	splash: string?,

	discovery_splash: string?,

	emojis: {EmojiObject},

	features: {GuildFeature},

	approximate_member_count: number,

	approximate_presence_count: number,

	description: string?,

	stickers: {StickerObject}
}
```

</details>

## Fields

## id

## name

## icon

## splash

## discovery_splash

## emojis

## features

## approximate_member_count

## approximate_presence_count

## description

## stickers

# BanObject

https://discord.com/developers/docs/resources/guild#ban-object

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#ban-object
type BanObject = {
	reason: string?,

	user: UserObject
}
```

</details>

## Fields

## reason

## user

# VoiceRegionObject

https://discord.com/developers/docs/resources/voice#voice-region-object

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/voice#voice-region-object
type VoiceRegionObject = {
	id: string,

	name: string,

	optimal: boolean,

	deprecated: boolean,

	custom: boolean
}
```

</details>

## Fields

## id

## name

## optimal

## deprecated

## custom

# GuildWidgetSettingsObject

https://discord.com/developers/docs/resources/guild#guild-widget-settings-object

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#guild-widget-settings-object
type GuildWidgetSettingsObject = {
	enabled: boolean?,

	channel_id: Snowflake?
}
```

</details>

## Fields

## enabled

## channel_id

# GuildWidgetObject

https://discord.com/developers/docs/resources/guild#guild-widget-object

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#guild-widget-object
type GuildWidgetObject = {
	id: Snowflake,

	name: string,

	instant_invite: string?,

	channels: {ChannelObject},

	members: {UserObject},

	presence_count: number
}
```

</details>

## Fields

## id

## name

## instant_invite

## channels

## members

## presence_count

# PromptOptionObject

https://discord.com/developers/docs/resources/guild#guild-onboarding-object-prompt-option-structure

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#guild-onboarding-object-prompt-option-structure
type PromptOptionObject = {
	id: Snowflake?,

	channel_ids: {Snowflake},

	role_ids: {Snowflake},

	emoji: EmojiObject | nil,

	emoji_id: Snowflake?,

	emoji_name: string?,

	emoji_animated: boolean?,

	title: string?,

	description: string?
}
```

</details>

## Fields

## id

## channel_ids

## role_ids

## emoji

## emoji_id

## emoji_name

## emoji_animated

## title

## description

# OnboardingPromptObject

https://discord.com/developers/docs/resources/guild#guild-onboarding-object-onboarding-prompt-structure

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#guild-onboarding-object-onboarding-prompt-structure
type OnboardingPromptObject = {
	id: Snowflake | nil,

	type: PromptTypes?,

	options: {PromptOptionObject},

	title: string?,

	single_select: boolean?,

	required: boolean?,

	in_onboarding: boolean?
}
```

</details>

## Fields

## id

## type

## options

## title

## single_select

## required

## in_onboarding

# GuildOnboardingObject

https://discord.com/developers/docs/resources/guild#guild-onboarding-object

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#guild-onboarding-object
type GuildOnboardingObject = {
	guild_id: Snowflake,

	prompts: {OnboardingPromptObject},

	default_channel_ids: {Snowflake},

	enabled: boolean,

	mode: OnboardingMode
}
```

</details>

## Fields

## guild_id

## prompts

## default_channel_ids

## enabled

## mode

# GuildScheduledEventUserObject

https://discord.com/developers/docs/resources/guild-scheduled-event#guild-scheduled-event-user-object

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild-scheduled-event#guild-scheduled-event-user-object
type GuildScheduledEventUserObject = {
	guild_scheduled_event_id: Snowflake,

	user: UserObject,

	member: GuildMemberObject?
}
```

</details>

## Fields

## guild_scheduled_event_id

## user

## member

# GuildTemplateObject

https://discord.com/developers/docs/resources/guild-template#guild-template-object

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild-template#guild-template-object
type GuildTemplateObject = {
	code: string,

	name: string,

	description: string?,

	usage_count: number,

	creator_id: Snowflake,

	creator: UserObject,

	created_at: string,

	updated_at: string,

	source_guild_id: Snowflake,

	serialized_source_guild: GuildObject,

	is_dirty: boolean?
}
```

</details>

## Fields

## code

## name

## description

## usage_count

## creator_id

## creator

## created_at

## updated_at

## source_guild_id

## serialized_source_guild

## is_dirty

# StickerPackObject

https://discord.com/developers/docs/resources/sticker#sticker-pack-object

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/sticker#sticker-pack-object
type StickerPackObject = {
	id: Snowflake,

	stickers: {StickerObject},

	name: string,

	sku_id: Snowflake,

	cover_sticker_id: Snowflake?,

	description: string,

	banner_asset_id: Snowflake?
}
```

</details>

## Fields

## id

## stickers

## name

## sku_id

## cover_sticker_id

## description

## banner_asset_id

# IntegrationApplicationObject

https://discord.com/developers/docs/resources/guild#integration-application-object

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#integration-application-object
type IntegrationApplicationObject = {
	id: Snowflake,

	name: string,

	icon: string?,

	description: string,

	bot: UserObject?
}
```

</details>

## Fields

## id

## name

## icon

## description

## bot

# ConnectionObject

https://discord.com/developers/docs/resources/user#connection-object

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/user#connection-object
type ConnectionObject = {
	id: string,

	name: string,

	type: ConnectionObjectServices,

	revoked: boolean?,

	integrations: {IntegrationObject}?,

	verified: boolean,

	friend_sync: boolean,

	show_Activity: boolean,

	two_way_link: boolean,

	visibility: ConnectionVisibilityTypes
}
```

</details>

## Fields

## id

## name

## type

## revoked

## integrations

## verified

## friend_sync

## show_Activity

## two_way_link

## visibility

# ApplicationRoleConnectionObject

https://discord.com/developers/docs/resources/user#application-role-connection-object

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/user#application-role-connection-object
type ApplicationRoleConnectionObject = {
	platform_name: string?,

	platform_username: string?,

	metadata: ApplicationRoleConnectionMetadataObject
}
```

</details>

## Fields

## platform_name

## platform_username

## metadata

# SessionStartLimitObject

https://discord.com/developers/docs/topics/gateway#session-start-limit-object

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/topics/gateway#session-start-limit-object
type SessionStartLimitObject = {
	total: number,

	remaining: number,

	reset_after: number,

	max_concurrency: number
}
```

</details>

## Fields

## total

## remaining

## reset_after

## max_concurrency

# AllowedMentionObject

https://discord.com/developers/docs/resources/channel#allowed-mentions-object

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#allowed-mentions-object
type AllowedMentionObject = {
	parse: {AllowedMentionTypes}?,

	users: {string}?,

	roles: {string}?,

	replied_user: boolean?
}
```

</details>

## Fields

## parse

## users

## roles

## replied_user

# ForumAndMediaThreadMessageObject

https://discord.com/developers/docs/resources/channel#start-thread-in-forum-or-media-channel-forum-and-media-thread-message-params-object

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#start-thread-in-forum-or-media-channel-forum-and-media-thread-message-params-object
type ForumAndMediaThreadMessageObject = {
	content: string?,

	embeds: {EmbedObject}?,

	allowed_mentions: AllowedMentionObject?,

	components: {ComponentObjects}?,

	sticker_ids: {Snowflake}?,

	attachments: {AttachmentObject}?,

	flags: number?
}
```

</details>

## Fields

## content

## embeds

## allowed_mentions

## components

## sticker_ids

## attachments

## flags

# InteractionCallbackAutocompleteObject

https://discord.com/developers/docs/interactions/receiving-and-responding#interaction-response-object-interaction-callback-data-structure

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/receiving-and-responding#interaction-response-object-interaction-callback-data-structure
type InteractionCallbackAutocompleteObject = {
	choices: {ApplicationCommandOptionChoiceObject}?
}
```

</details>

## Fields

## choices

# InteractionCallbackModalObject

https://discord.com/developers/docs/interactions/receiving-and-responding#interaction-response-object-interaction-callback-data-structure

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/receiving-and-responding#interaction-response-object-interaction-callback-data-structure
type InteractionCallbackModalObject = {
	custom_id: string?,

	title: string?,

	components: {ComponentObjects}
}
```

</details>

## Fields

## custom_id

## title

## components

# InteractionResponseObject

https://discord.com/developers/docs/interactions/receiving-and-responding#interaction-response-object-interaction-callback-type

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/receiving-and-responding#interaction-response-object-interaction-callback-type
type InteractionResponseObject = {
	type: InteractionCallbackType,

	data: (Partial<MessageObject> | InteractionCallbackAutocompleteObject | InteractionCallbackModalObject)?
}
```

</details>

## Fields

## type

## data

---


