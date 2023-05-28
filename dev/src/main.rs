#![feature(array_windows)]

use std::{
    fs::File,
    io::{self, Write},
};

fn main() -> io::Result<()> {
    let mut out = File::create("table.nix")?;
    writeln!(out, "# generated with `nix run ./dev`")?;
    writeln!(out, "{{")?;

    for (i, &[start, end]) in [0u8, 0b1100_0000, 0b1110_0000, 0b1111_0000, 0]
        .array_windows()
        .enumerate()
    {
        for x in start ..= end.wrapping_sub(1) {
            let esc = x.escape_ascii().to_string();
            write!(out, "  \"")?;
            if esc.contains("\\x") {
                out.write_all(&[x])?;
            } else {
                write!(out, "{esc}")?;
            }
            writeln!(out, "\" = {};", i + 1)?;
        }
    }

    writeln!(out, "}}")?;
    Ok(())
}
