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
    let (n, k) = get!(usize, usize);

    let mut memo = vec![vec![vec![0; 2]; k+1]; k+1];
    for _ in 0..n {
        let (x, y, c) = get!(usize, usize, String);
        let d = if c == "W" { 0 } else { 1 };
        memo[y % k + 1][x % k + 1][(y/k + x/k + d) % 2] += 1;
    }
    for i in 1..k+1 {
        for j in 1..k+1 {
            for b in 0..2 {
                memo[i][j][b] += memo[i-1][j][b] + memo[i][j-1][b] - memo[i-1][j-1][b];
            }
        }
    }
    let mut res = 0;
    for i in 0..k+1 {
        for j in 0..k+1 {
            for x in 0..2 {
                let y = (x + 1) % 2;
                res = cmp::max(res,
                    memo[k][k][x] - memo[i][k][x] - memo[k][j][x] + memo[i][j][x] * 2 +
                    memo[i][k][y] + memo[k][j][y] - memo[i][j][y] * 2
                );
            }
        }
    }
    println!("{}", res);
}