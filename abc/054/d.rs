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

fn solve(i: usize, a: usize, b: usize, n: usize, ma: usize, mb: usize, arr: &Vec<(usize, usize, i32)>, dp: &mut Vec<Vec<Vec<i32>>>) -> i32 {
    if i == n { return if a != 0 && b != 0 && a * mb == b * ma { 0 } else { 5000 } }
    if dp[i][a][b] == 0 {
        let mut r = solve(i+1, a, b, n, ma, mb, arr, dp);
        let (aa, bb, c) = arr[i];
        r = cmp::min(r, solve(i+1, a + aa, b + bb, n, ma, mb, arr, dp) + c);
        dp[i][a][b] = r;
    }
    return dp[i][a][b];
}

fn main() {
    let (n, ma, mb) = get!(usize, usize, usize);
    let mut arr = Vec::new();
    for _ in 0..n {
        arr.push(get!(usize, usize, i32));
    }
    let mut dp = vec![vec![vec![0; 401]; 401]; n];
    let r = solve(0, 0, 0, n, ma, mb, &arr, &mut dp);
    println!("{}", if r <= 4000 { r } else { -1 });
}