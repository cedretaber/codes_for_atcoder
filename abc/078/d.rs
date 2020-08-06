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
    let (n, z, w) = get!(usize, i32, i32);
    let aa = get!(String).split_whitespace().map(|a| a.parse::<i32>().unwrap()).rev().collect::<Vec<_>>();

    let mut dp = vec![vec![-1; n+1]; 2];

    for i in 0..n+1 {
        let (x, y) = if i == n { (z, w) } else { (aa[i], aa[i]) };
        dp[0][i] = (aa[0] - y).abs();
        dp[1][i] = (aa[0] - x).abs();
        for j in 1..i {
            dp[0][i] = cmp::max(dp[0][i], dp[1][j]);
            dp[1][i] = cmp::min(dp[1][i], dp[0][j]);
        }
    }

    println!("{}", dp[0][n]);
}