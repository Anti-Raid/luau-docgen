# luau-docgen

Generate documentation for Luau code. Unlike ``moonwave`` and friends, ``luau-docgen`` works based on standard Luau typing syntax (type definitions etc) and can be easily customized by modifying the (in Luau) documentor to your needs.

See ``a.md`` as an example of the current output. The output is currently not pretty and is a heavy work in progress.

## Usage

To document a ``~/staging/infra/templating-types/discord-luau-corrections/apiTypes.luau``:

```bash
target/debug/luau-docgen ~/staging/infra/templating-types/discord-luau-corrections/apiTypes.luau  > a
```