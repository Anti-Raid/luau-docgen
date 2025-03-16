<div id="Types"></div>

# Types

<div id="GetAuditLogOptions"></div>

## GetAuditLogOptions

Options for getting audit logs in Discord

<details>
<summary>Raw Type</summary>

```luau
--- Options for getting audit logs in Discord
type GetAuditLogOptions = {
	--- The action type to filter by
	action_type: discord.AuditLogEventType?,

	--- The user ID to filter by
	user_id: discord.Snowflake?,

	--- The audit log entry ID to filter
	before: discord.Snowflake?,

	--- The number of entries to return
	limit: number?
}
```

</details>

<div id="action_type"></div>

### action_type

The action type to filter by

*This field is optional and may not be specified*

[discord](module.discord).[AuditLogEventType](#AuditLogEventType)

<div id="user_id"></div>

### user_id

The user ID to filter by

*This field is optional and may not be specified*

[discord](module.discord).[Snowflake](#Snowflake)

<div id="before"></div>

### before

The audit log entry ID to filter

*This field is optional and may not be specified*

[discord](module.discord).[Snowflake](#Snowflake)

<div id="limit"></div>

### limit

The number of entries to return

*This field is optional and may not be specified*

[number?](#number)

<div id="GetAutoModerationRuleOptions"></div>

## GetAutoModerationRuleOptions

Options for getting an auto moderation rule in Discord

<details>
<summary>Raw Type</summary>

```luau
--- Options for getting an auto moderation rule in Discord
type GetAutoModerationRuleOptions = {
	--- The rule ID
	rule_id: discord.Snowflake
}
```

</details>

<div id="rule_id"></div>

### rule_id

The rule ID

[discord](module.discord).[Snowflake](#Snowflake)

<div id="CreateAutoModerationRuleOptions"></div>

## CreateAutoModerationRuleOptions

Options for creating an auto moderation rule in Discord

<details>
<summary>Raw Type</summary>

```luau
--- Options for creating an auto moderation rule in Discord
type CreateAutoModerationRuleOptions = {
	--- The reason for creating the rule
	reason: string,

	--- The data to create the rule with
	data: discordRest.CreateAutoModerationRuleRequest
}
```

</details>

<div id="reason"></div>

### reason

The reason for creating the rule

[string](#string)

<div id="data"></div>

### data

The data to create the rule with

[discordRest](module.discordRest).[CreateAutoModerationRuleRequest](#CreateAutoModerationRuleRequest)

<div id="EditAutoModerationRuleOptions"></div>

## EditAutoModerationRuleOptions

Options for editing an auto moderation rule in Discord

<details>
<summary>Raw Type</summary>

```luau
--- Options for editing an auto moderation rule in Discord
type EditAutoModerationRuleOptions = {
	--- The rule ID
	rule_id: discord.Snowflake,

	--- The reason for editing the rule
	reason: string,

	--- The data to edit the rule with
	data: discordRest.ModifyAutoModerationRuleRequest
}
```

</details>

<div id="rule_id"></div>

### rule_id

The rule ID

[discord](module.discord).[Snowflake](#Snowflake)

<div id="reason"></div>

### reason

The reason for editing the rule

[string](#string)

<div id="data"></div>

### data

The data to edit the rule with

[discordRest](module.discordRest).[ModifyAutoModerationRuleRequest](#ModifyAutoModerationRuleRequest)

<div id="DeleteAutoModerationRuleOptions"></div>

## DeleteAutoModerationRuleOptions

Options for deleting an auto moderation rule in Discord

<details>
<summary>Raw Type</summary>

```luau
--- Options for deleting an auto moderation rule in Discord
type DeleteAutoModerationRuleOptions = {
	--- The rule ID
	rule_id: discord.Snowflake,

	--- The reason for deleting the rule
	reason: string
}
```

</details>

<div id="rule_id"></div>

### rule_id

The rule ID

[discord](module.discord).[Snowflake](#Snowflake)

<div id="reason"></div>

### reason

The reason for deleting the rule

[string](#string)

<div id="GetChannelOptions"></div>

## GetChannelOptions

Options for getting a channel in Discord

<details>
<summary>Raw Type</summary>

```luau
--- Options for getting a channel in Discord
type GetChannelOptions = {
	--- The channel ID
	channel_id: discord.Snowflake
}
```

</details>

<div id="channel_id"></div>

### channel_id

The channel ID

[discord](module.discord).[Snowflake](#Snowflake)

<div id="EditChannelOptions"></div>

## EditChannelOptions

Options for editing a channel in Discord

<details>
<summary>Raw Type</summary>

```luau
--- Options for editing a channel in Discord
type EditChannelOptions = {
	--- The channel ID
	channel_id: discord.Snowflake,

	--- The reason for the edit
	reason: string,

	--- The data to edit the channel with
	data: discordRest.ModifyChannelRequest
}
```

</details>

<div id="channel_id"></div>

### channel_id

The channel ID

[discord](module.discord).[Snowflake](#Snowflake)

<div id="reason"></div>

### reason

The reason for the edit

[string](#string)

<div id="data"></div>

### data

The data to edit the channel with

[discordRest](module.discordRest).[ModifyChannelRequest](#ModifyChannelRequest)

<div id="DeleteChannelOptions"></div>

## DeleteChannelOptions

Options for deleting a channel in Discord

<details>
<summary>Raw Type</summary>

```luau
--- Options for deleting a channel in Discord
type DeleteChannelOptions = {
	--- The channel ID
	channel_id: discord.Snowflake,

	--- The reason for the deletion
	reason: string
}
```

</details>

<div id="channel_id"></div>

### channel_id

The channel ID

[discord](module.discord).[Snowflake](#Snowflake)

<div id="reason"></div>

### reason

The reason for the deletion

[string](#string)

<div id="EditChannelPermissionsOptions"></div>

## EditChannelPermissionsOptions

Options for editting channel permissions

<details>
<summary>Raw Type</summary>

```luau
--- Options for editting channel permissions
type EditChannelPermissionsOptions = {
	--- The channel ID
	channel_id: discord.Snowflake,

	--- The target ID to edit permissions of
	target_id: discord.Snowflake,

	--- The allow permissions
	allow: typesext.MultiOption<string>,

	--- The deny permissions
	deny: typesext.MultiOption<string>,

	--- The type of the target
	kind: discord.OverwriteObjectType,

	--- The reason for the edit
	reason: string
}
```

</details>

<div id="channel_id"></div>

### channel_id

The channel ID

[discord](module.discord).[Snowflake](#Snowflake)

<div id="target_id"></div>

### target_id

The target ID to edit permissions of

[discord](module.discord).[Snowflake](#Snowflake)

<div id="allow"></div>

### allow

The allow permissions

[typesext](module.typesext).[MultiOption](#MultiOption)<[string](#string)>

<div id="deny"></div>

### deny

The deny permissions

[typesext](module.typesext).[MultiOption](#MultiOption)<[string](#string)>

<div id="kind"></div>

### kind

The type of the target

[discord](module.discord).[OverwriteObjectType](#OverwriteObjectType)

<div id="reason"></div>

### reason

The reason for the edit

[string](#string)

<div id="AddGuildMemberRoleOptions"></div>

## AddGuildMemberRoleOptions

Options for adding a role to a member

<details>
<summary>Raw Type</summary>

```luau
--- Options for adding a role to a member
type AddGuildMemberRoleOptions = {
	--- The member ID
	user_id: discord.Snowflake,

	--- The role ID
	role_id: discord.Snowflake,

	--- The reason for adding the role
	reason: string
}
```

</details>

<div id="user_id"></div>

### user_id

The member ID

[discord](module.discord).[Snowflake](#Snowflake)

<div id="role_id"></div>

### role_id

The role ID

[discord](module.discord).[Snowflake](#Snowflake)

<div id="reason"></div>

### reason

The reason for adding the role

[string](#string)

<div id="RemoveGuildMemberRoleOptions"></div>

## RemoveGuildMemberRoleOptions

Options for removing a role from a member

<details>
<summary>Raw Type</summary>

```luau
--- Options for removing a role from a member
type RemoveGuildMemberRoleOptions = {
	--- The member ID
	user_id: discord.Snowflake,

	--- The role ID
	role_id: discord.Snowflake,

	--- The reason for adding the role
	reason: string
}
```

</details>

<div id="user_id"></div>

### user_id

The member ID

[discord](module.discord).[Snowflake](#Snowflake)

<div id="role_id"></div>

### role_id

The role ID

[discord](module.discord).[Snowflake](#Snowflake)

<div id="reason"></div>

### reason

The reason for adding the role

[string](#string)

<div id="RemoveGuildMemberOptions"></div>

## RemoveGuildMemberOptions

Options for removing a member from a guild

<details>
<summary>Raw Type</summary>

```luau
--- Options for removing a member from a guild
type RemoveGuildMemberOptions = {
	--- The member ID
	user_id: discord.Snowflake,

	--- The reason for removing the member
	reason: string
}
```

</details>

<div id="user_id"></div>

### user_id

The member ID

[discord](module.discord).[Snowflake](#Snowflake)

<div id="reason"></div>

### reason

The reason for removing the member

[string](#string)

<div id="GetGuildBansOptions"></div>

## GetGuildBansOptions

Options for getting guild bans



Note: If both `before` and `after` are provided, `before` will take precedence.

<details>
<summary>Raw Type</summary>

```luau
--- Options for getting guild bans
---
--- Note: If both `before` and `after` are provided, `before` will take precedence.
type GetGuildBansOptions = {
	--- The limit of bans to get (max 100)
	limit: number?,

	--- Before a certain user ID
	before: discord.Snowflake?,

	--- After a certain user ID
	after: discord.Snowflake?
}
```

</details>

<div id="limit"></div>

### limit

The limit of bans to get (max 100)

*This field is optional and may not be specified*

[number?](#number)

<div id="before"></div>

### before

Before a certain user ID

*This field is optional and may not be specified*

[discord](module.discord).[Snowflake](#Snowflake)

<div id="after"></div>

### after

After a certain user ID

*This field is optional and may not be specified*

[discord](module.discord).[Snowflake](#Snowflake)

<div id="CreateMessageOptions"></div>

## CreateMessageOptions

Options for sending a message to a channel in Discord

<details>
<summary>Raw Type</summary>

```luau
--- Options for sending a message to a channel in Discord
type CreateMessageOptions = {
	--- The channel ID
	channel_id: discord.Snowflake,

	--- The data to send the message with
	data: discordRest.CreateMessageRequest
}
```

</details>

<div id="channel_id"></div>

### channel_id

The channel ID

[discord](module.discord).[Snowflake](#Snowflake)

<div id="data"></div>

### data

The data to send the message with

[discordRest](module.discordRest).[CreateMessageRequest](#CreateMessageRequest)

<div id="CreateCommandOptions"></div>

## CreateCommandOptions

Options for creating a command in Discord

<details>
<summary>Raw Type</summary>

```luau
--- Options for creating a command in Discord
type CreateCommandOptions = {
	--- The data to create the command with
	data: discordRest.CreateGuildApplicationCommandRequest
}
```

</details>

<div id="data"></div>

### data

The data to create the command with

[discordRest](module.discordRest).[CreateGuildApplicationCommandRequest](#CreateGuildApplicationCommandRequest)

<div id="CreateInteractionResponseOptions"></div>

## CreateInteractionResponseOptions

Options for creating an interaction response in Discord

<details>
<summary>Raw Type</summary>

```luau
--- Options for creating an interaction response in Discord
type CreateInteractionResponseOptions = {
	--- The interaction ID
	interaction_id: discord.Snowflake,

	--- The interaction token
	interaction_token: string,

	--- The data to create the interaction response with
	data: discordRest.CreateInteractionRequest
}
```

</details>

<div id="interaction_id"></div>

### interaction_id

The interaction ID

[discord](module.discord).[Snowflake](#Snowflake)

<div id="interaction_token"></div>

### interaction_token

The interaction token

[string](#string)

<div id="data"></div>

### data

The data to create the interaction response with

[discordRest](module.discordRest).[CreateInteractionRequest](#CreateInteractionRequest)

<div id="CreateFollowupMessageOptions"></div>

## CreateFollowupMessageOptions

Options for creating a followup message in Discord

<details>
<summary>Raw Type</summary>

```luau
--- Options for creating a followup message in Discord
type CreateFollowupMessageOptions = {
	--- The interaction token
	interaction_token: string,

	--- The data to create the followup message with
	data: discordRest.CreateFollowupMessageRequest
}
```

</details>

<div id="interaction_token"></div>

### interaction_token

The interaction token

[string](#string)

<div id="data"></div>

### data

The data to create the followup message with

[discordRest](module.discordRest).[CreateFollowupMessageRequest](#CreateFollowupMessageRequest)

<div id="MessagePagination"></div>

## MessagePagination

A message pagination object

<details>
<summary>Raw Type</summary>

```luau
--- A message pagination object
type MessagePagination = {
	type: "After" | "Around" | "Before",

	id: discord.Snowflake
}
```

</details>

<div id="type"></div>

### type

Union with variants:

<details>
<summary>Variant 1</summary>

```luau
"After"
```

</details>

<details>
<summary>Variant 2</summary>

```luau
"Around"
```

</details>

<details>
<summary>Variant 3</summary>

```luau
"Before"
```

</details>

<div id="id"></div>

### id

[discord](module.discord).[Snowflake](#Snowflake)

<div id="GetMessagesOptions"></div>

## GetMessagesOptions

Options for getting messages in Discord

<details>
<summary>Raw Type</summary>

```luau
--- Options for getting messages in Discord
type GetMessagesOptions = {
	--- The channel ID
	channel_id: discord.Snowflake,

	--- The target message
	target: MessagePagination?,

	--- The limit of messages to get
	limit: number?
}
```

</details>

<div id="channel_id"></div>

### channel_id

The channel ID

[discord](module.discord).[Snowflake](#Snowflake)

<div id="target"></div>

### target

The target message

*This field is optional and may not be specified*

[MessagePagination?](#MessagePagination)

<div id="limit"></div>

### limit

The limit of messages to get

*This field is optional and may not be specified*

[number?](#number)

<div id="GetMessageOptions"></div>

## GetMessageOptions

Options for getting a message in Discord

<details>
<summary>Raw Type</summary>

```luau
--- Options for getting a message in Discord
type GetMessageOptions = {
	--- The channel ID
	channel_id: discord.Snowflake,

	--- The message ID
	message_id: discord.Snowflake
}
```

</details>

<div id="channel_id"></div>

### channel_id

The channel ID

[discord](module.discord).[Snowflake](#Snowflake)

<div id="message_id"></div>

### message_id

The message ID

[discord](module.discord).[Snowflake](#Snowflake)

<div id="DiscordExecutor"></div>

## DiscordExecutor

DiscordExecutor allows templates to access/use the Discord API in a sandboxed form.

<details>
<summary>Raw Type</summary>

```luau
--- DiscordExecutor allows templates to access/use the Discord API in a sandboxed form.
type DiscordExecutor = {
	--- Gets the audit logs
	get_audit_logs: (self: DiscordExecutor, data: GetAuditLogOptions) -> promise.LuaPromise<LazyAuditLogObject>,

	--- Lists the auto moderation rules available
	list_auto_moderation_rules: (self: DiscordExecutor) -> promise.LuaPromise<LazyAutomoderationRuleObjectList>,

	--- Gets an auto moderation rule by ID
	get_auto_moderation_rule: (self: DiscordExecutor, data: GetAutoModerationRuleOptions) -> promise.LuaPromise<LazyAutomoderationRuleObject>,

	--- Creates an auto moderation rule
	create_auto_moderation_rule: (self: DiscordExecutor, data: CreateAutoModerationRuleOptions) -> promise.LuaPromise<LazyAutomoderationRuleObject>,

	--- Edits an auto moderation rule
	edit_auto_moderation_rule: (self: DiscordExecutor, data: EditAutoModerationRuleOptions) -> promise.LuaPromise<LazyAutomoderationRuleObject>,

	--- Deletes an auto moderation rule
	delete_auto_moderation_rule: (self: DiscordExecutor, data: DeleteAutoModerationRuleOptions) -> promise.LuaPromise<LazyAutomoderationRuleObject>,

	--- Gets a channel
	get_channel: (self: DiscordExecutor, data: GetChannelOptions) -> promise.LuaPromise<LazyChannelObject>,

	--- Edits a channel
	edit_channel: (self: DiscordExecutor, data: EditChannelOptions) -> promise.LuaPromise<LazyChannelObject>,

	--- Deletes a channel
	delete_channel: (self: DiscordExecutor, data: DeleteChannelOptions) -> promise.LuaPromise<LazyChannelObject>,

	--- Edits channel permissions for a target
	edit_channel_permissions: (self: DiscordExecutor, data: EditChannelPermissionsOptions) -> promise.LuaPromise<nil>,

	--- Adds a role to a member
	add_guild_member_role: (self: DiscordExecutor, data: AddGuildMemberRoleOptions) -> promise.LuaPromise<nil>,

	--- Removes a role from a member
	remove_guild_member_role: (self: DiscordExecutor, data: RemoveGuildMemberRoleOptions) -> promise.LuaPromise<nil>,

	-- Removes a member from a guild
	remove_guild_member: (self: DiscordExecutor, data: RemoveGuildMemberOptions) -> promise.LuaPromise<nil>,

	--- Gets guild bans
	get_guild_bans: (self: DiscordExecutor, data: GetGuildBansOptions) -> promise.LuaPromise<LazyBanObjectList>,

	--- Returns the guild roles of a guild
	get_guild_roles: (self: DiscordExecutor, guild_id: discord.Snowflake) -> promise.LuaPromise<LazyRolesMap>,

	--- Gets messages from a channel
	get_messages: (self: DiscordExecutor, data: GetMessagesOptions) -> promise.LuaPromise<LazyMessagesObject>,

	--- Gets a message
	get_message: (self: DiscordExecutor, data: GetMessageOptions) -> promise.LuaPromise<LazyMessageObject>,

	--- Creates a message
	create_message: (self: DiscordExecutor, data: CreateMessageOptions) -> promise.LuaPromise<LazyMessageObject>,

	--- Creates an interaction response
	create_interaction_response: (self: DiscordExecutor, data: CreateInteractionResponseOptions) -> promise.LuaPromise<nil>,

	--- Creates a followup interaction response
	create_followup_message: (self: DiscordExecutor, data: CreateFollowupMessageOptions) -> promise.LuaPromise<LazyMessageObject>,

	--- Gets the original interaction response
	get_original_interaction_response: (self: DiscordExecutor, interaction_token: string) -> promise.LuaPromise<LazyMessageObject>,

	--- Gets all guild commands currently registered
	get_guild_commands: (self: DiscordExecutor) -> promise.LuaPromise<LazyApplicationCommandObject>,

	--- Creates a guild command
	create_guild_command: (self: DiscordExecutor, data: CreateCommandOptions) -> promise.LuaPromise<LazyApplicationCommandObject>
}
```

</details>

<div id="get_audit_logs"></div>

### get_audit_logs

Gets the audit logs

<details>
<summary>Function Signature</summary>

```luau
--- Gets the audit logs
get_audit_logs: (self: DiscordExecutor, data: GetAuditLogOptions) -> promise.LuaPromise<LazyAuditLogObject>
```

</details>

<div id="Arguments"></div>

#### Arguments

<div id="data"></div>

##### data

[GetAuditLogOptions](#GetAuditLogOptions)

<div id="Returns"></div>

#### Returns

<div id="ret1"></div>

##### ret1

[promise](module.promise).[LuaPromise](#LuaPromise)<[LazyAuditLogObject](#LazyAuditLogObject)>

<div id="list_auto_moderation_rules"></div>

### list_auto_moderation_rules

Lists the auto moderation rules available

<details>
<summary>Function Signature</summary>

```luau
--- Lists the auto moderation rules available
list_auto_moderation_rules: (self: DiscordExecutor) -> promise.LuaPromise<LazyAutomoderationRuleObjectList>
```

</details>

<div id="Returns"></div>

#### Returns

<div id="ret1"></div>

##### ret1

[promise](module.promise).[LuaPromise](#LuaPromise)<[LazyAutomoderationRuleObjectList](#LazyAutomoderationRuleObjectList)>

<div id="get_auto_moderation_rule"></div>

### get_auto_moderation_rule

Gets an auto moderation rule by ID

<details>
<summary>Function Signature</summary>

```luau
--- Gets an auto moderation rule by ID
get_auto_moderation_rule: (self: DiscordExecutor, data: GetAutoModerationRuleOptions) -> promise.LuaPromise<LazyAutomoderationRuleObject>
```

</details>

<div id="Arguments"></div>

#### Arguments

<div id="data"></div>

##### data

[GetAutoModerationRuleOptions](#GetAutoModerationRuleOptions)

<div id="Returns"></div>

#### Returns

<div id="ret1"></div>

##### ret1

[promise](module.promise).[LuaPromise](#LuaPromise)<[LazyAutomoderationRuleObject](#LazyAutomoderationRuleObject)>

<div id="create_auto_moderation_rule"></div>

### create_auto_moderation_rule

Creates an auto moderation rule

<details>
<summary>Function Signature</summary>

```luau
--- Creates an auto moderation rule
create_auto_moderation_rule: (self: DiscordExecutor, data: CreateAutoModerationRuleOptions) -> promise.LuaPromise<LazyAutomoderationRuleObject>
```

</details>

<div id="Arguments"></div>

#### Arguments

<div id="data"></div>

##### data

[CreateAutoModerationRuleOptions](#CreateAutoModerationRuleOptions)

<div id="Returns"></div>

#### Returns

<div id="ret1"></div>

##### ret1

[promise](module.promise).[LuaPromise](#LuaPromise)<[LazyAutomoderationRuleObject](#LazyAutomoderationRuleObject)>

<div id="edit_auto_moderation_rule"></div>

### edit_auto_moderation_rule

Edits an auto moderation rule

<details>
<summary>Function Signature</summary>

```luau
--- Edits an auto moderation rule
edit_auto_moderation_rule: (self: DiscordExecutor, data: EditAutoModerationRuleOptions) -> promise.LuaPromise<LazyAutomoderationRuleObject>
```

</details>

<div id="Arguments"></div>

#### Arguments

<div id="data"></div>

##### data

[EditAutoModerationRuleOptions](#EditAutoModerationRuleOptions)

<div id="Returns"></div>

#### Returns

<div id="ret1"></div>

##### ret1

[promise](module.promise).[LuaPromise](#LuaPromise)<[LazyAutomoderationRuleObject](#LazyAutomoderationRuleObject)>

<div id="delete_auto_moderation_rule"></div>

### delete_auto_moderation_rule

Deletes an auto moderation rule

<details>
<summary>Function Signature</summary>

```luau
--- Deletes an auto moderation rule
delete_auto_moderation_rule: (self: DiscordExecutor, data: DeleteAutoModerationRuleOptions) -> promise.LuaPromise<LazyAutomoderationRuleObject>
```

</details>

<div id="Arguments"></div>

#### Arguments

<div id="data"></div>

##### data

[DeleteAutoModerationRuleOptions](#DeleteAutoModerationRuleOptions)

<div id="Returns"></div>

#### Returns

<div id="ret1"></div>

##### ret1

[promise](module.promise).[LuaPromise](#LuaPromise)<[LazyAutomoderationRuleObject](#LazyAutomoderationRuleObject)>

<div id="get_channel"></div>

### get_channel

Gets a channel

<details>
<summary>Function Signature</summary>

```luau
--- Gets a channel
get_channel: (self: DiscordExecutor, data: GetChannelOptions) -> promise.LuaPromise<LazyChannelObject>
```

</details>

<div id="Arguments"></div>

#### Arguments

<div id="data"></div>

##### data

[GetChannelOptions](#GetChannelOptions)

<div id="Returns"></div>

#### Returns

<div id="ret1"></div>

##### ret1

[promise](module.promise).[LuaPromise](#LuaPromise)<[LazyChannelObject](#LazyChannelObject)>

<div id="edit_channel"></div>

### edit_channel

Edits a channel

<details>
<summary>Function Signature</summary>

```luau
--- Edits a channel
edit_channel: (self: DiscordExecutor, data: EditChannelOptions) -> promise.LuaPromise<LazyChannelObject>
```

</details>

<div id="Arguments"></div>

#### Arguments

<div id="data"></div>

##### data

[EditChannelOptions](#EditChannelOptions)

<div id="Returns"></div>

#### Returns

<div id="ret1"></div>

##### ret1

[promise](module.promise).[LuaPromise](#LuaPromise)<[LazyChannelObject](#LazyChannelObject)>

<div id="delete_channel"></div>

### delete_channel

Deletes a channel

<details>
<summary>Function Signature</summary>

```luau
--- Deletes a channel
delete_channel: (self: DiscordExecutor, data: DeleteChannelOptions) -> promise.LuaPromise<LazyChannelObject>
```

</details>

<div id="Arguments"></div>

#### Arguments

<div id="data"></div>

##### data

[DeleteChannelOptions](#DeleteChannelOptions)

<div id="Returns"></div>

#### Returns

<div id="ret1"></div>

##### ret1

[promise](module.promise).[LuaPromise](#LuaPromise)<[LazyChannelObject](#LazyChannelObject)>

<div id="edit_channel_permissions"></div>

### edit_channel_permissions

Edits channel permissions for a target

<details>
<summary>Function Signature</summary>

```luau
--- Edits channel permissions for a target
edit_channel_permissions: (self: DiscordExecutor, data: EditChannelPermissionsOptions) -> promise.LuaPromise<nil>
```

</details>

<div id="Arguments"></div>

#### Arguments

<div id="data"></div>

##### data

[EditChannelPermissionsOptions](#EditChannelPermissionsOptions)

<div id="Returns"></div>

#### Returns

<div id="ret1"></div>

##### ret1

[promise](module.promise).[LuaPromise](#LuaPromise)<[nil](#nil)>

<div id="add_guild_member_role"></div>

### add_guild_member_role

Adds a role to a member

<details>
<summary>Function Signature</summary>

```luau
--- Adds a role to a member
add_guild_member_role: (self: DiscordExecutor, data: AddGuildMemberRoleOptions) -> promise.LuaPromise<nil>
```

</details>

<div id="Arguments"></div>

#### Arguments

<div id="data"></div>

##### data

[AddGuildMemberRoleOptions](#AddGuildMemberRoleOptions)

<div id="Returns"></div>

#### Returns

<div id="ret1"></div>

##### ret1

[promise](module.promise).[LuaPromise](#LuaPromise)<[nil](#nil)>

<div id="remove_guild_member_role"></div>

### remove_guild_member_role

Removes a role from a member

<details>
<summary>Function Signature</summary>

```luau
--- Removes a role from a member
remove_guild_member_role: (self: DiscordExecutor, data: RemoveGuildMemberRoleOptions) -> promise.LuaPromise<nil>
```

</details>

<div id="Arguments"></div>

#### Arguments

<div id="data"></div>

##### data

[RemoveGuildMemberRoleOptions](#RemoveGuildMemberRoleOptions)

<div id="Returns"></div>

#### Returns

<div id="ret1"></div>

##### ret1

[promise](module.promise).[LuaPromise](#LuaPromise)<[nil](#nil)>

<div id="remove_guild_member"></div>

### remove_guild_member

Removes a member from a guild

<details>
<summary>Function Signature</summary>

```luau
-- Removes a member from a guild
remove_guild_member: (self: DiscordExecutor, data: RemoveGuildMemberOptions) -> promise.LuaPromise<nil>
```

</details>

<div id="Arguments"></div>

#### Arguments

<div id="data"></div>

##### data

[RemoveGuildMemberOptions](#RemoveGuildMemberOptions)

<div id="Returns"></div>

#### Returns

<div id="ret1"></div>

##### ret1

[promise](module.promise).[LuaPromise](#LuaPromise)<[nil](#nil)>

<div id="get_guild_bans"></div>

### get_guild_bans

Gets guild bans

<details>
<summary>Function Signature</summary>

```luau
--- Gets guild bans
get_guild_bans: (self: DiscordExecutor, data: GetGuildBansOptions) -> promise.LuaPromise<LazyBanObjectList>
```

</details>

<div id="Arguments"></div>

#### Arguments

<div id="data"></div>

##### data

[GetGuildBansOptions](#GetGuildBansOptions)

<div id="Returns"></div>

#### Returns

<div id="ret1"></div>

##### ret1

[promise](module.promise).[LuaPromise](#LuaPromise)<[LazyBanObjectList](#LazyBanObjectList)>

<div id="get_guild_roles"></div>

### get_guild_roles

Returns the guild roles of a guild

<details>
<summary>Function Signature</summary>

```luau
--- Returns the guild roles of a guild
get_guild_roles: (self: DiscordExecutor, guild_id: discord.Snowflake) -> promise.LuaPromise<LazyRolesMap>
```

</details>

<div id="Arguments"></div>

#### Arguments

<div id="guild_id"></div>

##### guild_id

[discord](module.discord).[Snowflake](#Snowflake)

<div id="Returns"></div>

#### Returns

<div id="ret1"></div>

##### ret1

[promise](module.promise).[LuaPromise](#LuaPromise)<[LazyRolesMap](#LazyRolesMap)>

<div id="get_messages"></div>

### get_messages

Gets messages from a channel

<details>
<summary>Function Signature</summary>

```luau
--- Gets messages from a channel
get_messages: (self: DiscordExecutor, data: GetMessagesOptions) -> promise.LuaPromise<LazyMessagesObject>
```

</details>

<div id="Arguments"></div>

#### Arguments

<div id="data"></div>

##### data

[GetMessagesOptions](#GetMessagesOptions)

<div id="Returns"></div>

#### Returns

<div id="ret1"></div>

##### ret1

[promise](module.promise).[LuaPromise](#LuaPromise)<[LazyMessagesObject](#LazyMessagesObject)>

<div id="get_message"></div>

### get_message

Gets a message

<details>
<summary>Function Signature</summary>

```luau
--- Gets a message
get_message: (self: DiscordExecutor, data: GetMessageOptions) -> promise.LuaPromise<LazyMessageObject>
```

</details>

<div id="Arguments"></div>

#### Arguments

<div id="data"></div>

##### data

[GetMessageOptions](#GetMessageOptions)

<div id="Returns"></div>

#### Returns

<div id="ret1"></div>

##### ret1

[promise](module.promise).[LuaPromise](#LuaPromise)<[LazyMessageObject](#LazyMessageObject)>

<div id="create_message"></div>

### create_message

Creates a message

<details>
<summary>Function Signature</summary>

```luau
--- Creates a message
create_message: (self: DiscordExecutor, data: CreateMessageOptions) -> promise.LuaPromise<LazyMessageObject>
```

</details>

<div id="Arguments"></div>

#### Arguments

<div id="data"></div>

##### data

[CreateMessageOptions](#CreateMessageOptions)

<div id="Returns"></div>

#### Returns

<div id="ret1"></div>

##### ret1

[promise](module.promise).[LuaPromise](#LuaPromise)<[LazyMessageObject](#LazyMessageObject)>

<div id="create_interaction_response"></div>

### create_interaction_response

Creates an interaction response

<details>
<summary>Function Signature</summary>

```luau
--- Creates an interaction response
create_interaction_response: (self: DiscordExecutor, data: CreateInteractionResponseOptions) -> promise.LuaPromise<nil>
```

</details>

<div id="Arguments"></div>

#### Arguments

<div id="data"></div>

##### data

[CreateInteractionResponseOptions](#CreateInteractionResponseOptions)

<div id="Returns"></div>

#### Returns

<div id="ret1"></div>

##### ret1

[promise](module.promise).[LuaPromise](#LuaPromise)<[nil](#nil)>

<div id="create_followup_message"></div>

### create_followup_message

Creates a followup interaction response

<details>
<summary>Function Signature</summary>

```luau
--- Creates a followup interaction response
create_followup_message: (self: DiscordExecutor, data: CreateFollowupMessageOptions) -> promise.LuaPromise<LazyMessageObject>
```

</details>

<div id="Arguments"></div>

#### Arguments

<div id="data"></div>

##### data

[CreateFollowupMessageOptions](#CreateFollowupMessageOptions)

<div id="Returns"></div>

#### Returns

<div id="ret1"></div>

##### ret1

[promise](module.promise).[LuaPromise](#LuaPromise)<[LazyMessageObject](#LazyMessageObject)>

<div id="get_original_interaction_response"></div>

### get_original_interaction_response

Gets the original interaction response

<details>
<summary>Function Signature</summary>

```luau
--- Gets the original interaction response
get_original_interaction_response: (self: DiscordExecutor, interaction_token: string) -> promise.LuaPromise<LazyMessageObject>
```

</details>

<div id="Arguments"></div>

#### Arguments

<div id="interaction_token"></div>

##### interaction_token

[string](#string)

<div id="Returns"></div>

#### Returns

<div id="ret1"></div>

##### ret1

[promise](module.promise).[LuaPromise](#LuaPromise)<[LazyMessageObject](#LazyMessageObject)>

<div id="get_guild_commands"></div>

### get_guild_commands

Gets all guild commands currently registered

<details>
<summary>Function Signature</summary>

```luau
--- Gets all guild commands currently registered
get_guild_commands: (self: DiscordExecutor) -> promise.LuaPromise<LazyApplicationCommandObject>
```

</details>

<div id="Returns"></div>

#### Returns

<div id="ret1"></div>

##### ret1

[promise](module.promise).[LuaPromise](#LuaPromise)<[LazyApplicationCommandObject](#LazyApplicationCommandObject)>

<div id="create_guild_command"></div>

### create_guild_command

Creates a guild command

<details>
<summary>Function Signature</summary>

```luau
--- Creates a guild command
create_guild_command: (self: DiscordExecutor, data: CreateCommandOptions) -> promise.LuaPromise<LazyApplicationCommandObject>
```

</details>

<div id="Arguments"></div>

#### Arguments

<div id="data"></div>

##### data

[CreateCommandOptions](#CreateCommandOptions)

<div id="Returns"></div>

#### Returns

<div id="ret1"></div>

##### ret1

[promise](module.promise).[LuaPromise](#LuaPromise)<[LazyApplicationCommandObject](#LazyApplicationCommandObject)>

<div id="Functions"></div>

# Functions

<div id="new"></div>

## new

<details>
<summary>Function Signature</summary>

```luau
function new(token: Primitives.TemplateContext, scope: ExecutorScope.ExecutorScope?) -> DiscordExecutor end
```

</details>

<div id="Arguments"></div>

## Arguments

<div id="token"></div>

### token

[Primitives](module.Primitives).[TemplateContext](#TemplateContext)

<div id="scope"></div>

### scope

*This field is optional and may not be specified*

[ExecutorScope](module.ExecutorScope).[ExecutorScope](#ExecutorScope)

<div id="Returns"></div>

## Returns

<div id="ret1"></div>

### ret1

[DiscordExecutor](#DiscordExecutor)

