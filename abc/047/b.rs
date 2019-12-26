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

use std::cmp;

fn main() {
    let (w, h, n) = get!(i32, i32, i32);
    let mut x_min = 0;
    let mut x_max = w;
    let mut y_min = 0;
    let mut y_max = h;

    for _ in 0..n {
        let (x, y, z) = get!(i32, i32, i32);
        match z {
            1 => {
                x_min = cmp::max(x_min, x);
            },
            2 => {
                x_max = cmp::min(x_max, x);
            },
            3 => {
                y_min = cmp::max(y_min, y);
            },
            4 => {
                y_max = cmp::min(y_max, y);
            },
            _ => {}
        }
    }
    println!("{}", if x_max - x_min < 0 || y_max - y_min < 0 { 0 } else { (x_max - x_min) * (y_max - y_min) });
}