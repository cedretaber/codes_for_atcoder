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
    let (n, w) = get!(usize, usize);
    let mut w_base = 0;
    let mut ws = Vec::new();
    let mut vs = Vec::new();
    for i in 0..n {
        let (w, v) = get!(usize, usize);
        if i == 0 {
            w_base = w;
        }
        ws.push(w - w_base);
        vs.push(v);
    }

    let mut dp: Vec<Vec<Vec<i64>>> = vec![vec![vec![-1; n*3+1]; n+1]; n+1];
    dp[0][0][0] = 0;
    for i in 0..n {
        for j in 0..n {
            for k in 0..n*3+1 {
                if dp[i][j][k] == -1 { continue; }
                dp[i+1][j][k] = cmp::max(dp[i+1][j][k], dp[i][j][k]);
                if (j+1)*w_base + k + ws[i] <= w {
                    dp[i+1][j+1][k+ws[i]] = cmp::max(dp[i+1][j+1][k+ws[i]], dp[i][j][k] + (vs[i] as i64));
                }
            }
        }
    }
    let mut r = 0;
    for j in 0..n+1 {
        for k in 0..n*3+1 {
            r = cmp::max(r, dp[n][j][k]);
        }
    }
    println!("{}", r);
}