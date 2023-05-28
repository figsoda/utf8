let
  inherit (builtins)
    substring
    ;

  table = import ./table.nix;

  head = str: substring 0 table.${substring 0 1 str} str;

  tail = str: substring table.${substring 0 1 str} (-1) str;

  chars = str: if str == "" then [ ] else [ (head str) ] ++ chars (tail str);

  length = str: if str == "" then 0 else 1 + length (tail str);
in

{
  inherit chars head length tail;
}
