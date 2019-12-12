macro_rules! get {
    ($t:ty) => {
        {
            let mut line: String = String::new();
            std::io::stdin().read_line(&mut line).unwrap();
            line.trim().parse::<$t>().unwrap()
        }
    };
    ($($t:ty),*) => {
        {
            let mut line: String = String::new();
            std::io::stdin().read_line(&mut line).unwrap();
            let mut iter = line.split_whitespace();
            (
                $(iter.next().unwrap().parse::<$t>().unwrap(),)*
            )
        }
    };
    ($t:ty; $n:expr) => {
        (0..$n).map(|_|
            get!($t)
        ).collect::<Vec<_>>()
    };
    ($($t:ty),*; $n:expr) => {
        (0..$n).map(|_|
            get!($($t),*)
        ).collect::<Vec<_>>()
    };
    ($t:ty ;;) => {
        {
            let mut line: String = String::new();
            std::io::stdin().read_line(&mut line).unwrap();
            line.split_whitespace()
                .map(|t| t.parse::<$t>().unwrap())
                .collect::<Vec<_>>()
        }
    };
    ($t:ty ;; $n:expr) => {
        (0..$n).map(|_| get!($t ;;)).collect::<Vec<_>>()
    };
}

use std::collections::LinkedList;

fn main() {
    let mut a = get!(String).chars().collect::<LinkedList<char>>();
    let mut b = get!(String).chars().collect::<LinkedList<char>>();
    let mut c = get!(String).chars().collect::<LinkedList<char>>();

    let mut t = 'a';
    loop {
        let mut s = match t {
            'a' => &mut a,
            'b' => &mut b,
            'c' => &mut c,
            _ => panic!("")
        };
        match s.front() {
            None => {
                println!("{}", t.to_string().to_uppercase());
                return;
            }
            Some(nt) => {
                t = *nt;
            }
        }
        s.pop_front();
    }
}