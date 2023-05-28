# utf8

UTF-8 support for Nix

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

Split a string into a list of characters

```
nix-repl> chars "你好，世界！"
[ "你" "好" "，" "世" "界" "！" ]
```

### `head`

Type: `String -> String`

Return the first character of the string

```
nix-repl> head "你好，世界！"
"你"
```

### `tail`

Type: `String -> String`

Return the string without the first character

```
nix-repl> tail "你好，世界！"
"好，世界！"
```

### `length`

Type: `String -> Int`

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
