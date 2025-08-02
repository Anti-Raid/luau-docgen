# luau-docgen

``luau-docgen`` generates embeddable markdown documentation for Luau code that can be custom tailed to different markdown providers (such as mkdocs/mdbook) without taking over your existing documentation. Unlike ``moonwave`` and friends, ``luau-docgen`` is Luau specific, does not produce a full documentation site like Moonwave does, and works solely based on standard Luau typing syntax (type definitions etc) and can be easily customized by modifying the (in Luau) documentor to your needs.

See ``a.md`` as an example of the current output. While the project is a work-in-progress, it is generally usable.

## Usage

To document a file called ``~/staging/infra/templating-types/discord-luau-corrections/apiTypes.luau`` to a file called ``discord-luau-apitypes.md``:

```bash
lune run init.luau ~/staging/infra/templating-types/discord-luau-corrections/apiTypes.luau --output discord-luau-apitypes.md
```

To use the Rust-accelerated IR generation (full-moon instead of luaup), compile the Rust code with:

```bash
cargo build --release
```

Then add the ``--use-full-moon`` flag to the command:

```bash
lune run init.luau ~/staging/infra/templating-types/discord-luau-corrections/apiTypes.luau --output discord-luau-apitypes.md --use-full-moon
```

## Differences from moonwave

**To be very clear: This is *not* a moonwave alternative**

1. luau-docgen is a WIP and not yet actually ready for use yet.

2. Moonwave generates a full documentation website for you while luau-docgen produces embeddable markdown documentation that can be custom tailored to different markdown dialects without taking over your existing documentation.

3. luau-docgen is Luau specific while moonwave works across multiple Lua dialects and versions.

4. Moonwave is based mostly on comments, while luau-docgen is based on Luau type definitions (and minimal use of 'doc comments' where Luau type definitions are not enough) 

5. luau-docgen has an emphasized use case on embedding a Luau API into a bigger documentation (for example, luau-docgen generates a second lower-level 'markdown IR' allowing for the formatter code to be quickly and easily adjusted when switching between markdown doc providers like mdbook and mkdocs) while moonwave is a full documentation site generator that is harder to directly embed in a mdbook/mkdocs site.

Basically, if your project:

- is written in Luau
- is part of a bigger project that contains its own established documentation
- uses standard Luau type definitions for typings

then luau-docgen might be a good fit for you.

## Generators

luau-docgen uses generators to generate its documentation. The default generator is the `markdown` generator, which generates markdown documentation for a generic markdown provider like mdbook. To specialize, simply copy paste the ``markdown`` generator and modify it to your needs. The generators are located in the ``documentor_core/generators`` directory.