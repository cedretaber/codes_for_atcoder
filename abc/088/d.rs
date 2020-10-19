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

use std::collections::VecDeque;

fn main() {
    let (h, w) = get!(usize, usize);
    let mut cc = Vec::new();
    for _ in 0..h {
        cc.push(get!(String).chars().collect::<Vec<_>>());
    }
    let mut wc = 0;
    for i in 0..h {
        for j in 0..w {
            if cc[i][j] == '.' {
                wc += 1;
            }
        }
    }

    let mut ss = VecDeque::new();
    ss.push_back((0, 0, 1));
    let mut dp = vec![vec![h*w+10; w]; h];
    dp[0][0] = 1;
    while let Some((i, j, c)) = ss.pop_front() {
        for d in [[0,1], [1,0], [-1,0], [0,-1]].iter() {
            let ii = (i as isize) + d[0];
            let jj = (j as isize) + d[1];
            if ii < 0 || ii >= (h as isize) || jj < 0 || jj >= (w as isize) || cc[ii as usize][jj as usize] == '#' || dp[ii as usize][jj as usize] <= c+1 { continue; }
            dp[ii as usize][jj as usize] = c+1;
            ss.push_back((ii as usize, jj as usize, c+1));
        }
    }
    if dp[h-1][w-1] == h*w+10 {
        println!("-1");
    } else {
        println!("{}", wc - dp[h-1][w-1]);
    }
}