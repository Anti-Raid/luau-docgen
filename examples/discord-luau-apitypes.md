<div id="Types"></div>

# Types

<div id="Partial"></div>

## Partial

<details>
<summary>Raw Type</summary>

```luau
type Partial<T> = MakePartial<T>
```

</details>

[MakePartial](#MakePartial)<[T](#T)><div id="Snowflake"></div>

## Snowflake

<details>
<summary>Raw Type</summary>

```luau
type Snowflake = string
```

</details>

[string](#string)

<div id="PremiumTypes"></div>

## PremiumTypes

https://discord.com/developers/docs/resources/user#user-object-premium-types

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/user#user-object-premium-types
type PremiumTypes = number
```

</details>

[number](#number)

<div id="LanguageLocales"></div>

## LanguageLocales

https://discord.com/developers/docs/reference#locales

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/reference#locales
type LanguageLocales = "id" | "da" | "de" | "en-GB" | "en-US" | "es-ES" | "fr" | "hr" | "it" | "lt" | "nl" | "no" | "pl" | "pt-BR" | "ro" | "fi" | "sv-SE" | "vi" | "tr" | "cs" | "el" | "bg" | "ru" | "uk" | "hi" | "th" | "zn-CH" | "ja" | "ko"
```

</details>

Union with variants:

<details>
<summary>Variant 1</summary>

```luau
"id"
```

</details>

<details>
<summary>Variant 2</summary>

```luau
"da"
```

</details>

<details>
<summary>Variant 3</summary>

```luau
"de"
```

</details>

<details>
<summary>Variant 4</summary>

```luau
"en-GB"
```

</details>

<details>
<summary>Variant 5</summary>

```luau
"en-US"
```

</details>

<details>
<summary>Variant 6</summary>

```luau
"es-ES"
```

</details>

<details>
<summary>Variant 7</summary>

```luau
"fr"
```

</details>

<details>
<summary>Variant 8</summary>

```luau
"hr"
```

</details>

<details>
<summary>Variant 9</summary>

```luau
"it"
```

</details>

<details>
<summary>Variant 10</summary>

```luau
"lt"
```

</details>

<details>
<summary>Variant 11</summary>

```luau
"nl"
```

</details>

<details>
<summary>Variant 12</summary>

```luau
"no"
```

</details>

<details>
<summary>Variant 13</summary>

```luau
"pl"
```

</details>

<details>
<summary>Variant 14</summary>

```luau
"pt-BR"
```

</details>

<details>
<summary>Variant 15</summary>

```luau
"ro"
```

</details>

<details>
<summary>Variant 16</summary>

```luau
"fi"
```

</details>

<details>
<summary>Variant 17</summary>

```luau
"sv-SE"
```

</details>

<details>
<summary>Variant 18</summary>

```luau
"vi"
```

</details>

<details>
<summary>Variant 19</summary>

```luau
"tr"
```

</details>

<details>
<summary>Variant 20</summary>

```luau
"cs"
```

</details>

<details>
<summary>Variant 21</summary>

```luau
"el"
```

</details>

<details>
<summary>Variant 22</summary>

```luau
"bg"
```

</details>

<details>
<summary>Variant 23</summary>

```luau
"ru"
```

</details>

<details>
<summary>Variant 24</summary>

```luau
"uk"
```

</details>

<details>
<summary>Variant 25</summary>

```luau
"hi"
```

</details>

<details>
<summary>Variant 26</summary>

```luau
"th"
```

</details>

<details>
<summary>Variant 27</summary>

```luau
"zn-CH"
```

</details>

<details>
<summary>Variant 28</summary>

```luau
"ja"
```

</details>

<details>
<summary>Variant 29</summary>

```luau
"ko"
```

</details>

<div id="MembershipState"></div>

## MembershipState

https://discord.com/developers/docs/topics/teams#data-models-membership-state-enum

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/topics/teams#data-models-membership-state-enum
type MembershipState = number
```

</details>

[number](#number)

<div id="TeamMemberRole"></div>

## TeamMemberRole

https://discord.com/developers/docs/topics/teams#data-models-membership-state-enum

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/topics/teams#data-models-membership-state-enum
type TeamMemberRole = "Owner" | "Admin" | "Developer" | "Read-only"
```

</details>

Union with variants:

<details>
<summary>Variant 1</summary>

```luau
"Owner"
```

</details>

<details>
<summary>Variant 2</summary>

```luau
"Admin"
```

</details>

<details>
<summary>Variant 3</summary>

```luau
"Developer"
```

</details>

<details>
<summary>Variant 4</summary>

```luau
"Read-only"
```

</details>

<div id="VerificationLevel"></div>

## VerificationLevel

https://discord.com/developers/docs/resources/guild#guild-object-verification-level

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#guild-object-verification-level
type VerificationLevel = number
```

</details>

[number](#number)

<div id="DefaultMessageNotification"></div>

## DefaultMessageNotification

https://discord.com/developers/docs/resources/guild#guild-object-default-message-notification-level

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#guild-object-default-message-notification-level
type DefaultMessageNotification = number
```

</details>

[number](#number)

<div id="ExplicitContentFilterLevel"></div>

## ExplicitContentFilterLevel

https://discord.com/developers/docs/resources/guild#guild-object-explicit-content-filter-level

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#guild-object-explicit-content-filter-level
type ExplicitContentFilterLevel = number
```

</details>

[number](#number)

<div id="MFALevel"></div>

## MFALevel

https://discord.com/developers/docs/resources/guild#guild-object-explicit-content-filter-level

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#guild-object-explicit-content-filter-level
type MFALevel = number
```

</details>

[number](#number)

<div id="GuildNSFWLevel"></div>

## GuildNSFWLevel

https://discord.com/developers/docs/resources/guild#guild-object-guild-nsfw-level

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#guild-object-guild-nsfw-level
type GuildNSFWLevel = number
```

</details>

[number](#number)

<div id="PremiumTier"></div>

## PremiumTier

https://discord.com/developers/docs/resources/guild#guild-object-premium-tier

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#guild-object-premium-tier
type PremiumTier = number
```

</details>

[number](#number)

<div id="SystemChannelFlags"></div>

## SystemChannelFlags

https://discord.com/developers/docs/resources/guild#guild-object-system-channel-flags

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#guild-object-system-channel-flags
type SystemChannelFlags = number
```

</details>

[number](#number)

<div id="GuildFeature"></div>

## GuildFeature

https://discord.com/developers/docs/resources/guild#guild-object-guild-features

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#guild-object-guild-features
type GuildFeature = "ANIMATED_BANNER" | "ANIMATED_ICON" | "APPLICATION_COMMAND_PERMISSIONS_V2" | "AUTO_MODERATION" | "BANNER" | "COMMUNITY" | "CREATOR_MONETIZABLE_PROVISIONAL" | "CREATOR_STORE_PAGE" | "DEVELOPER_SUPPORT_SERVER" | "DISCOVERABLE" | "FEATURABLE" | "INVITES_DISABLED" | "INVITE_SPLASH" | "MEMBER_VERIFICATION_GATE_ENABLED" | "MORE_STICKERS" | "NEWS" | "PARTNERED" | "PREVIEW_ENABLED" | "RAID_ALERTS_DISABLED" | "ROLE_ICONS" | "ROLE_SUBSCRIPTIONS_AVAILABLE_FOR_PURCHASE" | "ROLE_SUBSCRIPTIONS_ENABLED" | "TICKETED_EVENTS_ENABLED" | "VANITY_URL" | "VERIFIED" | "VIP_REGIONS" | "WELCOME_SCREEN_ENABLED"
```

</details>

Union with variants:

<details>
<summary>Variant 1</summary>

```luau
"ANIMATED_BANNER"
```

</details>

<details>
<summary>Variant 2</summary>

```luau
"ANIMATED_ICON"
```

</details>

<details>
<summary>Variant 3</summary>

```luau
"APPLICATION_COMMAND_PERMISSIONS_V2"
```

</details>

<details>
<summary>Variant 4</summary>

```luau
"AUTO_MODERATION"
```

</details>

<details>
<summary>Variant 5</summary>

```luau
"BANNER"
```

</details>

<details>
<summary>Variant 6</summary>

```luau
"COMMUNITY"
```

</details>

<details>
<summary>Variant 7</summary>

```luau
"CREATOR_MONETIZABLE_PROVISIONAL"
```

</details>

<details>
<summary>Variant 8</summary>

```luau
"CREATOR_STORE_PAGE"
```

</details>

<details>
<summary>Variant 9</summary>

```luau
"DEVELOPER_SUPPORT_SERVER"
```

</details>

<details>
<summary>Variant 10</summary>

```luau
"DISCOVERABLE"
```

</details>

<details>
<summary>Variant 11</summary>

```luau
"FEATURABLE"
```

</details>

<details>
<summary>Variant 12</summary>

```luau
"INVITES_DISABLED"
```

</details>

<details>
<summary>Variant 13</summary>

```luau
"INVITE_SPLASH"
```

</details>

<details>
<summary>Variant 14</summary>

```luau
"MEMBER_VERIFICATION_GATE_ENABLED"
```

</details>

<details>
<summary>Variant 15</summary>

```luau
"MORE_STICKERS"
```

</details>

<details>
<summary>Variant 16</summary>

```luau
"NEWS"
```

</details>

<details>
<summary>Variant 17</summary>

```luau
"PARTNERED"
```

</details>

<details>
<summary>Variant 18</summary>

```luau
"PREVIEW_ENABLED"
```

</details>

<details>
<summary>Variant 19</summary>

```luau
"RAID_ALERTS_DISABLED"
```

</details>

<details>
<summary>Variant 20</summary>

```luau
"ROLE_ICONS"
```

</details>

<details>
<summary>Variant 21</summary>

```luau
"ROLE_SUBSCRIPTIONS_AVAILABLE_FOR_PURCHASE"
```

</details>

<details>
<summary>Variant 22</summary>

```luau
"ROLE_SUBSCRIPTIONS_ENABLED"
```

</details>

<details>
<summary>Variant 23</summary>

```luau
"TICKETED_EVENTS_ENABLED"
```

</details>

<details>
<summary>Variant 24</summary>

```luau
"VANITY_URL"
```

</details>

<details>
<summary>Variant 25</summary>

```luau
"VERIFIED"
```

</details>

<details>
<summary>Variant 26</summary>

```luau
"VIP_REGIONS"
```

</details>

<details>
<summary>Variant 27</summary>

```luau
"WELCOME_SCREEN_ENABLED"
```

</details>

<div id="MutableGuildFeatures"></div>

## MutableGuildFeatures

https://discord.com/developers/docs/resources/guild#guild-object-mutable-guild-features

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#guild-object-mutable-guild-features
type MutableGuildFeatures = "COMMUNITY" | "DISCOVERABLE" | "INVITES_DISABLED" | "RAID_ALERTS_DISABLED"
```

</details>

Union with variants:

<details>
<summary>Variant 1</summary>

```luau
"COMMUNITY"
```

</details>

<details>
<summary>Variant 2</summary>

```luau
"DISCOVERABLE"
```

</details>

<details>
<summary>Variant 3</summary>

```luau
"INVITES_DISABLED"
```

</details>

<details>
<summary>Variant 4</summary>

```luau
"RAID_ALERTS_DISABLED"
```

</details>

<div id="StickerType"></div>

## StickerType

https://discord.com/developers/docs/resources/sticker#sticker-object-sticker-types

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/sticker#sticker-object-sticker-types
type StickerType = number
```

</details>

[number](#number)

<div id="StickerFormatType"></div>

## StickerFormatType

https://discord.com/developers/docs/resources/sticker#sticker-object-sticker-format-types

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/sticker#sticker-object-sticker-format-types
type StickerFormatType = number
```

</details>

[number](#number)

<div id="OAuth2Scopes"></div>

## OAuth2Scopes

https://discord.com/developers/docs/topics/oauth2#shared-resources-oauth2-scopes

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/topics/oauth2#shared-resources-oauth2-scopes
type OAuth2Scopes = "activities.read" | "activities.write" | "applications.builds.read" | "applications.builds.upload" | "applications.commands" | "applications.commands.update" | "applications.commands.permissions.update" | "applications.entitlements" | "applications.store.update" | "bot" | "connections" | "dm_channels.read" | "email" | "gdm.join" | "guilds" | "guilds.join" | "guilds.members.read" | "identify" | "messages.read" | "relationships.read" | "role_connections.write" | "rpc" | "rpc.activities.write" | "rpc.notifications.read" | "rpc.voice.read" | "rpc.voice.write" | "voice" | "webhook.incoming"
```

</details>

Union with variants:

<details>
<summary>Variant 1</summary>

```luau
"activities.read"
```

</details>

<details>
<summary>Variant 2</summary>

```luau
"activities.write"
```

</details>

<details>
<summary>Variant 3</summary>

```luau
"applications.builds.read"
```

</details>

<details>
<summary>Variant 4</summary>

```luau
"applications.builds.upload"
```

</details>

<details>
<summary>Variant 5</summary>

```luau
"applications.commands"
```

</details>

<details>
<summary>Variant 6</summary>

```luau
"applications.commands.update"
```

</details>

<details>
<summary>Variant 7</summary>

```luau
"applications.commands.permissions.update"
```

</details>

<details>
<summary>Variant 8</summary>

```luau
"applications.entitlements"
```

</details>

<details>
<summary>Variant 9</summary>

```luau
"applications.store.update"
```

</details>

<details>
<summary>Variant 10</summary>

```luau
"bot"
```

</details>

<details>
<summary>Variant 11</summary>

```luau
"connections"
```

</details>

<details>
<summary>Variant 12</summary>

```luau
"dm_channels.read"
```

</details>

<details>
<summary>Variant 13</summary>

```luau
"email"
```

</details>

<details>
<summary>Variant 14</summary>

```luau
"gdm.join"
```

</details>

<details>
<summary>Variant 15</summary>

```luau
"guilds"
```

</details>

<details>
<summary>Variant 16</summary>

```luau
"guilds.join"
```

</details>

<details>
<summary>Variant 17</summary>

```luau
"guilds.members.read"
```

</details>

<details>
<summary>Variant 18</summary>

```luau
"identify"
```

</details>

<details>
<summary>Variant 19</summary>

```luau
"messages.read"
```

</details>

<details>
<summary>Variant 20</summary>

```luau
"relationships.read"
```

</details>

<details>
<summary>Variant 21</summary>

```luau
"role_connections.write"
```

</details>

<details>
<summary>Variant 22</summary>

```luau
"rpc"
```

</details>

<details>
<summary>Variant 23</summary>

```luau
"rpc.activities.write"
```

</details>

<details>
<summary>Variant 24</summary>

```luau
"rpc.notifications.read"
```

</details>

<details>
<summary>Variant 25</summary>

```luau
"rpc.voice.read"
```

</details>

<details>
<summary>Variant 26</summary>

```luau
"rpc.voice.write"
```

</details>

<details>
<summary>Variant 27</summary>

```luau
"voice"
```

</details>

<details>
<summary>Variant 28</summary>

```luau
"webhook.incoming"
```

</details>

<div id="IntegrationType"></div>

## IntegrationType

https://discord.com/developers/docs/resources/guild#integration-object

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#integration-object
type IntegrationType = number
```

</details>

[number](#number)

<div id="ApplicationIntegrationType"></div>

## ApplicationIntegrationType

https://discord.com/developers/docs/resources/application#application-object-application-integration-types

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/application#application-object-application-integration-types
type ApplicationIntegrationType = number
```

</details>

[number](#number)

<div id="ApplicationCommandPermissionType"></div>

## ApplicationCommandPermissionType

https://discord.com/developers/docs/interactions/application-commands#application-command-permissions-object-application-command-permission-type

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/application-commands#application-command-permissions-object-application-command-permission-type
type ApplicationCommandPermissionType = number
```

</details>

[number](#number)

<div id="AutomoderationRuleEventType"></div>

## AutomoderationRuleEventType

https://discord.com/developers/docs/resources/auto-moderation#auto-moderation-rule-object-event-types

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/auto-moderation#auto-moderation-rule-object-event-types
type AutomoderationRuleEventType = number
```

</details>

[number](#number)

<div id="AutomoderationRuleTriggerType"></div>

## AutomoderationRuleTriggerType

https://discord.com/developers/docs/resources/auto-moderation#auto-moderation-rule-object-trigger-types

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/auto-moderation#auto-moderation-rule-object-trigger-types
type AutomoderationRuleTriggerType = number
```

</details>

[number](#number)

<div id="AutomoderationRuleKeywordPresetType"></div>

## AutomoderationRuleKeywordPresetType

https://discord.com/developers/docs/resources/auto-moderation#auto-moderation-rule-object-keyword-preset-types

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/auto-moderation#auto-moderation-rule-object-keyword-preset-types
type AutomoderationRuleKeywordPresetType = number
```

</details>

[number](#number)

<div id="AutomoderationActionType"></div>

## AutomoderationActionType

https://discord.com/developers/docs/resources/auto-moderation#auto-moderation-action-object-action-types

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/auto-moderation#auto-moderation-action-object-action-types
type AutomoderationActionType = number
```

</details>

[number](#number)

<div id="ChannelType"></div>

## ChannelType

https://discord.com/developers/docs/resources/channel#channel-object-channel-types

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#channel-object-channel-types
type ChannelType = number
```

</details>

[number](#number)

<div id="VideoQualityMode"></div>

## VideoQualityMode

https://discord.com/developers/docs/resources/channel#channel-object-video-quality-modes

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#channel-object-video-quality-modes
type VideoQualityMode = number
```

</details>

[number](#number)

<div id="ChannelFlags"></div>

## ChannelFlags

https://discord.com/developers/docs/resources/channel#channel-object-channel-flags

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#channel-object-channel-flags
type ChannelFlags = number
```

</details>

[number](#number)

<div id="SortOrderType"></div>

## SortOrderType

https://discord.com/developers/docs/resources/channel#channel-object-sort-order-types

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#channel-object-sort-order-types
type SortOrderType = number
```

</details>

[number](#number)

<div id="ForumLayoutType"></div>

## ForumLayoutType

https://discord.com/developers/docs/resources/channel#channel-object-forum-layout-types

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#channel-object-forum-layout-types
type ForumLayoutType = number
```

</details>

[number](#number)

<div id="OverwriteObjectType"></div>

## OverwriteObjectType

https://discord.com/developers/docs/resources/channel#overwrite-object

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#overwrite-object
type OverwriteObjectType = number
```

</details>

[number](#number)

<div id="EntitlementType"></div>

## EntitlementType

https://discord.com/developers/docs/monetization/entitlements#entitlement-object-entitlement-types

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/monetization/entitlements#entitlement-object-entitlement-types
type EntitlementType = number
```

</details>

[number](#number)

<div id="ActivityType"></div>

## ActivityType

https://discord.com/developers/docs/topics/gateway-events#activity-object-activity-types

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/topics/gateway-events#activity-object-activity-types
type ActivityType = number
```

</details>

[number](#number)

<div id="PrivacyLevel"></div>

## PrivacyLevel

https://discord.com/developers/docs/resources/stage-instance#stage-instance-object-privacy-level

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/stage-instance#stage-instance-object-privacy-level
type PrivacyLevel = number
```

</details>

[number](#number)

<div id="GuildScheduledEventStatus"></div>

## GuildScheduledEventStatus

https://discord.com/developers/docs/resources/guild-scheduled-event#guild-scheduled-event-object-guild-scheduled-event-status

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild-scheduled-event#guild-scheduled-event-object-guild-scheduled-event-status
type GuildScheduledEventStatus = number
```

</details>

[number](#number)

<div id="GuildScheduledEventEntityType"></div>

## GuildScheduledEventEntityType

https://discord.com/developers/docs/resources/guild-scheduled-event#guild-scheduled-event-object-guild-scheduled-event-entity-types

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild-scheduled-event#guild-scheduled-event-object-guild-scheduled-event-entity-types
type GuildScheduledEventEntityType = number
```

</details>

[number](#number)

<div id="IntegrationExpireBehaviours"></div>

## IntegrationExpireBehaviours

https://discord.com/developers/docs/resources/guild#integration-object-integration-expire-behaviors

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#integration-object-integration-expire-behaviors
type IntegrationExpireBehaviours = number
```

</details>

[number](#number)

<div id="InteractionType"></div>

## InteractionType

https://discord.com/developers/docs/interactions/receiving-and-responding#interaction-object-interaction-type

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/receiving-and-responding#interaction-object-interaction-type
type InteractionType = number
```

</details>

[number](#number)

<div id="EmbedType"></div>

## EmbedType

https://discord.com/developers/docs/resources/message#embed-object-embed-types

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/message#embed-object-embed-types
type EmbedType = "Rich" | "Image" | "Video" | "GIFV" | "Article" | "Link" | "PollResult"
```

</details>

Union with variants:

<details>
<summary>Variant 1</summary>

```luau
"Rich"
```

</details>

<details>
<summary>Variant 2</summary>

```luau
"Image"
```

</details>

<details>
<summary>Variant 3</summary>

```luau
"Video"
```

</details>

<details>
<summary>Variant 4</summary>

```luau
"GIFV"
```

</details>

<details>
<summary>Variant 5</summary>

```luau
"Article"
```

</details>

<details>
<summary>Variant 6</summary>

```luau
"Link"
```

</details>

<details>
<summary>Variant 7</summary>

```luau
"PollResult"
```

</details>

<div id="MessageType"></div>

## MessageType

https://discord.com/developers/docs/resources/channel#message-object-message-types

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#message-object-message-types
type MessageType = number
```

</details>

[number](#number)

<div id="MessageActivityType"></div>

## MessageActivityType

https://discord.com/developers/docs/resources/channel#message-object-message-activity-types

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#message-object-message-activity-types
type MessageActivityType = number
```

</details>

[number](#number)

<div id="ButtonStyle"></div>

## ButtonStyle

https://discord.com/developers/docs/interactions/message-components#button-object-button-styles

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/message-components#button-object-button-styles
type ButtonStyle = number
```

</details>

[number](#number)

<div id="TextInputStyles"></div>

## TextInputStyles

https://discord.com/developers/docs/interactions/message-components#text-input-object-text-input-styles

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/message-components#text-input-object-text-input-styles
type TextInputStyles = number
```

</details>

[number](#number)

<div id="PollLayoutType"></div>

## PollLayoutType

https://discord.com/developers/docs/resources/poll#layout-type

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/poll#layout-type
type PollLayoutType = number
```

</details>

[number](#number)

<div id="ApplicationCommandOptionType"></div>

## ApplicationCommandOptionType

https://discord.com/developers/docs/interactions/application-commands#application-command-object-application-command-option-type

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/application-commands#application-command-object-application-command-option-type
type ApplicationCommandOptionType = number
```

</details>

[number](#number)

<div id="InteractionContextType"></div>

## InteractionContextType

https://discord.com/developers/docs/interactions/receiving-and-responding#interaction-object-interaction-context-types

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/receiving-and-responding#interaction-object-interaction-context-types
type InteractionContextType = number
```

</details>

[number](#number)

<div id="InviteTypes"></div>

## InviteTypes

https://discord.com/developers/docs/resources/invite#invite-object-invite-types

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/invite#invite-object-invite-types
type InviteTypes = number
```

</details>

[number](#number)

<div id="InviteTargetTypes"></div>

## InviteTargetTypes

https://discord.com/developers/docs/resources/invite#invite-object-invite-target-types

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/invite#invite-object-invite-target-types
type InviteTargetTypes = number
```

</details>

[number](#number)

<div id="ReactionType"></div>

## ReactionType

https://discord.com/developers/docs/resources/channel#get-reactions-reaction-types

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#get-reactions-reaction-types
type ReactionType = number
```

</details>

[number](#number)

<div id="ApplicationRoleConnectionMetadataType"></div>

## ApplicationRoleConnectionMetadataType

https://discord.com/developers/docs/resources/application-role-connection-metadata#application-role-connection-metadata-object-application-role-connection-metadata-type

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/application-role-connection-metadata#application-role-connection-metadata-object-application-role-connection-metadata-type
type ApplicationRoleConnectionMetadataType = number
```

</details>

[number](#number)

<div id="ApplicationCommandType"></div>

## ApplicationCommandType

https://discord.com/developers/docs/interactions/application-commands#application-command-object-application-command-types

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/application-commands#application-command-object-application-command-types
type ApplicationCommandType = number
```

</details>

[number](#number)

<div id="AuditLogEventType"></div>

## AuditLogEventType

https://discord.com/developers/docs/resources/audit-log#audit-log-entry-object-audit-log-events

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/audit-log#audit-log-entry-object-audit-log-events
type AuditLogEventType = number
```

</details>

[number](#number)

<div id="WebhookType"></div>

## WebhookType

https://discord.com/developers/docs/resources/webhook#webhook-object-webhook-types

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/webhook#webhook-object-webhook-types
type WebhookType = number
```

</details>

[number](#number)

<div id="OnboardingMode"></div>

## OnboardingMode

https://discord.com/developers/docs/resources/guild#guild-onboarding-object-onboarding-mode

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#guild-onboarding-object-onboarding-mode
type OnboardingMode = number
```

</details>

[number](#number)

<div id="PromptTypes"></div>

## PromptTypes

https://discord.com/developers/docs/resources/guild#guild-onboarding-object-prompt-types

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#guild-onboarding-object-prompt-types
type PromptTypes = number
```

</details>

[number](#number)

<div id="ConnectionObjectServices"></div>

## ConnectionObjectServices

https://discord.com/developers/docs/resources/user#connection-object-services

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/user#connection-object-services
type ConnectionObjectServices = "battlenet" | "bungie" | "domain" | "ebay" | "epicgames" | "facebook" | "github" | "instagram" | "leagueoflegends" | "paypal" | "playstation" | "reddit" | "riotgames" | "spotify" | "skype" | "stream" | "tiktok" | "twitch" | "twitter" | "xbox" | "youtube"
```

</details>

Union with variants:

<details>
<summary>Variant 1</summary>

```luau
"battlenet"
```

</details>

<details>
<summary>Variant 2</summary>

```luau
"bungie"
```

</details>

<details>
<summary>Variant 3</summary>

```luau
"domain"
```

</details>

<details>
<summary>Variant 4</summary>

```luau
"ebay"
```

</details>

<details>
<summary>Variant 5</summary>

```luau
"epicgames"
```

</details>

<details>
<summary>Variant 6</summary>

```luau
"facebook"
```

</details>

<details>
<summary>Variant 7</summary>

```luau
"github"
```

</details>

<details>
<summary>Variant 8</summary>

```luau
"instagram"
```

</details>

<details>
<summary>Variant 9</summary>

```luau
"leagueoflegends"
```

</details>

<details>
<summary>Variant 10</summary>

```luau
"paypal"
```

</details>

<details>
<summary>Variant 11</summary>

```luau
"playstation"
```

</details>

<details>
<summary>Variant 12</summary>

```luau
"reddit"
```

</details>

<details>
<summary>Variant 13</summary>

```luau
"riotgames"
```

</details>

<details>
<summary>Variant 14</summary>

```luau
"spotify"
```

</details>

<details>
<summary>Variant 15</summary>

```luau
"skype"
```

</details>

<details>
<summary>Variant 16</summary>

```luau
"stream"
```

</details>

<details>
<summary>Variant 17</summary>

```luau
"tiktok"
```

</details>

<details>
<summary>Variant 18</summary>

```luau
"twitch"
```

</details>

<details>
<summary>Variant 19</summary>

```luau
"twitter"
```

</details>

<details>
<summary>Variant 20</summary>

```luau
"xbox"
```

</details>

<details>
<summary>Variant 21</summary>

```luau
"youtube"
```

</details>

<div id="AllowedMentionTypes"></div>

## AllowedMentionTypes

https://discord.com/developers/docs/resources/channel#allowed-mentions-object-allowed-mention-types

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#allowed-mentions-object-allowed-mention-types
type AllowedMentionTypes = "roles" | "users" | "everyone"
```

</details>

Union with variants:

<details>
<summary>Variant 1</summary>

```luau
"roles"
```

</details>

<details>
<summary>Variant 2</summary>

```luau
"users"
```

</details>

<details>
<summary>Variant 3</summary>

```luau
"everyone"
```

</details>

<div id="ConnectionVisibilityTypes"></div>

## ConnectionVisibilityTypes

https://discord.com/developers/docs/resources/user#connection-object-visibility-types

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/user#connection-object-visibility-types
type ConnectionVisibilityTypes = number
```

</details>

[number](#number)

<div id="MessageReferenceType"></div>

## MessageReferenceType

https://discord.com/developers/docs/resources/channel#message-reference-types

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/channel#message-reference-types
type MessageReferenceType = number
```

</details>

[number](#number)

<div id="GuildMemberFlags"></div>

## GuildMemberFlags

https://discord.com/developers/docs/resources/guild#guild-member-object-guild-member-flags

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/resources/guild#guild-member-object-guild-member-flags
type GuildMemberFlags = number
```

</details>

[number](#number)

<div id="InteractionCallbackType"></div>

## InteractionCallbackType

https://discord.com/developers/docs/interactions/receiving-and-responding#interaction-response-object-interaction-callback-type

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/receiving-and-responding#interaction-response-object-interaction-callback-type
type InteractionCallbackType = number
```

</details>

[number](#number)

<div id="ActivityTimestampObject"></div>

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

<div id="start"></div>

### start

[number](#number)

<div id="["end"]"></div>

### ["end"]

[number](#number)

<div id="ActivityEmojiObject"></div>

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

<div id="name"></div>

### name

[string](#string)

<div id="id"></div>

### id

[Snowflake](#Snowflake)

<div id="animated"></div>

### animated

*This field is optional and may not be specified*

[boolean](#boolean)?

<div id="ActivityPartyObject"></div>

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

<div id="id"></div>

### id

[string](#string)

<div id="size"></div>

### size

{[number](#number)}

<div id="ActivityAssetsObject"></div>

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

<div id="large_image"></div>

### large_image

[string](#string)

<div id="large_text"></div>

### large_text

[string](#string)

<div id="small_image"></div>

### small_image

[string](#string)

<div id="small_text"></div>

### small_text

[string](#string)

<div id="ActivitySecretsObject"></div>

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

<div id="join"></div>

### join

*This field is optional and may not be specified*

[string](#string)?

<div id="spectate"></div>

### spectate

*This field is optional and may not be specified*

[string](#string)?

<div id="match"></div>

### match

*This field is optional and may not be specified*

[string](#string)?

<div id="ActivityButtonsObject"></div>

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

<div id="label"></div>

### label

[string](#string)

<div id="url"></div>

### url

[string](#string)

<div id="ActivityObject"></div>

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

<div id="name"></div>

### name

[string](#string)

<div id="type"></div>

### type

[number](#number)

<div id="url"></div>

### url

*This field is optional and may not be specified*

[string](#string)?

<div id="created_at"></div>

### created_at

[number](#number)

<div id="timestamps"></div>

### timestamps

[ActivityTimestampObject](#ActivityTimestampObject)

<div id="application_id"></div>

### application_id

[Snowflake](#Snowflake)

<div id="details"></div>

### details

*This field is optional and may not be specified*

[string](#string)?

<div id="state"></div>

### state

*This field is optional and may not be specified*

[string](#string)?

<div id="emoji"></div>

### emoji

*This field is optional and may not be specified*

[ActivityEmojiObject](#ActivityEmojiObject)?

<div id="party"></div>

### party

*This field is optional and may not be specified*

[ActivityPartyObject](#ActivityPartyObject)?

<div id="assets"></div>

### assets

*This field is optional and may not be specified*

[ActivityAssetsObject](#ActivityAssetsObject)?

<div id="secrets"></div>

### secrets

*This field is optional and may not be specified*

[ActivitySecretsObject](#ActivitySecretsObject)?

<div id="instance"></div>

### instance

*This field is optional and may not be specified*

[boolean](#boolean)?

<div id="flags"></div>

### flags

*This field is optional and may not be specified*

[number](#number)?

<div id="buttons"></div>

### buttons

*This field is optional and may not be specified*

{[ActivityButtonsObject](#ActivityButtonsObject)}?

<div id="PresenceObject"></div>

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

<div id="since"></div>

### since

[number](#number)

<div id="activities"></div>

### activities

{[ActivityObject](#ActivityObject)}

<div id="status"></div>

### status

[string](#string)

<div id="afk"></div>

### afk

[boolean](#boolean)

<div id="IdentifyPropertiesObject"></div>

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

<div id="os"></div>

### os

[string](#string)

<div id="browser"></div>

### browser

[string](#string)

<div id="device"></div>

### device

[string](#string)

<div id="AvatarDecorationDataObject"></div>

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

<div id="asset"></div>

### asset

[string](#string)

<div id="sku_id"></div>

### sku_id

[Snowflake](#Snowflake)

<div id="UserObject"></div>

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

<div id="id"></div>

### id

[Snowflake](#Snowflake)

<div id="username"></div>

### username

[string](#string)

<div id="discriminator"></div>

### discriminator

[string](#string)

<div id="global_name"></div>

### global_name

[string](#string)

<div id="avatar"></div>

### avatar

[string](#string)

<div id="bot"></div>

### bot

*This field is optional and may not be specified*

[boolean](#boolean)?

<div id="system"></div>

### system

*This field is optional and may not be specified*

[boolean](#boolean)?

<div id="mfa_enabled"></div>

### mfa_enabled

*This field is optional and may not be specified*

[boolean](#boolean)?

<div id="banner"></div>

### banner

*This field is optional and may not be specified*

[string](#string)?

<div id="accent_color"></div>

### accent_color

*This field is optional and may not be specified*

[number](#number)?

<div id="locale"></div>

### locale

*This field is optional and may not be specified*

[LanguageLocales](#LanguageLocales)?

<div id="verified"></div>

### verified

*This field is optional and may not be specified*

[boolean](#boolean)?

<div id="email"></div>

### email

*This field is optional and may not be specified*

[string](#string)?

<div id="flags"></div>

### flags

*This field is optional and may not be specified*

[number](#number)?

<div id="premium_type"></div>

### premium_type

*This field is optional and may not be specified*

[PremiumTypes](#PremiumTypes)?

<div id="public_flags"></div>

### public_flags

*This field is optional and may not be specified*

[number](#number)?

<div id="avatar_decoration_data"></div>

### avatar_decoration_data

*This field is optional and may not be specified*

[AvatarDecorationDataObject](#AvatarDecorationDataObject)?

<div id="UnavailableGuildObject"></div>

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

<div id="id"></div>

### id

[Snowflake](#Snowflake)

<div id="unavailable"></div>

### unavailable

[boolean](#boolean)

<div id="TeamMemberObject"></div>

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

<div id="membership_state"></div>

### membership_state

[MembershipState](#MembershipState)

<div id="team_id"></div>

### team_id

[Snowflake](#Snowflake)

<div id="user"></div>

### user

[UserObject](#UserObject)

<div id="role"></div>

### role

[TeamMemberRole](#TeamMemberRole)

<div id="TeamObject"></div>

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

<div id="icon"></div>

### icon

[string](#string)

<div id="id"></div>

### id

[Snowflake](#Snowflake)

<div id="members"></div>

### members

{[TeamMemberObject](#TeamMemberObject)}

<div id="name"></div>

### name

[string](#string)

<div id="owner_user_id"></div>

### owner_user_id

[Snowflake](#Snowflake)

<div id="GuildRoleTagObject"></div>

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

<div id="bot_id"></div>

### bot_id

*This field is optional and may not be specified*

[Snowflake](#Snowflake)?

<div id="integration_id"></div>

### integration_id

*This field is optional and may not be specified*

[Snowflake](#Snowflake)?

<div id="premium_subscriber"></div>

### premium_subscriber

[nil](#nil)

<div id="subscription_listing_id"></div>

### subscription_listing_id

[Snowflake](#Snowflake)

<div id="available_for_purchase"></div>

### available_for_purchase

[nil](#nil)

<div id="guild_connections"></div>

### guild_connections

[nil](#nil)

<div id="GuildRoleObject"></div>

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

<div id="id"></div>

### id

*This field is optional and may not be specified*

[Snowflake](#Snowflake)?

<div id="name"></div>

### name

[string](#string)

<div id="color"></div>

### color

[number](#number)

<div id="hoist"></div>

### hoist

[boolean](#boolean)

<div id="icon"></div>

### icon

*This field is optional and may not be specified*

[string](#string)?

<div id="unicode_emoji"></div>

### unicode_emoji

*This field is optional and may not be specified*

[string](#string)?

<div id="position"></div>

### position

[number](#number)

<div id="permissions"></div>

### permissions

[string](#string)

<div id="managed"></div>

### managed

[boolean](#boolean)

<div id="mentionable"></div>

### mentionable

[boolean](#boolean)

<div id="tags"></div>

### tags

*This field is optional and may not be specified*

[GuildRoleTagObject](#GuildRoleTagObject)?

<div id="flags"></div>

### flags

[number](#number)

<div id="EmojiObject"></div>

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

<div id="id"></div>

### id

*This field is optional and may not be specified*

[Snowflake](#Snowflake)?

<div id="name"></div>

### name

[string](#string)

<div id="roles"></div>

### roles

*This field is optional and may not be specified*

{[Snowflake](#Snowflake)}?

<div id="user"></div>

### user

*This field is optional and may not be specified*

[UserObject](#UserObject)?

<div id="require_colons"></div>

### require_colons

*This field is optional and may not be specified*

[boolean](#boolean)?

<div id="managed"></div>

### managed

*This field is optional and may not be specified*

[boolean](#boolean)?

<div id="animated"></div>

### animated

*This field is optional and may not be specified*

[boolean](#boolean)?

<div id="available"></div>

### available

*This field is optional and may not be specified*

[boolean](#boolean)?

<div id="WelcomeScreenChannelObject"></div>

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

<div id="channel_id"></div>

### channel_id

*This field is optional and may not be specified*

[Snowflake](#Snowflake)?

<div id="description"></div>

### description

*This field is optional and may not be specified*

[string](#string)?

<div id="emoji_id"></div>

### emoji_id

*This field is optional and may not be specified*

[Snowflake](#Snowflake)?

<div id="emoji_name"></div>

### emoji_name

*This field is optional and may not be specified*

[string](#string)?

<div id="WelcomeScreenObject"></div>

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

<div id="description"></div>

### description

[string](#string)

<div id="welcome_channels"></div>

### welcome_channels

{[WelcomeScreenChannelObject](#WelcomeScreenChannelObject)}

<div id="StickerObject"></div>

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

<div id="id"></div>

### id

[Snowflake](#Snowflake)

<div id="pack_id"></div>

### pack_id

[Snowflake](#Snowflake)

<div id="name"></div>

### name

[string](#string)

<div id="description"></div>

### description

*This field is optional and may not be specified*

[string](#string)?

<div id="tags"></div>

### tags

[string](#string)

<div id="asset"></div>

### asset

*This field is optional and may not be specified*

[string](#string)?

<div id="type"></div>

### type

[StickerType](#StickerType)

<div id="format_type"></div>

### format_type

[StickerFormatType](#StickerFormatType)

<div id="available"></div>

### available

*This field is optional and may not be specified*

[boolean](#boolean)?

<div id="guild_id"></div>

### guild_id

*This field is optional and may not be specified*

[Snowflake](#Snowflake)?

<div id="user"></div>

### user

*This field is optional and may not be specified*

[UserObject](#UserObject)?

<div id="sort_value"></div>

### sort_value

*This field is optional and may not be specified*

[number](#number)?

<div id="GuildObject"></div>

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

<div id="id"></div>

### id

*This field is optional and may not be specified*

[Snowflake](#Snowflake)?

<div id="name"></div>

### name

*This field is optional and may not be specified*

[string](#string)?

<div id="icon"></div>

### icon

*This field is optional and may not be specified*

[string](#string)?

<div id="icon_hash"></div>

### icon_hash

*This field is optional and may not be specified*

[string](#string)?

<div id="splash"></div>

### splash

*This field is optional and may not be specified*

[string](#string)?

<div id="discovery_splash"></div>

### discovery_splash

*This field is optional and may not be specified*

[string](#string)?

<div id="owner"></div>

### owner

*This field is optional and may not be specified*

[boolean](#boolean)?

<div id="owner_id"></div>

### owner_id

*This field is optional and may not be specified*

[Snowflake](#Snowflake)?

<div id="permissions"></div>

### permissions

*This field is optional and may not be specified*

[string](#string)?

<div id="region"></div>

### region

*This field is optional and may not be specified*

[string](#string)?

<div id="afk_channel_id"></div>

### afk_channel_id

*This field is optional and may not be specified*

[Snowflake](#Snowflake)?

<div id="afk_timeout"></div>

### afk_timeout

*This field is optional and may not be specified*

[number](#number)?

<div id="widget_enabled"></div>

### widget_enabled

*This field is optional and may not be specified*

[boolean](#boolean)?

<div id="widget_channel_id"></div>

### widget_channel_id

*This field is optional and may not be specified*

[Snowflake](#Snowflake)?

<div id="verification_level"></div>

### verification_level

*This field is optional and may not be specified*

[VerificationLevel](#VerificationLevel)?

<div id="default_message_notifications"></div>

### default_message_notifications

*This field is optional and may not be specified*

[DefaultMessageNotification](#DefaultMessageNotification)?

<div id="explicit_content_filter"></div>

### explicit_content_filter

*This field is optional and may not be specified*

[ExplicitContentFilterLevel](#ExplicitContentFilterLevel)?

<div id="roles"></div>

### roles

*This field is optional and may not be specified*

{[GuildRoleObject](#GuildRoleObject)}?

<div id="emojis"></div>

### emojis

*This field is optional and may not be specified*

{[EmojiObject](#EmojiObject)}?

<div id="features"></div>

### features

*This field is optional and may not be specified*

{[GuildFeature](#GuildFeature)}?

<div id="mfa_level"></div>

### mfa_level

*This field is optional and may not be specified*

[MFALevel](#MFALevel)?

<div id="application_id"></div>

### application_id

*This field is optional and may not be specified*

[Snowflake](#Snowflake)?

<div id="system_channel_id"></div>

### system_channel_id

*This field is optional and may not be specified*

[Snowflake](#Snowflake)?

<div id="system_channel_flags"></div>

### system_channel_flags

*This field is optional and may not be specified*

[SystemChannelFlags](#SystemChannelFlags)?

<div id="rules_channel_id"></div>

### rules_channel_id

*This field is optional and may not be specified*

[Snowflake](#Snowflake)?

<div id="max_presences"></div>

### max_presences

*This field is optional and may not be specified*

[number](#number)?

<div id="max_members"></div>

### max_members

*This field is optional and may not be specified*

[number](#number)?

<div id="vanity_url_code"></div>

### vanity_url_code

*This field is optional and may not be specified*

[string](#string)?

<div id="description"></div>

### description

*This field is optional and may not be specified*

[string](#string)?

<div id="banner"></div>

### banner

*This field is optional and may not be specified*

[string](#string)?

<div id="premium_tier"></div>

### premium_tier

*This field is optional and may not be specified*

[PremiumTier](#PremiumTier)?

<div id="premium_subscription_count"></div>

### premium_subscription_count

*This field is optional and may not be specified*

[number](#number)?

<div id="preferred_locale"></div>

### preferred_locale

*This field is optional and may not be specified*

[LanguageLocales](#LanguageLocales)?

<div id="public_updates_channel_id"></div>

### public_updates_channel_id

*This field is optional and may not be specified*

[Snowflake](#Snowflake)?

<div id="max_video_channel_users"></div>

### max_video_channel_users

*This field is optional and may not be specified*

[number](#number)?

<div id="max_stage_video_channel_users"></div>

### max_stage_video_channel_users

*This field is optional and may not be specified*

[number](#number)?

<div id="approximate_member_count"></div>

### approximate_member_count

*This field is optional and may not be specified*

[number](#number)?

<div id="approximate_presence_count"></div>

### approximate_presence_count

*This field is optional and may not be specified*

[number](#number)?

<div id="welcome_screen"></div>

### welcome_screen

*This field is optional and may not be specified*

[WelcomeScreenObject](#WelcomeScreenObject)?

<div id="nsfw_level"></div>

### nsfw_level

*This field is optional and may not be specified*

[GuildNSFWLevel](#GuildNSFWLevel)?

<div id="stickers"></div>

### stickers

*This field is optional and may not be specified*

{[StickerObject](#StickerObject)}?

<div id="premium_progress_bar_enabled"></div>

### premium_progress_bar_enabled

*This field is optional and may not be specified*

[boolean](#boolean)?

<div id="safety_alerts_channel_id"></div>

### safety_alerts_channel_id

*This field is optional and may not be specified*

[Snowflake](#Snowflake)?

<div id="InstallParamsObject"></div>

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

<div id="scopes"></div>

### scopes

{[OAuth2Scopes](#OAuth2Scopes)}

<div id="permissions"></div>

### permissions

[string](#string)

<div id="ApplicationObject"></div>

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

<div id="id"></div>

### id

[Snowflake](#Snowflake)

<div id="name"></div>

### name

[string](#string)

<div id="icon"></div>

### icon

*This field is optional and may not be specified*

[string](#string)?

<div id="description"></div>

### description

[string](#string)

<div id="rpc_origins"></div>

### rpc_origins

*This field is optional and may not be specified*

{[string](#string)}?

<div id="bot_public"></div>

### bot_public

[boolean](#boolean)

<div id="bot_require_code_grant"></div>

### bot_require_code_grant

[boolean](#boolean)

<div id="bot"></div>

### bot

*This field is optional and may not be specified*

[UserObject](#UserObject)?

<div id="terms_of_service_url"></div>

### terms_of_service_url

*This field is optional and may not be specified*

[string](#string)?

<div id="privacy_policy_url"></div>

### privacy_policy_url

*This field is optional and may not be specified*

[string](#string)?

<div id="owner"></div>

### owner

*This field is optional and may not be specified*

[UserObject](#UserObject)?

<div id="summary"></div>

### summary

[string](#string)

<div id="verify_key"></div>

### verify_key

[string](#string)

<div id="team"></div>

### team

*This field is optional and may not be specified*

[TeamObject](#TeamObject)?

<div id="guild_id"></div>

### guild_id

*This field is optional and may not be specified*

[Snowflake](#Snowflake)?

<div id="guild"></div>

### guild

*This field is optional and may not be specified*

[GuildObject](#GuildObject)?

<div id="primary_sku_id"></div>

### primary_sku_id

*This field is optional and may not be specified*

[Snowflake](#Snowflake)?

<div id="slug"></div>

### slug

*This field is optional and may not be specified*

[string](#string)?

<div id="cover_image"></div>

### cover_image

*This field is optional and may not be specified*

[string](#string)?

<div id="flags"></div>

### flags

*This field is optional and may not be specified*

[number](#number)?

<div id="approximate_guild_count"></div>

### approximate_guild_count

*This field is optional and may not be specified*

[number](#number)?

<div id="redirect_uris"></div>

### redirect_uris

*This field is optional and may not be specified*

{[string](#string)}?

<div id="interactions_endpoint_url"></div>

### interactions_endpoint_url

*This field is optional and may not be specified*

[string](#string)?

<div id="role_connections_verification_url"></div>

### role_connections_verification_url

*This field is optional and may not be specified*

[string](#string)?

<div id="tags"></div>

### tags

*This field is optional and may not be specified*

{[string](#string)}?

<div id="install_params"></div>

### install_params

*This field is optional and may not be specified*

[InstallParamsObject](#InstallParamsObject)?

<div id="integration_types_config"></div>

### integration_types_config

*This field is optional and may not be specified*

[boolean](#boolean)?

<div id="custom_install_url"></div>

### custom_install_url

*This field is optional and may not be specified*

[string](#string)?

<div id="GuildApplicationCommandPermissionObject"></div>

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

<div id="id"></div>

### id

[Snowflake](#Snowflake)

<div id="type"></div>

### type

[ApplicationCommandPermissionType](#ApplicationCommandPermissionType)

<div id="permission"></div>

### permission

[boolean](#boolean)

<div id="GuildApplicationCommandPermissionsObject"></div>

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

<div id="id"></div>

### id

[Snowflake](#Snowflake)

<div id="application_id"></div>

### application_id

[Snowflake](#Snowflake)

<div id="guild_id"></div>

### guild_id

[Snowflake](#Snowflake)

<div id="permissions"></div>

### permissions

{[GuildApplicationCommandPermissionObject](#GuildApplicationCommandPermissionObject)}

<div id="AutomoderationRuleTriggerMetadataObject"></div>

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

<div id="keyword_filter"></div>

### keyword_filter

{[string](#string)}

<div id="regex_patterns"></div>

### regex_patterns

{[string](#string)}

<div id="presets"></div>

### presets

{[AutomoderationRuleKeywordPresetType](#AutomoderationRuleKeywordPresetType)}

<div id="allow_list"></div>

### allow_list

{[string](#string)}

<div id="mention_total_limit"></div>

### mention_total_limit

[number](#number)

<div id="mention_raid_protection_enabled"></div>

### mention_raid_protection_enabled

[boolean](#boolean)

<div id="AutmoderationActionMetadataObject"></div>

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

<div id="channel_id"></div>

### channel_id

[Snowflake](#Snowflake)

<div id="duration_seconds"></div>

### duration_seconds

[number](#number)

<div id="custom_message"></div>

### custom_message

*This field is optional and may not be specified*

[string](#string)?

<div id="AutomoderationActionObject"></div>

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

<div id="type"></div>

### type

[AutomoderationActionType](#AutomoderationActionType)

<div id="metadata"></div>

### metadata

*This field is optional and may not be specified*

[AutmoderationActionMetadataObject](#AutmoderationActionMetadataObject)?

<div id="AutomoderationRuleObject"></div>

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

<div id="id"></div>

### id

[Snowflake](#Snowflake)

<div id="guild_id"></div>

### guild_id

[Snowflake](#Snowflake)

<div id="name"></div>

### name

[string](#string)

<div id="creator_id"></div>

### creator_id

[Snowflake](#Snowflake)

<div id="event_type"></div>

### event_type

[AutomoderationRuleEventType](#AutomoderationRuleEventType)

<div id="trigger_type"></div>

### trigger_type

[AutomoderationRuleTriggerType](#AutomoderationRuleTriggerType)

<div id="trigger_metadata"></div>

### trigger_metadata

[AutomoderationRuleTriggerMetadataObject](#AutomoderationRuleTriggerMetadataObject)

<div id="actions"></div>

### actions

{[AutomoderationActionObject](#AutomoderationActionObject)}

<div id="enabled"></div>

### enabled

[boolean](#boolean)

<div id="exempt_roles"></div>

### exempt_roles

{[Snowflake](#Snowflake)}

<div id="exempt_channels"></div>

### exempt_channels

{[Snowflake](#Snowflake)}

<div id="OverwriteObject"></div>

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

<div id="id"></div>

### id

[Snowflake](#Snowflake)

<div id="type"></div>

### type

[OverwriteObjectType](#OverwriteObjectType)

<div id="allow"></div>

### allow

[string](#string)

<div id="deny"></div>

### deny

[string](#string)

<div id="ThreadMetadataObject"></div>

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

<div id="archived"></div>

### archived

[boolean](#boolean)

<div id="auto_archive_duration"></div>

### auto_archive_duration

[number](#number)

<div id="archive_timestamp"></div>

### archive_timestamp

[string](#string)

<div id="locked"></div>

### locked

[boolean](#boolean)

<div id="invitable"></div>

### invitable

*This field is optional and may not be specified*

[boolean](#boolean)?

<div id="create_timestamp"></div>

### create_timestamp

[string](#string)

<div id="GuildMemberObject"></div>

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

<div id="user"></div>

### user

*This field is optional and may not be specified*

[UserObject](#UserObject)?

<div id="nick"></div>

### nick

*This field is optional and may not be specified*

[string](#string)?

<div id="avatar"></div>

### avatar

*This field is optional and may not be specified*

[string](#string)?

<div id="roles"></div>

### roles

{[Snowflake](#Snowflake)}

<div id="joined_at"></div>

### joined_at

[string](#string)

<div id="premium_since"></div>

### premium_since

*This field is optional and may not be specified*

[string](#string)?

<div id="deaf"></div>

### deaf

[boolean](#boolean)

<div id="mute"></div>

### mute

[boolean](#boolean)

<div id="flags"></div>

### flags

[number](#number)

<div id="pending"></div>

### pending

*This field is optional and may not be specified*

[boolean](#boolean)?

<div id="permissions"></div>

### permissions

*This field is optional and may not be specified*

[string](#string)?

<div id="communication_disabled_until"></div>

### communication_disabled_until

*This field is optional and may not be specified*

[string](#string)?

<div id="avatar_decoration_data"></div>

### avatar_decoration_data

*This field is optional and may not be specified*

[AvatarDecorationDataObject](#AvatarDecorationDataObject)?

<div id="ThreadMemberObject"></div>

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

<div id="id"></div>

### id

*This field is optional and may not be specified*

[Snowflake](#Snowflake)?

<div id="user_id"></div>

### user_id

*This field is optional and may not be specified*

[Snowflake](#Snowflake)?

<div id="join_timestamp"></div>

### join_timestamp

[string](#string)

<div id="flags"></div>

### flags

[number](#number)

<div id="member"></div>

### member

*This field is optional and may not be specified*

[GuildMemberObject](#GuildMemberObject)?

<div id="ForumTagObject"></div>

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

<div id="id"></div>

### id

[Snowflake](#Snowflake)

<div id="name"></div>

### name

[string](#string)

<div id="moderated"></div>

### moderated

[boolean](#boolean)

<div id="emoji_id"></div>

### emoji_id

*This field is optional and may not be specified*

[string](#string)?

<div id="emoji_name"></div>

### emoji_name

*This field is optional and may not be specified*

[string](#string)?

<div id="DefaultReactionObject"></div>

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

<div id="emoji_id"></div>

### emoji_id

*This field is optional and may not be specified*

[string](#string)?

<div id="emoji_name"></div>

### emoji_name

*This field is optional and may not be specified*

[string](#string)?

<div id="ChannelObject"></div>

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

<div id="id"></div>

### id

*This field is optional and may not be specified*

[Snowflake](#Snowflake)?

<div id="type"></div>

### type

[ChannelType](#ChannelType)

<div id="guild_id"></div>

### guild_id

*This field is optional and may not be specified*

[Snowflake](#Snowflake)?

<div id="position"></div>

### position

[number](#number)

<div id="permission_overwrites"></div>

### permission_overwrites

{[OverwriteObject](#OverwriteObject)}

<div id="name"></div>

### name

[string](#string)

<div id="topic"></div>

### topic

*This field is optional and may not be specified*

[string](#string)?

<div id="nsfw"></div>

### nsfw

*This field is optional and may not be specified*

[boolean](#boolean)?

<div id="last_message_id"></div>

### last_message_id

*This field is optional and may not be specified*

[Snowflake](#Snowflake)?

<div id="bitrate"></div>

### bitrate

*This field is optional and may not be specified*

[number](#number)?

<div id="user_limit"></div>

### user_limit

*This field is optional and may not be specified*

[number](#number)?

<div id="rate_limit_per_user"></div>

### rate_limit_per_user

*This field is optional and may not be specified*

[number](#number)?

<div id="recipients"></div>

### recipients

*This field is optional and may not be specified*

{[UserObject](#UserObject)}?

<div id="icon"></div>

### icon

*This field is optional and may not be specified*

[string](#string)?

<div id="owner_id"></div>

### owner_id

*This field is optional and may not be specified*

[Snowflake](#Snowflake)?

<div id="application_id"></div>

### application_id

*This field is optional and may not be specified*

[Snowflake](#Snowflake)?

<div id="managed"></div>

### managed

*This field is optional and may not be specified*

[boolean](#boolean)?

<div id="parent_id"></div>

### parent_id

*This field is optional and may not be specified*

[Snowflake](#Snowflake)?

<div id="last_pin_timestamp"></div>

### last_pin_timestamp

*This field is optional and may not be specified*

[string](#string)?

<div id="rtc_region"></div>

### rtc_region

*This field is optional and may not be specified*

[string](#string)?

<div id="video_quality_mode"></div>

### video_quality_mode

*This field is optional and may not be specified*

[VideoQualityMode](#VideoQualityMode)?

<div id="message_count"></div>

### message_count

*This field is optional and may not be specified*

[number](#number)?

<div id="member_count"></div>

### member_count

*This field is optional and may not be specified*

[number](#number)?

<div id="thread_metadata"></div>

### thread_metadata

*This field is optional and may not be specified*

[ThreadMetadataObject](#ThreadMetadataObject)?

<div id="member"></div>

### member

*This field is optional and may not be specified*

[ThreadMemberObject](#ThreadMemberObject)?

<div id="default_auto_archive_duration"></div>

### default_auto_archive_duration

*This field is optional and may not be specified*

[number](#number)?

<div id="permissions"></div>

### permissions

*This field is optional and may not be specified*

[string](#string)?

<div id="flags"></div>

### flags

*This field is optional and may not be specified*

[ChannelFlags](#ChannelFlags)?

<div id="total_message_sent"></div>

### total_message_sent

*This field is optional and may not be specified*

[number](#number)?

<div id="available_tags"></div>

### available_tags

*This field is optional and may not be specified*

{[ForumTagObject](#ForumTagObject)}?

<div id="applied_tags"></div>

### applied_tags

*This field is optional and may not be specified*

{[Snowflake](#Snowflake)}?

<div id="default_reaction_emoji"></div>

### default_reaction_emoji

*This field is optional and may not be specified*

[DefaultReactionObject](#DefaultReactionObject)?

<div id="default_thread_rate_limit_per_user"></div>

### default_thread_rate_limit_per_user

*This field is optional and may not be specified*

[number](#number)?

<div id="default_sort_order"></div>

### default_sort_order

*This field is optional and may not be specified*

[SortOrderType](#SortOrderType)?

<div id="default_forum_layout"></div>

### default_forum_layout

*This field is optional and may not be specified*

[ForumLayoutType](#ForumLayoutType)?

<div id="EntitlementObject"></div>

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

<div id="id"></div>

### id

[Snowflake](#Snowflake)

<div id="sku_id"></div>

### sku_id

[Snowflake](#Snowflake)

<div id="application_id"></div>

### application_id

[Snowflake](#Snowflake)

<div id="user_id"></div>

### user_id

*This field is optional and may not be specified*

[Snowflake](#Snowflake)?

<div id="type"></div>

### type

[EntitlementType](#EntitlementType)

<div id="deleted"></div>

### deleted

[boolean](#boolean)

<div id="starts_at"></div>

### starts_at

*This field is optional and may not be specified*

[string](#string)?

<div id="ends_at"></div>

### ends_at

*This field is optional and may not be specified*

[string](#string)?

<div id="guild_id"></div>

### guild_id

*This field is optional and may not be specified*

[Snowflake](#Snowflake)?

<div id="consumed"></div>

### consumed

*This field is optional and may not be specified*

[boolean](#boolean)?

<div id="VoiceStateObject"></div>

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

<div id="guild_id"></div>

### guild_id

*This field is optional and may not be specified*

[Snowflake](#Snowflake)?

<div id="channel_id"></div>

### channel_id

*This field is optional and may not be specified*

[Snowflake](#Snowflake)?

<div id="user_id"></div>

### user_id

[Snowflake](#Snowflake)

<div id="member"></div>

### member

*This field is optional and may not be specified*

[GuildMemberObject](#GuildMemberObject)?

<div id="session_id"></div>

### session_id

[string](#string)

<div id="deaf"></div>

### deaf

[boolean](#boolean)

<div id="mute"></div>

### mute

[boolean](#boolean)

<div id="self_deaf"></div>

### self_deaf

[boolean](#boolean)

<div id="self_mute"></div>

### self_mute

[boolean](#boolean)

<div id="self_stream"></div>

### self_stream

*This field is optional and may not be specified*

[boolean](#boolean)?

<div id="self_video"></div>

### self_video

[boolean](#boolean)

<div id="suppress"></div>

### suppress

[boolean](#boolean)

<div id="request_to_speak_timestamp"></div>

### request_to_speak_timestamp

*This field is optional and may not be specified*

[string](#string)?

<div id="ClientStatusObject"></div>

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

<div id="desktop"></div>

### desktop

*This field is optional and may not be specified*

[string](#string)?

<div id="mobile"></div>

### mobile

*This field is optional and may not be specified*

[string](#string)?

<div id="web"></div>

### web

*This field is optional and may not be specified*

[string](#string)?

<div id="PresenceUpdateObject"></div>

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

<div id="user"></div>

### user

[UserObject](#UserObject)

<div id="guild_id"></div>

### guild_id

[Snowflake](#Snowflake)

<div id="status"></div>

### status

[string](#string)

<div id="activities"></div>

### activities

{[ActivityObject](#ActivityObject)}

<div id="client_status"></div>

### client_status

[ClientStatusObject](#ClientStatusObject)

<div id="StageInstanceObject"></div>

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

<div id="id"></div>

### id

[Snowflake](#Snowflake)

<div id="guild_id"></div>

### guild_id

[Snowflake](#Snowflake)

<div id="channel_id"></div>

### channel_id

[Snowflake](#Snowflake)

<div id="topic"></div>

### topic

[string](#string)

<div id="privacy_level"></div>

### privacy_level

[PrivacyLevel](#PrivacyLevel)

<div id="discoverable_disabled"></div>

### discoverable_disabled

[boolean](#boolean)

<div id="guild_scheduled_event_id"></div>

### guild_scheduled_event_id

*This field is optional and may not be specified*

[Snowflake](#Snowflake)?

<div id="GuildScheduledEventEntityMetadata"></div>

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

<div id="location"></div>

### location

[string](#string)

<div id="GuildScheduledEventObject"></div>

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

<div id="id"></div>

### id

[Snowflake](#Snowflake)

<div id="guild_id"></div>

### guild_id

[Snowflake](#Snowflake)

<div id="channel_id"></div>

### channel_id

*This field is optional and may not be specified*

[Snowflake](#Snowflake)?

<div id="creator_id"></div>

### creator_id

*This field is optional and may not be specified*

[Snowflake](#Snowflake)?

<div id="name"></div>

### name

[string](#string)

<div id="description"></div>

### description

*This field is optional and may not be specified*

[string](#string)?

<div id="scheduled_start_time"></div>

### scheduled_start_time

[string](#string)

<div id="scheduled_end_time"></div>

### scheduled_end_time

*This field is optional and may not be specified*

[string](#string)?

<div id="privacy_level"></div>

### privacy_level

[PrivacyLevel](#PrivacyLevel)

<div id="status"></div>

### status

[GuildScheduledEventStatus](#GuildScheduledEventStatus)

<div id="entity_type"></div>

### entity_type

[GuildScheduledEventEntityType](#GuildScheduledEventEntityType)

<div id="entity_id"></div>

### entity_id

*This field is optional and may not be specified*

[Snowflake](#Snowflake)?

<div id="entity_metadata"></div>

### entity_metadata

*This field is optional and may not be specified*

[GuildScheduledEventEntityMetadata](#GuildScheduledEventEntityMetadata)?

<div id="creator"></div>

### creator

*This field is optional and may not be specified*

[UserObject](#UserObject)?

<div id="user_count"></div>

### user_count

[number](#number)

<div id="image"></div>

### image

*This field is optional and may not be specified*

[string](#string)?

<div id="IntegrationAccountObject"></div>

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

<div id="id"></div>

### id

[string](#string)

<div id="name"></div>

### name

[string](#string)

<div id="IntegrationObject"></div>

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

<div id="id"></div>

### id

[Snowflake](#Snowflake)

<div id="name"></div>

### name

[string](#string)

<div id="type"></div>

### type

[IntegrationType](#IntegrationType)

<div id="enabled"></div>

### enabled

[boolean](#boolean)

<div id="syncing"></div>

### syncing

*This field is optional and may not be specified*

[boolean](#boolean)?

<div id="role_id"></div>

### role_id

*This field is optional and may not be specified*

[Snowflake](#Snowflake)?

<div id="enable_emoticons"></div>

### enable_emoticons

*This field is optional and may not be specified*

[boolean](#boolean)?

<div id="expire_behaviour"></div>

### expire_behaviour

*This field is optional and may not be specified*

[IntegrationExpireBehaviours](#IntegrationExpireBehaviours)?

<div id="expire_grace_period"></div>

### expire_grace_period

*This field is optional and may not be specified*

[number](#number)?

<div id="user"></div>

### user

*This field is optional and may not be specified*

[UserObject](#UserObject)?

<div id="account"></div>

### account

[IntegrationAccountObject](#IntegrationAccountObject)

<div id="synced_at"></div>

### synced_at

*This field is optional and may not be specified*

[string](#string)?

<div id="subscriber_count"></div>

### subscriber_count

*This field is optional and may not be specified*

[number](#number)?

<div id="revoked"></div>

### revoked

*This field is optional and may not be specified*

[boolean](#boolean)?

<div id="application"></div>

### application

*This field is optional and may not be specified*

[IntegrationApplicationObject](#IntegrationApplicationObject)?

<div id="scopes"></div>

### scopes

*This field is optional and may not be specified*

{[OAuth2Scopes](#OAuth2Scopes)}?

<div id="ChannelMentionObject"></div>

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

<div id="id"></div>

### id

[Snowflake](#Snowflake)

<div id="guild_id"></div>

### guild_id

[Snowflake](#Snowflake)

<div id="type"></div>

### type

[ChannelType](#ChannelType)

<div id="name"></div>

### name

[string](#string)

<div id="AttachmentObject"></div>

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

[Partial](#Partial)<[Snowflake](#Snowflake), [string](#string), [string](#string)?, [string](#string)?, [string](#string)?, [number](#number), [string](#string), [string](#string), [number](#number)?, [number](#number)?, [boolean](#boolean)?, [number](#number)?, [string](#string)?, [number](#number)><div id="EmbedFooterObject"></div>

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

<div id="text"></div>

### text

[string](#string)

<div id="icon_url"></div>

### icon_url

*This field is optional and may not be specified*

[string](#string)?

<div id="proxy_icon_url"></div>

### proxy_icon_url

*This field is optional and may not be specified*

[string](#string)?

<div id="EmbedImageObject"></div>

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

<div id="url"></div>

### url

[string](#string)

<div id="proxy_url"></div>

### proxy_url

*This field is optional and may not be specified*

[string](#string)?

<div id="height"></div>

### height

*This field is optional and may not be specified*

[number](#number)?

<div id="width"></div>

### width

*This field is optional and may not be specified*

[number](#number)?

<div id="EmbedProviderObject"></div>

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

<div id="name"></div>

### name

*This field is optional and may not be specified*

[string](#string)?

<div id="url"></div>

### url

*This field is optional and may not be specified*

[string](#string)?

<div id="EmbedAuthorObject"></div>

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

<div id="name"></div>

### name

[string](#string)

<div id="url"></div>

### url

*This field is optional and may not be specified*

[string](#string)?

<div id="icon_url"></div>

### icon_url

*This field is optional and may not be specified*

[string](#string)?

<div id="proxy_icon_url"></div>

### proxy_icon_url

*This field is optional and may not be specified*

[string](#string)?

<div id="EmbedFieldObject"></div>

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

<div id="name"></div>

### name

[string](#string)

<div id="value"></div>

### value

[string](#string)

<div id="inline"></div>

### inline

*This field is optional and may not be specified*

[boolean](#boolean)?

<div id="EmbedThumbnailObject"></div>

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

<div id="url"></div>

### url

[string](#string)

<div id="proxy_url"></div>

### proxy_url

*This field is optional and may not be specified*

[string](#string)?

<div id="height"></div>

### height

*This field is optional and may not be specified*

[number](#number)?

<div id="width"></div>

### width

*This field is optional and may not be specified*

[number](#number)?

<div id="EmbedVideoObject"></div>

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

<div id="url"></div>

### url

[string](#string)

<div id="proxy_url"></div>

### proxy_url

*This field is optional and may not be specified*

[string](#string)?

<div id="height"></div>

### height

*This field is optional and may not be specified*

[number](#number)?

<div id="width"></div>

### width

*This field is optional and may not be specified*

[number](#number)?

<div id="EmbedObject"></div>

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

<div id="title"></div>

### title

*This field is optional and may not be specified*

[string](#string)?

<div id="type"></div>

### type

*This field is optional and may not be specified*

[EmbedType](#EmbedType)?

<div id="description"></div>

### description

*This field is optional and may not be specified*

[string](#string)?

<div id="url"></div>

### url

*This field is optional and may not be specified*

[string](#string)?

<div id="timestamp"></div>

### timestamp

*This field is optional and may not be specified*

[string](#string)?

<div id="color"></div>

### color

*This field is optional and may not be specified*

[number](#number)?

<div id="footer"></div>

### footer

*This field is optional and may not be specified*

[EmbedFooterObject](#EmbedFooterObject)?

<div id="image"></div>

### image

*This field is optional and may not be specified*

[EmbedImageObject](#EmbedImageObject)?

<div id="thumbnail"></div>

### thumbnail

*This field is optional and may not be specified*

[EmbedThumbnailObject](#EmbedThumbnailObject)?

<div id="video"></div>

### video

*This field is optional and may not be specified*

[EmbedVideoObject](#EmbedVideoObject)?

<div id="provider"></div>

### provider

*This field is optional and may not be specified*

[EmbedProviderObject](#EmbedProviderObject)?

<div id="author"></div>

### author

*This field is optional and may not be specified*

[EmbedAuthorObject](#EmbedAuthorObject)?

<div id="fields"></div>

### fields

*This field is optional and may not be specified*

{[EmbedFieldObject](#EmbedFieldObject)}?

<div id="ReactionCountDetailsObject"></div>

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

<div id="burst"></div>

### burst

[number](#number)

<div id="normal"></div>

### normal

[number](#number)

<div id="ReactionObject"></div>

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

<div id="count"></div>

### count

[number](#number)

<div id="count_details"></div>

### count_details

[ReactionCountDetailsObject](#ReactionCountDetailsObject)

<div id="me"></div>

### me

[boolean](#boolean)

<div id="me_burst"></div>

### me_burst

[boolean](#boolean)

<div id="emoji"></div>

### emoji

[EmojiObject](#EmojiObject)

<div id="burst_colors"></div>

### burst_colors

{[string](#string)}

<div id="MessageActivityObject"></div>

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

<div id="type"></div>

### type

[MessageActivityType](#MessageActivityType)

<div id="party_id"></div>

### party_id

[string](#string)

<div id="MessageReferenceObject"></div>

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

<div id="type"></div>

### type

*This field is optional and may not be specified*

[MessageReferenceType](#MessageReferenceType)?

<div id="message_id"></div>

### message_id

*This field is optional and may not be specified*

[Snowflake](#Snowflake)?

<div id="channel_id"></div>

### channel_id

*This field is optional and may not be specified*

[Snowflake](#Snowflake)?

<div id="guild_id"></div>

### guild_id

*This field is optional and may not be specified*

[Snowflake](#Snowflake)?

<div id="fail_if_not_exists"></div>

### fail_if_not_exists

*This field is optional and may not be specified*

[boolean](#boolean)?

<div id="MessageInteractionMetadatObject"></div>

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

<div id="id"></div>

### id

[Snowflake](#Snowflake)

<div id="type"></div>

### type

[InteractionType](#InteractionType)

<div id="user"></div>

### user

[UserObject](#UserObject)

<div id="authorizing_integration_owners"></div>

### authorizing_integration_owners

*This is an inline table type with the following fields*

<div id="[ApplicationIntegrationType]"></div>

##### [ApplicationIntegrationType]

[Snowflake](#Snowflake)

<div id="original_response_message_id"></div>

### original_response_message_id

*This field is optional and may not be specified*

[Snowflake](#Snowflake)?

<div id="interacted_message_id"></div>

### interacted_message_id

*This field is optional and may not be specified*

[Snowflake](#Snowflake)?

<div id="triggering_interaction_metadata"></div>

### triggering_interaction_metadata

[MessageInteractionMetadatObject](#MessageInteractionMetadatObject)

<div id="MessageInteractionObject"></div>

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

<div id="id"></div>

### id

[string](#string)

<div id="type"></div>

### type

[InteractionType](#InteractionType)

<div id="name"></div>

### name

[string](#string)

<div id="user"></div>

### user

[UserObject](#UserObject)

<div id="member"></div>

### member

*This field is optional and may not be specified*

[GuildMemberObject](#GuildMemberObject)?

<div id="SelectOptionObject"></div>

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

<div id="label"></div>

### label

[string](#string)

<div id="value"></div>

### value

[string](#string)

<div id="description"></div>

### description

*This field is optional and may not be specified*

[string](#string)?

<div id="emoji"></div>

### emoji

*This field is optional and may not be specified*

[EmojiObject](#EmojiObject)?

<div id="default"></div>

### default

[boolean](#boolean)

<div id="SelectDefaultValueObject"></div>

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

<div id="id"></div>

### id

[Snowflake](#Snowflake)

<div id="type"></div>

### type

[string](#string)

<div id="ActionRowComponentObject"></div>

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

<div id="type"></div>

### type

[number](#number)

<div id="components"></div>

### components

{[ComponentObjects](#ComponentObjects)}

<div id="ButtonComponentObject"></div>

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

[Partial](#Partial)<[number](#number), [ButtonStyle](#ButtonStyle), [string](#string)?, [EmojiObject](#EmojiObject)?, [string](#string)?, [string](#string)?, [string](#string)?, [boolean](#boolean)?><div id="SelectMenuComponentObject"></div>

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

<div id="type"></div>

### type

[number](#number)

<div id="custom_id"></div>

### custom_id

[string](#string)

<div id="options"></div>

### options

*This field is optional and may not be specified*

{[SelectOptionObject](#SelectOptionObject)}?

<div id="channel_types"></div>

### channel_types

*This field is optional and may not be specified*

{[ChannelType](#ChannelType)}?

<div id="placeholder"></div>

### placeholder

*This field is optional and may not be specified*

[string](#string)?

<div id="default_values"></div>

### default_values

*This field is optional and may not be specified*

{[SelectDefaultValueObject](#SelectDefaultValueObject)}?

<div id="min_values"></div>

### min_values

*This field is optional and may not be specified*

[number](#number)?

<div id="max_values"></div>

### max_values

*This field is optional and may not be specified*

[number](#number)?

<div id="disabled"></div>

### disabled

*This field is optional and may not be specified*

[boolean](#boolean)?

<div id="TextInputComponentObject"></div>

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

<div id="type"></div>

### type

[number](#number)

<div id="custom_id"></div>

### custom_id

[string](#string)

<div id="style"></div>

### style

[TextInputStyles](#TextInputStyles)

<div id="label"></div>

### label

[string](#string)

<div id="min_length"></div>

### min_length

*This field is optional and may not be specified*

[number](#number)?

<div id="max_length"></div>

### max_length

*This field is optional and may not be specified*

[number](#number)?

<div id="required"></div>

### required

*This field is optional and may not be specified*

[boolean](#boolean)?

<div id="value"></div>

### value

*This field is optional and may not be specified*

[string](#string)?

<div id="placeholder"></div>

### placeholder

*This field is optional and may not be specified*

[string](#string)?

<div id="ComponentObjects"></div>

## ComponentObjects

https://discord.com/developers/docs/interactions/message-components#message-components

<details>
<summary>Raw Type</summary>

```luau
-- https://discord.com/developers/docs/interactions/message-components#message-components
type ComponentObjects = ActionRowComponentObject | ButtonComponentObject | SelectMenuComponentObject | TextInputComponentObject
```

</details>

Union with variants:

<details>
<summary>Variant 1</summary>

[ActionRowComponentObject](#ActionRowComponentObject)

</details>

<details>
<summary>Variant 2</summary>

[ButtonComponentObject](#ButtonComponentObject)

</details>

<details>
<summary>Variant 3</summary>

[SelectMenuComponentObject](#SelectMenuComponentObject)

</details>

<details>
<summary>Variant 4</summary>

[TextInputComponentObject](#TextInputComponentObject)

</details>

<div id="SitckerItemObject"></div>

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

<div id="id"></div>

### id

[Snowflake](#Snowflake)

<div id="name"></div>

### name

[string](#string)

<div id="format_type"></div>

### format_type

[StickerFormatType](#StickerFormatType)

<div id="RoleSubscriptionDataObject"></div>

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

<div id="role_subscription_listing_id"></div>

### role_subscription_listing_id

[Snowflake](#Snowflake)

<div id="tier_name"></div>

### tier_name

[string](#string)

<div id="total_months_subscribed"></div>

### total_months_subscribed

[number](#number)

<div id="is_renewal"></div>

### is_renewal

[boolean](#boolean)

<div id="PollMediaObject"></div>

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

<div id="text"></div>

### text

*This field is optional and may not be specified*

[string](#string)?

<div id="emoji"></div>

### emoji

*This field is optional and may not be specified*

[Partial](#Partial)<[EmojiObject](#EmojiObject)>?

<div id="PollAnswerObject"></div>

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

<div id="answer_id"></div>

### answer_id

[number](#number)

<div id="poll_media"></div>

### poll_media

[PollMediaObject](#PollMediaObject)

<div id="PollAnswerCountObject"></div>

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

<div id="id"></div>

### id

[number](#number)

<div id="count"></div>

### count

[number](#number)

<div id="me_voted"></div>

### me_voted

[boolean](#boolean)

<div id="PollResultObject"></div>

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

<div id="is_finalized"></div>

### is_finalized

[boolean](#boolean)

<div id="answer_counts"></div>

### answer_counts

{[PollAnswerCountObject](#PollAnswerCountObject)}

<div id="PollObject"></div>

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

<div id="question"></div>

### question

[PollMediaObject](#PollMediaObject)

<div id="answers"></div>

### answers

{[PollAnswerObject](#PollAnswerObject)}

<div id="expiry"></div>

### expiry

*This field is optional and may not be specified*

[string](#string)?

<div id="allow_multiselect"></div>

### allow_multiselect

fixme: for some reason luau's type system doesn't like this being a `boolean`????

Union with variants:

<details>
<summary>Variant 1</summary>

```luau
true
```

</details>

<details>
<summary>Variant 2</summary>

```luau
false
```

</details>

<div id="layout_type"></div>

### layout_type

[PollLayoutType](#PollLayoutType)

<div id="results"></div>

### results

*This field is optional and may not be specified*

[PollResultObject](#PollResultObject)?

<div id="MessageCallObject"></div>

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

<div id="participants"></div>

### participants

{[UserObject](#UserObject)}

<div id="ended_timestamp"></div>

### ended_timestamp

[string](#string)

<div id="MessageObject"></div>

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

<div id="id"></div>

### id

*This field is optional and may not be specified*

[Snowflake](#Snowflake)?

<div id="channel_id"></div>

### channel_id

*This field is optional and may not be specified*

[Snowflake](#Snowflake)?

<div id="author"></div>

### author

*This field is optional and may not be specified*

[UserObject](#UserObject)?

<div id="content"></div>

### content

*This field is optional and may not be specified*

[string](#string)?

<div id="timestamp"></div>

### timestamp

*This field is optional and may not be specified*

[string](#string)?

<div id="edited_timestamp"></div>

### edited_timestamp

*This field is optional and may not be specified*

[string](#string)?

<div id="tts"></div>

### tts

*This field is optional and may not be specified*

[boolean](#boolean)?

<div id="mention_everyone"></div>

### mention_everyone

*This field is optional and may not be specified*

[boolean](#boolean)?

<div id="mentions"></div>

### mentions

*This field is optional and may not be specified*

{[UserObject](#UserObject)}?

<div id="mention_roles"></div>

### mention_roles

*This field is optional and may not be specified*

{[GuildRoleObject](#GuildRoleObject)}?

<div id="mention_channels"></div>

### mention_channels

*This field is optional and may not be specified*

{[ChannelMentionObject](#ChannelMentionObject)}?

<div id="attachments"></div>

### attachments

*This field is optional and may not be specified*

{[AttachmentObject](#AttachmentObject)}?

<div id="embeds"></div>

### embeds

*This field is optional and may not be specified*

{[EmbedObject](#EmbedObject)}?

<div id="reactions"></div>

### reactions

*This field is optional and may not be specified*

{[ReactionObject](#ReactionObject)}?

<div id="nonce"></div>

### nonce

*This field is optional and may not be specified*

[string](#string)?

<div id="pinned"></div>

### pinned

*This field is optional and may not be specified*

[boolean](#boolean)?

<div id="webhook_id"></div>

### webhook_id

*This field is optional and may not be specified*

[Snowflake](#Snowflake)?

<div id="type"></div>

### type

*This field is optional and may not be specified*

[MessageType](#MessageType)?

<div id="activity"></div>

### activity

*This field is optional and may not be specified*

[MessageActivityObject](#MessageActivityObject)?

<div id="application"></div>

### application

*This field is optional and may not be specified*

[ApplicationObject](#ApplicationObject)?

<div id="application_id"></div>

### application_id

*This field is optional and may not be specified*

[Snowflake](#Snowflake)?

<div id="message_reference"></div>

### message_reference

*This field is optional and may not be specified*

[MessageReferenceObject](#MessageReferenceObject)?

<div id="flags"></div>

### flags

*This field is optional and may not be specified*

[number](#number)?

<div id="referenced_message"></div>

### referenced_message

*This field is optional and may not be specified*

[MessageObject](#MessageObject)?

<div id="interaction_metadata"></div>

### interaction_metadata

*This field is optional and may not be specified*

[MessageInteractionMetadatObject](#MessageInteractionMetadatObject)?

<div id="interaction"></div>

### interaction

*This field is optional and may not be specified*

[MessageInteractionObject](#MessageInteractionObject)?

<div id="thread"></div>

### thread

*This field is optional and may not be specified*

[ChannelObject](#ChannelObject)?

<div id="components"></div>

### components

*This field is optional and may not be specified*

{[ComponentObjects](#ComponentObjects)}?

<div id="sticker_items"></div>

### sticker_items

*This field is optional and may not be specified*

{[SitckerItemObject](#SitckerItemObject)}?

<div id="stickers"></div>

### stickers

*This field is optional and may not be specified*

{[StickerObject](#StickerObject)}?

<div id="position"></div>

### position

*This field is optional and may not be specified*

[number](#number)?

<div id="role_subscription_data"></div>

### role_subscription_data

*This field is optional and may not be specified*

[RoleSubscriptionDataObject](#RoleSubscriptionDataObject)?

<div id="resolved"></div>

### resolved

*This field is optional and may not be specified*

[ResolvedDataStructure](#ResolvedDataStructure)?

<div id="poll"></div>

### poll

*This field is optional and may not be specified*

[PollObject](#PollObject)?

<div id="call"></div>

### call

*This field is optional and may not be specified*

[MessageCallObject](#MessageCallObject)?

<div id="ResolvedDataStructure"></div>

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

<div id="users"></div>

### users

*This field is optional and may not be specified*

{[UserObject](#UserObject)}?

<div id="members"></div>

### members

*This field is optional and may not be specified*

{[GuildMemberObject](#GuildMemberObject)}?

<div id="roles"></div>

### roles

*This field is optional and may not be specified*

{[GuildRoleObject](#GuildRoleObject)}?

<div id="channels"></div>

### channels

*This field is optional and may not be specified*

{[ChannelObject](#ChannelObject)}?

<div id="messages"></div>

### messages

*This field is optional and may not be specified*

{[MessageObject](#MessageObject)}?

<div id="attachments"></div>

### attachments

*This field is optional and may not be specified*

{[AttachmentObject](#AttachmentObject)}?

<div id="ApplicationCommandInteractionDataOptionObject"></div>

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

<div id="name"></div>

### name

[string](#string)

<div id="type"></div>

### type

[ApplicationCommandOptionType](#ApplicationCommandOptionType)

<div id="value"></div>

### value

*This field is optional and may not be specified*

([string](#string) | [number](#number) | [boolean](#boolean))?

<div id="options"></div>

### options

{[ApplicationCommandInteractionDataOptionObject](#ApplicationCommandInteractionDataOptionObject)}

<div id="focused"></div>

### focused

[boolean](#boolean)

<div id="InteractionDataObject"></div>

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

<div id="id"></div>

### id

[Snowflake](#Snowflake)

<div id="name"></div>

### name

[string](#string)

<div id="type"></div>

### type

[number](#number)

<div id="resolved"></div>

### resolved

*This field is optional and may not be specified*

[ResolvedDataStructure](#ResolvedDataStructure)?

<div id="options"></div>

### options

*This field is optional and may not be specified*

{[ApplicationCommandInteractionDataOptionObject](#ApplicationCommandInteractionDataOptionObject)}?

<div id="guild_id"></div>

### guild_id

*This field is optional and may not be specified*

[Snowflake](#Snowflake)?

<div id="target_id"></div>

### target_id

*This field is optional and may not be specified*

[Snowflake](#Snowflake)?

<div id="custom_id"></div>

### custom_id

*This field is optional and may not be specified*

[string](#string)?

<div id="component_type"></div>

### component_type

*This field is optional and may not be specified*

[number](#number)?

<div id="values"></div>

### values

*This field is optional and may not be specified*

{[SelectOptionObject](#SelectOptionObject)}?

<div id="components"></div>

### components

*This field is optional and may not be specified*

{[ComponentObjects](#ComponentObjects)}?

<div id="InteractionObject"></div>

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

<div id="id"></div>

### id

[Snowflake](#Snowflake)

<div id="application_id"></div>

### application_id

[Snowflake](#Snowflake)

<div id="type"></div>

### type

[InteractionType](#InteractionType)

<div id="data"></div>

### data

*This field is optional and may not be specified*

[InteractionDataObject](#InteractionDataObject)?

<div id="guild"></div>

### guild

*This field is optional and may not be specified*

[GuildObject](#GuildObject)?

<div id="guild_id"></div>

### guild_id

*This field is optional and may not be specified*

[Snowflake](#Snowflake)?

<div id="channel"></div>

### channel

*This field is optional and may not be specified*

[ChannelObject](#ChannelObject)?

<div id="channel_id"></div>

### channel_id

*This field is optional and may not be specified*

[Snowflake](#Snowflake)?

<div id="member"></div>

### member

*This field is optional and may not be specified*

[GuildMemberObject](#GuildMemberObject)?

<div id="user"></div>

### user

*This field is optional and may not be specified*

[UserObject](#UserObject)?

<div id="token"></div>

### token

[string](#string)

<div id="version"></div>

### version

[number](#number)

<div id="message"></div>

### message

*This field is optional and may not be specified*

[MessageObject](#MessageObject)?

<div id="app_permissions"></div>

### app_permissions

[string](#string)

<div id="locale"></div>

### locale

*This field is optional and may not be specified*

[LanguageLocales](#LanguageLocales)?

<div id="guild_locale"></div>

### guild_locale

*This field is optional and may not be specified*

[LanguageLocales](#LanguageLocales)?

<div id="entitlements"></div>

### entitlements

{[EntitlementObject](#EntitlementObject)}

<div id="authorizing_integration_owners"></div>

### authorizing_integration_owners

{[IntegrationType](#IntegrationType)}

<div id="context"></div>

### context

[InteractionContextType](#InteractionContextType)

<div id="ApplicationRoleConnectionMetadataObject"></div>

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

<div id="type"></div>

### type

[ApplicationRoleConnectionMetadataType](#ApplicationRoleConnectionMetadataType)

<div id="key"></div>

### key

[string](#string)

<div id="name"></div>

### name

[string](#string)

<div id="name_localizations"></div>

### name_localizations

*This field is optional and may not be specified*

[string](#string)?

<div id="description"></div>

### description

[string](#string)

<div id="description_localizations"></div>

### description_localizations

*This field is optional and may not be specified*

[string](#string)?

<div id="ApplicationCommandOptionChoiceObject"></div>

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

<div id="name"></div>

### name

[string](#string)

<div id="name_localizations"></div>

### name_localizations

*This field is optional and may not be specified*

[string](#string)?

<div id="value"></div>

### value

Union with variants:

<details>
<summary>Variant 1</summary>

[string](#string)

</details>

<details>
<summary>Variant 2</summary>

[number](#number)

</details>

<div id="ApplicationCommandOptionObject"></div>

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

<div id="type"></div>

### type

[ApplicationCommandOptionType](#ApplicationCommandOptionType)

<div id="name"></div>

### name

[string](#string)

<div id="name_localizations"></div>

### name_localizations

*This field is optional and may not be specified*

[string](#string)?

<div id="description"></div>

### description

*This field is optional and may not be specified*

[string](#string)?

<div id="description_localizations"></div>

### description_localizations

*This field is optional and may not be specified*

[string](#string)?

<div id="required"></div>

### required

*This field is optional and may not be specified*

[boolean](#boolean)?

<div id="choices"></div>

### choices

{[ApplicationCommandOptionChoiceObject](#ApplicationCommandOptionChoiceObject)}

<div id="options"></div>

### options

*This field is optional and may not be specified*

{[ApplicationCommandOptionObject](#ApplicationCommandOptionObject)}?

<div id="channel_types"></div>

### channel_types

*This field is optional and may not be specified*

{[ChannelType](#ChannelType)}?

<div id="min_value"></div>

### min_value

*This field is optional and may not be specified*

[number](#number)?

<div id="max_value"></div>

### max_value

*This field is optional and may not be specified*

[number](#number)?

<div id="min_length"></div>

### min_length

*This field is optional and may not be specified*

[number](#number)?

<div id="max_length"></div>

### max_length

*This field is optional and may not be specified*

[number](#number)?

<div id="autocomplete"></div>

### autocomplete

*This field is optional and may not be specified*

[boolean](#boolean)?

<div id="ApplicationCommandObject"></div>

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

<div id="id"></div>

### id

*This field is optional and may not be specified*

[Snowflake](#Snowflake)?

<div id="type"></div>

### type

*This field is optional and may not be specified*

[ApplicationCommandType](#ApplicationCommandType)?

<div id="application_id"></div>

### application_id

*This field is optional and may not be specified*

[Snowflake](#Snowflake)?

<div id="guild_id"></div>

### guild_id

*This field is optional and may not be specified*

[Snowflake](#Snowflake)?

<div id="name"></div>

### name

[string](#string)

<div id="name_localizations"></div>

### name_localizations

*This field is optional and may not be specified*

[string](#string)?

<div id="description"></div>

### description

[string](#string)

<div id="description_localizations"></div>

### description_localizations

*This field is optional and may not be specified*

[string](#string)?

<div id="options"></div>

### options

*This field is optional and may not be specified*

{[ApplicationCommandOptionObject](#ApplicationCommandOptionObject)}?

<div id="default_member_permissions"></div>

### default_member_permissions

*This field is optional and may not be specified*

[string](#string)?

<div id="dm_permission"></div>

### dm_permission

*This field is optional and may not be specified*

[string](#string)?

<div id="default_permission"></div>

### default_permission

*This field is optional and may not be specified*

[boolean](#boolean)?

<div id="nsfw"></div>

### nsfw

*This field is optional and may not be specified*

[boolean](#boolean)?

<div id="integration_types"></div>

### integration_types

*This field is optional and may not be specified*

{[IntegrationType](#IntegrationType)}?

<div id="contexts"></div>

### contexts

*This field is optional and may not be specified*

{[InteractionContextType](#InteractionContextType)}?

<div id="version"></div>

### version

*This field is optional and may not be specified*

[Snowflake](#Snowflake)?

<div id="AuditLogChangeObject"></div>

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

<div id="new_value"></div>

### new_value

*This field is optional and may not be specified*

[any](#any)?

<div id="old_value"></div>

### old_value

*This field is optional and may not be specified*

[any](#any)?

<div id="key"></div>

### key

[string](#string)

<div id="OptionalAuditEntryInfoObject"></div>

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

<div id="application_id"></div>

### application_id

[Snowflake](#Snowflake)

<div id="auto_moderation_rule_name"></div>

### auto_moderation_rule_name

[string](#string)

<div id="auto_moderation_rule_trigger_type"></div>

### auto_moderation_rule_trigger_type

[AutomoderationRuleTriggerType](#AutomoderationRuleTriggerType)

<div id="channel_id"></div>

### channel_id

[Snowflake](#Snowflake)

<div id="count"></div>

### count

[string](#string)

<div id="delete_member_days"></div>

### delete_member_days

[string](#string)

<div id="id"></div>

### id

[Snowflake](#Snowflake)

<div id="members_removed"></div>

### members_removed

[string](#string)

<div id="message_id"></div>

### message_id

[Snowflake](#Snowflake)

<div id="role_name"></div>

### role_name

[string](#string)

<div id="type"></div>

### type

[string](#string)

<div id="integration_type"></div>

### integration_type

[IntegrationType](#IntegrationType)

<div id="AuditLogEntryObject"></div>

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

<div id="target_id"></div>

### target_id

*This field is optional and may not be specified*

[string](#string)?

<div id="changes"></div>

### changes

*This field is optional and may not be specified*

{[AuditLogChangeObject](#AuditLogChangeObject)}?

<div id="user_id"></div>

### user_id

*This field is optional and may not be specified*

[Snowflake](#Snowflake)?

<div id="id"></div>

### id

[Snowflake](#Snowflake)

<div id="action_type"></div>

### action_type

[AuditLogEventType](#AuditLogEventType)

<div id="options"></div>

### options

*This field is optional and may not be specified*

{[OptionalAuditEntryInfoObject](#OptionalAuditEntryInfoObject)}?

<div id="reason"></div>

### reason

*This field is optional and may not be specified*

[string](#string)?

<div id="WebhookObject"></div>

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

<div id="id"></div>

### id

[Snowflake](#Snowflake)

<div id="type"></div>

### type

[WebhookType](#WebhookType)

<div id="guild_id"></div>

### guild_id

*This field is optional and may not be specified*

[Snowflake](#Snowflake)?

<div id="channel_id"></div>

### channel_id

*This field is optional and may not be specified*

[Snowflake](#Snowflake)?

<div id="user"></div>

### user

*This field is optional and may not be specified*

[UserObject](#UserObject)?

<div id="name"></div>

### name

*This field is optional and may not be specified*

[string](#string)?

<div id="avatar"></div>

### avatar

*This field is optional and may not be specified*

[string](#string)?

<div id="token"></div>

### token

*This field is optional and may not be specified*

[string](#string)?

<div id="application_id"></div>

### application_id

*This field is optional and may not be specified*

[Snowflake](#Snowflake)?

<div id="source_guild"></div>

### source_guild

*This field is optional and may not be specified*

[GuildObject](#GuildObject)?

<div id="source_channel"></div>

### source_channel

*This field is optional and may not be specified*

[ChannelObject](#ChannelObject)?

<div id="url"></div>

### url

*This field is optional and may not be specified*

[string](#string)?

<div id="AuditLogObject"></div>

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

<div id="application_commands"></div>

### application_commands

{[ApplicationCommandObject](#ApplicationCommandObject)}

<div id="audit_log_entries"></div>

### audit_log_entries

{[AuditLogEntryObject](#AuditLogEntryObject)}

<div id="auto_moderation_rules"></div>

### auto_moderation_rules

{[AutomoderationRuleObject](#AutomoderationRuleObject)}

<div id="guild_scheduled_events"></div>

### guild_scheduled_events

{[GuildScheduledEventObject](#GuildScheduledEventObject)}

<div id="integrations"></div>

### integrations

{[IntegrationObject](#IntegrationObject)}

<div id="threads"></div>

### threads

{[ChannelObject](#ChannelObject)}

<div id="users"></div>

### users

{[UserObject](#UserObject)}

<div id="webhooks"></div>

### webhooks

{[WebhookObject](#WebhookObject)}

<div id="InviteObject"></div>

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

<div id="type"></div>

### type

[InviteTypes](#InviteTypes)

<div id="code"></div>

### code

[string](#string)

<div id="guild"></div>

### guild

*This field is optional and may not be specified*

[GuildObject](#GuildObject)?

<div id="channel"></div>

### channel

*This field is optional and may not be specified*

[ChannelObject](#ChannelObject)?

<div id="inviter"></div>

### inviter

*This field is optional and may not be specified*

[UserObject](#UserObject)?

<div id="target_type"></div>

### target_type

[InviteTargetTypes](#InviteTargetTypes)

<div id="target_user"></div>

### target_user

*This field is optional and may not be specified*

[UserObject](#UserObject)?

<div id="target_application"></div>

### target_application

*This field is optional and may not be specified*

[ApplicationObject](#ApplicationObject)?

<div id="approximate_presence_count"></div>

### approximate_presence_count

*This field is optional and may not be specified*

[number](#number)?

<div id="approximate_member_count"></div>

### approximate_member_count

*This field is optional and may not be specified*

[number](#number)?

<div id="expires_at"></div>

### expires_at

*This field is optional and may not be specified*

[string](#string)?

<div id="stage_instance"></div>

### stage_instance

*This field is optional and may not be specified*

[StageInstanceObject](#StageInstanceObject)?

<div id="guild_scheduled_event"></div>

### guild_scheduled_event

*This field is optional and may not be specified*

[GuildScheduledEventObject](#GuildScheduledEventObject)?

<div id="GuildVanityUrl"></div>

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

<div id="code"></div>

### code

[string](#string)

<div id="uses"></div>

### uses

[number](#number)

<div id="InviteMetadataObject"></div>

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

<div id="uses"></div>

### uses

[number](#number)

<div id="max_uses"></div>

### max_uses

[number](#number)

<div id="max_age"></div>

### max_age

[number](#number)

<div id="temporary"></div>

### temporary

[boolean](#boolean)

<div id="created_at"></div>

### created_at

[string](#string)

<div id="FollowedChannelObject"></div>

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

<div id="channel_id"></div>

### channel_id

[Snowflake](#Snowflake)

<div id="webhook_id"></div>

### webhook_id

[Snowflake](#Snowflake)

<div id="GuildPreviewObject"></div>

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

<div id="id"></div>

### id

[Snowflake](#Snowflake)

<div id="name"></div>

### name

[string](#string)

<div id="icon"></div>

### icon

*This field is optional and may not be specified*

[string](#string)?

<div id="splash"></div>

### splash

*This field is optional and may not be specified*

[string](#string)?

<div id="discovery_splash"></div>

### discovery_splash

*This field is optional and may not be specified*

[string](#string)?

<div id="emojis"></div>

### emojis

{[EmojiObject](#EmojiObject)}

<div id="features"></div>

### features

{[GuildFeature](#GuildFeature)}

<div id="approximate_member_count"></div>

### approximate_member_count

[number](#number)

<div id="approximate_presence_count"></div>

### approximate_presence_count

[number](#number)

<div id="description"></div>

### description

*This field is optional and may not be specified*

[string](#string)?

<div id="stickers"></div>

### stickers

{[StickerObject](#StickerObject)}

<div id="BanObject"></div>

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

<div id="reason"></div>

### reason

*This field is optional and may not be specified*

[string](#string)?

<div id="user"></div>

### user

[UserObject](#UserObject)

<div id="VoiceRegionObject"></div>

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

<div id="id"></div>

### id

[string](#string)

<div id="name"></div>

### name

[string](#string)

<div id="optimal"></div>

### optimal

[boolean](#boolean)

<div id="deprecated"></div>

### deprecated

[boolean](#boolean)

<div id="custom"></div>

### custom

[boolean](#boolean)

<div id="GuildWidgetSettingsObject"></div>

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

<div id="enabled"></div>

### enabled

*This field is optional and may not be specified*

[boolean](#boolean)?

<div id="channel_id"></div>

### channel_id

*This field is optional and may not be specified*

[Snowflake](#Snowflake)?

<div id="GuildWidgetObject"></div>

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

<div id="id"></div>

### id

[Snowflake](#Snowflake)

<div id="name"></div>

### name

[string](#string)

<div id="instant_invite"></div>

### instant_invite

*This field is optional and may not be specified*

[string](#string)?

<div id="channels"></div>

### channels

{[ChannelObject](#ChannelObject)}

<div id="members"></div>

### members

{[UserObject](#UserObject)}

<div id="presence_count"></div>

### presence_count

[number](#number)

<div id="PromptOptionObject"></div>

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

<div id="id"></div>

### id

*This field is optional and may not be specified*

[Snowflake](#Snowflake)?

<div id="channel_ids"></div>

### channel_ids

{[Snowflake](#Snowflake)}

<div id="role_ids"></div>

### role_ids

{[Snowflake](#Snowflake)}

<div id="emoji"></div>

### emoji

Union with variants:

<details>
<summary>Variant 1</summary>

[EmojiObject](#EmojiObject)

</details>

<details>
<summary>Variant 2</summary>

[nil](#nil)

</details>

<div id="emoji_id"></div>

### emoji_id

*This field is optional and may not be specified*

[Snowflake](#Snowflake)?

<div id="emoji_name"></div>

### emoji_name

*This field is optional and may not be specified*

[string](#string)?

<div id="emoji_animated"></div>

### emoji_animated

*This field is optional and may not be specified*

[boolean](#boolean)?

<div id="title"></div>

### title

*This field is optional and may not be specified*

[string](#string)?

<div id="description"></div>

### description

*This field is optional and may not be specified*

[string](#string)?

<div id="OnboardingPromptObject"></div>

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

<div id="id"></div>

### id

Union with variants:

<details>
<summary>Variant 1</summary>

[Snowflake](#Snowflake)

</details>

<details>
<summary>Variant 2</summary>

[nil](#nil)

</details>

<div id="type"></div>

### type

*This field is optional and may not be specified*

[PromptTypes](#PromptTypes)?

<div id="options"></div>

### options

{[PromptOptionObject](#PromptOptionObject)}

<div id="title"></div>

### title

*This field is optional and may not be specified*

[string](#string)?

<div id="single_select"></div>

### single_select

*This field is optional and may not be specified*

[boolean](#boolean)?

<div id="required"></div>

### required

*This field is optional and may not be specified*

[boolean](#boolean)?

<div id="in_onboarding"></div>

### in_onboarding

*This field is optional and may not be specified*

[boolean](#boolean)?

<div id="GuildOnboardingObject"></div>

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

<div id="guild_id"></div>

### guild_id

[Snowflake](#Snowflake)

<div id="prompts"></div>

### prompts

{[OnboardingPromptObject](#OnboardingPromptObject)}

<div id="default_channel_ids"></div>

### default_channel_ids

{[Snowflake](#Snowflake)}

<div id="enabled"></div>

### enabled

[boolean](#boolean)

<div id="mode"></div>

### mode

[OnboardingMode](#OnboardingMode)

<div id="GuildScheduledEventUserObject"></div>

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

<div id="guild_scheduled_event_id"></div>

### guild_scheduled_event_id

[Snowflake](#Snowflake)

<div id="user"></div>

### user

[UserObject](#UserObject)

<div id="member"></div>

### member

*This field is optional and may not be specified*

[GuildMemberObject](#GuildMemberObject)?

<div id="GuildTemplateObject"></div>

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

<div id="code"></div>

### code

[string](#string)

<div id="name"></div>

### name

[string](#string)

<div id="description"></div>

### description

*This field is optional and may not be specified*

[string](#string)?

<div id="usage_count"></div>

### usage_count

[number](#number)

<div id="creator_id"></div>

### creator_id

[Snowflake](#Snowflake)

<div id="creator"></div>

### creator

[UserObject](#UserObject)

<div id="created_at"></div>

### created_at

[string](#string)

<div id="updated_at"></div>

### updated_at

[string](#string)

<div id="source_guild_id"></div>

### source_guild_id

[Snowflake](#Snowflake)

<div id="serialized_source_guild"></div>

### serialized_source_guild

[GuildObject](#GuildObject)

<div id="is_dirty"></div>

### is_dirty

*This field is optional and may not be specified*

[boolean](#boolean)?

<div id="StickerPackObject"></div>

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

<div id="id"></div>

### id

[Snowflake](#Snowflake)

<div id="stickers"></div>

### stickers

{[StickerObject](#StickerObject)}

<div id="name"></div>

### name

[string](#string)

<div id="sku_id"></div>

### sku_id

[Snowflake](#Snowflake)

<div id="cover_sticker_id"></div>

### cover_sticker_id

*This field is optional and may not be specified*

[Snowflake](#Snowflake)?

<div id="description"></div>

### description

[string](#string)

<div id="banner_asset_id"></div>

### banner_asset_id

*This field is optional and may not be specified*

[Snowflake](#Snowflake)?

<div id="IntegrationApplicationObject"></div>

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

<div id="id"></div>

### id

[Snowflake](#Snowflake)

<div id="name"></div>

### name

[string](#string)

<div id="icon"></div>

### icon

*This field is optional and may not be specified*

[string](#string)?

<div id="description"></div>

### description

[string](#string)

<div id="bot"></div>

### bot

*This field is optional and may not be specified*

[UserObject](#UserObject)?

<div id="ConnectionObject"></div>

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

<div id="id"></div>

### id

[string](#string)

<div id="name"></div>

### name

[string](#string)

<div id="type"></div>

### type

[ConnectionObjectServices](#ConnectionObjectServices)

<div id="revoked"></div>

### revoked

*This field is optional and may not be specified*

[boolean](#boolean)?

<div id="integrations"></div>

### integrations

*This field is optional and may not be specified*

{[IntegrationObject](#IntegrationObject)}?

<div id="verified"></div>

### verified

[boolean](#boolean)

<div id="friend_sync"></div>

### friend_sync

[boolean](#boolean)

<div id="show_Activity"></div>

### show_Activity

[boolean](#boolean)

<div id="two_way_link"></div>

### two_way_link

[boolean](#boolean)

<div id="visibility"></div>

### visibility

[ConnectionVisibilityTypes](#ConnectionVisibilityTypes)

<div id="ApplicationRoleConnectionObject"></div>

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

<div id="platform_name"></div>

### platform_name

*This field is optional and may not be specified*

[string](#string)?

<div id="platform_username"></div>

### platform_username

*This field is optional and may not be specified*

[string](#string)?

<div id="metadata"></div>

### metadata

[ApplicationRoleConnectionMetadataObject](#ApplicationRoleConnectionMetadataObject)

<div id="SessionStartLimitObject"></div>

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

<div id="total"></div>

### total

[number](#number)

<div id="remaining"></div>

### remaining

[number](#number)

<div id="reset_after"></div>

### reset_after

[number](#number)

<div id="max_concurrency"></div>

### max_concurrency

[number](#number)

<div id="AllowedMentionObject"></div>

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

<div id="parse"></div>

### parse

*This field is optional and may not be specified*

{[AllowedMentionTypes](#AllowedMentionTypes)}?

<div id="users"></div>

### users

*This field is optional and may not be specified*

{[string](#string)}?

<div id="roles"></div>

### roles

*This field is optional and may not be specified*

{[string](#string)}?

<div id="replied_user"></div>

### replied_user

*This field is optional and may not be specified*

[boolean](#boolean)?

<div id="ForumAndMediaThreadMessageObject"></div>

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

<div id="content"></div>

### content

*This field is optional and may not be specified*

[string](#string)?

<div id="embeds"></div>

### embeds

*This field is optional and may not be specified*

{[EmbedObject](#EmbedObject)}?

<div id="allowed_mentions"></div>

### allowed_mentions

*This field is optional and may not be specified*

[AllowedMentionObject](#AllowedMentionObject)?

<div id="components"></div>

### components

*This field is optional and may not be specified*

{[ComponentObjects](#ComponentObjects)}?

<div id="sticker_ids"></div>

### sticker_ids

*This field is optional and may not be specified*

{[Snowflake](#Snowflake)}?

<div id="attachments"></div>

### attachments

*This field is optional and may not be specified*

{[AttachmentObject](#AttachmentObject)}?

<div id="flags"></div>

### flags

*This field is optional and may not be specified*

[number](#number)?

<div id="InteractionCallbackAutocompleteObject"></div>

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

<div id="choices"></div>

### choices

*This field is optional and may not be specified*

{[ApplicationCommandOptionChoiceObject](#ApplicationCommandOptionChoiceObject)}?

<div id="InteractionCallbackModalObject"></div>

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

<div id="custom_id"></div>

### custom_id

*This field is optional and may not be specified*

[string](#string)?

<div id="title"></div>

### title

*This field is optional and may not be specified*

[string](#string)?

<div id="components"></div>

### components

{[ComponentObjects](#ComponentObjects)}

<div id="InteractionResponseObject"></div>

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

<div id="type"></div>

### type

[InteractionCallbackType](#InteractionCallbackType)

<div id="data"></div>

### data

*This field is optional and may not be specified*

([Partial](#Partial)<[MessageObject](#MessageObject)> | [InteractionCallbackAutocompleteObject](#InteractionCallbackAutocompleteObject) | [InteractionCallbackModalObject](#InteractionCallbackModalObject))?

