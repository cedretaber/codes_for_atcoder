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
    let (n, c) = get!(usize, usize);
    let mut l = vec![vec![0; c]; 100_001];
    for _ in 0..n {
        let (s, t, c) = get!(usize, usize, usize);
        l[s-1][c-1] += 1;
        l[t][c-1] -= 1;
    }
    for i in 0..100_000 {
        for j in 0..c {
            l[i+1][j] += l[i][j];
        }
    }
    println!("{}", l.into_iter().map(|t| t.into_iter().map(|x| cmp::min(1, x)).sum::<i32>()).max().unwrap());
}