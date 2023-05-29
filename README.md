# utf8

UTF-8 support for Nix

## Why

Strings in Nix are byte strings, and builtin functions like `substring`
(and by extension some `lib` functions in [nixpkgs](https://github.com/nixos/nixpkgs))
processes bytes instead of UTF-8 code points.
That means these functions can create invalid strings when given strings with UTF-8.
This library basically allows you to convert it to a list of UTF-8 code points.

## Usage

Try it out with flakes

```bash
nix repl github:figsoda/utf8#lib --extra-experimental-features "flakes nix-command repl-flake"
```

or locally

```bash
nix repl -f .
```

### `chars`

Type: `String -> [ String ]`

Split a string into a list of code points

```
nix-repl> chars "你好，世界！"
[ "你" "好" "，" "世" "界" "！" ]
```

### `head`

Type: `String -> String`

Return the first code point of the string

```
nix-repl> head "你好，世界！"
"你"
```

### `tail`

Type: `String -> String`

Return the string without the first code point

```
nix-repl> tail "你好，世界！"
"好，世界！"
```

### `length`

Type: `String -> Int`

Return the number of code points in the string

```
nix-repl> length "你好，世界！"
6
```

## Development

```bash
nix run ./dev # regenerate table.nix

nix develop ./dev
namaka check # run tests
namaka review # review pending snapshots
```
