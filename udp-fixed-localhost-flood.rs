use std::net::{UdpSocket, ToSocketAddrs};

fn main() {
    let total = 10 * 1000 * 1000;
    println!("{}", total);

    let buf = [b'Q'; 64];

    let socket = UdpSocket::bind("127.0.0.1:0").unwrap();
    let dst_addr = ToSocketAddrs::to_socket_addrs("127.0.0.1:9999").unwrap().next().unwrap();

    for _ in 0 .. total {
        socket.send_to(&buf, &dst_addr).unwrap();
    }
}
