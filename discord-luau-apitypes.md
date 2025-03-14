# Types

## Partial

<details>
<summary>Raw Type</summary>

```luau
type Partial<T> = MakePartial<T>
```

</details>

## Snowflake

<details>
<summary>Raw Type</summary>

```luau
type Snowflake = string
```

</details>

## PremiumTypes

https://discord.com/developers/docs/resources/user#user-object-premium-types

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/user#user-object-premium-types
type PremiumTypes = number
```

</details>

## LanguageLocales

https://discord.com/developers/docs/reference#locales

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/reference#locales
type LanguageLocales = "id" | "da" | "de" | "en-GB" | "en-US" | "es-ES" | "fr" | "hr" | "it" | "lt" | "nl" | "no" | "pl" | "pt-BR" | "ro" | "fi" | "sv-SE" | "vi" | "tr" | "cs" | "el" | "bg" | "ru" | "uk" | "hi" | "th" | "zn-CH" | "ja" | "ko"
```

</details>

## MembershipState

https://discord.com/developers/docs/topics/teams#data-models-membership-state-enum

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/topics/teams#data-models-membership-state-enum
type MembershipState = number
```

</details>

## TeamMemberRole

https://discord.com/developers/docs/topics/teams#data-models-membership-state-enum

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/topics/teams#data-models-membership-state-enum
type TeamMemberRole = "Owner" | "Admin" | "Developer" | "Read-only"
```

</details>

## VerificationLevel

https://discord.com/developers/docs/resources/guild#guild-object-verification-level

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#guild-object-verification-level
type VerificationLevel = number
```

</details>

## DefaultMessageNotification

https://discord.com/developers/docs/resources/guild#guild-object-default-message-notification-level

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#guild-object-default-message-notification-level
type DefaultMessageNotification = number
```

</details>

## ExplicitContentFilterLevel

https://discord.com/developers/docs/resources/guild#guild-object-explicit-content-filter-level

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#guild-object-explicit-content-filter-level
type ExplicitContentFilterLevel = number
```

</details>

## MFALevel

https://discord.com/developers/docs/resources/guild#guild-object-explicit-content-filter-level

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#guild-object-explicit-content-filter-level
type MFALevel = number
```

</details>

## GuildNSFWLevel

https://discord.com/developers/docs/resources/guild#guild-object-guild-nsfw-level

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#guild-object-guild-nsfw-level
type GuildNSFWLevel = number
```

</details>

## PremiumTier

https://discord.com/developers/docs/resources/guild#guild-object-premium-tier

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#guild-object-premium-tier
type PremiumTier = number
```

</details>

## SystemChannelFlags

https://discord.com/developers/docs/resources/guild#guild-object-system-channel-flags

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#guild-object-system-channel-flags
type SystemChannelFlags = number
```

</details>

## GuildFeature

https://discord.com/developers/docs/resources/guild#guild-object-guild-features

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#guild-object-guild-features
type GuildFeature = "ANIMATED_BANNER" | "ANIMATED_ICON" | "APPLICATION_COMMAND_PERMISSIONS_V2" | "AUTO_MODERATION" | "BANNER" | "COMMUNITY" | "CREATOR_MONETIZABLE_PROVISIONAL" | "CREATOR_STORE_PAGE" | "DEVELOPER_SUPPORT_SERVER" | "DISCOVERABLE" | "FEATURABLE" | "INVITES_DISABLED" | "INVITE_SPLASH" | "MEMBER_VERIFICATION_GATE_ENABLED" | "MORE_STICKERS" | "NEWS" | "PARTNERED" | "PREVIEW_ENABLED" | "RAID_ALERTS_DISABLED" | "ROLE_ICONS" | "ROLE_SUBSCRIPTIONS_AVAILABLE_FOR_PURCHASE" | "ROLE_SUBSCRIPTIONS_ENABLED" | "TICKETED_EVENTS_ENABLED" | "VANITY_URL" | "VERIFIED" | "VIP_REGIONS" | "WELCOME_SCREEN_ENABLED"
```

</details>

## MutableGuildFeatures

https://discord.com/developers/docs/resources/guild#guild-object-mutable-guild-features

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#guild-object-mutable-guild-features
type MutableGuildFeatures = "COMMUNITY" | "DISCOVERABLE" | "INVITES_DISABLED" | "RAID_ALERTS_DISABLED"
```

</details>

## StickerType

https://discord.com/developers/docs/resources/sticker#sticker-object-sticker-types

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/sticker#sticker-object-sticker-types
type StickerType = number
```

</details>

## StickerFormatType

https://discord.com/developers/docs/resources/sticker#sticker-object-sticker-format-types

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/sticker#sticker-object-sticker-format-types
type StickerFormatType = number
```

</details>

## OAuth2Scopes

https://discord.com/developers/docs/topics/oauth2#shared-resources-oauth2-scopes

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/topics/oauth2#shared-resources-oauth2-scopes
type OAuth2Scopes = "activities.read" | "activities.write" | "applications.builds.read" | "applications.builds.upload" | "applications.commands" | "applications.commands.update" | "applications.commands.permissions.update" | "applications.entitlements" | "applications.store.update" | "bot" | "connections" | "dm_channels.read" | "email" | "gdm.join" | "guilds" | "guilds.join" | "guilds.members.read" | "identify" | "messages.read" | "relationships.read" | "role_connections.write" | "rpc" | "rpc.activities.write" | "rpc.notifications.read" | "rpc.voice.read" | "rpc.voice.write" | "voice" | "webhook.incoming"
```

</details>

## IntegrationType

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

## ApplicationIntegrationType

https://discord.com/developers/docs/resources/application#application-object-application-integration-types

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/application#application-object-application-integration-types
type ApplicationIntegrationType = number
```

</details>

## ApplicationCommandPermissionType

https://discord.com/developers/docs/interactions/application-commands#application-command-permissions-object-application-command-permission-type

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/application-commands#application-command-permissions-object-application-command-permission-type
type ApplicationCommandPermissionType = number
```

</details>

## AutomoderationRuleEventType

https://discord.com/developers/docs/resources/auto-moderation#auto-moderation-rule-object-event-types

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/auto-moderation#auto-moderation-rule-object-event-types
type AutomoderationRuleEventType = number
```

</details>

## AutomoderationRuleTriggerType

https://discord.com/developers/docs/resources/auto-moderation#auto-moderation-rule-object-trigger-types

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/auto-moderation#auto-moderation-rule-object-trigger-types
type AutomoderationRuleTriggerType = number
```

</details>

## AutomoderationRuleKeywordPresetType

https://discord.com/developers/docs/resources/auto-moderation#auto-moderation-rule-object-keyword-preset-types

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/auto-moderation#auto-moderation-rule-object-keyword-preset-types
type AutomoderationRuleKeywordPresetType = number
```

</details>

## AutomoderationActionType

https://discord.com/developers/docs/resources/auto-moderation#auto-moderation-action-object-action-types

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/auto-moderation#auto-moderation-action-object-action-types
type AutomoderationActionType = number
```

</details>

## ChannelType

https://discord.com/developers/docs/resources/channel#channel-object-channel-types

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#channel-object-channel-types
type ChannelType = number
```

</details>

## VideoQualityMode

https://discord.com/developers/docs/resources/channel#channel-object-video-quality-modes

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#channel-object-video-quality-modes
type VideoQualityMode = number
```

</details>

## ChannelFlags

https://discord.com/developers/docs/resources/channel#channel-object-channel-flags

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#channel-object-channel-flags
type ChannelFlags = number
```

</details>

## SortOrderType

https://discord.com/developers/docs/resources/channel#channel-object-sort-order-types

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#channel-object-sort-order-types
type SortOrderType = number
```

</details>

## ForumLayoutType

https://discord.com/developers/docs/resources/channel#channel-object-forum-layout-types

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#channel-object-forum-layout-types
type ForumLayoutType = number
```

</details>

## OverwriteObjectType

https://discord.com/developers/docs/resources/channel#overwrite-object

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#overwrite-object
type OverwriteObjectType = number
```

</details>

## EntitlementType

https://discord.com/developers/docs/monetization/entitlements#entitlement-object-entitlement-types

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/monetization/entitlements#entitlement-object-entitlement-types
type EntitlementType = number
```

</details>

## ActivityType

https://discord.com/developers/docs/topics/gateway-events#activity-object-activity-types

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/topics/gateway-events#activity-object-activity-types
type ActivityType = number
```

</details>

## PrivacyLevel

https://discord.com/developers/docs/resources/stage-instance#stage-instance-object-privacy-level

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/stage-instance#stage-instance-object-privacy-level
type PrivacyLevel = number
```

</details>

## GuildScheduledEventStatus

https://discord.com/developers/docs/resources/guild-scheduled-event#guild-scheduled-event-object-guild-scheduled-event-status

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild-scheduled-event#guild-scheduled-event-object-guild-scheduled-event-status
type GuildScheduledEventStatus = number
```

</details>

## GuildScheduledEventEntityType

https://discord.com/developers/docs/resources/guild-scheduled-event#guild-scheduled-event-object-guild-scheduled-event-entity-types

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild-scheduled-event#guild-scheduled-event-object-guild-scheduled-event-entity-types
type GuildScheduledEventEntityType = number
```

</details>

## IntegrationExpireBehaviours

https://discord.com/developers/docs/resources/guild#integration-object-integration-expire-behaviors

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#integration-object-integration-expire-behaviors
type IntegrationExpireBehaviours = number
```

</details>

## InteractionType

https://discord.com/developers/docs/interactions/receiving-and-responding#interaction-object-interaction-type

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/receiving-and-responding#interaction-object-interaction-type
type InteractionType = number
```

</details>

## EmbedType

https://discord.com/developers/docs/resources/message#embed-object-embed-types

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/message#embed-object-embed-types
type EmbedType = "Rich" | "Image" | "Video" | "GIFV" | "Article" | "Link" | "PollResult"
```

</details>

## MessageType

https://discord.com/developers/docs/resources/channel#message-object-message-types

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#message-object-message-types
type MessageType = number
```

</details>

## MessageActivityType

https://discord.com/developers/docs/resources/channel#message-object-message-activity-types

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#message-object-message-activity-types
type MessageActivityType = number
```

</details>

## ButtonStyle

https://discord.com/developers/docs/interactions/message-components#button-object-button-styles

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/message-components#button-object-button-styles
type ButtonStyle = number
```

</details>

## TextInputStyles

https://discord.com/developers/docs/interactions/message-components#text-input-object-text-input-styles

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/message-components#text-input-object-text-input-styles
type TextInputStyles = number
```

</details>

## PollLayoutType

https://discord.com/developers/docs/resources/poll#layout-type

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/poll#layout-type
type PollLayoutType = number
```

</details>

## ApplicationCommandOptionType

https://discord.com/developers/docs/interactions/application-commands#application-command-object-application-command-option-type

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/application-commands#application-command-object-application-command-option-type
type ApplicationCommandOptionType = number
```

</details>

## InteractionContextType

https://discord.com/developers/docs/interactions/receiving-and-responding#interaction-object-interaction-context-types

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/receiving-and-responding#interaction-object-interaction-context-types
type InteractionContextType = number
```

</details>

## InviteTypes

https://discord.com/developers/docs/resources/invite#invite-object-invite-types

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/invite#invite-object-invite-types
type InviteTypes = number
```

</details>

## InviteTargetTypes

https://discord.com/developers/docs/resources/invite#invite-object-invite-target-types

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/invite#invite-object-invite-target-types
type InviteTargetTypes = number
```

</details>

## ReactionType

https://discord.com/developers/docs/resources/channel#get-reactions-reaction-types

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#get-reactions-reaction-types
type ReactionType = number
```

</details>

## ApplicationRoleConnectionMetadataType

https://discord.com/developers/docs/resources/application-role-connection-metadata#application-role-connection-metadata-object-application-role-connection-metadata-type

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/application-role-connection-metadata#application-role-connection-metadata-object-application-role-connection-metadata-type
type ApplicationRoleConnectionMetadataType = number
```

</details>

## ApplicationCommandType

https://discord.com/developers/docs/interactions/application-commands#application-command-object-application-command-types

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/application-commands#application-command-object-application-command-types
type ApplicationCommandType = number
```

</details>

## AuditLogEventType

https://discord.com/developers/docs/resources/audit-log#audit-log-entry-object-audit-log-events

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/audit-log#audit-log-entry-object-audit-log-events
type AuditLogEventType = number
```

</details>

## WebhookType

https://discord.com/developers/docs/resources/webhook#webhook-object-webhook-types

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/webhook#webhook-object-webhook-types
type WebhookType = number
```

</details>

## OnboardingMode

https://discord.com/developers/docs/resources/guild#guild-onboarding-object-onboarding-mode

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#guild-onboarding-object-onboarding-mode
type OnboardingMode = number
```

</details>

## PromptTypes

https://discord.com/developers/docs/resources/guild#guild-onboarding-object-prompt-types

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#guild-onboarding-object-prompt-types
type PromptTypes = number
```

</details>

## ConnectionObjectServices

https://discord.com/developers/docs/resources/user#connection-object-services

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/user#connection-object-services
type ConnectionObjectServices = "battlenet" | "bungie" | "domain" | "ebay" | "epicgames" | "facebook" | "github" | "instagram" | "leagueoflegends" | "paypal" | "playstation" | "reddit" | "riotgames" | "spotify" | "skype" | "stream" | "tiktok" | "twitch" | "twitter" | "xbox" | "youtube"
```

</details>

## AllowedMentionTypes

https://discord.com/developers/docs/resources/channel#allowed-mentions-object-allowed-mention-types

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#allowed-mentions-object-allowed-mention-types
type AllowedMentionTypes = "roles" | "users" | "everyone"
```

</details>

## ConnectionVisibilityTypes

https://discord.com/developers/docs/resources/user#connection-object-visibility-types

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/user#connection-object-visibility-types
type ConnectionVisibilityTypes = number
```

</details>

## MessageReferenceType

https://discord.com/developers/docs/resources/channel#message-reference-types

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#message-reference-types
type MessageReferenceType = number
```

</details>

## GuildMemberFlags

https://discord.com/developers/docs/resources/guild#guild-member-object-guild-member-flags

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#guild-member-object-guild-member-flags
type GuildMemberFlags = number
```

</details>

## InteractionCallbackType

https://discord.com/developers/docs/interactions/receiving-and-responding#interaction-response-object-interaction-callback-type

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/receiving-and-responding#interaction-response-object-interaction-callback-type
type InteractionCallbackType = number
```

</details>

## ActivityTimestampObject

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

### start

Field with the following constraints:

- Type: number
- Constraints: None

### ["end"]

Field with the following constraints:

- Type: number
- Constraints: None

## ActivityEmojiObject

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

### name

Field with the following constraints:

- Type: string
- Constraints: None

### id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### animated

Field with the following constraints:

- Type: boolean
- Constraints: None

## ActivityPartyObject

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

### id

Field with the following constraints:

- Type: string
- Constraints: None

### size

Field with the following constraints:

- Type: number
- Constraints: None

## ActivityAssetsObject

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

### large_image

Field with the following constraints:

- Type: string
- Constraints: None

### large_text

Field with the following constraints:

- Type: string
- Constraints: None

### small_image

Field with the following constraints:

- Type: string
- Constraints: None

### small_text

Field with the following constraints:

- Type: string
- Constraints: None

## ActivitySecretsObject

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

### join

Field with the following constraints:

- Type: string
- Constraints: None

### spectate

Field with the following constraints:

- Type: string
- Constraints: None

### match

Field with the following constraints:

- Type: string
- Constraints: None

## ActivityButtonsObject

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

### label

Field with the following constraints:

- Type: string
- Constraints: None

### url

Field with the following constraints:

- Type: string
- Constraints: None

## ActivityObject

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

### name

Field with the following constraints:

- Type: string
- Constraints: None

### type

Field with the following constraints:

- Type: number
- Constraints: None

### url

Field with the following constraints:

- Type: string
- Constraints: None

### created_at

Field with the following constraints:

- Type: number
- Constraints: None

### timestamps

Field with the following constraints:

- Type: ActivityTimestampObject
- Constraints: None

### application_id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### details

Field with the following constraints:

- Type: string
- Constraints: None

### state

Field with the following constraints:

- Type: string
- Constraints: None

### emoji

Field with the following constraints:

- Type: ActivityEmojiObject
- Constraints: None

### party

Field with the following constraints:

- Type: ActivityPartyObject
- Constraints: None

### assets

Field with the following constraints:

- Type: ActivityAssetsObject
- Constraints: None

### secrets

Field with the following constraints:

- Type: ActivitySecretsObject
- Constraints: None

### instance

Field with the following constraints:

- Type: boolean
- Constraints: None

### flags

Field with the following constraints:

- Type: number
- Constraints: None

### buttons

Field with the following constraints:

- Type: ActivityButtonsObject
- Constraints: None

## PresenceObject

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

### since

Field with the following constraints:

- Type: number
- Constraints: None

### activities

Field with the following constraints:

- Type: ActivityObject
- Constraints: None

### status

Field with the following constraints:

- Type: string
- Constraints: None

### afk

Field with the following constraints:

- Type: boolean
- Constraints: None

## IdentifyPropertiesObject

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

### os

Field with the following constraints:

- Type: string
- Constraints: None

### browser

Field with the following constraints:

- Type: string
- Constraints: None

### device

Field with the following constraints:

- Type: string
- Constraints: None

## AvatarDecorationDataObject

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

### asset

Field with the following constraints:

- Type: string
- Constraints: None

### sku_id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

## UserObject

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

### id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### username

Field with the following constraints:

- Type: string
- Constraints: None

### discriminator

Field with the following constraints:

- Type: string
- Constraints: None

### global_name

Field with the following constraints:

- Type: string
- Constraints: None

### avatar

Field with the following constraints:

- Type: string
- Constraints: None

### bot

Field with the following constraints:

- Type: boolean
- Constraints: None

### system

Field with the following constraints:

- Type: boolean
- Constraints: None

### mfa_enabled

Field with the following constraints:

- Type: boolean
- Constraints: None

### banner

Field with the following constraints:

- Type: string
- Constraints: None

### accent_color

Field with the following constraints:

- Type: number
- Constraints: None

### locale

Field with the following constraints:

- Type: LanguageLocales
- Constraints: None

### verified

Field with the following constraints:

- Type: boolean
- Constraints: None

### email

Field with the following constraints:

- Type: string
- Constraints: None

### flags

Field with the following constraints:

- Type: number
- Constraints: None

### premium_type

Field with the following constraints:

- Type: PremiumTypes
- Constraints: None

### public_flags

Field with the following constraints:

- Type: number
- Constraints: None

### avatar_decoration_data

Field with the following constraints:

- Type: AvatarDecorationDataObject
- Constraints: None

## UnavailableGuildObject

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

### id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### unavailable

Field with the following constraints:

- Type: boolean
- Constraints: None

## TeamMemberObject

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

### membership_state

Field with the following constraints:

- Type: MembershipState
- Constraints: None

### team_id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### user

Field with the following constraints:

- Type: UserObject
- Constraints: None

### role

Field with the following constraints:

- Type: TeamMemberRole
- Constraints: None

## TeamObject

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

### icon

Field with the following constraints:

- Type: string
- Constraints: None

### id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### members

Field with the following constraints:

- Type: TeamMemberObject
- Constraints: None

### name

Field with the following constraints:

- Type: string
- Constraints: None

### owner_user_id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

## GuildRoleTagObject

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

### bot_id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### integration_id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### premium_subscriber

Field with the following constraints:

- Type: nil
- Constraints: None

### subscription_listing_id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### available_for_purchase

Field with the following constraints:

- Type: nil
- Constraints: None

### guild_connections

Field with the following constraints:

- Type: nil
- Constraints: None

## GuildRoleObject

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

### id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### name

Field with the following constraints:

- Type: string
- Constraints: None

### color

Field with the following constraints:

- Type: number
- Constraints: None

### hoist

Field with the following constraints:

- Type: boolean
- Constraints: None

### icon

Field with the following constraints:

- Type: string
- Constraints: None

### unicode_emoji

Field with the following constraints:

- Type: string
- Constraints: None

### position

Field with the following constraints:

- Type: number
- Constraints: None

### permissions

Field with the following constraints:

- Type: string
- Constraints: None

### managed

Field with the following constraints:

- Type: boolean
- Constraints: None

### mentionable

Field with the following constraints:

- Type: boolean
- Constraints: None

### tags

Field with the following constraints:

- Type: GuildRoleTagObject
- Constraints: None

### flags

Field with the following constraints:

- Type: number
- Constraints: None

## EmojiObject

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

### id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### name

Field with the following constraints:

- Type: string
- Constraints: None

### roles

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### user

Field with the following constraints:

- Type: UserObject
- Constraints: None

### require_colons

Field with the following constraints:

- Type: boolean
- Constraints: None

### managed

Field with the following constraints:

- Type: boolean
- Constraints: None

### animated

Field with the following constraints:

- Type: boolean
- Constraints: None

### available

Field with the following constraints:

- Type: boolean
- Constraints: None

## WelcomeScreenChannelObject

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

### channel_id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### description

Field with the following constraints:

- Type: string
- Constraints: None

### emoji_id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### emoji_name

Field with the following constraints:

- Type: string
- Constraints: None

## WelcomeScreenObject

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

### description

Field with the following constraints:

- Type: string
- Constraints: None

### welcome_channels

Field with the following constraints:

- Type: WelcomeScreenChannelObject
- Constraints: None

## StickerObject

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

### id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### pack_id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### name

Field with the following constraints:

- Type: string
- Constraints: None

### description

Field with the following constraints:

- Type: string
- Constraints: None

### tags

Field with the following constraints:

- Type: string
- Constraints: None

### asset

Field with the following constraints:

- Type: string
- Constraints: None

### type

Field with the following constraints:

- Type: StickerType
- Constraints: None

### format_type

Field with the following constraints:

- Type: StickerFormatType
- Constraints: None

### available

Field with the following constraints:

- Type: boolean
- Constraints: None

### guild_id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### user

Field with the following constraints:

- Type: UserObject
- Constraints: None

### sort_value

Field with the following constraints:

- Type: number
- Constraints: None

## GuildObject

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

### id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### name

Field with the following constraints:

- Type: string
- Constraints: None

### icon

Field with the following constraints:

- Type: string
- Constraints: None

### icon_hash

Field with the following constraints:

- Type: string
- Constraints: None

### splash

Field with the following constraints:

- Type: string
- Constraints: None

### discovery_splash

Field with the following constraints:

- Type: string
- Constraints: None

### owner

Field with the following constraints:

- Type: boolean
- Constraints: None

### owner_id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### permissions

Field with the following constraints:

- Type: string
- Constraints: None

### region

Field with the following constraints:

- Type: string
- Constraints: None

### afk_channel_id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### afk_timeout

Field with the following constraints:

- Type: number
- Constraints: None

### widget_enabled

Field with the following constraints:

- Type: boolean
- Constraints: None

### widget_channel_id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### verification_level

Field with the following constraints:

- Type: VerificationLevel
- Constraints: None

### default_message_notifications

Field with the following constraints:

- Type: DefaultMessageNotification
- Constraints: None

### explicit_content_filter

Field with the following constraints:

- Type: ExplicitContentFilterLevel
- Constraints: None

### roles

Field with the following constraints:

- Type: GuildRoleObject
- Constraints: None

### emojis

Field with the following constraints:

- Type: EmojiObject
- Constraints: None

### features

Field with the following constraints:

- Type: GuildFeature
- Constraints: None

### mfa_level

Field with the following constraints:

- Type: MFALevel
- Constraints: None

### application_id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### system_channel_id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### system_channel_flags

Field with the following constraints:

- Type: SystemChannelFlags
- Constraints: None

### rules_channel_id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### max_presences

Field with the following constraints:

- Type: number
- Constraints: None

### max_members

Field with the following constraints:

- Type: number
- Constraints: None

### vanity_url_code

Field with the following constraints:

- Type: string
- Constraints: None

### description

Field with the following constraints:

- Type: string
- Constraints: None

### banner

Field with the following constraints:

- Type: string
- Constraints: None

### premium_tier

Field with the following constraints:

- Type: PremiumTier
- Constraints: None

### premium_subscription_count

Field with the following constraints:

- Type: number
- Constraints: None

### preferred_locale

Field with the following constraints:

- Type: LanguageLocales
- Constraints: None

### public_updates_channel_id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### max_video_channel_users

Field with the following constraints:

- Type: number
- Constraints: None

### max_stage_video_channel_users

Field with the following constraints:

- Type: number
- Constraints: None

### approximate_member_count

Field with the following constraints:

- Type: number
- Constraints: None

### approximate_presence_count

Field with the following constraints:

- Type: number
- Constraints: None

### welcome_screen

Field with the following constraints:

- Type: WelcomeScreenObject
- Constraints: None

### nsfw_level

Field with the following constraints:

- Type: GuildNSFWLevel
- Constraints: None

### stickers

Field with the following constraints:

- Type: StickerObject
- Constraints: None

### premium_progress_bar_enabled

Field with the following constraints:

- Type: boolean
- Constraints: None

### safety_alerts_channel_id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

## InstallParamsObject

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

### scopes

Field with the following constraints:

- Type: OAuth2Scopes
- Constraints: None

### permissions

Field with the following constraints:

- Type: string
- Constraints: None

## ApplicationObject

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

### id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### name

Field with the following constraints:

- Type: string
- Constraints: None

### icon

Field with the following constraints:

- Type: string
- Constraints: None

### description

Field with the following constraints:

- Type: string
- Constraints: None

### rpc_origins

Field with the following constraints:

- Type: string
- Constraints: None

### bot_public

Field with the following constraints:

- Type: boolean
- Constraints: None

### bot_require_code_grant

Field with the following constraints:

- Type: boolean
- Constraints: None

### bot

Field with the following constraints:

- Type: UserObject
- Constraints: None

### terms_of_service_url

Field with the following constraints:

- Type: string
- Constraints: None

### privacy_policy_url

Field with the following constraints:

- Type: string
- Constraints: None

### owner

Field with the following constraints:

- Type: UserObject
- Constraints: None

### summary

Field with the following constraints:

- Type: string
- Constraints: None

### verify_key

Field with the following constraints:

- Type: string
- Constraints: None

### team

Field with the following constraints:

- Type: TeamObject
- Constraints: None

### guild_id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### guild

Field with the following constraints:

- Type: GuildObject
- Constraints: None

### primary_sku_id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### slug

Field with the following constraints:

- Type: string
- Constraints: None

### cover_image

Field with the following constraints:

- Type: string
- Constraints: None

### flags

Field with the following constraints:

- Type: number
- Constraints: None

### approximate_guild_count

Field with the following constraints:

- Type: number
- Constraints: None

### redirect_uris

Field with the following constraints:

- Type: string
- Constraints: None

### interactions_endpoint_url

Field with the following constraints:

- Type: string
- Constraints: None

### role_connections_verification_url

Field with the following constraints:

- Type: string
- Constraints: None

### tags

Field with the following constraints:

- Type: string
- Constraints: None

### install_params

Field with the following constraints:

- Type: InstallParamsObject
- Constraints: None

### integration_types_config

*This is an inline table type with the following fields*

##### [ApplicationIntegrationType]

Field with the following constraints:

- Type: boolean
- Constraints: None

### custom_install_url

Field with the following constraints:

- Type: string
- Constraints: None

## GuildApplicationCommandPermissionObject

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

### id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### type

Field with the following constraints:

- Type: ApplicationCommandPermissionType
- Constraints: None

### permission

Field with the following constraints:

- Type: boolean
- Constraints: None

## GuildApplicationCommandPermissionsObject

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

### id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### application_id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### guild_id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### permissions

Field with the following constraints:

- Type: GuildApplicationCommandPermissionObject
- Constraints: None

## AutomoderationRuleTriggerMetadataObject

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

### keyword_filter

Field with the following constraints:

- Type: string
- Constraints: None

### regex_patterns

Field with the following constraints:

- Type: string
- Constraints: None

### presets

Field with the following constraints:

- Type: AutomoderationRuleKeywordPresetType
- Constraints: None

### allow_list

Field with the following constraints:

- Type: string
- Constraints: None

### mention_total_limit

Field with the following constraints:

- Type: number
- Constraints: None

### mention_raid_protection_enabled

Field with the following constraints:

- Type: boolean
- Constraints: None

## AutmoderationActionMetadataObject

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

### channel_id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### duration_seconds

Field with the following constraints:

- Type: number
- Constraints: None

### custom_message

Field with the following constraints:

- Type: string
- Constraints: None

## AutomoderationActionObject

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

### type

Field with the following constraints:

- Type: AutomoderationActionType
- Constraints: None

### metadata

Field with the following constraints:

- Type: AutmoderationActionMetadataObject
- Constraints: None

## AutomoderationRuleObject

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

### id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### guild_id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### name

Field with the following constraints:

- Type: string
- Constraints: None

### creator_id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### event_type

Field with the following constraints:

- Type: AutomoderationRuleEventType
- Constraints: None

### trigger_type

Field with the following constraints:

- Type: AutomoderationRuleTriggerType
- Constraints: None

### trigger_metadata

Field with the following constraints:

- Type: AutomoderationRuleTriggerMetadataObject
- Constraints: None

### actions

Field with the following constraints:

- Type: AutomoderationActionObject
- Constraints: None

### enabled

Field with the following constraints:

- Type: boolean
- Constraints: None

### exempt_roles

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### exempt_channels

Field with the following constraints:

- Type: Snowflake
- Constraints: None

## OverwriteObject

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

### id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### type

Field with the following constraints:

- Type: OverwriteObjectType
- Constraints: None

### allow

Field with the following constraints:

- Type: string
- Constraints: None

### deny

Field with the following constraints:

- Type: string
- Constraints: None

## ThreadMetadataObject

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

### archived

Field with the following constraints:

- Type: boolean
- Constraints: None

### auto_archive_duration

Field with the following constraints:

- Type: number
- Constraints: None

### archive_timestamp

Field with the following constraints:

- Type: string
- Constraints: None

### locked

Field with the following constraints:

- Type: boolean
- Constraints: None

### invitable

Field with the following constraints:

- Type: boolean
- Constraints: None

### create_timestamp

Field with the following constraints:

- Type: string
- Constraints: None

## GuildMemberObject

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

### user

Field with the following constraints:

- Type: UserObject
- Constraints: None

### nick

Field with the following constraints:

- Type: string
- Constraints: None

### avatar

Field with the following constraints:

- Type: string
- Constraints: None

### roles

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### joined_at

Field with the following constraints:

- Type: string
- Constraints: None

### premium_since

Field with the following constraints:

- Type: string
- Constraints: None

### deaf

Field with the following constraints:

- Type: boolean
- Constraints: None

### mute

Field with the following constraints:

- Type: boolean
- Constraints: None

### flags

Field with the following constraints:

- Type: number
- Constraints: None

### pending

Field with the following constraints:

- Type: boolean
- Constraints: None

### permissions

Field with the following constraints:

- Type: string
- Constraints: None

### communication_disabled_until

Field with the following constraints:

- Type: string
- Constraints: None

### avatar_decoration_data

Field with the following constraints:

- Type: AvatarDecorationDataObject
- Constraints: None

## ThreadMemberObject

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

### id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### user_id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### join_timestamp

Field with the following constraints:

- Type: string
- Constraints: None

### flags

Field with the following constraints:

- Type: number
- Constraints: None

### member

Field with the following constraints:

- Type: GuildMemberObject
- Constraints: None

## ForumTagObject

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

### id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### name

Field with the following constraints:

- Type: string
- Constraints: None

### moderated

Field with the following constraints:

- Type: boolean
- Constraints: None

### emoji_id

Field with the following constraints:

- Type: string
- Constraints: None

### emoji_name

Field with the following constraints:

- Type: string
- Constraints: None

## DefaultReactionObject

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

### emoji_id

Field with the following constraints:

- Type: string
- Constraints: None

### emoji_name

Field with the following constraints:

- Type: string
- Constraints: None

## ChannelObject

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

### id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### type

Field with the following constraints:

- Type: ChannelType
- Constraints: None

### guild_id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### position

Field with the following constraints:

- Type: number
- Constraints: None

### permission_overwrites

Field with the following constraints:

- Type: OverwriteObject
- Constraints: None

### name

Field with the following constraints:

- Type: string
- Constraints: None

### topic

Field with the following constraints:

- Type: string
- Constraints: None

### nsfw

Field with the following constraints:

- Type: boolean
- Constraints: None

### last_message_id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### bitrate

Field with the following constraints:

- Type: number
- Constraints: None

### user_limit

Field with the following constraints:

- Type: number
- Constraints: None

### rate_limit_per_user

Field with the following constraints:

- Type: number
- Constraints: None

### recipients

Field with the following constraints:

- Type: UserObject
- Constraints: None

### icon

Field with the following constraints:

- Type: string
- Constraints: None

### owner_id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### application_id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### managed

Field with the following constraints:

- Type: boolean
- Constraints: None

### parent_id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### last_pin_timestamp

Field with the following constraints:

- Type: string
- Constraints: None

### rtc_region

Field with the following constraints:

- Type: string
- Constraints: None

### video_quality_mode

Field with the following constraints:

- Type: VideoQualityMode
- Constraints: None

### message_count

Field with the following constraints:

- Type: number
- Constraints: None

### member_count

Field with the following constraints:

- Type: number
- Constraints: None

### thread_metadata

Field with the following constraints:

- Type: ThreadMetadataObject
- Constraints: None

### member

Field with the following constraints:

- Type: ThreadMemberObject
- Constraints: None

### default_auto_archive_duration

Field with the following constraints:

- Type: number
- Constraints: None

### permissions

Field with the following constraints:

- Type: string
- Constraints: None

### flags

Field with the following constraints:

- Type: ChannelFlags
- Constraints: None

### total_message_sent

Field with the following constraints:

- Type: number
- Constraints: None

### available_tags

Field with the following constraints:

- Type: ForumTagObject
- Constraints: None

### applied_tags

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### default_reaction_emoji

Field with the following constraints:

- Type: DefaultReactionObject
- Constraints: None

### default_thread_rate_limit_per_user

Field with the following constraints:

- Type: number
- Constraints: None

### default_sort_order

Field with the following constraints:

- Type: SortOrderType
- Constraints: None

### default_forum_layout

Field with the following constraints:

- Type: ForumLayoutType
- Constraints: None

## EntitlementObject

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

### id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### sku_id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### application_id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### user_id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### type

Field with the following constraints:

- Type: EntitlementType
- Constraints: None

### deleted

Field with the following constraints:

- Type: boolean
- Constraints: None

### starts_at

Field with the following constraints:

- Type: string
- Constraints: None

### ends_at

Field with the following constraints:

- Type: string
- Constraints: None

### guild_id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### consumed

Field with the following constraints:

- Type: boolean
- Constraints: None

## VoiceStateObject

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

### guild_id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### channel_id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### user_id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### member

Field with the following constraints:

- Type: GuildMemberObject
- Constraints: None

### session_id

Field with the following constraints:

- Type: string
- Constraints: None

### deaf

Field with the following constraints:

- Type: boolean
- Constraints: None

### mute

Field with the following constraints:

- Type: boolean
- Constraints: None

### self_deaf

Field with the following constraints:

- Type: boolean
- Constraints: None

### self_mute

Field with the following constraints:

- Type: boolean
- Constraints: None

### self_stream

Field with the following constraints:

- Type: boolean
- Constraints: None

### self_video

Field with the following constraints:

- Type: boolean
- Constraints: None

### suppress

Field with the following constraints:

- Type: boolean
- Constraints: None

### request_to_speak_timestamp

Field with the following constraints:

- Type: string
- Constraints: None

## ClientStatusObject

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

### desktop

Field with the following constraints:

- Type: string
- Constraints: None

### mobile

Field with the following constraints:

- Type: string
- Constraints: None

### web

Field with the following constraints:

- Type: string
- Constraints: None

## PresenceUpdateObject

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

### user

Field with the following constraints:

- Type: UserObject
- Constraints: None

### guild_id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### status

Field with the following constraints:

- Type: string
- Constraints: None

### activities

Field with the following constraints:

- Type: ActivityObject
- Constraints: None

### client_status

Field with the following constraints:

- Type: ClientStatusObject
- Constraints: None

## StageInstanceObject

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

### id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### guild_id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### channel_id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### topic

Field with the following constraints:

- Type: string
- Constraints: None

### privacy_level

Field with the following constraints:

- Type: PrivacyLevel
- Constraints: None

### discoverable_disabled

Field with the following constraints:

- Type: boolean
- Constraints: None

### guild_scheduled_event_id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

## GuildScheduledEventEntityMetadata

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

### location

Field with the following constraints:

- Type: string
- Constraints: None

## GuildScheduledEventObject

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

### id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### guild_id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### channel_id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### creator_id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### name

Field with the following constraints:

- Type: string
- Constraints: None

### description

Field with the following constraints:

- Type: string
- Constraints: None

### scheduled_start_time

Field with the following constraints:

- Type: string
- Constraints: None

### scheduled_end_time

Field with the following constraints:

- Type: string
- Constraints: None

### privacy_level

Field with the following constraints:

- Type: PrivacyLevel
- Constraints: None

### status

Field with the following constraints:

- Type: GuildScheduledEventStatus
- Constraints: None

### entity_type

Field with the following constraints:

- Type: GuildScheduledEventEntityType
- Constraints: None

### entity_id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### entity_metadata

Field with the following constraints:

- Type: GuildScheduledEventEntityMetadata
- Constraints: None

### creator

Field with the following constraints:

- Type: UserObject
- Constraints: None

### user_count

Field with the following constraints:

- Type: number
- Constraints: None

### image

Field with the following constraints:

- Type: string
- Constraints: None

## IntegrationAccountObject

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

### id

Field with the following constraints:

- Type: string
- Constraints: None

### name

Field with the following constraints:

- Type: string
- Constraints: None

## IntegrationObject

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

### id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### name

Field with the following constraints:

- Type: string
- Constraints: None

### type

Field with the following constraints:

- Type: IntegrationType
- Constraints: None

### enabled

Field with the following constraints:

- Type: boolean
- Constraints: None

### syncing

Field with the following constraints:

- Type: boolean
- Constraints: None

### role_id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### enable_emoticons

Field with the following constraints:

- Type: boolean
- Constraints: None

### expire_behaviour

Field with the following constraints:

- Type: IntegrationExpireBehaviours
- Constraints: None

### expire_grace_period

Field with the following constraints:

- Type: number
- Constraints: None

### user

Field with the following constraints:

- Type: UserObject
- Constraints: None

### account

Field with the following constraints:

- Type: IntegrationAccountObject
- Constraints: None

### synced_at

Field with the following constraints:

- Type: string
- Constraints: None

### subscriber_count

Field with the following constraints:

- Type: number
- Constraints: None

### revoked

Field with the following constraints:

- Type: boolean
- Constraints: None

### application

Field with the following constraints:

- Type: IntegrationApplicationObject
- Constraints: None

### scopes

Field with the following constraints:

- Type: OAuth2Scopes
- Constraints: None

## ChannelMentionObject

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

### id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### guild_id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### type

Field with the following constraints:

- Type: ChannelType
- Constraints: None

### name

Field with the following constraints:

- Type: string
- Constraints: None

## AttachmentObject

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

## EmbedFooterObject

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

### text

Field with the following constraints:

- Type: string
- Constraints: None

### icon_url

Field with the following constraints:

- Type: string
- Constraints: None

### proxy_icon_url

Field with the following constraints:

- Type: string
- Constraints: None

## EmbedImageObject

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

### url

Field with the following constraints:

- Type: string
- Constraints: None

### proxy_url

Field with the following constraints:

- Type: string
- Constraints: None

### height

Field with the following constraints:

- Type: number
- Constraints: None

### width

Field with the following constraints:

- Type: number
- Constraints: None

## EmbedProviderObject

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

### name

Field with the following constraints:

- Type: string
- Constraints: None

### url

Field with the following constraints:

- Type: string
- Constraints: None

## EmbedAuthorObject

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

### name

Field with the following constraints:

- Type: string
- Constraints: None

### url

Field with the following constraints:

- Type: string
- Constraints: None

### icon_url

Field with the following constraints:

- Type: string
- Constraints: None

### proxy_icon_url

Field with the following constraints:

- Type: string
- Constraints: None

## EmbedFieldObject

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

### name

Field with the following constraints:

- Type: string
- Constraints: None

### value

Field with the following constraints:

- Type: string
- Constraints: None

### inline

Field with the following constraints:

- Type: boolean
- Constraints: None

## EmbedThumbnailObject

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

### url

Field with the following constraints:

- Type: string
- Constraints: None

### proxy_url

Field with the following constraints:

- Type: string
- Constraints: None

### height

Field with the following constraints:

- Type: number
- Constraints: None

### width

Field with the following constraints:

- Type: number
- Constraints: None

## EmbedVideoObject

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

### url

Field with the following constraints:

- Type: string
- Constraints: None

### proxy_url

Field with the following constraints:

- Type: string
- Constraints: None

### height

Field with the following constraints:

- Type: number
- Constraints: None

### width

Field with the following constraints:

- Type: number
- Constraints: None

## EmbedObject

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

### title

Field with the following constraints:

- Type: string
- Constraints: None

### type

Field with the following constraints:

- Type: EmbedType
- Constraints: None

### description

Field with the following constraints:

- Type: string
- Constraints: None

### url

Field with the following constraints:

- Type: string
- Constraints: None

### timestamp

Field with the following constraints:

- Type: string
- Constraints: None

### color

Field with the following constraints:

- Type: number
- Constraints: None

### footer

Field with the following constraints:

- Type: EmbedFooterObject
- Constraints: None

### image

Field with the following constraints:

- Type: EmbedImageObject
- Constraints: None

### thumbnail

Field with the following constraints:

- Type: EmbedThumbnailObject
- Constraints: None

### video

Field with the following constraints:

- Type: EmbedVideoObject
- Constraints: None

### provider

Field with the following constraints:

- Type: EmbedProviderObject
- Constraints: None

### author

Field with the following constraints:

- Type: EmbedAuthorObject
- Constraints: None

### fields

Field with the following constraints:

- Type: EmbedFieldObject
- Constraints: None

## ReactionCountDetailsObject

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

### burst

Field with the following constraints:

- Type: number
- Constraints: None

### normal

Field with the following constraints:

- Type: number
- Constraints: None

## ReactionObject

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

### count

Field with the following constraints:

- Type: number
- Constraints: None

### count_details

Field with the following constraints:

- Type: ReactionCountDetailsObject
- Constraints: None

### me

Field with the following constraints:

- Type: boolean
- Constraints: None

### me_burst

Field with the following constraints:

- Type: boolean
- Constraints: None

### emoji

Field with the following constraints:

- Type: EmojiObject
- Constraints: None

### burst_colors

Field with the following constraints:

- Type: string
- Constraints: None

## MessageActivityObject

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

### type

Field with the following constraints:

- Type: MessageActivityType
- Constraints: None

### party_id

Field with the following constraints:

- Type: string
- Constraints: None

## MessageReferenceObject

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

### type

Field with the following constraints:

- Type: MessageReferenceType
- Constraints: None

### message_id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### channel_id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### guild_id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### fail_if_not_exists

Field with the following constraints:

- Type: boolean
- Constraints: None

## MessageInteractionMetadatObject

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

### id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### type

Field with the following constraints:

- Type: InteractionType
- Constraints: None

### user

Field with the following constraints:

- Type: UserObject
- Constraints: None

### authorizing_integration_owners

*This is an inline table type with the following fields*

##### [ApplicationIntegrationType]

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### original_response_message_id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### interacted_message_id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### triggering_interaction_metadata

Field with the following constraints:

- Type: MessageInteractionMetadatObject
- Constraints: None

## MessageInteractionObject

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

### id

Field with the following constraints:

- Type: string
- Constraints: None

### type

Field with the following constraints:

- Type: InteractionType
- Constraints: None

### name

Field with the following constraints:

- Type: string
- Constraints: None

### user

Field with the following constraints:

- Type: UserObject
- Constraints: None

### member

Field with the following constraints:

- Type: GuildMemberObject
- Constraints: None

## SelectOptionObject

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

### label

Field with the following constraints:

- Type: string
- Constraints: None

### value

Field with the following constraints:

- Type: string
- Constraints: None

### description

Field with the following constraints:

- Type: string
- Constraints: None

### emoji

Field with the following constraints:

- Type: EmojiObject
- Constraints: None

### default

Field with the following constraints:

- Type: boolean
- Constraints: None

## SelectDefaultValueObject

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

### id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### type

Field with the following constraints:

- Type: string
- Constraints: None

## ActionRowComponentObject

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

### type

Field with the following constraints:

- Type: number
- Constraints: None

### components

Field with the following constraints:

- Type: ComponentObjects
- Constraints: None

## ButtonComponentObject

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

## SelectMenuComponentObject

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

### type

Field with the following constraints:

- Type: number
- Constraints: None

### custom_id

Field with the following constraints:

- Type: string
- Constraints: None

### options

Field with the following constraints:

- Type: SelectOptionObject
- Constraints: None

### channel_types

Field with the following constraints:

- Type: ChannelType
- Constraints: None

### placeholder

Field with the following constraints:

- Type: string
- Constraints: None

### default_values

Field with the following constraints:

- Type: SelectDefaultValueObject
- Constraints: None

### min_values

Field with the following constraints:

- Type: number
- Constraints: None

### max_values

Field with the following constraints:

- Type: number
- Constraints: None

### disabled

Field with the following constraints:

- Type: boolean
- Constraints: None

## TextInputComponentObject

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

### type

Field with the following constraints:

- Type: number
- Constraints: None

### custom_id

Field with the following constraints:

- Type: string
- Constraints: None

### style

Field with the following constraints:

- Type: TextInputStyles
- Constraints: None

### label

Field with the following constraints:

- Type: string
- Constraints: None

### min_length

Field with the following constraints:

- Type: number
- Constraints: None

### max_length

Field with the following constraints:

- Type: number
- Constraints: None

### required

Field with the following constraints:

- Type: boolean
- Constraints: None

### value

Field with the following constraints:

- Type: string
- Constraints: None

### placeholder

Field with the following constraints:

- Type: string
- Constraints: None

## ComponentObjects

https://discord.com/developers/docs/interactions/message-components#message-components

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/message-components#message-components
type ComponentObjects = ActionRowComponentObject | ButtonComponentObject | SelectMenuComponentObject | TextInputComponentObject
```

</details>

## SitckerItemObject

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

### id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### name

Field with the following constraints:

- Type: string
- Constraints: None

### format_type

Field with the following constraints:

- Type: StickerFormatType
- Constraints: None

## RoleSubscriptionDataObject

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

### role_subscription_listing_id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### tier_name

Field with the following constraints:

- Type: string
- Constraints: None

### total_months_subscribed

Field with the following constraints:

- Type: number
- Constraints: None

### is_renewal

Field with the following constraints:

- Type: boolean
- Constraints: None

## PollMediaObject

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

### text

Field with the following constraints:

- Type: string
- Constraints: None

### emoji

[Documentor] Unsupported type: Generic

## PollAnswerObject

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

### answer_id

Field with the following constraints:

- Type: number
- Constraints: None

### poll_media

Field with the following constraints:

- Type: PollMediaObject
- Constraints: None

## PollAnswerCountObject

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

### id

Field with the following constraints:

- Type: number
- Constraints: None

### count

Field with the following constraints:

- Type: number
- Constraints: None

### me_voted

Field with the following constraints:

- Type: boolean
- Constraints: None

## PollResultObject

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

### is_finalized

Field with the following constraints:

- Type: boolean
- Constraints: None

### answer_counts

Field with the following constraints:

- Type: PollAnswerCountObject
- Constraints: None

## PollObject

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

### question

Field with the following constraints:

- Type: PollMediaObject
- Constraints: None

### answers

Field with the following constraints:

- Type: PollAnswerObject
- Constraints: None

### expiry

Field with the following constraints:

- Type: string
- Constraints: None

### allow_multiselect

fixme: for some reason luau's type system doesn't like this being a `boolean`????

[Documentor] Unsupported type: Union

### layout_type

Field with the following constraints:

- Type: PollLayoutType
- Constraints: None

### results

Field with the following constraints:

- Type: PollResultObject
- Constraints: None

## MessageCallObject

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

### participants

Field with the following constraints:

- Type: UserObject
- Constraints: None

### ended_timestamp

Field with the following constraints:

- Type: string
- Constraints: None

## MessageObject

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

### id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### channel_id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### author

Field with the following constraints:

- Type: UserObject
- Constraints: None

### content

Field with the following constraints:

- Type: string
- Constraints: None

### timestamp

Field with the following constraints:

- Type: string
- Constraints: None

### edited_timestamp

Field with the following constraints:

- Type: string
- Constraints: None

### tts

Field with the following constraints:

- Type: boolean
- Constraints: None

### mention_everyone

Field with the following constraints:

- Type: boolean
- Constraints: None

### mentions

Field with the following constraints:

- Type: UserObject
- Constraints: None

### mention_roles

Field with the following constraints:

- Type: GuildRoleObject
- Constraints: None

### mention_channels

Field with the following constraints:

- Type: ChannelMentionObject
- Constraints: None

### attachments

Field with the following constraints:

- Type: AttachmentObject
- Constraints: None

### embeds

Field with the following constraints:

- Type: EmbedObject
- Constraints: None

### reactions

Field with the following constraints:

- Type: ReactionObject
- Constraints: None

### nonce

Field with the following constraints:

- Type: string
- Constraints: None

### pinned

Field with the following constraints:

- Type: boolean
- Constraints: None

### webhook_id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### type

Field with the following constraints:

- Type: MessageType
- Constraints: None

### activity

Field with the following constraints:

- Type: MessageActivityObject
- Constraints: None

### application

Field with the following constraints:

- Type: ApplicationObject
- Constraints: None

### application_id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### message_reference

Field with the following constraints:

- Type: MessageReferenceObject
- Constraints: None

### flags

Field with the following constraints:

- Type: number
- Constraints: None

### referenced_message

Field with the following constraints:

- Type: MessageObject
- Constraints: None

### interaction_metadata

Field with the following constraints:

- Type: MessageInteractionMetadatObject
- Constraints: None

### interaction

Field with the following constraints:

- Type: MessageInteractionObject
- Constraints: None

### thread

Field with the following constraints:

- Type: ChannelObject
- Constraints: None

### components

Field with the following constraints:

- Type: ComponentObjects
- Constraints: None

### sticker_items

Field with the following constraints:

- Type: SitckerItemObject
- Constraints: None

### stickers

Field with the following constraints:

- Type: StickerObject
- Constraints: None

### position

Field with the following constraints:

- Type: number
- Constraints: None

### role_subscription_data

Field with the following constraints:

- Type: RoleSubscriptionDataObject
- Constraints: None

### resolved

Field with the following constraints:

- Type: ResolvedDataStructure
- Constraints: None

### poll

Field with the following constraints:

- Type: PollObject
- Constraints: None

### call

Field with the following constraints:

- Type: MessageCallObject
- Constraints: None

## ResolvedDataStructure

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

### users

Field with the following constraints:

- Type: UserObject
- Constraints: None

### members

Field with the following constraints:

- Type: GuildMemberObject
- Constraints: None

### roles

Field with the following constraints:

- Type: GuildRoleObject
- Constraints: None

### channels

Field with the following constraints:

- Type: ChannelObject
- Constraints: None

### messages

Field with the following constraints:

- Type: MessageObject
- Constraints: None

### attachments

Field with the following constraints:

- Type: AttachmentObject
- Constraints: None

## ApplicationCommandInteractionDataOptionObject

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

### name

Field with the following constraints:

- Type: string
- Constraints: None

### type

Field with the following constraints:

- Type: ApplicationCommandOptionType
- Constraints: None

### value

[Documentor] Unsupported type: Tuple

### options

Field with the following constraints:

- Type: ApplicationCommandInteractionDataOptionObject
- Constraints: None

### focused

Field with the following constraints:

- Type: boolean
- Constraints: None

## InteractionDataObject

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

### id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### name

Field with the following constraints:

- Type: string
- Constraints: None

### type

Field with the following constraints:

- Type: number
- Constraints: None

### resolved

Field with the following constraints:

- Type: ResolvedDataStructure
- Constraints: None

### options

Field with the following constraints:

- Type: ApplicationCommandInteractionDataOptionObject
- Constraints: None

### guild_id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### target_id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### custom_id

Field with the following constraints:

- Type: string
- Constraints: None

### component_type

Field with the following constraints:

- Type: number
- Constraints: None

### values

Field with the following constraints:

- Type: SelectOptionObject
- Constraints: None

### components

Field with the following constraints:

- Type: ComponentObjects
- Constraints: None

## InteractionObject

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

### id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### application_id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### type

Field with the following constraints:

- Type: InteractionType
- Constraints: None

### data

Field with the following constraints:

- Type: InteractionDataObject
- Constraints: None

### guild

Field with the following constraints:

- Type: GuildObject
- Constraints: None

### guild_id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### channel

Field with the following constraints:

- Type: ChannelObject
- Constraints: None

### channel_id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### member

Field with the following constraints:

- Type: GuildMemberObject
- Constraints: None

### user

Field with the following constraints:

- Type: UserObject
- Constraints: None

### token

Field with the following constraints:

- Type: string
- Constraints: None

### version

Field with the following constraints:

- Type: number
- Constraints: None

### message

Field with the following constraints:

- Type: MessageObject
- Constraints: None

### app_permissions

Field with the following constraints:

- Type: string
- Constraints: None

### locale

Field with the following constraints:

- Type: LanguageLocales
- Constraints: None

### guild_locale

Field with the following constraints:

- Type: LanguageLocales
- Constraints: None

### entitlements

Field with the following constraints:

- Type: EntitlementObject
- Constraints: None

### authorizing_integration_owners

Field with the following constraints:

- Type: IntegrationType
- Constraints: None

### context

Field with the following constraints:

- Type: InteractionContextType
- Constraints: None

## ApplicationRoleConnectionMetadataObject

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

### type

Field with the following constraints:

- Type: ApplicationRoleConnectionMetadataType
- Constraints: None

### key

Field with the following constraints:

- Type: string
- Constraints: None

### name

Field with the following constraints:

- Type: string
- Constraints: None

### name_localizations

*This is an inline table type with the following fields*

##### [LanguageLocales]

Field with the following constraints:

- Type: string
- Constraints: None

### description

Field with the following constraints:

- Type: string
- Constraints: None

### description_localizations

*This is an inline table type with the following fields*

##### [LanguageLocales]

Field with the following constraints:

- Type: string
- Constraints: None

## ApplicationCommandOptionChoiceObject

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

### name

Field with the following constraints:

- Type: string
- Constraints: None

### name_localizations

*This is an inline table type with the following fields*

##### [LanguageLocales]

Field with the following constraints:

- Type: string
- Constraints: None

### value

[Documentor] Unsupported type: Union

## ApplicationCommandOptionObject

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

### type

Field with the following constraints:

- Type: ApplicationCommandOptionType
- Constraints: None

### name

Field with the following constraints:

- Type: string
- Constraints: None

### name_localizations

*This is an inline table type with the following fields*

##### [LanguageLocales]

Field with the following constraints:

- Type: string
- Constraints: None

### description

Field with the following constraints:

- Type: string
- Constraints: None

### description_localizations

*This is an inline table type with the following fields*

##### [LanguageLocales]

Field with the following constraints:

- Type: string
- Constraints: None

### required

Field with the following constraints:

- Type: boolean
- Constraints: None

### choices

Field with the following constraints:

- Type: ApplicationCommandOptionChoiceObject
- Constraints: None

### options

Field with the following constraints:

- Type: ApplicationCommandOptionObject
- Constraints: None

### channel_types

Field with the following constraints:

- Type: ChannelType
- Constraints: None

### min_value

Field with the following constraints:

- Type: number
- Constraints: None

### max_value

Field with the following constraints:

- Type: number
- Constraints: None

### min_length

Field with the following constraints:

- Type: number
- Constraints: None

### max_length

Field with the following constraints:

- Type: number
- Constraints: None

### autocomplete

Field with the following constraints:

- Type: boolean
- Constraints: None

## ApplicationCommandObject

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

### id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### type

Field with the following constraints:

- Type: ApplicationCommandType
- Constraints: None

### application_id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### guild_id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### name

Field with the following constraints:

- Type: string
- Constraints: None

### name_localizations

*This is an inline table type with the following fields*

##### [LanguageLocales]

Field with the following constraints:

- Type: string
- Constraints: None

### description

Field with the following constraints:

- Type: string
- Constraints: None

### description_localizations

*This is an inline table type with the following fields*

##### [LanguageLocales]

Field with the following constraints:

- Type: string
- Constraints: None

### options

Field with the following constraints:

- Type: ApplicationCommandOptionObject
- Constraints: None

### default_member_permissions

Field with the following constraints:

- Type: string
- Constraints: None

### dm_permission

Field with the following constraints:

- Type: string
- Constraints: None

### default_permission

Field with the following constraints:

- Type: boolean
- Constraints: None

### nsfw

Field with the following constraints:

- Type: boolean
- Constraints: None

### integration_types

Field with the following constraints:

- Type: IntegrationType
- Constraints: None

### contexts

Field with the following constraints:

- Type: InteractionContextType
- Constraints: None

### version

Field with the following constraints:

- Type: Snowflake
- Constraints: None

## AuditLogChangeObject

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

### new_value

Field with the following constraints:

- Type: any
- Constraints: None

### old_value

Field with the following constraints:

- Type: any
- Constraints: None

### key

Field with the following constraints:

- Type: string
- Constraints: None

## OptionalAuditEntryInfoObject

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

### application_id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### auto_moderation_rule_name

Field with the following constraints:

- Type: string
- Constraints: None

### auto_moderation_rule_trigger_type

Field with the following constraints:

- Type: AutomoderationRuleTriggerType
- Constraints: None

### channel_id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### count

Field with the following constraints:

- Type: string
- Constraints: None

### delete_member_days

Field with the following constraints:

- Type: string
- Constraints: None

### id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### members_removed

Field with the following constraints:

- Type: string
- Constraints: None

### message_id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### role_name

Field with the following constraints:

- Type: string
- Constraints: None

### type

Field with the following constraints:

- Type: string
- Constraints: None

### integration_type

Field with the following constraints:

- Type: IntegrationType
- Constraints: None

## AuditLogEntryObject

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

### target_id

Field with the following constraints:

- Type: string
- Constraints: None

### changes

Field with the following constraints:

- Type: AuditLogChangeObject
- Constraints: None

### user_id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### action_type

Field with the following constraints:

- Type: AuditLogEventType
- Constraints: None

### options

Field with the following constraints:

- Type: OptionalAuditEntryInfoObject
- Constraints: None

### reason

Field with the following constraints:

- Type: string
- Constraints: None

## WebhookObject

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

### id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### type

Field with the following constraints:

- Type: WebhookType
- Constraints: None

### guild_id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### channel_id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### user

Field with the following constraints:

- Type: UserObject
- Constraints: None

### name

Field with the following constraints:

- Type: string
- Constraints: None

### avatar

Field with the following constraints:

- Type: string
- Constraints: None

### token

Field with the following constraints:

- Type: string
- Constraints: None

### application_id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### source_guild

Field with the following constraints:

- Type: GuildObject
- Constraints: None

### source_channel

Field with the following constraints:

- Type: ChannelObject
- Constraints: None

### url

Field with the following constraints:

- Type: string
- Constraints: None

## AuditLogObject

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

### application_commands

Field with the following constraints:

- Type: ApplicationCommandObject
- Constraints: None

### audit_log_entries

Field with the following constraints:

- Type: AuditLogEntryObject
- Constraints: None

### auto_moderation_rules

Field with the following constraints:

- Type: AutomoderationRuleObject
- Constraints: None

### guild_scheduled_events

Field with the following constraints:

- Type: GuildScheduledEventObject
- Constraints: None

### integrations

Field with the following constraints:

- Type: IntegrationObject
- Constraints: None

### threads

Field with the following constraints:

- Type: ChannelObject
- Constraints: None

### users

Field with the following constraints:

- Type: UserObject
- Constraints: None

### webhooks

Field with the following constraints:

- Type: WebhookObject
- Constraints: None

## InviteObject

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

### type

Field with the following constraints:

- Type: InviteTypes
- Constraints: None

### code

Field with the following constraints:

- Type: string
- Constraints: None

### guild

Field with the following constraints:

- Type: GuildObject
- Constraints: None

### channel

Field with the following constraints:

- Type: ChannelObject
- Constraints: None

### inviter

Field with the following constraints:

- Type: UserObject
- Constraints: None

### target_type

Field with the following constraints:

- Type: InviteTargetTypes
- Constraints: None

### target_user

Field with the following constraints:

- Type: UserObject
- Constraints: None

### target_application

Field with the following constraints:

- Type: ApplicationObject
- Constraints: None

### approximate_presence_count

Field with the following constraints:

- Type: number
- Constraints: None

### approximate_member_count

Field with the following constraints:

- Type: number
- Constraints: None

### expires_at

Field with the following constraints:

- Type: string
- Constraints: None

### stage_instance

Field with the following constraints:

- Type: StageInstanceObject
- Constraints: None

### guild_scheduled_event

Field with the following constraints:

- Type: GuildScheduledEventObject
- Constraints: None

## GuildVanityUrl

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

### code

Field with the following constraints:

- Type: string
- Constraints: None

### uses

Field with the following constraints:

- Type: number
- Constraints: None

## InviteMetadataObject

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

### uses

Field with the following constraints:

- Type: number
- Constraints: None

### max_uses

Field with the following constraints:

- Type: number
- Constraints: None

### max_age

Field with the following constraints:

- Type: number
- Constraints: None

### temporary

Field with the following constraints:

- Type: boolean
- Constraints: None

### created_at

Field with the following constraints:

- Type: string
- Constraints: None

## FollowedChannelObject

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

### channel_id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### webhook_id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

## GuildPreviewObject

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

### id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### name

Field with the following constraints:

- Type: string
- Constraints: None

### icon

Field with the following constraints:

- Type: string
- Constraints: None

### splash

Field with the following constraints:

- Type: string
- Constraints: None

### discovery_splash

Field with the following constraints:

- Type: string
- Constraints: None

### emojis

Field with the following constraints:

- Type: EmojiObject
- Constraints: None

### features

Field with the following constraints:

- Type: GuildFeature
- Constraints: None

### approximate_member_count

Field with the following constraints:

- Type: number
- Constraints: None

### approximate_presence_count

Field with the following constraints:

- Type: number
- Constraints: None

### description

Field with the following constraints:

- Type: string
- Constraints: None

### stickers

Field with the following constraints:

- Type: StickerObject
- Constraints: None

## BanObject

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

### reason

Field with the following constraints:

- Type: string
- Constraints: None

### user

Field with the following constraints:

- Type: UserObject
- Constraints: None

## VoiceRegionObject

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

### id

Field with the following constraints:

- Type: string
- Constraints: None

### name

Field with the following constraints:

- Type: string
- Constraints: None

### optimal

Field with the following constraints:

- Type: boolean
- Constraints: None

### deprecated

Field with the following constraints:

- Type: boolean
- Constraints: None

### custom

Field with the following constraints:

- Type: boolean
- Constraints: None

## GuildWidgetSettingsObject

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

### enabled

Field with the following constraints:

- Type: boolean
- Constraints: None

### channel_id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

## GuildWidgetObject

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

### id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### name

Field with the following constraints:

- Type: string
- Constraints: None

### instant_invite

Field with the following constraints:

- Type: string
- Constraints: None

### channels

Field with the following constraints:

- Type: ChannelObject
- Constraints: None

### members

Field with the following constraints:

- Type: UserObject
- Constraints: None

### presence_count

Field with the following constraints:

- Type: number
- Constraints: None

## PromptOptionObject

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

### id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### channel_ids

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### role_ids

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### emoji

[Documentor] Unsupported type: Union

### emoji_id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### emoji_name

Field with the following constraints:

- Type: string
- Constraints: None

### emoji_animated

Field with the following constraints:

- Type: boolean
- Constraints: None

### title

Field with the following constraints:

- Type: string
- Constraints: None

### description

Field with the following constraints:

- Type: string
- Constraints: None

## OnboardingPromptObject

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

### id

[Documentor] Unsupported type: Union

### type

Field with the following constraints:

- Type: PromptTypes
- Constraints: None

### options

Field with the following constraints:

- Type: PromptOptionObject
- Constraints: None

### title

Field with the following constraints:

- Type: string
- Constraints: None

### single_select

Field with the following constraints:

- Type: boolean
- Constraints: None

### required

Field with the following constraints:

- Type: boolean
- Constraints: None

### in_onboarding

Field with the following constraints:

- Type: boolean
- Constraints: None

## GuildOnboardingObject

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

### guild_id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### prompts

Field with the following constraints:

- Type: OnboardingPromptObject
- Constraints: None

### default_channel_ids

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### enabled

Field with the following constraints:

- Type: boolean
- Constraints: None

### mode

Field with the following constraints:

- Type: OnboardingMode
- Constraints: None

## GuildScheduledEventUserObject

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

### guild_scheduled_event_id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### user

Field with the following constraints:

- Type: UserObject
- Constraints: None

### member

Field with the following constraints:

- Type: GuildMemberObject
- Constraints: None

## GuildTemplateObject

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

### code

Field with the following constraints:

- Type: string
- Constraints: None

### name

Field with the following constraints:

- Type: string
- Constraints: None

### description

Field with the following constraints:

- Type: string
- Constraints: None

### usage_count

Field with the following constraints:

- Type: number
- Constraints: None

### creator_id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### creator

Field with the following constraints:

- Type: UserObject
- Constraints: None

### created_at

Field with the following constraints:

- Type: string
- Constraints: None

### updated_at

Field with the following constraints:

- Type: string
- Constraints: None

### source_guild_id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### serialized_source_guild

Field with the following constraints:

- Type: GuildObject
- Constraints: None

### is_dirty

Field with the following constraints:

- Type: boolean
- Constraints: None

## StickerPackObject

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

### id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### stickers

Field with the following constraints:

- Type: StickerObject
- Constraints: None

### name

Field with the following constraints:

- Type: string
- Constraints: None

### sku_id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### cover_sticker_id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### description

Field with the following constraints:

- Type: string
- Constraints: None

### banner_asset_id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

## IntegrationApplicationObject

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

### id

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### name

Field with the following constraints:

- Type: string
- Constraints: None

### icon

Field with the following constraints:

- Type: string
- Constraints: None

### description

Field with the following constraints:

- Type: string
- Constraints: None

### bot

Field with the following constraints:

- Type: UserObject
- Constraints: None

## ConnectionObject

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

### id

Field with the following constraints:

- Type: string
- Constraints: None

### name

Field with the following constraints:

- Type: string
- Constraints: None

### type

Field with the following constraints:

- Type: ConnectionObjectServices
- Constraints: None

### revoked

Field with the following constraints:

- Type: boolean
- Constraints: None

### integrations

Field with the following constraints:

- Type: IntegrationObject
- Constraints: None

### verified

Field with the following constraints:

- Type: boolean
- Constraints: None

### friend_sync

Field with the following constraints:

- Type: boolean
- Constraints: None

### show_Activity

Field with the following constraints:

- Type: boolean
- Constraints: None

### two_way_link

Field with the following constraints:

- Type: boolean
- Constraints: None

### visibility

Field with the following constraints:

- Type: ConnectionVisibilityTypes
- Constraints: None

## ApplicationRoleConnectionObject

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

### platform_name

Field with the following constraints:

- Type: string
- Constraints: None

### platform_username

Field with the following constraints:

- Type: string
- Constraints: None

### metadata

Field with the following constraints:

- Type: ApplicationRoleConnectionMetadataObject
- Constraints: None

## SessionStartLimitObject

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

### total

Field with the following constraints:

- Type: number
- Constraints: None

### remaining

Field with the following constraints:

- Type: number
- Constraints: None

### reset_after

Field with the following constraints:

- Type: number
- Constraints: None

### max_concurrency

Field with the following constraints:

- Type: number
- Constraints: None

## AllowedMentionObject

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

### parse

Field with the following constraints:

- Type: AllowedMentionTypes
- Constraints: None

### users

Field with the following constraints:

- Type: string
- Constraints: None

### roles

Field with the following constraints:

- Type: string
- Constraints: None

### replied_user

Field with the following constraints:

- Type: boolean
- Constraints: None

## ForumAndMediaThreadMessageObject

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

### content

Field with the following constraints:

- Type: string
- Constraints: None

### embeds

Field with the following constraints:

- Type: EmbedObject
- Constraints: None

### allowed_mentions

Field with the following constraints:

- Type: AllowedMentionObject
- Constraints: None

### components

Field with the following constraints:

- Type: ComponentObjects
- Constraints: None

### sticker_ids

Field with the following constraints:

- Type: Snowflake
- Constraints: None

### attachments

Field with the following constraints:

- Type: AttachmentObject
- Constraints: None

### flags

Field with the following constraints:

- Type: number
- Constraints: None

## InteractionCallbackAutocompleteObject

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

### choices

Field with the following constraints:

- Type: ApplicationCommandOptionChoiceObject
- Constraints: None

## InteractionCallbackModalObject

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

### custom_id

Field with the following constraints:

- Type: string
- Constraints: None

### title

Field with the following constraints:

- Type: string
- Constraints: None

### components

Field with the following constraints:

- Type: ComponentObjects
- Constraints: None

## InteractionResponseObject

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

### type

Field with the following constraints:

- Type: InteractionCallbackType
- Constraints: None

### data

[Documentor] Unsupported type: Tuple

