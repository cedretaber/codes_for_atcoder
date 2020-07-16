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
}

use std::char;

fn main() {
    let (h, w) = get!(i32, i32);
    let mut b = Vec::new();
    for _ in 0..h {
        b.push(get!(String).chars().collect::<Vec<_>>());
    }
    let r = [-1, 0, 1];
    for i in 0..h {
        for j in 0..w {
            if b[i as usize][j as usize] == '#' { continue; }
            let mut c = 0;
            for &y in r.iter() {
                for &x in r.iter() {
                    if i+y >= 0 && i+y < h && j+x >= 0 && j+x < w && b[(i+y) as usize][(j+x) as usize] == '#' { c += 1; }
                }
            }
            b[i as usize][j as usize] = char::from_digit(c, 10).unwrap();
        }
    }
    for l in b {
        println!("{}", l.into_iter().collect::<String>());
    }
}