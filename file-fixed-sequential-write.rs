use std::{io, fs};
use std::io::Write;

fn main() {
    let total = 25 * 1024 * 1024 * 1024;
    println!("{}", total);

    let buf: Vec<u8> = std::iter::repeat(b'Q')
        .take(8 * 1024 * 1024)
        .collect();

    let file = fs::File::create("bench.bin").unwrap();
    let mut file_buf = io::BufWriter::new(file);

    let mut bytes_left = total;
    while bytes_left > 0 {
        let amount = if bytes_left > buf.len() { buf.len() } else { bytes_left };
        let chunk = &buf[.. amount];
        file_buf.write_all(chunk).unwrap();
        bytes_left -= amount;
    }
}
