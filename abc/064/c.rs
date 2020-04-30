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

use std::cmp;

fn main() {
    let _n = get!(usize);
    let mut cs = vec![0; 9];
    for s in get!(String).split_whitespace() {
        let a = s.parse::<i32>().unwrap();
        let i = cmp::min(8, a / 400) as usize;
        cs[i] += 1;
    }
    let min_c = cs.iter().take(8).fold(0, |a, &n| if n > 0 { a + 1 } else { a });
    let max_c = min_c + cs[8];
    println!("{} {}", cmp::max(1, min_c), max_c);
}