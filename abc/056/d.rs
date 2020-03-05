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

fn solve(i: usize, s: usize, x: usize, n: usize, k: usize, aa: Vec<usize>, mut dp: &Vec<Vec<i32>>) -> i32 {
    if i == n {
        return if k-aa[x] <= s && s < k { 1 } else { -1 };
    }
    if dp[i][s] != 0 {
        return dp[i][s];
    }
    if s+aa[i] <= 5000 && solve(i+1, s+aa[i], x, n, k, aa, dp) == 1 {
        dp[i][s] = 1;
        return 1;
    }
    if solve(i+1, s, x, b, k, aa, dp) == 1 {
        dp[i][s] = 1;
        return 1;
    }
    dp[i][s] = -1;
    return -1;
}

fn main() {
    let (n, k) = get!(usize, usize);
    let mut aa = Vec::new();
    for _ in 0..n {
        aa.push(get!(usize));
    }
    aa.sort();

    
}