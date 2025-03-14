# Types

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

### action_type

The action type to filter by

[Documentor] Unsupported type: Optional

### user_id

The user ID to filter by

[Documentor] Unsupported type: Optional

### before

The audit log entry ID to filter

[Documentor] Unsupported type: Optional

### limit

The number of entries to return

[Documentor] Unsupported type: Optional

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

### rule_id

The rule ID

[Documentor] Unsupported type: Module

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

### reason

The reason for creating the rule

Field with the following constraints:

- Type: string
- Constraints: None

### data

The data to create the rule with

[Documentor] Unsupported type: Module

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

### rule_id

The rule ID

[Documentor] Unsupported type: Module

### reason

The reason for editing the rule

Field with the following constraints:

- Type: string
- Constraints: None

### data

The data to edit the rule with

[Documentor] Unsupported type: Module

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

### rule_id

The rule ID

[Documentor] Unsupported type: Module

### reason

The reason for deleting the rule

Field with the following constraints:

- Type: string
- Constraints: None

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

### channel_id

The channel ID

[Documentor] Unsupported type: Module

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

### channel_id

The channel ID

[Documentor] Unsupported type: Module

### reason

The reason for the edit

Field with the following constraints:

- Type: string
- Constraints: None

### data

The data to edit the channel with

[Documentor] Unsupported type: Module

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

### channel_id

The channel ID

[Documentor] Unsupported type: Module

### reason

The reason for the deletion

Field with the following constraints:

- Type: string
- Constraints: None

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

### channel_id

The channel ID

[Documentor] Unsupported type: Module

### target_id

The target ID to edit permissions of

[Documentor] Unsupported type: Module

### allow

The allow permissions

[Documentor] Unsupported type: Module

### deny

The deny permissions

[Documentor] Unsupported type: Module

### kind

The type of the target

[Documentor] Unsupported type: Module

### reason

The reason for the edit

Field with the following constraints:

- Type: string
- Constraints: None

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

### user_id

The member ID

[Documentor] Unsupported type: Module

### role_id

The role ID

[Documentor] Unsupported type: Module

### reason

The reason for adding the role

Field with the following constraints:

- Type: string
- Constraints: None

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

### user_id

The member ID

[Documentor] Unsupported type: Module

### role_id

The role ID

[Documentor] Unsupported type: Module

### reason

The reason for adding the role

Field with the following constraints:

- Type: string
- Constraints: None

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

### user_id

The member ID

[Documentor] Unsupported type: Module

### reason

The reason for removing the member

Field with the following constraints:

- Type: string
- Constraints: None

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

### limit

The limit of bans to get (max 100)

[Documentor] Unsupported type: Optional

### before

Before a certain user ID

[Documentor] Unsupported type: Optional

### after

After a certain user ID

[Documentor] Unsupported type: Optional

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

### channel_id

The channel ID

[Documentor] Unsupported type: Module

### data

The data to send the message with

[Documentor] Unsupported type: Module

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

### data

The data to create the command with

[Documentor] Unsupported type: Module

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

### interaction_id

The interaction ID

[Documentor] Unsupported type: Module

### interaction_token

The interaction token

Field with the following constraints:

- Type: string
- Constraints: None

### data

The data to create the interaction response with

[Documentor] Unsupported type: Module

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

### interaction_token

The interaction token

Field with the following constraints:

- Type: string
- Constraints: None

### data

The data to create the followup message with

[Documentor] Unsupported type: Module

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

### type

[Documentor] Unsupported type: Union

### id

[Documentor] Unsupported type: Module

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

### channel_id

The channel ID

[Documentor] Unsupported type: Module

### target

The target message

[Documentor] Unsupported type: Optional

### limit

The limit of messages to get

[Documentor] Unsupported type: Optional

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

### channel_id

The channel ID

[Documentor] Unsupported type: Module

### message_id

The message ID

[Documentor] Unsupported type: Module

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

### get_audit_logs

Gets the audit logs

<details>
<summary>Function Signature</summary>

```luau
--- Gets the audit logs
get_audit_logs: (self: DiscordExecutor, data: GetAuditLogOptions) -> promise.LuaPromise<LazyAuditLogObject>
```

</details>

#### Arguments

- **data** *(GetAuditLogOptions)*

#### Returns

- **ret1** *(promise.LuaPromise&lt;LazyAuditLogObject&gt;)*

### list_auto_moderation_rules

Lists the auto moderation rules available

<details>
<summary>Function Signature</summary>

```luau
--- Lists the auto moderation rules available
list_auto_moderation_rules: (self: DiscordExecutor) -> promise.LuaPromise<LazyAutomoderationRuleObjectList>
```

</details>

#### Arguments

#### Returns

- **ret1** *(promise.LuaPromise&lt;LazyAutomoderationRuleObjectList&gt;)*

### get_auto_moderation_rule

Gets an auto moderation rule by ID

<details>
<summary>Function Signature</summary>

```luau
--- Gets an auto moderation rule by ID
get_auto_moderation_rule: (self: DiscordExecutor, data: GetAutoModerationRuleOptions) -> promise.LuaPromise<LazyAutomoderationRuleObject>
```

</details>

#### Arguments

- **data** *(GetAutoModerationRuleOptions)*

#### Returns

- **ret1** *(promise.LuaPromise&lt;LazyAutomoderationRuleObject&gt;)*

### create_auto_moderation_rule

Creates an auto moderation rule

<details>
<summary>Function Signature</summary>

```luau
--- Creates an auto moderation rule
create_auto_moderation_rule: (self: DiscordExecutor, data: CreateAutoModerationRuleOptions) -> promise.LuaPromise<LazyAutomoderationRuleObject>
```

</details>

#### Arguments

- **data** *(CreateAutoModerationRuleOptions)*

#### Returns

- **ret1** *(promise.LuaPromise&lt;LazyAutomoderationRuleObject&gt;)*

### edit_auto_moderation_rule

Edits an auto moderation rule

<details>
<summary>Function Signature</summary>

```luau
--- Edits an auto moderation rule
edit_auto_moderation_rule: (self: DiscordExecutor, data: EditAutoModerationRuleOptions) -> promise.LuaPromise<LazyAutomoderationRuleObject>
```

</details>

#### Arguments

- **data** *(EditAutoModerationRuleOptions)*

#### Returns

- **ret1** *(promise.LuaPromise&lt;LazyAutomoderationRuleObject&gt;)*

### delete_auto_moderation_rule

Deletes an auto moderation rule

<details>
<summary>Function Signature</summary>

```luau
--- Deletes an auto moderation rule
delete_auto_moderation_rule: (self: DiscordExecutor, data: DeleteAutoModerationRuleOptions) -> promise.LuaPromise<LazyAutomoderationRuleObject>
```

</details>

#### Arguments

- **data** *(DeleteAutoModerationRuleOptions)*

#### Returns

- **ret1** *(promise.LuaPromise&lt;LazyAutomoderationRuleObject&gt;)*

### get_channel

Gets a channel

<details>
<summary>Function Signature</summary>

```luau
--- Gets a channel
get_channel: (self: DiscordExecutor, data: GetChannelOptions) -> promise.LuaPromise<LazyChannelObject>
```

</details>

#### Arguments

- **data** *(GetChannelOptions)*

#### Returns

- **ret1** *(promise.LuaPromise&lt;LazyChannelObject&gt;)*

### edit_channel

Edits a channel

<details>
<summary>Function Signature</summary>

```luau
--- Edits a channel
edit_channel: (self: DiscordExecutor, data: EditChannelOptions) -> promise.LuaPromise<LazyChannelObject>
```

</details>

#### Arguments

- **data** *(EditChannelOptions)*

#### Returns

- **ret1** *(promise.LuaPromise&lt;LazyChannelObject&gt;)*

### delete_channel

Deletes a channel

<details>
<summary>Function Signature</summary>

```luau
--- Deletes a channel
delete_channel: (self: DiscordExecutor, data: DeleteChannelOptions) -> promise.LuaPromise<LazyChannelObject>
```

</details>

#### Arguments

- **data** *(DeleteChannelOptions)*

#### Returns

- **ret1** *(promise.LuaPromise&lt;LazyChannelObject&gt;)*

### edit_channel_permissions

Edits channel permissions for a target

<details>
<summary>Function Signature</summary>

```luau
--- Edits channel permissions for a target
edit_channel_permissions: (self: DiscordExecutor, data: EditChannelPermissionsOptions) -> promise.LuaPromise<nil>
```

</details>

#### Arguments

- **data** *(EditChannelPermissionsOptions)*

#### Returns

- **ret1** *(promise.LuaPromise&lt;nil&gt;)*

### add_guild_member_role

Adds a role to a member

<details>
<summary>Function Signature</summary>

```luau
--- Adds a role to a member
add_guild_member_role: (self: DiscordExecutor, data: AddGuildMemberRoleOptions) -> promise.LuaPromise<nil>
```

</details>

#### Arguments

- **data** *(AddGuildMemberRoleOptions)*

#### Returns

- **ret1** *(promise.LuaPromise&lt;nil&gt;)*

### remove_guild_member_role

Removes a role from a member

<details>
<summary>Function Signature</summary>

```luau
--- Removes a role from a member
remove_guild_member_role: (self: DiscordExecutor, data: RemoveGuildMemberRoleOptions) -> promise.LuaPromise<nil>
```

</details>

#### Arguments

- **data** *(RemoveGuildMemberRoleOptions)*

#### Returns

- **ret1** *(promise.LuaPromise&lt;nil&gt;)*

### remove_guild_member

Removes a member from a guild

<details>
<summary>Function Signature</summary>

```luau
-- Removes a member from a guild
remove_guild_member: (self: DiscordExecutor, data: RemoveGuildMemberOptions) -> promise.LuaPromise<nil>
```

</details>

#### Arguments

- **data** *(RemoveGuildMemberOptions)*

#### Returns

- **ret1** *(promise.LuaPromise&lt;nil&gt;)*

### get_guild_bans

Gets guild bans

<details>
<summary>Function Signature</summary>

```luau
--- Gets guild bans
get_guild_bans: (self: DiscordExecutor, data: GetGuildBansOptions) -> promise.LuaPromise<LazyBanObjectList>
```

</details>

#### Arguments

- **data** *(GetGuildBansOptions)*

#### Returns

- **ret1** *(promise.LuaPromise&lt;LazyBanObjectList&gt;)*

### get_guild_roles

Returns the guild roles of a guild

<details>
<summary>Function Signature</summary>

```luau
--- Returns the guild roles of a guild
get_guild_roles: (self: DiscordExecutor, guild_id: discord.Snowflake) -> promise.LuaPromise<LazyRolesMap>
```

</details>

#### Arguments

- **guild_id** *(discord.Snowflake)*

#### Returns

- **ret1** *(promise.LuaPromise&lt;LazyRolesMap&gt;)*

### get_messages

Gets messages from a channel

<details>
<summary>Function Signature</summary>

```luau
--- Gets messages from a channel
get_messages: (self: DiscordExecutor, data: GetMessagesOptions) -> promise.LuaPromise<LazyMessagesObject>
```

</details>

#### Arguments

- **data** *(GetMessagesOptions)*

#### Returns

- **ret1** *(promise.LuaPromise&lt;LazyMessagesObject&gt;)*

### get_message

Gets a message

<details>
<summary>Function Signature</summary>

```luau
--- Gets a message
get_message: (self: DiscordExecutor, data: GetMessageOptions) -> promise.LuaPromise<LazyMessageObject>
```

</details>

#### Arguments

- **data** *(GetMessageOptions)*

#### Returns

- **ret1** *(promise.LuaPromise&lt;LazyMessageObject&gt;)*

### create_message

Creates a message

<details>
<summary>Function Signature</summary>

```luau
--- Creates a message
create_message: (self: DiscordExecutor, data: CreateMessageOptions) -> promise.LuaPromise<LazyMessageObject>
```

</details>

#### Arguments

- **data** *(CreateMessageOptions)*

#### Returns

- **ret1** *(promise.LuaPromise&lt;LazyMessageObject&gt;)*

### create_interaction_response

Creates an interaction response

<details>
<summary>Function Signature</summary>

```luau
--- Creates an interaction response
create_interaction_response: (self: DiscordExecutor, data: CreateInteractionResponseOptions) -> promise.LuaPromise<nil>
```

</details>

#### Arguments

- **data** *(CreateInteractionResponseOptions)*

#### Returns

- **ret1** *(promise.LuaPromise&lt;nil&gt;)*

### create_followup_message

Creates a followup interaction response

<details>
<summary>Function Signature</summary>

```luau
--- Creates a followup interaction response
create_followup_message: (self: DiscordExecutor, data: CreateFollowupMessageOptions) -> promise.LuaPromise<LazyMessageObject>
```

</details>

#### Arguments

- **data** *(CreateFollowupMessageOptions)*

#### Returns

- **ret1** *(promise.LuaPromise&lt;LazyMessageObject&gt;)*

### get_original_interaction_response

Gets the original interaction response

<details>
<summary>Function Signature</summary>

```luau
--- Gets the original interaction response
get_original_interaction_response: (self: DiscordExecutor, interaction_token: string) -> promise.LuaPromise<LazyMessageObject>
```

</details>

#### Arguments

- **interaction_token** *(string)*

#### Returns

- **ret1** *(promise.LuaPromise&lt;LazyMessageObject&gt;)*

### get_guild_commands

Gets all guild commands currently registered

<details>
<summary>Function Signature</summary>

```luau
--- Gets all guild commands currently registered
get_guild_commands: (self: DiscordExecutor) -> promise.LuaPromise<LazyApplicationCommandObject>
```

</details>

#### Arguments

#### Returns

- **ret1** *(promise.LuaPromise&lt;LazyApplicationCommandObject&gt;)*

### create_guild_command

Creates a guild command

<details>
<summary>Function Signature</summary>

```luau
--- Creates a guild command
create_guild_command: (self: DiscordExecutor, data: CreateCommandOptions) -> promise.LuaPromise<LazyApplicationCommandObject>
```

</details>

#### Arguments

- **data** *(CreateCommandOptions)*

#### Returns

- **ret1** *(promise.LuaPromise&lt;LazyApplicationCommandObject&gt;)*

# Functions

## new

<details>
<summary>Function Signature</summary>

```luau
function new(token: Primitives.TemplateContext, scope: ExecutorScope.ExecutorScope?) -> DiscordExecutor end
```

</details>

## Arguments

- **token** *(Primitives.TemplateContext)*
- **scope** *(ExecutorScope.ExecutorScope?)*

## Returns

- **ret1** *(DiscordExecutor)*

